// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:mime/mime.dart' as mime;
import 'package:path/path.dart' as path;

const String _defaultStaticPath = '/static';

/// Stores binary data for /static
final StaticsCache staticsCache = new StaticsCache();

final Set<String> staticRootFiles = new Set<String>.from([
  '/favicon.ico',
  '/robots.txt',
]);

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
class StaticsCache {
  final String staticPath = _defaultStaticPath;
  final Map<String, StaticFile> _staticFiles = <String, StaticFile>{};

  StaticsCache() {
    final staticDirPath = _resolveStaticDirPath();
    final staticsDirectory = new Directory(staticDirPath).absolute;
    staticsDirectory
        .listSync(recursive: true)
        .where((fse) => fse is File)
        .map((file) => file.absolute as File)
        .map((File file) => _loadFile(staticsDirectory.path, file))
        .forEach(_addFile);
  }

  StaticsCache.fromFiles(List<StaticFile> files) {
    files.forEach(_addFile);
  }

  void _addFile(StaticFile file) {
    final requestPath = '$staticPath/${file.relativePath}';
    _staticFiles[requestPath] = file;
  }

  StaticFile _loadFile(String rootPath, File file) {
    final contentType = mime.lookupMimeType(file.path) ?? 'octet/binary';
    final bytes = file.readAsBytesSync();
    final lastModified = file.lastModifiedSync();
    final String relativePath = path.relative(file.path, from: rootPath);
    final digest = crypto.sha256.convert(bytes);
    final String etag =
        digest.bytes.map((b) => (b & 31).toRadixString(32)).join();
    return new StaticFile(relativePath, contentType, bytes, lastModified, etag);
  }

  StaticFile getFile(String requestedPath) => _staticFiles[requestedPath];
}

class StaticFile {
  final String relativePath;
  final String contentType;
  final List<int> bytes;
  final DateTime lastModified;
  final String etag;

  StaticFile(
    this.relativePath,
    this.contentType,
    this.bytes,
    this.lastModified,
    this.etag,
  );
}

final staticUrls = new StaticUrls();

class StaticUrls {
  final StaticsCache _cache;
  final String staticPath;
  final String smallDartFavicon;
  final String dartLogoSvg;
  final String flutterLogo32x32;
  final String documentationIcon;
  final String downloadIcon;
  Map _versionsTableIcons;
  Map<String, String> _assets;

  factory StaticUrls({StaticsCache cache}) {
    cache ??= staticsCache;
    return new StaticUrls._(cache, cache.staticPath);
  }

  StaticUrls._(this._cache, this.staticPath)
      : smallDartFavicon = '$staticPath/favicon.ico',
        dartLogoSvg = '$staticPath/img/dart-logo.svg',
        flutterLogo32x32 = '$staticPath/img/flutter-logo-32x32.png',
        documentationIcon = '$staticPath/img/ic_drive_document_black_24dp.svg',
        downloadIcon = '$staticPath/img/ic_get_app_black_24dp.svg';

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
    final file = _cache.getFile(requestPath);
    if (file == null) {
      throw new Exception('Static resource not found: $relativePath');
    } else {
      return '$requestPath?hash=${file.etag}';
    }
  }
}
