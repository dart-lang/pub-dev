// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine_pub.file_repository;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:pub_server/repository.dart';
import 'package:yaml/yaml.dart';

final Logger _logger = new Logger('pub_server.file_repository');

/// Implements the [PackageRepository] by storing pub packages on a file system.
class FileRepository extends PackageRepository {
  final String baseDir;

  FileRepository(this.baseDir);

  Stream<PackageVersion> versions(String package) {
    var directory = new Directory(path.join(baseDir, package));
    if (directory.existsSync()) {
      return directory
          .list(recursive: false)
          .where((fse) => fse is Directory)
          .map((dir) {
        var version = path.basename(dir.path);
        var pubspecFile = new File(pubspecFilePath(package, version));
        var tarballFile = new File(packageTarballPath(package, version));
        if (pubspecFile.existsSync() && tarballFile.existsSync()) {
          var pubspec = pubspecFile.readAsStringSync();
          return new PackageVersion(package, version, pubspec);
        }
      });
    }

    return new Stream.fromIterable([]);
  }

  // TODO: Could be optimized by searching for the exact package/version
  // combination instead of enumerating all.
  Future<PackageVersion> lookupVersion(String package, String version) {
    return versions(package)
        .where((pv) => pv.versionString == version)
        .toList()
        .then((List<PackageVersion> versions) {
      if (versions.length >= 1) return versions.first;
      return null;
    });
  }

  bool get supportsUpload => true;

  Future<PackageVersion> upload(Stream<List<int>> data) {
    _logger.info('Start uploading package.');
    return data.fold(new BytesBuilder(), (b, d) => b..add(d)).then((bb) {
      var tarballBytes = bb.takeBytes();
      var tarBytes = new GZipDecoder().decodeBytes(tarballBytes);
      var archive = new TarDecoder().decodeBytes(tarBytes);
      var pubspecArchiveFile;
      for (var file in archive.files) {
        if (file.name == 'pubspec.yaml') {
          pubspecArchiveFile = file;
          break;
        }
      }
      if (pubspecArchiveFile != null) {
        // TODO: Error handling.
        var pubspec = loadYaml(UTF8.decode(pubspecArchiveFile.content));

        var package = pubspec['name'];
        var version = pubspec['version'];

        var packageVersionDir =
            new Directory(path.join(baseDir, package, version));
        var pubspecFile = new File(pubspecFilePath(package, version));
        var tarballFile = new File(packageTarballPath(package, version));

        if (!packageVersionDir.existsSync()) {
          packageVersionDir.createSync(recursive: true);
        }
        pubspecFile.writeAsBytesSync(pubspecArchiveFile.content);
        tarballFile.writeAsBytesSync(tarballBytes);

        _logger.info('Uploaded new $package/$version');
      } else {
        _logger.warning('Did not find any pubspec.yaml file in upload. '
            'Aborting.');
        throw 'No pubspec file.';
      }
    });
  }

  bool get supportsDownloadUrl => false;

  Future<Stream> download(String package, String version) {
    var pubspecFile = new File(pubspecFilePath(package, version));
    var tarballFile = new File(packageTarballPath(package, version));

    if (pubspecFile.existsSync() && tarballFile.existsSync()) {
      return new Future.value(tarballFile.openRead());
    } else {
      return new Future.error(
          'package cannot be downloaded, because it does not exist');
    }
  }

  String pubspecFilePath(String package, String version) =>
      path.join(baseDir, package, version, 'pubspec.yaml');

  String packageTarballPath(String package, String version) =>
      path.join(baseDir, package, version, 'package.tar.gz');
}
