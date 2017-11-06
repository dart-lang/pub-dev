// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../executable_settings.dart';
import 'browser.dart';
import 'default_settings.dart';

/// A class for running an instance of Safari.
///
/// Any errors starting or running the process are reported through [onExit].
class Safari extends Browser {
  final name = "Safari";

  Safari(url, {ExecutableSettings settings})
      : super(() => _startBrowser(url, settings));

  /// Starts a new instance of Safari open to the given [url], which may be a
  /// [Uri] or a [String].
  static Future<Process> _startBrowser(url, ExecutableSettings settings) async {
    settings ??= defaultSettings[TestPlatform.safari];
    var dir = createTempDir();

    // Safari will only open files (not general URLs) via the command-line
    // API, so we create a dummy file to redirect it to the page we actually
    // want it to load.
    var redirect = p.join(dir, 'redirect.html');
    new File(redirect).writeAsStringSync(
        "<script>location = " + JSON.encode(url.toString()) + "</script>");

    var process = await Process.start(
        settings.executable, settings.arguments.toList()..add(redirect));

    process.exitCode
        .then((_) => new Directory(dir).deleteSync(recursive: true));

    return process;
  }
}
