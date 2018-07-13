// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:mime/mime.dart' as mime;
import 'package:pana/src/utils.dart' show runProc;
import 'package:path/path.dart' as path;

const String _defaultStaticPath = '/static';
const _staticRootPaths = const <String>['favicon.ico', 'robots.txt'];

StaticFileCache _cache;

/// The static file cache. If no cache was registered before the first access,
/// the default instance will be created.
StaticFileCache get staticFileCache =>
    _cache ??= new StaticFileCache.withDefaults();

/// Register the static file cache.
/// Can be called only once, before the static file cache is set.
void registerStaticFileCache(StaticFileCache cache) {
  assert(_cache == null);
  _cache = cache;
}

String _resolveStaticDirPath() {
  if (Platform.script.path.contains('bin/server.dart')) {
    return Platform.script.resolve('../../static').toFilePath();
  }
  if (Platform.script.path.contains('app/test')) {
    return path.join(Directory.current.path, '../static');
  }
  throw new Exception('Unknown script: ${Platform.script}');
}

/// Stores static files in memory for fast http serving.
class StaticFileCache {
  final _files = <String, StaticFile>{};

  StaticFileCache();

  StaticFileCache.withDefaults() {
    final staticsDirectory = new Directory(_resolveStaticDirPath()).absolute;
    staticsDirectory
        .listSync(recursive: true)
        .where((fse) => fse is File)
        .map((file) => file.absolute as File)
        .map(
      (File file) {
        final contentType = mime.lookupMimeType(file.path) ?? 'octet/binary';
        final bytes = file.readAsBytesSync();
        final lastModified = file.lastModifiedSync();
        final relativePath =
            path.relative(file.path, from: staticsDirectory.path);
        final isRoot = _staticRootPaths.contains(relativePath);
        final prefix = isRoot ? '' : _defaultStaticPath;
        final requestPath = '$prefix/$relativePath';
        final digest = crypto.sha256.convert(bytes);
        final String etag =
            digest.bytes.map((b) => (b & 31).toRadixString(32)).join();
        return new StaticFile(
            requestPath, contentType, bytes, lastModified, etag);
      },
    ).forEach(addFile);
  }

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
}

final staticUrls = new StaticUrls();

class StaticUrls {
  final String staticPath = _defaultStaticPath;
  final String smallDartFavicon;
  final String dartLogoSvg;
  final String flutterLogo32x32;
  final String documentationIcon;
  final String downloadIcon;
  Map _versionsTableIcons;
  Map<String, String> _assets;

  StaticUrls()
      : smallDartFavicon = '/favicon.ico',
        dartLogoSvg = '$_defaultStaticPath/img/dart-logo.svg',
        flutterLogo32x32 = '$_defaultStaticPath/img/flutter-logo-32x32.png',
        documentationIcon =
            '$_defaultStaticPath/img/ic_drive_document_black_24dp.svg',
        downloadIcon = '$_defaultStaticPath/img/ic_get_app_black_24dp.svg';

  Map get versionsTableIcons {
    return _versionsTableIcons ??= {
      'documentation': documentationIcon,
      'download': downloadIcon,
    };
  }

  Map<String, String> get assets {
    return _assets ??= {
      'script_dart_js': _getCacheableStaticUrl('/js/script.dart.js'),
      'style_css': _getCacheableStaticUrl('/css/style.css'),
    };
  }

  /// Returns the URL of a static resource
  String _getCacheableStaticUrl(String relativePath) {
    if (!relativePath.startsWith('/')) {
      relativePath = '/$relativePath';
    }
    final String requestPath = '$staticPath$relativePath';
    final file = staticFileCache.getFile(requestPath);
    if (file == null) {
      throw new Exception('Static resource not found: $relativePath');
    } else {
      return '$requestPath?hash=${file.etag}';
    }
  }
}

Future updateLocalBuiltFiles() async {
  final staticDir = new Directory(_resolveStaticDirPath());
  final scriptDart = new File(path.join(staticDir.path, 'js', 'script.dart'));
  final scriptJs = new File(path.join(staticDir.path, 'js', 'script.dart.js'));
  if (!scriptJs.existsSync() ||
      (scriptJs.lastModifiedSync().isBefore(scriptDart.lastModifiedSync()))) {
    final pr = await runProc(
      'dart2js',
      [
        '--dump-info',
        '--minify',
        '--trust-primitives',
        '--omit-implicit-checks',
        scriptDart.path,
        '-o',
        scriptJs.path,
      ],
      workingDirectory: staticDir.path,
      timeout: const Duration(minutes: 2),
    );
    if (pr.exitCode != 0) {
      final message = 'Unable to compile script.dart\n\n'
          'exitCode: ${pr.exitCode}\n'
          'STDOUT:\n${pr.stdout}\n\n'
          'STDERR:\n${pr.stderr}';
      throw new Exception(message);
    }
  }
}
