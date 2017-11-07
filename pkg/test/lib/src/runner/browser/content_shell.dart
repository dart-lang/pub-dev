// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../../utils.dart';
import '../application_exception.dart';
import '../executable_settings.dart';
import 'browser.dart';
import 'default_settings.dart';

final _observatoryRegExp = new RegExp(r"^Observatory listening on ([^ ]+)");
final _errorTimeout = const Duration(seconds: 10);

/// A class for running an instance of the Dartium content shell.
///
/// Most of the communication with the browser is expected to happen via HTTP,
/// so this exposes a bare-bones API. The browser starts as soon as the class is
/// constructed, and is killed when [close] is called.
///
/// Any errors starting or running the process are reported through [onExit].
class ContentShell extends Browser {
  final name = "Content Shell";

  final Future<Uri> observatoryUrl;

  final Future<Uri> remoteDebuggerUrl;

  factory ContentShell(url, {ExecutableSettings settings, bool debug: false}) {
    settings ??= defaultSettings[TestPlatform.contentShell];
    var observatoryCompleter = new Completer<Uri>.sync();
    var remoteDebuggerCompleter = new Completer<Uri>.sync();
    return new ContentShell._(() {
      var tryPort = ([int port]) async {
        var args = ["--dump-render-tree", url.toString()]
          ..addAll(settings.arguments);
        if (port != null) args.add("--remote-debugging-port=$port");

        var process = await Process.start(settings.executable, args,
            environment: {"DART_FLAGS": "--checked"});

        if (debug) {
          observatoryCompleter.complete(lineSplitter
              .bind(process.stdout)
              .map((line) {
                var match = _observatoryRegExp.firstMatch(line);
                if (match == null) return null;
                return Uri.parse(match[1]);
              })
              .where((uri) => uri != null)
              .first);
        } else {
          observatoryCompleter.complete(null);
        }

        var stderr = new StreamIterator(lineSplitter.bind(process.stderr));

        // Before we can consider content_shell started successfully, we have to
        // make sure it's not expired and that the remote debugging port worked.
        // Any errors from this will always come before the "Running without
        // renderer sandbox" message.
        while (await stderr.moveNext().timeout(_errorTimeout).catchError((_) =>
                throw new ApplicationException(
                    "Error starting up content_shell.\n"
                    "Ensure you are using the latest version:\n"
                    "http://gsdview.appspot.com/dart-archive/channels/stable/"
                    "release/latest/dartium/")) &&
            !stderr.current.endsWith("Running without renderer sandbox") &&
            !stderr.current.contains("Running without the SUID sandbox") &&
            // Error messages on Mac can get gobbled, we must assume that it
            // it started up successfully.
            !stderr.current
                .contains("kq_init: detected broken kqueue; not using")) {
          if (stderr.current == "[dartToStderr]: Dartium build has expired") {
            stderr.cancel();
            process.kill();
            // TODO(nweiz): link to dartlang.org once it has download links for
            // content shell
            // (https://github.com/dart-lang/www.dartlang.org/issues/1164).
            throw new ApplicationException(
                "You're using an expired content_shell. Upgrade to the latest "
                "version:\n"
                "http://gsdview.appspot.com/dart-archive/channels/stable/"
                "release/latest/dartium/");
          } else if (stderr.current.contains("bind() returned an error")) {
            // If we failed to bind to the port, return null to tell
            // getUnusedPort to try another one.
            stderr.cancel();
            process.kill();
            return null;
          }
        }

        if (port != null) {
          remoteDebuggerCompleter.complete(
              getRemoteDebuggerUrl(Uri.parse("http://localhost:$port")));
        } else {
          remoteDebuggerCompleter.complete(null);
        }

        stderr.cancel();
        return process;
      };

      if (!debug) return tryPort();
      return getUnusedPort<Future<Process>>(tryPort);
    }, observatoryCompleter.future, remoteDebuggerCompleter.future);
  }

  ContentShell._(Future<Process> startBrowser(), this.observatoryUrl,
      this.remoteDebuggerUrl)
      : super(startBrowser);
}
