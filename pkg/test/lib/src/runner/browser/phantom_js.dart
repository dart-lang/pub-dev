// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../../backend/test_platform.dart';
import '../../util/exit_codes.dart' as exit_codes;
import '../../util/io.dart';
import '../application_exception.dart';
import '../executable_settings.dart';
import 'browser.dart';
import 'default_settings.dart';

/// The PhantomJS script that opens the host page.
final _script = """
var system = require('system');
var page = require('webpage').create();

// PhantomJS versions older than 2.0.0 don't support the latest WebSocket spec.
if (phantom.version.major < 2) phantom.exit(${exit_codes.protocol});

// Pipe browser messages to the process's stdout. This isn't used by default,
// but it can be useful for debugging.
page.onConsoleMessage = function(message) {
  console.log(message);
}

page.open(system.args[1], function(status) {
  if (status !== "success") phantom.exit(1);
});
""";

/// A class for running an instance of PhantomJS.
///
/// Any errors starting or running the process are reported through [onExit].
class PhantomJS extends Browser {
  final name = "PhantomJS";

  final Future<Uri> remoteDebuggerUrl;

  factory PhantomJS(url, {ExecutableSettings settings, bool debug: false}) {
    settings ??= defaultSettings[TestPlatform.phantomJS];
    var remoteDebuggerCompleter = new Completer<Uri>.sync();
    return new PhantomJS._(() async {
      var dir = createTempDir();
      var script = p.join(dir, "script.js");
      new File(script).writeAsStringSync(_script);

      var port = debug ? await getUnsafeUnusedPort() : null;

      var args = settings.arguments.toList();
      if (debug) {
        args.addAll(
            ["--remote-debugger-port=$port", "--remote-debugger-autorun=yes"]);
      }
      args.addAll([script, url.toString()]);
      var process = await Process.start(settings.executable, args);

      // PhantomJS synchronously emits standard output, which means that if we
      // don't drain its stdout stream it can deadlock.
      process.stdout.listen((_) {});

      process.exitCode.then((exitCode) {
        new Directory(dir).deleteSync(recursive: true);

        if (exitCode == exit_codes.protocol) {
          throw new ApplicationException(
              "Only PhantomJS version 2.0.0 or greater is supported");
        }
      });

      if (port != null) {
        remoteDebuggerCompleter.complete(Uri.parse(
            "http://localhost:$port/webkit/inspector/inspector.html?page=2"));
      } else {
        remoteDebuggerCompleter.complete(null);
      }

      return process;
    }, remoteDebuggerCompleter.future);
  }

  PhantomJS._(Future<Process> startBrowser(), this.remoteDebuggerUrl)
      : super(startBrowser);
}
