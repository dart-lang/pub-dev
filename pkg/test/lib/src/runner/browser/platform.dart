// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:async/async.dart';
import 'package:http_multi_server/http_multi_server.dart';
import 'package:package_resolver/package_resolver.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:shelf_packages_handler/shelf_packages_handler.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yaml/yaml.dart';

import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../../util/one_off_handler.dart';
import '../../util/path_handler.dart';
import '../../util/stack_trace_mapper.dart';
import '../../utils.dart';
import '../compiler_pool.dart';
import '../configuration.dart';
import '../configuration/suite.dart';
import '../executable_settings.dart';
import '../load_exception.dart';
import '../plugin/customizable_platform.dart';
import '../plugin/platform.dart';
import '../runner_suite.dart';
import 'browser_manager.dart';
import 'default_settings.dart';
import 'polymer.dart';

class BrowserPlatform extends PlatformPlugin
    implements CustomizablePlatform<ExecutableSettings> {
  /// Starts the server.
  ///
  /// [root] is the root directory that the server should serve. It defaults to
  /// the working directory.
  static Future<BrowserPlatform> start({String root}) async {
    var server = new shelf_io.IOServer(await HttpMultiServer.loopback(0));
    return new BrowserPlatform._(
        server,
        Configuration.current,
        p.fromUri(await Isolate.resolvePackageUri(
            Uri.parse('package:test/src/runner/browser/static/favicon.ico'))),
        root: root);
  }

  /// The test runner configuration.
  final Configuration _config;

  /// The underlying server.
  final shelf.Server _server;

  /// A randomly-generated secret.
  ///
  /// This is used to ensure that other users on the same system can't snoop
  /// on data being served through this server.
  final _secret = Uri.encodeComponent(randomBase64(24));

  /// The URL for this server.
  Uri get url => _server.url.resolve(_secret + "/");

  /// A [OneOffHandler] for servicing WebSocket connections for
  /// [BrowserManager]s.
  ///
  /// This is one-off because each [BrowserManager] can only connect to a single
  /// WebSocket,
  final _webSocketHandler = new OneOffHandler();

  /// A [PathHandler] used to serve compiled JS.
  final _jsHandler = new PathHandler();

  /// The [CompilerPool] managing active instances of `dart2js`.
  final _compilers = new CompilerPool();

  /// The temporary directory in which compiled JS is emitted.
  final String _compiledDir;

  /// The root directory served statically by this server.
  final String _root;

  /// The pool of active `pub serve` compilations.
  ///
  /// Pub itself ensures that only one compilation runs at a time; we just use
  /// this pool to make sure that the output is nice and linear.
  final _pubServePool = new Pool(1);

  /// The HTTP client to use when caching JS files in `pub serve`.
  final HttpClient _http;

  /// Whether [close] has been called.
  bool get _closed => _closeMemo.hasRun;

  /// A map from browser identifiers to futures that will complete to the
  /// [BrowserManager]s for those browsers, or `null` if they failed to load.
  ///
  /// This should only be accessed through [_browserManagerFor].
  final _browserManagers = <TestPlatform, Future<BrowserManager>>{};

  /// Settings for invoking each browser.
  ///
  /// This starts out with the default settings, which may be overridden by user settings.
  final _browserSettings =
      new Map<TestPlatform, ExecutableSettings>.from(defaultSettings);

  /// A cascade of handlers for suites' precompiled paths.
  ///
  /// This is `null` if there are no precompiled suites yet.
  shelf.Cascade _precompiledCascade;

  /// The precompiled paths that have handlers in [_precompiledHandler].
  final _precompiledPaths = new Set<String>();

  /// A map from test suite paths to Futures that will complete once those
  /// suites are finished compiling.
  ///
  /// This is used to make sure that a given test suite is only compiled once
  /// per run, rather than once per browser per run.
  final _compileFutures = new Map<String, Future>();

  /// Mappers for Dartifying stack traces, indexed by test path.
  final _mappers = new Map<String, StackTraceMapper>();

  BrowserPlatform._(this._server, Configuration config, String faviconPath,
      {String root})
      : _config = config,
        _root = root == null ? p.current : root,
        _compiledDir = config.pubServeUrl == null ? createTempDir() : null,
        _http = config.pubServeUrl == null ? null : new HttpClient() {
    var cascade = new shelf.Cascade().add(_webSocketHandler.handler);

    if (_config.pubServeUrl == null) {
      cascade = cascade
          .add(packagesDirHandler())
          .add(_jsHandler.handler)
          .add(createStaticHandler(_root))

          // Add this before the wrapper handler so that its HTML takes
          // precedence over the test runner's.
          .add((request) =>
              _precompiledCascade?.handler(request) ??
              new shelf.Response.notFound(null))
          .add(_wrapperHandler);
    }

    var pipeline = new shelf.Pipeline()
        .addMiddleware(PathHandler.nestedIn(_secret))
        .addHandler(cascade.handler);

    _server.mount(new shelf.Cascade()
        .add(createFileHandler(faviconPath))
        .add(pipeline)
        .handler);
  }

  /// A handler that serves wrapper files used to bootstrap tests.
  shelf.Response _wrapperHandler(shelf.Request request) {
    var path = p.fromUri(request.url);

    if (path.endsWith(".browser_test.dart")) {
      var testPath = p.basename(p.withoutExtension(p.withoutExtension(path)));
      return new shelf.Response.ok('''
        import "package:stream_channel/stream_channel.dart";

        import "package:test/src/runner/plugin/remote_platform_helpers.dart";
        import "package:test/src/runner/browser/post_message_channel.dart";

        import "$testPath" as test;

        void main() {
          var channel = serializeSuite(() => test.main, hidePrints: false);
          postMessageChannel().pipe(channel);
        }
      ''', headers: {'Content-Type': 'application/dart'});
    }

    if (path.endsWith(".html")) {
      var test = p.withoutExtension(path) + ".dart";

      // Link to the Dart wrapper on Dartium and the compiled JS version
      // elsewhere.
      var scriptBase =
          "${HTML_ESCAPE.convert(p.basename(test))}.browser_test.dart";
      var script = request.headers['user-agent'].contains('(Dart)')
          ? 'type="application/dart" src="$scriptBase"'
          : 'src="$scriptBase.js"';

      return new shelf.Response.ok('''
        <!DOCTYPE html>
        <html>
        <head>
          <title>${HTML_ESCAPE.convert(test)} Test</title>
          <script $script></script>
        </head>
        </html>
      ''', headers: {'Content-Type': 'text/html'});
    }

    return new shelf.Response.notFound('Not found.');
  }

  ExecutableSettings parsePlatformSettings(YamlMap settings) =>
      new ExecutableSettings.parse(settings);

  ExecutableSettings mergePlatformSettings(
          ExecutableSettings settings1, ExecutableSettings settings2) =>
      settings1.merge(settings2);

  void customizePlatform(TestPlatform platform, ExecutableSettings settings) {
    var oldSettings =
        _browserSettings[platform] ?? _browserSettings[platform.root];
    if (oldSettings != null) settings = oldSettings.merge(settings);
    _browserSettings[platform] = settings;
  }

  /// Loads the test suite at [path] on the browser [browser].
  ///
  /// This will start a browser to load the suite if one isn't already running.
  /// Throws an [ArgumentError] if [browser] isn't a browser platform.
  Future<RunnerSuite> load(String path, TestPlatform browser,
      SuiteConfiguration suiteConfig, Object message) async {
    assert(suiteConfig.platforms.contains(browser.identifier));

    if (!browser.isBrowser) {
      throw new ArgumentError("$browser is not a browser.");
    }

    var htmlPath = p.withoutExtension(path) + '.html';
    if (new File(htmlPath).existsSync() &&
        !new File(htmlPath)
            .readAsStringSync()
            .contains('packages/test/dart.js')) {
      throw new LoadException(
          path,
          '"${htmlPath}" must contain <script src="packages/test/dart.js">'
          '</script>.');
    }

    var suiteUrl;
    if (_config.pubServeUrl != null) {
      var suitePrefix = p
          .toUri(
              p.withoutExtension(p.relative(path, from: p.join(_root, 'test'))))
          .path;

      var dartUrl;
      // Polymer generates a bootstrap entrypoint that wraps the entrypoint we
      // see on disk, and modifies the HTML file to point to the bootstrap
      // instead. To make sure we get the right source maps and wait for the
      // right file to compile, we have some Polymer-specific logic here to load
      // the boostrap instead of the unwrapped file.
      if (isPolymerEntrypoint(path)) {
        dartUrl = _config.pubServeUrl.resolve(
            "$suitePrefix.html.polymer.bootstrap.dart.browser_test.dart");
      } else {
        dartUrl =
            _config.pubServeUrl.resolve('$suitePrefix.dart.browser_test.dart');
      }

      await _pubServeSuite(path, dartUrl, browser, suiteConfig);
      suiteUrl = _config.pubServeUrl.resolveUri(p.toUri('$suitePrefix.html'));
    } else {
      if (browser.isJS) {
        if (_precompiled(suiteConfig, path)) {
          if (_precompiledPaths.add(suiteConfig.precompiledPath)) {
            if (!suiteConfig.jsTrace) {
              var jsPath = p.join(suiteConfig.precompiledPath,
                  p.relative(path + ".browser_test.dart.js", from: _root));

              var sourceMapPath = '${jsPath}.map';
              if (new File(sourceMapPath).existsSync()) {
                _mappers[path] = new StackTraceMapper(
                    new File(sourceMapPath).readAsStringSync(),
                    mapUrl: p.toUri(sourceMapPath),
                    packageResolver: await PackageResolver.current.asSync,
                    sdkRoot: p.toUri(sdkDir));
              }
            }
            _precompiledCascade ??= new shelf.Cascade();
            _precompiledCascade = _precompiledCascade
                .add(createStaticHandler(suiteConfig.precompiledPath));
          }
        } else {
          await _compileSuite(path, suiteConfig);
        }
      }

      if (_closed) return null;
      suiteUrl = url.resolveUri(
          p.toUri(p.withoutExtension(p.relative(path, from: _root)) + ".html"));
    }

    if (_closed) return null;

    // TODO(nweiz): Don't start the browser until all the suites are compiled.
    var browserManager = await _browserManagerFor(browser);
    if (_closed || browserManager == null) return null;

    var suite = await browserManager.load(path, suiteUrl, suiteConfig, message,
        mapper: browser.isJS ? _mappers[path] : null);
    if (_closed) return null;
    return suite;
  }

  /// Returns whether the test at [path] has precompiled HTML available
  /// underneath [suiteConfig.precompiledPath].
  bool _precompiled(SuiteConfiguration suiteConfig, String path) {
    if (suiteConfig.precompiledPath == null) return false;
    var htmlPath = p.join(suiteConfig.precompiledPath,
        p.relative(p.withoutExtension(path) + ".html", from: _root));
    return new File(htmlPath).existsSync();
  }

  StreamChannel loadChannel(String path, TestPlatform platform) =>
      throw new UnimplementedError();

  /// Loads a test suite at [path] from the `pub serve` URL [dartUrl].
  ///
  /// This ensures that only one suite is loaded at a time, and that any errors
  /// are exposed as [LoadException]s.
  Future _pubServeSuite(String path, Uri dartUrl, TestPlatform browser,
      SuiteConfiguration suiteConfig) {
    return _pubServePool.withResource(() async {
      var timer = new Timer(new Duration(seconds: 1), () {
        print('"pub serve" is compiling $path...');
      });

      // For browsers that run Dart compiled to JavaScript, get the source map
      // instead of the Dart code for two reasons. We want to verify that the
      // server's dart2js compiler is running on the Dart code, and also load
      // the StackTraceMapper.
      var getSourceMap = browser.isJS;

      var url = getSourceMap
          ? dartUrl.replace(path: dartUrl.path + '.js.map')
          : dartUrl;

      HttpClientResponse response;
      try {
        var request = await _http.getUrl(url);
        response = await request.close();

        if (response.statusCode != 200) {
          // We don't care about the response body, but we have to drain it or
          // else the process can't exit.
          response.listen((_) {});

          throw new LoadException(
              path,
              "Error getting $url: ${response.statusCode} "
              "${response.reasonPhrase}\n"
              'Make sure "pub serve" is serving the test/ directory.');
        }

        if (getSourceMap && !suiteConfig.jsTrace) {
          _mappers[path] = new StackTraceMapper(
              await UTF8.decodeStream(response),
              mapUrl: url,
              packageResolver: new SyncPackageResolver.root('packages'),
              sdkRoot: p.toUri('packages/\$sdk'));
          return;
        }

        // Drain the response stream.
        response.listen((_) {});
      } on IOException catch (error) {
        var message = getErrorMessage(error);
        if (error is SocketException) {
          message = "${error.osError.message} "
              "(errno ${error.osError.errorCode})";
        }

        throw new LoadException(
            path,
            "Error getting $url: $message\n"
            'Make sure "pub serve" is running.');
      } finally {
        timer.cancel();
      }
    });
  }

  /// Compile the test suite at [dartPath] to JavaScript.
  ///
  /// Once the suite has been compiled, it's added to [_jsHandler] so it can be
  /// served.
  Future _compileSuite(String dartPath, SuiteConfiguration suiteConfig) {
    return _compileFutures.putIfAbsent(dartPath, () async {
      var dir = new Directory(_compiledDir).createTempSync('test_').path;
      var jsPath = p.join(dir, p.basename(dartPath) + ".browser_test.dart.js");

      await _compilers.compile('''
        import "package:test/src/bootstrap/browser.dart";

        import "${p.toUri(p.absolute(dartPath))}" as test;

        void main() {
          internalBootstrapBrowserTest(() => test.main);
        }
      ''', jsPath, suiteConfig);
      if (_closed) return;

      var jsUrl = p.toUri(p.relative(dartPath, from: _root)).path +
          '.browser_test.dart.js';
      _jsHandler.add(jsUrl, (request) {
        return new shelf.Response.ok(new File(jsPath).readAsStringSync(),
            headers: {'Content-Type': 'application/javascript'});
      });

      var mapUrl = p.toUri(p.relative(dartPath, from: _root)).path +
          '.browser_test.dart.js.map';
      _jsHandler.add(mapUrl, (request) {
        return new shelf.Response.ok(
            new File(jsPath + '.map').readAsStringSync(),
            headers: {'Content-Type': 'application/json'});
      });

      if (suiteConfig.jsTrace) return;
      var mapPath = jsPath + '.map';
      _mappers[dartPath] = new StackTraceMapper(
          new File(mapPath).readAsStringSync(),
          mapUrl: p.toUri(mapPath),
          packageResolver: await PackageResolver.current.asSync,
          sdkRoot: p.toUri(sdkDir));
    });
  }

  /// Returns the [BrowserManager] for [platform], which should be a browser.
  ///
  /// If no browser manager is running yet, starts one.
  Future<BrowserManager> _browserManagerFor(TestPlatform platform) {
    var managerFuture = _browserManagers[platform];
    if (managerFuture != null) return managerFuture;

    var completer = new Completer<WebSocketChannel>.sync();
    var path = _webSocketHandler.create(webSocketHandler(completer.complete));
    var webSocketUrl = url.replace(scheme: 'ws').resolve(path);
    var hostUrl = (_config.pubServeUrl == null ? url : _config.pubServeUrl)
        .resolve('packages/test/src/runner/browser/static/index.html')
        .replace(queryParameters: {
      'managerUrl': webSocketUrl.toString(),
      'debug': _config.pauseAfterLoad.toString()
    });

    var future = BrowserManager.start(
        platform, hostUrl, completer.future, _browserSettings[platform],
        debug: _config.pauseAfterLoad);

    // Store null values for browsers that error out so we know not to load them
    // again.
    _browserManagers[platform] = future.catchError((_) => null);

    return future;
  }

  /// Close all the browsers that the server currently has open.
  ///
  /// Note that this doesn't close the server itself. Browser tests can still be
  /// loaded, they'll just spawn new browsers.
  Future closeEphemeral() {
    var managers = _browserManagers.values.toList();
    _browserManagers.clear();
    return Future.wait(managers.map((manager) async {
      var result = await manager;
      if (result == null) return;
      await result.close();
    }));
  }

  /// Closes the server and releases all its resources.
  ///
  /// Returns a [Future] that completes once the server is closed and its
  /// resources have been fully released.
  Future close() => _closeMemo.runOnce(() async {
        var futures =
            _browserManagers.values.map<Future<dynamic>>((future) async {
          var result = await future;
          if (result == null) return;

          await result.close();
        }).toList();

        futures.add(_server.close());
        futures.add(_compilers.close());

        await Future.wait(futures);

        if (_config.pubServeUrl == null) {
          new Directory(_compiledDir).deleteSync(recursive: true);
        } else {
          _http.close();
        }
      });
  final _closeMemo = new AsyncMemoizer();
}
