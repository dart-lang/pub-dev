// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;

import '../package_graph/package_graph.dart';
import 'reader.dart';
import 'writer.dart';

/// Basic [AssetReader] which uses a [PackageGraph] to look up where to read
/// files from disk.
class FileBasedAssetReader implements RunnerAssetReader {
  final PackageGraph packageGraph;

  FileBasedAssetReader(this.packageGraph);

  @override
  Future<bool> canRead(AssetId id) => _fileFor(id, packageGraph).exists();

  @override
  Future<List<int>> readAsBytes(AssetId id) async =>
      (await _fileForOrThrow(id, packageGraph)).readAsBytes();

  @override
  Future<String> readAsString(AssetId id, {Encoding encoding}) async =>
      (await _fileForOrThrow(id, packageGraph))
          .readAsString(encoding: encoding ?? UTF8);

  @override
  Iterable<AssetId> findAssets(Glob glob, {String packageName}) sync* {
    var packageNode =
        packageName == null ? packageGraph.root : packageGraph[packageName];
    if (packageNode == null) {
      throw new ArgumentError(
          "Could not find package '$packageName' which was listed as "
          "an input. Please ensure you have that package in your deps, or "
          "remove it from your input sets.");
    }
    var packagePath = packageNode.location.toFilePath();
    try {
      var files = glob
          .listSync(followLinks: false, root: packagePath)
          .where((e) => e is File);
      for (var file in files) {
        // TODO(jakemac): Where do these files come from???
        if (path.basename(file.path).startsWith('._')) continue;
        yield _fileToAssetId(file as File, packageNode);
      }
    } on FileSystemException catch (_) {
      // Empty results
    }
  }

  @override
  Future<DateTime> lastModified(AssetId id) async =>
      (await _fileForOrThrow(id, packageGraph)).lastModified();
}

/// Creates an [AssetId] for [file], which is a part of [packageNode].
AssetId _fileToAssetId(File file, PackageNode packageNode) {
  var filePath = path.normalize(file.absolute.path);
  var packageUri = packageNode.location;
  var packagePath = path.normalize(packageUri.isAbsolute
      ? packageUri.toFilePath()
      : path.absolute(packageUri.toFilePath()));
  var relativePath = path.relative(filePath, from: packagePath);
  return new AssetId(packageNode.name, relativePath);
}

/// Basic [AssetWriter] which uses a [PackageGraph] to look up where to write
/// files to disk.
class FileBasedAssetWriter implements RunnerAssetWriter {
  final PackageGraph packageGraph;

  FileBasedAssetWriter(this.packageGraph);

  @override
  Future writeAsBytes(AssetId id, List<int> bytes) async {
    var file = _fileFor(id, packageGraph);
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
  }

  @override
  Future writeAsString(AssetId id, String contents,
      {Encoding encoding: UTF8}) async {
    var file = _fileFor(id, packageGraph);
    await file.create(recursive: true);
    await file.writeAsString(contents, encoding: encoding);
  }

  @override
  Future delete(AssetId id) {
    if (id.package != packageGraph.root.name) {
      throw new InvalidOutputException(
          id, 'Should not delete assets outside of ${packageGraph.root.name}');
    }

    var file = _fileFor(id, packageGraph);
    return () async {
      if (await file.exists()) {
        await file.delete();
      }
    }();
  }
}

/// Returns a [File] for [id] given [packageGraph].
File _fileFor(AssetId id, PackageGraph packageGraph) {
  var package = packageGraph[id.package];
  if (package == null) {
    throw new PackageNotFoundException(id.package);
  }
  return new File(path.join(package.location.toFilePath(), id.path));
}

/// Returns a [Future<File>] for [id] given [packageGraph].
///
/// Throws an `AssetNotFoundException` if it doesn't exist.
Future<File> _fileForOrThrow(AssetId id, PackageGraph packageGraph) async {
  var file = _fileFor(id, packageGraph);
  if (!await file.exists()) throw new AssetNotFoundException(id);
  return file;
}
