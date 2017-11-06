// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:node_preamble/preamble.dart' as preamble;
import 'package:package_resolver/package_resolver.dart';
import 'package:path/path.dart' as p;
import 'package:stream_channel/stream_channel.dart';
import 'package:yaml/yaml.dart';

import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../../util/stack_trace_mapper.dart';
import '../../utils.dart';
import '../application_exception.dart';
import '../compiler_pool.dart';
import '../configuration.dart';
import '../configuration/suite.dart';
import '../executable_settings.dart';
import '../load_exception.dart';
import '../plugin/customizable_platform.dart';
import '../plugin/environment.dart';
import '../plugin/platform.dart';
import '../plugin/platform_helpers.dart';
import '../runner_suite.dart';

/// A platform that loads tests in Node.js processes.
class NodePlatform extends PlatformPlugin
    implements CustomizablePlatform<ExecutableSettings> {
  /// The test runner configuration.
  final Configuration _config;

  /// The [CompilerPool] managing active instances of `dart2js`.
  final _compilers = new CompilerPool(["-Dnode=true"]);

  /// The temporary directory in which compiled JS is emitted.
  final _compiledDir = createTempDir();

  /// The HTTP client to use when fetching JS files for `pub serve`.
  final HttpClient _http;

  /// Executable settings for [TestPlatform.nodeJS] and platforms that extend
  /// it.
  final _settings = {
    TestPlatform.nodeJS: new ExecutableSettings(
        linuxExecutable: "node",
        macOSExecutable: "node",
        windowsExecutable: "node.exe")
  };

  NodePlatform()
      : _config = Configuration.current,
        _http =
            Configuration.current.pubServeUrl == null ? null : new HttpClient();

  ExecutableSettings parsePlatformSettings(YamlMap settings) =>
      new ExecutableSettings.parse(settings);

  ExecutableSettings mergePlatformSettings(
          ExecutableSettings settings1, ExecutableSettings settings2) =>
      settings1.merge(settings2);

  void customizePlatform(TestPlatform platform, ExecutableSettings settings) {
    var oldSettings = _settings[platform] ?? _settings[platform.root];
    if (oldSettings != null) settings = oldSettings.merge(settings);
    _settings[platform] = settings;
  }

  StreamChannel loadChannel(String path, TestPlatform platform) =>
      throw new UnimplementedError();

  Future<RunnerSuite> load(String path, TestPlatform platform,
      SuiteConfiguration suiteConfig, Object message) async {
    assert(platform == TestPlatform.nodeJS);

    var pair = await _loadChannel(path, platform, suiteConfig);
    var controller = await deserializeSuite(path, platform, suiteConfig,
        new PluginEnvironment(), pair.first, message,
        mapper: pair.last);
    return controller.suite;
  }

  /// Loads a [StreamChannel] communicating with the test suite at [path].
  ///
  /// Returns that channel along with a [StackTraceMapper] representing the
  /// source map for the compiled suite.
  Future<Pair<StreamChannel, StackTraceMapper>> _loadChannel(String path,
      TestPlatform platform, SuiteConfiguration suiteConfig) async {
    var pair = await _spawnProcess(path, platform, suiteConfig);
    var process = pair.first;

    // Node normally doesn't emit any standard error, but if it does we forward
    // it to the print handler so it's associated with the load test.
    process.stderr.transform(lineSplitter).listen(print);

    var channel = new StreamChannel.withGuarantees(
            process.stdout, process.stdin)
        .transform(new StreamChannelTransformer.fromCodec(UTF8))
        .transform(chunksToLines)
        .transform(jsonDocument)
        .transformStream(new StreamTransformer.fromHandlers(handleDone: (sink) {
      if (process != null) process.kill();
      sink.close();
    }));

    return new Pair(channel, pair.last);
  }

  /// Spawns a Node.js process that loads the Dart test suite at [path].
  ///
  /// Returns that channel along with a [StackTraceMapper] representing the
  /// source map for the compiled suite.
  Future<Pair<Process, StackTraceMapper>> _spawnProcess(String path,
      TestPlatform platform, SuiteConfiguration suiteConfig) async {
    var dir = new Directory(_compiledDir).createTempSync('test_').path;
    var jsPath = p.join(dir, p.basename(path) + ".node_test.dart.js");

    if (_config.pubServeUrl == null) {
      await _compilers.compile('''
        import "package:test/src/bootstrap/node.dart";

        import "${p.toUri(p.absolute(path))}" as test;

        void main() {
          internalBootstrapNodeTest(() => test.main);
        }
      ''', jsPath, suiteConfig);

      // Add the Node.js preamble to ensure that the dart2js output is
      // compatible. Use the minified version so the source map remains valid.
      var jsFile = new File(jsPath);
      await jsFile.writeAsString(
          preamble.getPreamble(minified: true) + await jsFile.readAsString());

      StackTraceMapper mapper;
      if (!suiteConfig.jsTrace) {
        var mapPath = jsPath + '.map';
        mapper = new StackTraceMapper(await new File(mapPath).readAsString(),
            mapUrl: p.toUri(mapPath),
            packageResolver: await PackageResolver.current.asSync,
            sdkRoot: p.toUri(sdkDir));
      }

      return new Pair(await _startProcess(platform, jsPath), mapper);
    }

    var url = _config.pubServeUrl.resolveUri(
        p.toUri(p.relative(path, from: 'test') + '.node_test.dart.js'));

    var js = await _get(url, path);
    await new File(jsPath)
        .writeAsString(preamble.getPreamble(minified: true) + js);

    StackTraceMapper mapper;
    if (!suiteConfig.jsTrace) {
      var mapUrl = url.replace(path: url.path + '.map');
      mapper = new StackTraceMapper(await _get(mapUrl, path),
          mapUrl: mapUrl,
          packageResolver: new SyncPackageResolver.root('packages'),
          sdkRoot: p.toUri('packages/\$sdk'));
    }

    return new Pair(await _startProcess(platform, jsPath), mapper);
  }

  /// Starts the Node.js process for [platform] with [jsPath].
  Future<Process> _startProcess(TestPlatform platform, String jsPath) async {
    var settings = _settings[platform];
    try {
      return await Process.start(
          settings.executable, settings.arguments.toList()..add(jsPath));
    } catch (error, stackTrace) {
      await new Future.error(
          new ApplicationException(
              "Failed to run ${platform.name}: ${getErrorMessage(error)}"),
          stackTrace);
      return null;
    }
  }

  /// Runs an HTTP GET on [url].
  ///
  /// If this fails, throws a [LoadException] for [suitePath].
  Future<String> _get(Uri url, String suitePath) async {
    try {
      var response = await (await _http.getUrl(url)).close();

      if (response.statusCode != 200) {
        // We don't care about the response body, but we have to drain it or
        // else the process can't exit.
        response.listen(null);

        throw new LoadException(
            suitePath,
            "Error getting $url: ${response.statusCode} "
            "${response.reasonPhrase}\n"
            'Make sure "pub serve" is serving the test/ directory.');
      }

      return await UTF8.decodeStream(response);
    } on IOException catch (error) {
      var message = getErrorMessage(error);
      if (error is SocketException) {
        message = "${error.osError.message} "
            "(errno ${error.osError.errorCode})";
      }

      throw new LoadException(
          suitePath,
          "Error getting $url: $message\n"
          'Make sure "pub serve" is running.');
    }
  }

  Future close() => _closeMemo.runOnce(() async {
        await _compilers.close();

        if (_config.pubServeUrl == null) {
          new Directory(_compiledDir).deleteSync(recursive: true);
        } else {
          _http.close();
        }
      });
  final _closeMemo = new AsyncMemoizer();
}
