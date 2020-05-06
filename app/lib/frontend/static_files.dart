// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart' as mime;
import 'package:pana/pana.dart' show runProc;
import 'package:path/path.dart' as path;

final _logger = Logger('pub.static_files');

const String _defaultStaticPath = '/static';
const _staticRootPaths = <String>['favicon.ico', 'robots.txt'];

StaticFileCache _cache;
StaticUrls _staticUrls;

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
  if (Platform.script.path.contains('bin/server.dart')) {
    return Platform.script.resolve('../').toFilePath();
  }
  if (Platform.script.path.contains('bin/fake_pub_server.dart')) {
    return Platform.script.resolve('../../../app').toFilePath();
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

  StaticFileCache();

  StaticFileCache.withDefaults() {
    _addDirectory(Directory(resolveStaticDirPath()).absolute);
    final thirdPartyDir = _resolveDir('third_party');
    _addDirectory(_resolveDir('third_party/highlight'), baseDir: thirdPartyDir);
    _addDirectory(_resolveDir('third_party/css'), baseDir: thirdPartyDir);
    _addDirectory(_resolveDir('third_party/material'), baseDir: thirdPartyDir);
  }

  /// Returns the keys that are accepted as requests paths.
  Iterable<String> get keys => _files.keys;

  void _addDirectory(Directory contentDir, {Directory baseDir}) {
    baseDir ??= contentDir;
    contentDir
        .listSync(recursive: true)
        .whereType<File>()
        .map((file) => file.absolute)
        .map(
      (File file) {
        final relativePath = path.relative(file.path, from: baseDir.path);
        String contentType = mime.lookupMimeType(file.path) ?? 'octet/binary';
        if (relativePath == 'osd.xml') {
          contentType = 'application/opensearchdescription+xml';
        }
        final bytes = file.readAsBytesSync();
        final lastModified = file.lastModifiedSync();
        final isRoot = _staticRootPaths.contains(relativePath);
        final prefix = isRoot ? '' : _defaultStaticPath;
        final requestPath = '$prefix/$relativePath';
        final digest = crypto.sha256.convert(bytes);
        final String etag =
            digest.bytes.map((b) => (b & 31).toRadixString(32)).join();
        return StaticFile(requestPath, contentType, bytes, lastModified, etag);
      },
    ).forEach(addFile);
  }

  @visibleForTesting
  void addFile(StaticFile file) {
    _files[file.requestPath] = file;
  }

  bool hasFile(String requestPath) => _files.containsKey(requestPath);

  StaticFile getFile(String requestPath) => _files[requestPath];
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
}

class StaticUrls {
  final String staticPath = _defaultStaticPath;
  final String smallDartFavicon;
  final String dartLogoSvg;
  final String flutterLogo32x32;
  final String documentationIcon;
  final String downloadIcon;
  final String pubDevLogo2xPng;
  final String defaultProfilePng;
  final String githubMarkdownCss;
  final String packagesSideImage;
  Map _versionsTableIcons;
  Map<String, String> _assets;

  StaticUrls._()
      : smallDartFavicon = _getCacheableStaticUrl('/favicon.ico'),
        dartLogoSvg =
            _getCacheableStaticUrl('$_defaultStaticPath/img/dart-logo.svg'),
        flutterLogo32x32 = _getCacheableStaticUrl(
            '$_defaultStaticPath/img/flutter-logo-32x32.png'),
        documentationIcon = _getCacheableStaticUrl(
            '$_defaultStaticPath/img/ic_drive_document_black_24dp.svg'),
        downloadIcon = _getCacheableStaticUrl(
            '$_defaultStaticPath/img/ic_get_app_black_24dp.svg'),
        pubDevLogo2xPng = _getCacheableStaticUrl(
            '$_defaultStaticPath/img/pub-dev-logo-2x.png'),
        defaultProfilePng = _getCacheableStaticUrl(
            '$_defaultStaticPath/img/material-icon-twotone-account-circle-white-24dp.png'),
        githubMarkdownCss = _getCacheableStaticUrl(
            '$_defaultStaticPath/css/github-markdown.css'),
        packagesSideImage =
            _getCacheableStaticUrl('$_defaultStaticPath/img/packages-side.png');

  // TODO: merge with [newVersionTableIcons] after migration to the new UI
  Map get versionsTableIcons {
    return _versionsTableIcons ??= {
      'documentation': documentationIcon,
      'download': downloadIcon,
    };
  }

  // TODO: merge with [versionsTableIcons] after migration to the new UI
  final newVersionsTableIcons = {
    'documentation':
        _getCacheableStaticUrl('$_defaultStaticPath/img/description-24px.svg'),
    'download': _getCacheableStaticUrl(
        '$_defaultStaticPath/img/vertical_align_bottom-24px.svg'),
  };

  /// A hashed version of the static assets.
  ///
  /// For each file like /static/img/logo.gif we create a key and value of:
  /// `img__logo_gif => /static/img/logo.gif?hash=etag_hash`
  ///
  /// The /static/ prefix is stripped from the start of the key in order to
  /// reduce the length of the mostly used files in the mustache templates.
  Map<String, String> get assets {
    if (_assets == null) {
      _assets = <String, String>{};
      for (String requestPath in staticFileCache.keys) {
        final inStatic = requestPath.startsWith('$_defaultStaticPath/');
        // Removing the /static/ prefix from the keys in order to make them
        // shorter in the templates.
        final hashedFile = inStatic
            ? requestPath.substring(_defaultStaticPath.length + 1)
            : requestPath;
        final key = hashedFile.replaceAll('/', '__').replaceAll('.', '_');
        _assets[key] = _getCacheableStaticUrl(requestPath);
      }
    }
    return _assets;
  }
}

/// Returns the URL of a static resource
String _getCacheableStaticUrl(String requestPath) {
  final file = staticFileCache.getFile(requestPath);
  if (file == null) {
    throw Exception('Static resource not found: $requestPath');
  } else {
    return '$requestPath?hash=${file.etag}';
  }
}

Future<DateTime> _detectLastModified(Directory dir) async {
  DateTime lastModified;
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
    'pub',
    ['get'],
    workingDirectory: dir.path,
    timeout: Duration(minutes: 2),
  );
  if (pr.exitCode != 0) {
    final message = 'Unable to run `pub get` in ${dir.path}\n\n'
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
  _logger.info(
      'pkg/web_app build status: source: $webAppLastModified, target: $scriptJsLastModified');
  if (!scriptJsExists || (scriptJsLastModified.isBefore(webAppLastModified))) {
    await scriptJs.parent.create(recursive: true);
    await updateWebAppBuild();
  }

  final webCssDir = Directory(resolveWebCssDirPath());
  final webCssLastModified = await _detectLastModified(webCssDir);
  final styleCss = File(path.join(staticDir.path, 'css', 'style.css'));
  final styleCssExists = await styleCss.exists();
  final styleCssLastModified =
      styleCssExists ? await styleCss.lastModified() : null;
  _logger.info(
      'pkg/web_css build status: source: $webCssLastModified, target: $styleCssLastModified');
  if (!styleCssExists || (styleCssLastModified.isBefore(webCssLastModified))) {
    await updateWebCssBuild();
  }
}

/// Runs build.sh in pkg/web_app
Future<void> updateWebAppBuild() async {
  final webAppDir = Directory(resolveWebAppDirPath());

  await _runPubGet(webAppDir);
  final pr = await runProc(
    '/bin/sh',
    ['build.sh'],
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
    '/bin/sh',
    ['build.sh'],
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
