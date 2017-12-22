// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:mime/mime.dart' as mime;
import 'package:path/path.dart' as path;

/// Stores binary data for /static
final StaticsCache staticsCache = new StaticsCache('/static');

String _resolveStaticDirPath() {
  if (Platform.script.path.contains('bin/server.dart')) {
    return Platform.script.resolve('../../static').toFilePath();
  }
  if (Platform.script.path.contains('app/test')) {
    return path.join(Directory.current.path, '../static');
  }
  throw new Exception('Unknown script: ${Platform.script}');
}

class StaticsCache {
  final String staticPath;
  final Map<String, StaticFile> _staticFiles = <String, StaticFile>{};

  StaticsCache(this.staticPath) {
    final staticDirPath = _resolveStaticDirPath();
    final staticsDirectory = new Directory(staticDirPath).absolute;
    final files = staticsDirectory
        .listSync(recursive: true)
        .where((fse) => fse is File)
        .map((file) => file.absolute as File);

    final staticFiles = files
        .map((File file) => _loadFile(staticsDirectory.path, file))
        .toList();

    for (StaticFile file in staticFiles) {
      final requestPath = '$staticPath/${file.relativePath}';
      _staticFiles[requestPath] = file;
    }
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

final staticUrls = new StaticUrls(staticsCache.staticPath);

class StaticUrls {
  final String staticPath;
  final String smallDartFavicon;
  final String flutterLogo32x32;
  final String newDesignAssetsDir;
  final String documentationIcon;
  final String downloadIcon;
  Map _versionsTableIcons;
  Map _assets;

  StaticUrls(this.staticPath)
      : smallDartFavicon = '$staticPath/favicon.ico',
        flutterLogo32x32 = '$staticPath/img/flutter-logo-32x32.png',
        newDesignAssetsDir = '$staticPath/v2',
        documentationIcon =
            '$staticPath/v2/img/ic_drive_document_black_24dp.svg',
        downloadIcon = '$staticPath/v2/img/ic_get_app_black_24dp.svg';

  Map get versionsTableIcons {
    return _versionsTableIcons ??= {
      'documentation': documentationIcon,
      'download': downloadIcon,
    };
  }

  Map get assets {
    return _assets ??= {
      'script_dart_js': _getCacheableStaticUrl('/v2/js/script.dart.js'),
    };
  }
}

/// Returns the URL of a static resource
String _getCacheableStaticUrl(String relativePath) {
  if (!relativePath.startsWith('/')) {
    relativePath = '/$relativePath';
  }
  final String requestPath = '${staticUrls.staticPath}$relativePath';
  final file = staticsCache.getFile(requestPath);
  if (file == null) {
    throw new Exception('Static resource not found: $relativePath');
  } else {
    return '$requestPath?hash=${file.etag}';
  }
}
