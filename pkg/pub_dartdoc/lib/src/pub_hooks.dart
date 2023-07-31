// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/file_system.dart';
// ignore: implementation_imports
import 'package:analyzer/src/generated/sdk.dart';
// ignore: implementation_imports
import 'package:analyzer/src/generated/source.dart';
import 'package:dartdoc/dartdoc.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

/// Creates an overlay file system with binary file support on top
/// of the input sources.
///
/// TODO: Use a proper overlay in-memory filesystem with binary support,
///       instead of overriding file writes in the output path.
class PubResourceProvider implements ResourceProvider {
  final ResourceProvider _defaultProvider;

  PubResourceProvider(this._defaultProvider);

  @override
  File getFile(String path) => _File(_defaultProvider.getFile(path));

  @override
  Folder getFolder(String path) => _defaultProvider.getFolder(path);

  @override
  Resource getResource(String path) => _defaultProvider.getResource(path);

  @override
  Folder? getStateLocation(String pluginId) {
    return _defaultProvider.getStateLocation(pluginId);
  }

  @override
  p.Context get pathContext => _defaultProvider.pathContext;
}

class _File implements File {
  final File _delegate;
  _File(this._delegate);

  @override
  Stream<WatchEvent> get changes => _delegate.watch().changes;

  @override
  File copyTo(Folder parentFolder) => _delegate.copyTo(parentFolder);

  @override
  Source createSource([Uri? uri]) => _delegate.createSource(uri);

  @override
  void delete() => _delegate.delete();

  @override
  bool get exists => _delegate.exists;

  @override
  bool isOrContains(String path) => _delegate.isOrContains(path);

  @override
  int get lengthSync => _delegate.lengthSync;

  @override
  int get modificationStamp => _delegate.modificationStamp;

  @override
  Folder get parent2 => _delegate.parent;

  @override
  String get path => _delegate.path;

  @override
  ResourceProvider get provider => _delegate.provider;

  @override
  Uint8List readAsBytesSync() => _delegate.readAsBytesSync();

  @override
  String readAsStringSync() => _delegate.readAsStringSync();

  @override
  File renameSync(String newPath) => _delegate.renameSync(newPath);

  @override
  Resource resolveSymbolicLinksSync() => _delegate.resolveSymbolicLinksSync();

  @override
  String get shortName => _delegate.shortName;

  @override
  Uri toUri() => _delegate.toUri();

  @override
  ResourceWatcher watch() => _delegate.watch();

  @override
  void writeAsBytesSync(List<int> bytes) {
    _delegate.writeAsBytesSync(bytes);
  }

  @override
  void writeAsStringSync(String content) {
    writeAsBytesSync(utf8.encode(content));
  }

  @override
  Folder get parent => _delegate.parent;
}

/// Allows the override of [resourceProvider].
class PubPackageMetaProvider implements PackageMetaProvider {
  final PackageMetaProvider _delegate;
  final ResourceProvider _resourceProvider;

  PubPackageMetaProvider(this._delegate, this._resourceProvider);

  @override
  DartSdk? get defaultSdk => _delegate.defaultSdk;

  @override
  Folder get defaultSdkDir => _delegate.defaultSdkDir;

  @override
  PackageMeta? fromDir(Folder dir) => _delegate.fromDir(dir);

  @override
  PackageMeta? fromElement(LibraryElement library, String s) =>
      _delegate.fromElement(library, s);

  @override
  PackageMeta? fromFilename(String s) => _delegate.fromFilename(s);

  @override
  ResourceProvider get resourceProvider => _resourceProvider;

  @override
  String getMessageForMissingPackageMeta(
          LibraryElement library, DartdocOptionContext optionContext) =>
      _delegate.getMessageForMissingPackageMeta(library, optionContext);

  @override
  Map<String, String> get environmentProvider => _delegate.environmentProvider;
}
