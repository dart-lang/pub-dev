// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../executable_settings.dart';
import 'browser.dart';
import 'default_settings.dart';

// TODO(nweiz): move this into its own package?
/// A class for running an instance of Chrome.
///
/// Most of the communication with the browser is expected to happen via HTTP,
/// so this exposes a bare-bones API. The browser starts as soon as the class is
/// constructed, and is killed when [close] is called.
///
/// Any errors starting or running the process are reported through [onExit].
class Chrome extends Browser {
  final name = "Chrome";

  final Future<Uri> remoteDebuggerUrl;

  /// Starts a new instance of Chrome open to the given [url], which may be a
  /// [Uri] or a [String].
  factory Chrome(url, {ExecutableSettings settings, bool debug: false}) {
    settings ??= defaultSettings[TestPlatform.chrome];
    var remoteDebuggerCompleter = new Completer<Uri>.sync();
    return new Chrome._(() async {
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
          "--disable-translate",
        ]..addAll(settings.arguments);

        // Currently, Chrome doesn't provide any way of ensuring that this port
        // was successfully bound. It produces an error if the binding fails,
        // but without a reliable and fast way to tell if it succeeded that
        // doesn't provide us much. It's very unlikely that this port will fail,
        // though.
        if (port != null) args.add("--remote-debugging-port=$port");

        var process = await Process.start(settings.executable, args);

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
    }, remoteDebuggerCompleter.future);
  }

  Chrome._(Future<Process> startBrowser(), this.remoteDebuggerUrl)
      : super(startBrowser);
}
