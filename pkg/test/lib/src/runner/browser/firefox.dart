// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../executable_settings.dart';
import 'browser.dart';
import 'default_settings.dart';

final _preferences = '''
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("dom.disable_open_during_load", false);
user_pref("dom.max_script_run_time", 0);
''';

/// A class for running an instance of Firefox.
///
/// Most of the communication with the browser is expected to happen via HTTP,
/// so this exposes a bare-bones API. The browser starts as soon as the class is
/// constructed, and is killed when [close] is called.
///
/// Any errors starting or running the process are reported through [onExit].
class Firefox extends Browser {
  final name = "Firefox";

  Firefox(url, {ExecutableSettings settings})
      : super(() => _startBrowser(url, settings));

  /// Starts a new instance of Firefox open to the given [url], which may be a
  /// [Uri] or a [String].
  static Future<Process> _startBrowser(url, ExecutableSettings settings) async {
    settings ??= defaultSettings[TestPlatform.dartium];
    var dir = createTempDir();
    new File(p.join(dir, 'prefs.js')).writeAsStringSync(_preferences);

    var process = await Process.start(
        settings.executable,
        ["--profile", "$dir", url.toString(), "--no-remote"]
          ..addAll(settings.arguments),
        environment: {"MOZ_CRASHREPORTER_DISABLE": "1"});

    process.exitCode
        .then((_) => new Directory(dir).deleteSync(recursive: true));

    return process;
  }
}
