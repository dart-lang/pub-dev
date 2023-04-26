// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart' as mime;
import 'package:pana/pana.dart' show runProc;
import 'package:path/path.dart' as path;

final _logger = Logger('pub.static_files');

/// NOTE: also add annotation to routes.dart.
const staticRootPaths = <String>[
  'favicon.ico',
  'osd.xml',
];

StaticFileCache? _cache;
StaticUrls? _staticUrls;

/// The static file cache. If no cache was registered before the first access,
/// the default instance will be created.
StaticFileCache get staticFileCache =>
    _cache ??= StaticFileCache.withDefaults();

StaticUrls get staticUrls => _staticUrls ??= StaticUrls._();

/// Register the static file cache.
void registerStaticFileCacheForTest(StaticFileCache cache) {
  _cache = cache;
  _staticUrls = null;
}

/// Returns the path of the `app/` directory.
String resolveAppDir() {
  if (Directory.current.path.endsWith('/app') &&
      Directory('${Directory.current.path}/../static').existsSync()) {
    return Directory.current.path;
  }
  if (Platform.script.path.contains('bin/server.dart')) {
    return Platform.script.resolve('../').toFilePath();
  }
  if (Platform.script.path.contains('bin/fake_server.dart')) {
    return Platform.script.resolve('../').toFilePath();
  }
  if (Platform.script.path.contains('app/test')) {
    return Directory.current.path;
  }
  throw Exception('Unknown script: ${Platform.script}');
}

/// Returns the path of /static on the local filesystem.
String resolveStaticDirPath() {
  return path.join(resolveAppDir(), '../static');
}

/// Returns the path of pkg/web_app on the local filesystem.
String resolveWebAppDirPath() {
  return Directory(path.join(resolveAppDir(), '../pkg/web_app'))
      .resolveSymbolicLinksSync();
}

/// Returns the path of pkg/web_css on the local filesystem.
String resolveWebCssDirPath() {
  return Directory(path.join(resolveAppDir(), '../pkg/web_css'))
      .resolveSymbolicLinksSync();
}

/// Returns the path of pkg/pub_dartdoc on the local filesystem.
String resolvePubDartdocDirPath() {
  return Directory(path.join(resolveAppDir(), '../pkg/pub_dartdoc'))
      .resolveSymbolicLinksSync();
}

/// Returns the path of /doc on the local filesystem.
String resolveDocDirPath() {
  return path.join(resolveAppDir(), '../doc');
}

String _resolveRootDirPath() =>
    Directory(path.join(resolveAppDir(), '../')).resolveSymbolicLinksSync();
Directory _resolveDir(String relativePath) =>
    Directory(path.join(_resolveRootDirPath(), relativePath)).absolute;

/// Stores static files in memory for fast http serving.
class StaticFileCache {
  final _files = <String, StaticFile>{};
  String? _etag;

  StaticFileCache();

  StaticFileCache.withDefaults() {
    _addDirectory(Directory(resolveStaticDirPath()).absolute);
    final thirdPartyDir = _resolveDir('third_party');
    _addDirectory(_resolveDir('third_party/highlight'), baseDir: thirdPartyDir);
    _addDirectory(_resolveDir('third_party/css'), baseDir: thirdPartyDir);
    _addDirectory(_resolveDir('third_party/dartdoc/resources'),
        baseDir: thirdPartyDir);
    _addDirectory(_resolveDir('third_party/material/bundle'),
        baseDir: thirdPartyDir);
    _joinFiles(
      path: '/static/highlight/highlight-with-init.js',
      from: [
        '/static/highlight/highlight.pack.js',
        '/static/highlight/init.js',
      ],
      contentSeparator: '\n',
    );
  }

  @visibleForTesting
  factory StaticFileCache.forTests() {
    final properCache = StaticFileCache.withDefaults();
    final cache = StaticFileCache();
    final paths = <String>{
      ...properCache.keys,
      '/static/css/style.css',
      '/static/js/script.dart.js',
    };
    for (String path in paths) {
      final file = StaticFile(path, 'text/mock', [], clock.now(),
          'mocked_hash_${path.hashCode.abs()}');
      cache.addFile(file);
    }
    return cache;
  }

  /// Returns the keys that are accepted as requests paths.
  Iterable<String> get keys => _files.keys;

  void _addDirectory(Directory contentDir, {Directory? baseDir}) {
    baseDir ??= contentDir;
    contentDir
        .listSync(recursive: true)
        .whereType<File>()
        .map((file) => file.absolute)
        .map(
      (File file) {
        final relativePath = path.relative(file.path, from: baseDir!.path);
        String contentType = mime.lookupMimeType(file.path) ?? 'octet/binary';
        if (relativePath == 'osd.xml') {
          contentType = 'application/opensearchdescription+xml';
        }
        final bytes = file.readAsBytesSync();
        final lastModified = file.lastModifiedSync();
        final isRoot = staticRootPaths.contains(relativePath);
        final prefix = isRoot ? '' : '/static';
        final requestPath = '$prefix/$relativePath';
        final digest = crypto.sha256.convert(bytes);
        final etag = digest.bytes.map((b) => (b & 31).toRadixString(32)).join();
        return StaticFile(requestPath, contentType, bytes, lastModified, etag);
      },
    ).forEach(addFile);
  }

  void _joinFiles({
    required String path,
    required List<String> from,
    String? contentSeparator,
  }) {
    final buffer = <int>[];
    String? contentType;
    DateTime? lastModified;
    for (final f in from) {
      final file = _files[f]!;
      contentType ??= file.contentType;
      lastModified ??= file.lastModified;
      if (lastModified.isBefore(file.lastModified)) {
        lastModified = file.lastModified;
      }
      if (contentSeparator != null && buffer.isNotEmpty) {
        buffer.addAll(utf8.encode(contentSeparator));
      }
      buffer.addAll(file.bytes);
    }
    final digest = crypto.sha256.convert(buffer);

    final etag = digest.bytes.map((b) => (b & 31).toRadixString(32)).join();
    _files[path] = StaticFile(path, contentType!, buffer, lastModified!, etag);
  }

  @visibleForTesting
  void addFile(StaticFile file) {
    _files[file.requestPath] = file;
    _etag = null;
  }

  @visibleForTesting
  Iterable<String> get paths => _files.keys;

  bool hasFile(String requestPath) => _files.containsKey(requestPath);

  StaticFile? getFile(String requestPath) => _files[requestPath];

  String get etag => _etag ??= _calculateEtagOfEtags().substring(0, 8);

  String _calculateEtagOfEtags() {
    final files = List<StaticFile>.from(_files.values);
    files.sort((a, b) => a.requestPath.compareTo(b.requestPath));
    final concatenatedEtags = files.map((f) => f.etag).join(' ');
    final digest = crypto.sha256.convert(utf8.encode(concatenatedEtags));
    return digest.bytes.map((b) => (b & 31).toRadixString(32)).join();
  }
}

/// Stores the content and metadata of a statically served file.
class StaticFile {
  final String requestPath;
  final String contentType;
  final List<int> bytes;
  final DateTime lastModified;
  final String etag;

  StaticFile(
    this.requestPath,
    this.contentType,
    this.bytes,
    this.lastModified,
    this.etag,
  );

  String get contentAsString => utf8.decode(bytes);

  late final String _cacheableUrl =
      Uri(path: requestPath, queryParameters: {'hash': etag}).toString();

  late final gzippedBytes = GZipCodec(level: 9).encode(bytes);
}

class StaticUrls {
  late final smallDartFavicon = getAssetUrl('/favicon.ico');
  late final dartLogoSvg = getAssetUrl('/static/img/dart-logo.svg');
  late final flutterLogo32x32 =
      getAssetUrl('/static/img/flutter-logo-32x32.png');
  late final pubDevLogo2xPng = getAssetUrl('/static/img/pub-dev-logo-2x.png');
  late final defaultProfilePng = getAssetUrl(
      '/static/img/material-icon-twotone-account-circle-white-24dp.png');
  late final githubMarkdownCss = getAssetUrl('/static/css/github-markdown.css');
  late final dartdocGithubCss =
      getAssetUrl('/static/dartdoc/resources/github.css');
  late final dartdocStylesCss =
      getAssetUrl('/static/dartdoc/resources/styles.css');
  late final dartdocScriptJs =
      getAssetUrl('/static/dartdoc/resources/docs.dart.js');
  late final dartdochighlightJs =
      getAssetUrl('/static/dartdoc/resources/highlight.pack.js');
  late final packagesSideImage = getAssetUrl('/static/img/packages-side.webp');
  late final reportMissingIconRed =
      getAssetUrl('/static/img/report-missing-icon-red.svg');
  late final reportMissingIconYellow =
      getAssetUrl('/static/img/report-missing-icon-yellow.svg');
  late final reportOKIconGreen =
      getAssetUrl('/static/img/report-ok-icon-green.svg');
  late final gtmJs = getAssetUrl('/static/js/gtm.js');
  late final documentationIcon =
      getAssetUrl('/static/img/description-24px.svg');
  late final documentationFailedIcon =
      getAssetUrl('/static/img/documentation-failed-icon.svg');
  late final downloadIcon =
      getAssetUrl('/static/img/vertical_align_bottom-24px.svg');

  StaticUrls._();

  /// Returns the hashed URL of the static resource like:
  /// `/static/img/logo.gif => /static/hash-<hash>/img/logo.gif`
  String getAssetUrl(String requestPath) {
    final file = staticFileCache.getFile(requestPath);
    if (file == null) {
      throw Exception('Static resource not found: $requestPath');
    } else if (requestPath.startsWith('/static/')) {
      return '/static/hash-${staticFileCache.etag}/${requestPath.substring(8)}';
    } else {
      return file._cacheableUrl;
    }
  }
}

Future<DateTime> _detectLastModified(Directory dir) async {
  DateTime? lastModified;
  await for (FileSystemEntity fse in dir.list(recursive: true)) {
    if (fse is File) {
      final lm = await fse.lastModified();
      if (lastModified == null || lastModified.isBefore(lm)) {
        lastModified = lm;
      }
    }
  }
  if (lastModified == null) {
    throw StateError('No files detected in ${dir.path}.');
  }
  return lastModified;
}

Future _runPubGet(Directory dir) async {
  final pr = await runProc(
    ['dart', 'pub', 'get'],
    workingDirectory: dir.path,
    timeout: Duration(minutes: 2),
  );
  if (pr.exitCode != 0) {
    final message = 'Unable to run `dart pub get` in ${dir.path}\n\n'
        'exitCode: ${pr.exitCode}\n'
        'STDOUT:\n${pr.stdout}\n\n'
        'STDERR:\n${pr.stderr}';
    throw Exception(message);
  }
}

/// Updates the built resources if their sources changed:
/// - `script.dart.js` is updated if `pkg/web_app` changed.
/// - `style.css` is updated if `pkg/web_css` changed.
Future updateLocalBuiltFilesIfNeeded() async {
  final staticDir = Directory(resolveStaticDirPath());

  final webAppDir = Directory(resolveWebAppDirPath());
  final webAppLastModified = await _detectLastModified(webAppDir);
  final scriptJs = File(path.join(staticDir.path, 'js', 'script.dart.js'));
  final scriptJsExists = await scriptJs.exists();
  final scriptJsLastModified =
      scriptJsExists ? await scriptJs.lastModified() : null;
  if (!scriptJsExists || (scriptJsLastModified!.isBefore(webAppLastModified))) {
    _logger.info('Building pkg/web_app');
    await scriptJs.parent.create(recursive: true);
    await updateWebAppBuild();
  }

  final webCssDir = Directory(resolveWebCssDirPath());
  final webCssLastModified = await _detectLastModified(webCssDir);
  final styleCss = File(path.join(staticDir.path, 'css', 'style.css'));
  final styleCssExists = await styleCss.exists();
  final styleCssLastModified =
      styleCssExists ? await styleCss.lastModified() : null;
  if (!styleCssExists || (styleCssLastModified!.isBefore(webCssLastModified))) {
    _logger.info('Building pkg/web_css');
    await updateWebCssBuild();
  }
}

/// Runs build.sh in pkg/web_app
Future<void> updateWebAppBuild() async {
  final webAppDir = Directory(resolveWebAppDirPath());

  await _runPubGet(webAppDir);
  final pr = await runProc(
    ['/bin/sh', 'build.sh'],
    workingDirectory: webAppDir.path,
    timeout: const Duration(minutes: 2),
  );
  if (pr.exitCode != 0) {
    final message = 'Unable to compile script.dart\n\n'
        'exitCode: ${pr.exitCode}\n'
        'STDOUT:\n${pr.stdout}\n\n'
        'STDERR:\n${pr.stderr}';
    throw Exception(message);
  }
}

/// Runs build.sh in pkg/web_css
Future<void> updateWebCssBuild() async {
  final webCssDir = Directory(resolveWebCssDirPath());
  await _runPubGet(webCssDir);
  final pr = await runProc(
    ['/bin/sh', 'build.sh'],
    workingDirectory: webCssDir.path,
    timeout: const Duration(minutes: 2),
  );
  if (pr.exitCode != 0) {
    final message = 'Unable to compile style.scss\n\n'
        'exitCode: ${pr.exitCode}\n'
        'STDOUT:\n${pr.stdout}\n\n'
        'STDERR:\n${pr.stderr}';
    throw Exception(message);
  }
}

/// Parses the static resource URL and returns the parsed hash values.
/// It can parse the following formats:
/// - /static/<url-hash>/path/to/resource
/// - /static/path/to/resource?hash=<url-hash>
///
/// TODO: remove after we no longer use url-hash
class ParsedStaticUrl {
  final String? urlHash;
  final String? pathHash;
  final String filePath;

  ParsedStaticUrl._({
    required this.urlHash,
    required this.pathHash,
    required this.filePath,
  });

  factory ParsedStaticUrl.parse(Uri requestedUri) {
    final normalizedRequestPath = path.normalize(requestedUri.path);
    final pathSegments =
        List<String>.from(Uri(path: normalizedRequestPath).pathSegments);
    String? pathHash;
    var filePath = normalizedRequestPath;
    if (pathSegments.length > 2 && pathSegments[1].startsWith('hash-')) {
      pathHash = pathSegments.removeAt(1).substring(5);
      filePath = '/${Uri(pathSegments: pathSegments)}';
    }
    return ParsedStaticUrl._(
      urlHash: requestedUri.queryParameters['hash'],
      pathHash: pathHash,
      filePath: filePath,
    );
  }
}
