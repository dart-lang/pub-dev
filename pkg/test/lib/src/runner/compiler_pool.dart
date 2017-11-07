// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:package_resolver/package_resolver.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import '../util/io.dart';
import 'configuration.dart';
import 'configuration/suite.dart';

/// A regular expression matching the first status line printed by dart2js.
final _dart2jsStatus =
    new RegExp(r"^Dart file \(.*\) compiled to JavaScript: .*\n?");

/// A pool of `dart2js` instances.
///
/// This limits the number of compiler instances running concurrently.
class CompilerPool {
  /// The test runner configuration.
  final _config = Configuration.current;

  /// The internal pool that controls the number of process running at once.
  final Pool _pool;

  /// The currently-active dart2js processes.
  final _processes = new Set<Process>();

  /// Whether [close] has been called.
  bool get _closed => _closeMemo.hasRun;

  /// The memoizer for running [close] exactly once.
  final _closeMemo = new AsyncMemoizer();

  /// Extra arguments to pass to dart2js.
  final List<String> _extraArgs;

  /// Creates a compiler pool that multiple instances of `dart2js` at once.
  CompilerPool([Iterable<String> extraArgs])
      : _pool = new Pool(Configuration.current.concurrency),
        _extraArgs = extraArgs?.toList() ?? const [];

  /// Compiles [code] to [jsPath].
  ///
  /// This wraps the Dart code in the standard browser-testing wrapper.
  ///
  /// The returned [Future] will complete once the `dart2js` process completes
  /// *and* all its output has been printed to the command line.
  Future compile(String code, String jsPath, SuiteConfiguration suiteConfig) {
    return _pool.withResource(() {
      if (_closed) return null;

      return withTempDir((dir) async {
        var wrapperPath = p.join(dir, "runInBrowser.dart");
        new File(wrapperPath).writeAsStringSync(code);

        var dart2jsPath = _config.dart2jsPath;
        if (Platform.isWindows) dart2jsPath += '.bat';

        var args = [
          "--checked",
          wrapperPath,
          "--out=$jsPath",
          await PackageResolver.current.processArgument
        ]
          ..addAll(_extraArgs)
          ..addAll(suiteConfig.dart2jsArgs);

        if (_config.color) args.add("--enable-diagnostic-colors");

        var process = await Process.start(dart2jsPath, args);
        if (_closed) {
          process.kill();
          return;
        }

        _processes.add(process);

        /// Wait until the process is entirely done to print out any output.
        /// This can produce a little extra time for users to wait with no
        /// update, but it also avoids some really nasty-looking interleaved
        /// output. Write both stdout and stderr to the same buffer in case
        /// they're intended to be printed in order.
        var buffer = new StringBuffer();

        await Future.wait([
          _printOutputStream(process.stdout, buffer),
          _printOutputStream(process.stderr, buffer),
        ]);

        var exitCode = await process.exitCode;
        _processes.remove(process);
        if (_closed) return;

        var output = buffer.toString().replaceFirst(_dart2jsStatus, '');
        if (output.isNotEmpty) print(output);

        if (exitCode != 0) throw "dart2js failed.";

        _fixSourceMap(jsPath + '.map');
      });
    });
  }

  // TODO(nweiz): Remove this when sdk#17544 is fixed.
  /// Fix up the source map at [mapPath] so that it points to absolute file:
  /// URIs that are resolvable by the browser.
  void _fixSourceMap(String mapPath) {
    var map = JSON.decode(new File(mapPath).readAsStringSync());
    var root = map['sourceRoot'];

    map['sources'] = map['sources'].map((source) {
      var url = Uri.parse(root + source);
      if (url.scheme != '' && url.scheme != 'file') return source;
      if (url.path.endsWith("/runInBrowser.dart")) return "";
      return p.toUri(mapPath).resolveUri(url).toString();
    }).toList();

    new File(mapPath).writeAsStringSync(JSON.encode(map));
  }

  /// Sanitizes the bytes emitted by [stream], converts them to text, and writes
  /// them to [buffer].
  Future _printOutputStream(Stream<List<int>> stream, StringBuffer buffer) {
    return sanitizeForWindows(stream)
        .listen((data) => buffer.write(UTF8.decode(data)))
        .asFuture();
  }

  /// Closes the compiler pool.
  ///
  /// This kills all currently-running compilers and ensures that no more will
  /// be started. It returns a [Future] that completes once all the compilers
  /// have been killed and all resources released.
  Future close() {
    return _closeMemo.runOnce(() async {
      await Future.wait(_processes.map((process) async {
        process.kill();
        await process.exitCode;
      }));
    });
  }
}
