// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';

import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../../utils.dart';
import '../executable_settings.dart';
import 'browser.dart';
import 'default_settings.dart';

final _observatoryRegExp =
    new RegExp(r'Observatory listening (?:on|at) ([^ "]+)');

/// A class for running an instance of Dartium.
///
/// Most of the communication with the browser is expected to happen via HTTP,
/// so this exposes a bare-bones API. The browser starts as soon as the class is
/// constructed, and is killed when [close] is called.
///
/// Any errors starting or running the process are reported through [onExit].
class Dartium extends Browser {
  final name = "Dartium";

  final Future<Uri> observatoryUrl;

  final Future<Uri> remoteDebuggerUrl;

  factory Dartium(url, {ExecutableSettings settings, bool debug: false}) {
    settings ??= defaultSettings[TestPlatform.dartium];
    var observatoryCompleter = new Completer<Uri>.sync();
    var remoteDebuggerCompleter = new Completer<Uri>.sync();
    return new Dartium._(() async {
      var tryPort = ([int port]) async {
        var dir = createTempDir();
        var args = [
          "--user-data-dir=$dir",
          url.toString(),
          "--disable-extensions",
          "--disable-popup-blocking",
          "--bwsi",
          "--no-first-run",
          "--no-default-browser-check",
          "--disable-default-apps",
          "--disable-translate"
        ]..addAll(settings.arguments);

        if (port != null) {
          args.add("--remote-debugging-port=$port");

          // This forces Dartium to emit logging on Windows. See sdk#28034.
          args.add("--enable-logging=stderr");

          // This flags causes Dartium to print a consistent line of output
          // after its internal call to `bind()` has succeeded or failed. We
          // wait for that output to determine whether the port we chose worked.
          args.add("--vmodule=startup_browser_creator_impl=1");
        }

        var process = await Process.start(settings.executable, args,
            environment: {"DART_FLAGS": "--checked"});

        if (port != null) {
          // Dartium on Windows prints all standard IO to stderr, so we need to
          // look there rather than stdout for the Observatory URL.
          Stream<List<int>> observatoryStream;
          Stream<List<int>> logStream;
          if (Platform.isWindows) {
            var split = StreamSplitter.splitFrom(process.stderr);
            observatoryStream = split.first;
            logStream = split.last;
          } else {
            observatoryStream = process.stdout;
            logStream = process.stderr;
          }

          observatoryCompleter.complete(_getObservatoryUrl(observatoryStream));

          var logs = new StreamIterator(lineSplitter.bind(logStream));

          // Before we can consider Dartium started successfully, we have to
          // make sure the remote debugging port worked. Any errors from this
          // will always come before the "Running without renderer sandbox"
          // message.
          while (await logs.moveNext() &&
              !logs.current.contains("startup_browser_creator_impl")) {
            if (logs.current.contains("bind() returned an error")) {
              // If we failed to bind to the port, return null to tell
              // getUnusedPort to try another one.
              logs.cancel();
              process.kill();
              return null;
            }
          }
          logs.cancel();
        } else {
          observatoryCompleter.complete(null);
        }

        if (port != null) {
          remoteDebuggerCompleter.complete(
              getRemoteDebuggerUrl(Uri.parse("http://localhost:$port")));
        } else {
          remoteDebuggerCompleter.complete(null);
        }

        process.exitCode
            .then((_) => new Directory(dir).deleteSync(recursive: true));

        return process;
      };

      if (!debug) return tryPort();
      return getUnusedPort<Future<Process>>(tryPort);
    }, observatoryCompleter.future, remoteDebuggerCompleter.future);
  }

  Dartium._(Future<Process> startBrowser(), this.observatoryUrl,
      this.remoteDebuggerUrl)
      : super(startBrowser);

  // TODO(nweiz): simplify this when sdk#23923 is fixed.
  /// Returns the Observatory URL for the Dartium executable with the given
  /// [stdout] stream, or `null` if the correct one couldn't be found.
  ///
  /// Dartium prints out three different Observatory URLs when it starts. Only
  /// one of them is connected to the VM instance running the host page, and the
  /// ordering isn't guaranteed, so we need to figure out which one is correct.
  /// We do so by connecting to the VM service via WebSockets and looking for
  /// the Observatory instance that actually contains an isolate, and returning
  /// the corresponding URI.
  static Future<Uri> _getObservatoryUrl(Stream<List<int>> stdout) async {
    var urlQueue = new StreamQueue<Uri>(lineSplitter.bind(stdout).map((line) {
      var match = _observatoryRegExp.firstMatch(line);
      return match == null ? null : Uri.parse(match[1]);
    }).where((line) => line != null));

    var operations = [urlQueue.next, urlQueue.next, urlQueue.next]
        .map((future) => _checkObservatoryUrl(future));

    urlQueue.cancel();

    /// Dartium will print three possible observatory URLs. For each one, we
    /// check whether it's actually connected to an isolate, indicating that
    /// it's the observatory for the main page. Once we find the one that is, we
    /// cancel the other requests and return it.
    return (await inCompletionOrder(operations)
        .firstWhere((url) => url != null, defaultValue: () => null)) as Uri;
  }

  /// If the URL returned by [future] corresponds to the correct Observatory
  /// instance, returns it. Otherwise, returns `null`.
  ///
  /// If the returned operation is canceled before it fires, the WebSocket
  /// connection with the given Observatory will be closed immediately.
  static CancelableOperation<Uri> _checkObservatoryUrl(Future<Uri> future) {
    var webSocket;
    var canceled = false;
    var completer = new CancelableCompleter<Uri>(onCancel: () {
      canceled = true;
      if (webSocket != null) webSocket.close();
    });

    // We've encountered a format we don't understand. Close the web socket and
    // complete to null.
    giveUp() {
      webSocket.close();
      if (!completer.isCompleted) completer.complete();
    }

    future.then((url) async {
      try {
        webSocket = await WebSocket
            .connect(url.replace(scheme: 'ws', path: '/ws').toString());
        if (canceled) {
          webSocket.close();
          return null;
        }

        webSocket.add(JSON.encode({
          "jsonrpc": "2.0",
          "method": "streamListen",
          "params": {"streamId": "Isolate"},
          "id": "0"
        }));

        webSocket.add(JSON.encode(
            {"jsonrpc": "2.0", "method": "getVM", "params": {}, "id": "1"}));

        webSocket.listen((response) {
          try {
            response = JSON.decode(response);
          } on FormatException catch (_) {
            giveUp();
            return;
          }

          // If there's a "response" key, we're probably talking to the pre-1.0
          // VM service protocol, in which case we should just give up.
          if (response is! Map || response.containsKey("response")) {
            giveUp();
            return;
          }

          if (response["id"] == "0") return;

          if (response["id"] == "1") {
            var result = response["result"];
            if (result is! Map) {
              giveUp();
              return;
            }

            var isolates = result["isolates"];
            if (isolates is! List) {
              giveUp();
              return;
            }

            if (isolates.isNotEmpty) {
              webSocket.close();
              if (!completer.isCompleted) completer.complete(url);
            }
            return;
          }

          // The 1.0 protocol used a raw "event" key, while the 2.0 protocol
          // wraps it in JSON-RPC method params.
          var event;
          if (response.containsKey("event")) {
            event = response["event"];
          } else {
            var params = response["params"];
            if (params is Map) event = params["event"];
          }

          if (event is! Map) {
            giveUp();
            return;
          }

          if (event["kind"] != "IsolateStart") return;
          webSocket.close();
          if (completer.isCompleted) return;

          // TODO(nweiz): include the isolate ID in the URL?
          completer.complete(url);
        });
      } on IOException catch (_) {
        // IO exceptions are probably caused by connecting to an
        // incorrect WebSocket that already closed.
        return null;
      }
    }).catchError((error, stackTrace) {
      if (!completer.isCompleted) completer.completeError(error, stackTrace);
    });

    return completer.operation;
  }
}
