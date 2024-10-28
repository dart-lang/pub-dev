// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/shared/utils.dart';
import '../../shared/storage.dart';
import '../../shared/versions.dart'
    show runtimeVersion, runtimeVersionPattern, shouldGCVersion;

final _log = Logger('api_export:exported_bucket');

/// Minimum age before an item can be consider garbage.
///
/// This ensures that we don't delete files we've just created.
/// It's entirely possible that one process is writing files, while another
/// process is running garbage collection.
const _minGarbageAge = Duration(days: 1);

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
        if (info.updated.isBefore(clock.agoBy(_minGarbageAge))) {
          // Only delete if the item if it's older than _minGarbageAge
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
        if (info.updated.isBefore(clock.agoBy(_minGarbageAge))) {
          // Only delete if the item if it's older than _minGarbageAge
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
          (entry) async => await _bucket.tryDelete(entry.name),
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

  /// Garbage collect versions from this package not in [allVersionNumbers].
  ///
  /// [allVersionNumbers] must be encoded as canonical versions.
  Future<void> garbageCollect(Set<String> allVersionNumbers) async {
    await Future.wait([
      ..._owner._prefixes.map((prefix) async {
        final pfx = '/api/archives/$_package-';
        await _owner._listBucket(prefix: pfx, delimiter: '', (item) async {
          assert(item.isObject);
          final version = item.name.without(prefix: pfx, suffix: '.tar.gz');
          if (allVersionNumbers.contains(version)) {
            return;
          }
          if (await _owner._bucket.tryInfo(item.name) case final info?) {
            if (info.updated.isBefore(clock.agoBy(_minGarbageAge))) {
              // Only delete if the item if it's older than _minGarbageAge
              // This avoids any races where we delete files we've just created
              await _owner._bucket.tryDelete(item.name);
            }
          }
          // Ignore cases where tryInfo fails, assuming the object has been
          // deleted by another process.
        });
      }),
    ]);
  }

  /// Delete all files related to this package.
  Future<void> delete() async {
    await Future.wait([
      _owner._pool.withResource(() async => await versions.delete()),
      _owner._pool.withResource(() async => await advisories.delete()),
      ..._owner._prefixes.map((prefix) async {
        await _owner._listBucket(
          prefix: prefix + '/api/archives/$_package-',
          delimiter: '',
          (item) async => await _owner._bucket.tryDelete(item.name),
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
        await _owner._bucket.tryDelete(prefix + _objectName);
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

  ObjectMetadata _metadata() {
    return ObjectMetadata(
      contentType: 'application/json; charset="utf-8"',
      contentEncoding: 'gzip',
      cacheControl: 'public, max-age=${_maxAge.inSeconds}',
      custom: {
        'validated': clock.now().toIso8601String(),
      },
    );
  }

  /// Write [data] as gzipped JSON in UTF-8 format.
  Future<void> write(T data) async {
    final gzipped = _jsonGzip.encode(data);
    final metadata = _metadata();

    await Future.wait(_owner._prefixes.map((prefix) async {
      await _owner._pool.withResource(() async {
        await _owner._bucket.writeBytesIfDifferent(
          prefix + _objectName,
          gzipped,
          metadata,
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

  ObjectMetadata _metadata() {
    return ObjectMetadata(
      contentType: _contentType,
      cacheControl: 'public, max-age=${_maxAge.inSeconds}',
      contentDisposition: 'attachment; filename="$_filename"',
      custom: {
        'validated': clock.now().toIso8601String(),
      },
    );
  }

  /// Write binary blob to this file.
  Future<void> write(List<int> data) async {
    final metadata = _metadata();
    await Future.wait(_owner._prefixes.map((prefix) async {
      await _owner._pool.withResource(() async {
        await _owner._bucket.writeBytesIfDifferent(
          prefix + _objectName,
          data,
          metadata,
        );
      });
    }));
  }

  /// Copy binary blob from [bucket] and [source] to this file.
  Future<void> copyFrom(Bucket bucket, String source) async {
    final metadata = _metadata();
    Future<ObjectInfo?>? srcInfo;

    await Future.wait(_owner._prefixes.map((prefix) async {
      await _owner._pool.withResource(() async {
        final dst = prefix + _objectName;

        // Check if the dst already exists
        if (await _owner._bucket.tryInfo(dst) case final dstInfo?) {
          // Fetch info for source object (if we haven't already done this)
          srcInfo ??= bucket.tryInfo(source);
          if (await srcInfo case final srcInfo?) {
            if (dstInfo.contentEquals(srcInfo)) {
              // If both source and dst exists, and their content matches, then
              // we only need to update the "validated" metadata. And we only
              // need to update the "validated" timestamp if it's older than
              // _retouchDeadline
              final retouchDeadline = clock.agoBy(_revalidateAfter);
              if (dstInfo.metadata.validated.isBefore(retouchDeadline)) {
                await _owner._bucket.updateMetadata(dst, metadata);
              }
              return;
            }
          }
        }

        // If dst or source doesn't exist, then we shall attempt to make a copy.
        // (if source doesn't exist we'll consistently get an error from here!)
        await _owner._storage.copyObject(
          bucket.absoluteObjectName(source),
          _owner._bucket.absoluteObjectName(dst),
          metadata: metadata,
        );
      });
    }));
  }
}

const _revalidateAfter = Duration(days: 1);

extension on Bucket {
  Future<void> writeBytesIfDifferent(
    String name,
    List<int> bytes,
    ObjectMetadata metadata,
  ) async {
    if (await tryInfo(name) case final info?) {
      if (info.isSameContent(bytes)) {
        if (info.metadata.validated.isBefore(clock.agoBy(_revalidateAfter))) {
          await updateMetadata(name, metadata);
        }
        return;
      }
    }

    await uploadWithRetry(
      this,
      name,
      bytes.length,
      () => Stream.value(bytes),
      metadata: metadata,
    );
  }
}

extension on ObjectInfo {
  bool isSameContent(List<int> bytes) {
    if (length != bytes.length) {
      return false;
    }
    final bytesHash = md5.convert(bytes).bytes;
    return fixedTimeIntListEquals(md5Hash, bytesHash);
  }

  bool contentEquals(ObjectInfo info) {
    if (length != info.length) {
      return false;
    }
    return fixedTimeIntListEquals(md5Hash, info.md5Hash);
  }
}

extension on ObjectMetadata {
  DateTime get validated {
    return DateTime.tryParse(custom?['validated'] ?? '') ?? DateTime(0);
  }
}
