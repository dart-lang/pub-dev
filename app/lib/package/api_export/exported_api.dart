// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/shared/utils.dart';
import '../../shared/versions.dart'
    show runtimeVersion, runtimeVersionPattern, shouldGCVersion;

final _log = Logger('api_export:exported_bucket');

/// Interface for [Bucket] containing exported API that is served directly from
/// Google Cloud Storage.
///
/// This interface is responsible for:
///  * Naming of files in the bucket.
///  * Deletion of all files related to a package.
///  * Garbage collection of unknown package entries.
///  * Maintaining two prefixes with files in the bucket.
///    * "latest" (that all runtimeVersions write to)
///    * "<runtimeVersion>" (that only this runtimeVersion writes to)
///  * Garbage collecting old prefixes.
///  * Limit concurrency of operations.
///
/// All writes to the bucket containing the exported API should go through this
/// interface.
final class ExportedApi {
  final Pool _pool = Pool(50);
  final Storage _storage;
  final Bucket _bucket;
  final List<String> _prefixes = [
    'latest',
    runtimeVersion,
  ];

  ExportedApi(this._storage, this._bucket);

  /// Interface for writing all files related to [packageName].
  ExportedPackage package(String packageName) =>
      ExportedPackage._(this, packageName);

  /// Interface for writing `/api/package-name-completion-data`
  ExportedJsonFile<Map<String, Object?>> get packageNameCompletionData =>
      ExportedJsonFile<Map<String, Object?>>._(
        this,
        '/api/package-name-completion-data',
        Duration(hours: 8),
      );

  /// Run garbage collection on the bucket.
  ///
  /// This will remove all packages from `latest/` and `<runtimeVersion>/`,
  /// where:
  ///  * The name of the package is not in [allPackageNames], and,
  ///  * The file is more than one day old.
  ///
  /// This will remove prefixes other than `latest/` where [shouldGCVersion]
  /// returns true.
  Future<void> garbageCollect(Set<String> allPackageNames) async {
    await Future.wait([
      _gcOldPrefixes(),
      ..._prefixes.map((prefix) => _gcPrefix(prefix, allPackageNames)),
    ]);
  }

  /// Garbage collect unknown packages from [prefix].
  ///
  /// This will remove all packages from the `<prefix>/` where:
  ///  * The name of the package is not in [allPackageNames], and,
  ///  * The file is more than one day old.
  Future<void> _gcPrefix(String prefix, Set<String> allPackageNames) async {
    _log.info('Garbage collecting "$prefix"');

    await _listBucket(prefix: prefix + '/api/packages/', delimiter: '/',
        (item) async {
      final String packageName;
      if (item.isObject) {
        assert(!item.name.endsWith('/'));
        packageName = item.name.split('/').last;
      } else {
        assert(item.name.endsWith('/'));
        packageName = item.name.without(suffix: '/').split('/').last;
      }
      if (!allPackageNames.contains(packageName)) {
        final info = await _bucket.info(item.name);
        if (info.updated.isBefore(clock.ago(days: 1))) {
          // Only delete if the item is more than one day old
          // This avoids any races where we delete files we've just created
          await package(packageName).delete();
        }
      }
    });

    await _listBucket(prefix: prefix + '/api/archives/', delimiter: '-',
        (item) async {
      if (item.isObject) {
        throw AssertionError('Unknown package archive at ${item.name}');
      }
      assert(item.name.endsWith('-'));
      final packageName = item.name.without(suffix: '-').split('/').last;
      if (!allPackageNames.contains(packageName)) {
        final info = await _bucket.info(item.name);
        if (info.updated.isBefore(clock.ago(days: 1))) {
          // Only delete if the item is more than one day old
          // This avoids any races where we delete files we've just created
          await package(packageName).delete();
        }
      }
    });
  }

  /// Garbage collect old prefixes.
  ///
  /// This will remove prefixes other than `latest/` where [shouldGCVersion]
  /// returns true.
  Future<void> _gcOldPrefixes() async {
    // List all top-level prefixes, and delete the ones we don't need
    final topLevelprefixes = await _pool.withResource(
      () async => await _bucket.list(prefix: '', delimiter: '/').toList(),
    );
    await Future.wait(topLevelprefixes.map((entry) async {
      if (entry.isObject) {
        return; // ignore top-level files
      }

      final topLevelPrefix = entry.name.without(suffix: '/');
      if (_prefixes.contains(topLevelPrefix)) {
        return; // Don't GC prefixes we are writing to
      }

      if (!runtimeVersionPattern.hasMatch(topLevelPrefix)) {
        return; // Don't GC non-runtimeVersions
      }

      if (shouldGCVersion(topLevelPrefix)) {
        _log.info(
          'Garbage collecting old prefix "$topLevelPrefix/" '
          '(removing all objects under it)',
        );

        assert(entry.name.endsWith('/'));
        await _listBucket(
          prefix: entry.name,
          delimiter: '',
          (entry) async => await _bucket.delete(entry.name),
        );
      }
    }));
  }

  Future<void> _listBucket(
    FutureOr<void> Function(BucketEntry entry) each, {
    required String prefix,
    required String delimiter,
  }) async {
    var p = await _pool.withResource(() async => await _bucket.page(
          prefix: prefix,
          delimiter: delimiter,
          pageSize: 1000,
        ));
    while (true) {
      await Future.wait(p.items.map((item) async {
        await _pool.withResource(() async => await each(item));
      }));

      if (p.isLast) break;
      p = await _pool.withResource(() async => await p.next(pageSize: 1000));
    }
  }
}

/// Interface for writing data about a package to the exported API bucket.
final class ExportedPackage {
  final ExportedApi _owner;
  final String _package;

  ExportedPackage._(this._owner, this._package);

  ExportedJsonFile<T> _suffix<T>(String suffix) => ExportedJsonFile<T>._(
        _owner,
        '/api/packages/$_package$suffix',
        Duration(minutes: 10),
      );

  /// Interface for writing `/api/packages/<package>`.
  ///
  /// Which contains version listing information.
  ExportedJsonFile<PackageData> get versions => _suffix<PackageData>('');

  /// Interface for writing `/api/packages/<package>/advisories`.
  ExportedJsonFile<ListAdvisoriesResponse> get advisories =>
      _suffix<ListAdvisoriesResponse>('/advisories');

  /// Interace for writing `/api/archives/<package>-<version>.tar.gz`.
  ExportedBlob tarball(String version) => ExportedBlob._(
        _owner,
        '/api/archives/$_package-$version.tar.gz',
        '$_package-$version.tar.gz',
        'application/octet',
        Duration(hours: 2),
      );

  /// Delete all files related to this package.
  Future<void> delete() async {
    await Future.wait([
      _owner._pool.withResource(() async => await versions.delete()),
      _owner._pool.withResource(() async => await advisories.delete()),
      ..._owner._prefixes.map((prefix) async {
        await _owner._listBucket(
          prefix: prefix + '/api/archives/$_package-',
          delimiter: '',
          (item) async => await _owner._bucket.delete(item.name),
        );
      }),
    ]);
  }
}

/// Interface for an exported file.
sealed class ExportedObject {
  final ExportedApi _owner;
  final String _objectName;
  ExportedObject._(this._owner, this._objectName);

  /// Delete this file.
  Future<void> delete() async {
    await Future.wait(_owner._prefixes.map((prefix) async {
      await _owner._pool.withResource(() async {
        await _owner._bucket.delete(prefix + _objectName);
      });
    }));
  }
}

/// Interface for an exported JSON file.
///
/// This will write JSON as gzipped UTF-8, adding headers for
///  * `Content-Type`,
///  * `Content-Encoding`, and,
///  * `Cache-Control`.
final class ExportedJsonFile<T> extends ExportedObject {
  static final _jsonGzip = json.fuse(utf8).fuse(gzip);
  final Duration _maxAge;

  ExportedJsonFile._(
    ExportedApi _owner,
    String _objectName,
    this._maxAge,
  ) : super._(_owner, _objectName);

  late final _metadata = ObjectMetadata(
    contentType: 'application/json; charset="utf-8"',
    contentEncoding: 'gzip',
    cacheControl: 'public, max-age=${_maxAge.inSeconds}',
  );

  /// Write [data] as gzipped JSON in UTF-8 format.
  Future<void> write(T data) async {
    final gzipped = _jsonGzip.encode(data);
    await Future.wait(_owner._prefixes.map((prefix) async {
      await _owner._pool.withResource(() async {
        await _owner._bucket.writeBytes(
          prefix + _objectName,
          gzipped,
          metadata: _metadata,
        );
      });
    }));
  }
}

/// Interface for an exported binary file.
///
/// This will write a binary blob as is, adding headers for
///  * `Content-Type`,
///  * `Content-Disposition`, and,
///  * `Cache-Control`.
final class ExportedBlob extends ExportedObject {
  final String _contentType;
  final Duration _maxAge;
  final String _filename;

  ExportedBlob._(
    ExportedApi _owner,
    String _objectName,
    this._filename,
    this._contentType,
    this._maxAge,
  ) : super._(_owner, _objectName);

  late final _metadata = ObjectMetadata(
    contentType: _contentType,
    cacheControl: 'public, max-age=${_maxAge.inSeconds}',
    contentDisposition: 'attachment; filename="$_filename"',
  );

  /// Write binary blob to this file.
  Future<void> write(List<int> data) async {
    await Future.wait(_owner._prefixes.map((prefix) async {
      await _owner._pool.withResource(() async {
        await _owner._bucket.writeBytes(
          prefix + _objectName,
          data,
          metadata: _metadata,
        );
      });
    }));
  }

  /// Copy binary blob from [absoluteObjectName] to this file.
  ///
  /// Notice that [absoluteObjectName] must be an a GCS URI including `gs://`.
  /// This means that it must include bucket name.
  /// Such URIs can be created with [Bucket.absoluteObjectName].
  Future<void> copyFrom(String absoluteObjectName) async {
    await Future.wait(_owner._prefixes.map((prefix) async {
      await _owner._pool.withResource(() async {
        await _owner._storage.copyObject(
          absoluteObjectName,
          _owner._bucket.absoluteObjectName(prefix + _objectName),
          metadata: _metadata,
        );
      });
    }));
  }
}
