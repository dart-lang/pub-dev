import 'dart:async';
import 'dart:convert';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

final _logger = Logger('mem_storage');

class MemStorage implements Storage {
  final _buckets = <String, _Bucket>{};

  MemStorage({List<String>? buckets}) {
    buckets?.forEach((name) {
      _buckets[name] = _Bucket(name);
    });
  }

  @override
  Future<void> createBucket(String bucketName,
      {PredefinedAcl? predefinedAcl, Acl? acl}) async {
    _buckets.putIfAbsent(bucketName, () => _Bucket(bucketName));
  }

  @override
  Future<void> deleteBucket(String bucketName) async {
    _buckets.remove(bucketName);
  }

  @override
  Bucket bucket(String bucketName,
      {PredefinedAcl? defaultPredefinedObjectAcl, Acl? defaultObjectAcl}) {
    return _buckets[bucketName]!;
  }

  @override
  Future<bool> bucketExists(String bucketName) async {
    return _buckets.containsKey(bucketName);
  }

  @override
  Future<BucketInfo> bucketInfo(String bucketName) async {
    throw UnimplementedError(
        'fake_gcloud.Storage.bucketInfo is not implemented.');
  }

  @override
  Stream<String> listBucketNames() async* {
    for (final name in _buckets.keys) {
      yield name;
    }
  }

  @override
  Future<Page<String>> pageBucketNames({int pageSize = 50}) {
    throw UnimplementedError(
        'fake_gcloud.Storage.pageBucketNames is not implemented.');
  }

  @override
  Future<void> copyObject(
    String src,
    String dest, {
    ObjectMetadata? metadata,
  }) async {
    _logger.info('Copy object from $src to $dest');
    final srcUri = Uri.parse(src);
    final destUri = Uri.parse(dest);
    await bucket(srcUri.host)
        .read(srcUri.path.substring(1))
        .pipe(bucket(destUri.host).write(destUri.path.substring(1)));
  }

  /// Serializes the content of the Storage to the [sink], with a line-by-line
  /// JSON-encoded data format.
  void writeTo(StringSink sink) {
    for (final bucket in _buckets.values) {
      for (final file in bucket._files.values) {
        sink.writeln(json.encode({'file': _encodeFile(file)}));
      }
    }
  }

  /// Reads content as a line-by-line JSON-encoded data format.
  void readFrom(Iterable<String> lines) {
    for (final line in lines) {
      if (line.isEmpty) continue;
      final map = json.decode(line) as Map<String, dynamic>;
      final key = map.keys.single;
      switch (key) {
        case 'file':
          final file = _decodeFile(map[key] as Map<String, dynamic>);
          _buckets
              .putIfAbsent(file.bucketName, () => _Bucket(file.bucketName))
              ._files[file.name] = file;
          break;
        default:
          throw UnimplementedError('Unknown key: $key');
      }
    }
  }

  Map<String, dynamic> _encodeFile(_File file) {
    return <String, dynamic>{
      'bucket': file.bucketName,
      'name': file.name,
      'content': base64.encode(file.content),
      'updated': file.updated.toUtc().toIso8601String(),
      'metadata': null, // TODO: add metadata support
    };
  }

  _File _decodeFile(Map<String, dynamic> map) {
    final content = base64.decode(map['content'] as String);
    final updated = DateTime.parse(map['updated'] as String);
    return _File(
      bucketName: map['bucket'] as String,
      name: map['name'] as String,
      content: content,
      updated: updated,
    );
  }
}

class _File implements ObjectInfo {
  final String bucketName;
  @override
  final String name;
  final List<int> content;
  @override
  final int crc32CChecksum;
  @override
  final List<int> md5Hash;
  @override
  final DateTime updated;
  @override
  final ObjectMetadata metadata;

  _File({
    required this.bucketName,
    required this.name,
    required this.content,
    DateTime? updated,
  })  : // TODO: use a real CRC32 check
        crc32CChecksum = content.fold<int>(0, (a, b) => a + b) & 0xffffffff,
        md5Hash = md5.convert(content).bytes,
        updated = updated ?? DateTime.now().toUtc(),
        metadata = ObjectMetadata(acl: Acl([]));

  @override
  Uri get downloadLink => Uri(scheme: 'gs', host: bucketName, path: name);

  @override
  String get etag => base64Encode(md5Hash);

  @override
  ObjectGeneration get generation {
    throw UnimplementedError(
        'fake_gcloud.ObjectInfo.generation is not implemented.');
  }

  @override
  int get length => content.length;
}

class _Bucket implements Bucket {
  final _files = <String, _File>{};

  @override
  final String bucketName;

  _Bucket(this.bucketName);

  @override
  String absoluteObjectName(String objectName) {
    _validateObjectName(objectName);
    return Uri(scheme: 'gs', host: bucketName, path: objectName).toString();
  }

  @override
  StreamSink<List<int>> write(String objectName,
      {int? length,
      ObjectMetadata? metadata,
      Acl? acl,
      PredefinedAcl? predefinedAcl,
      String? contentType}) {
    _validateObjectName(objectName);
    _logger.info('Writing stream to: $objectName');
    // ignore: close_sinks
    final controller = StreamController<List<int>>();
    controller.stream.fold<List<int>>(<int>[], (buffer, data) {
      buffer.addAll(data);
      return buffer;
    }).then((content) {
      _files[objectName] = _File(
        bucketName: bucketName,
        name: objectName,
        content: content,
      );
      _logger.info('Completed ${content.length} bytes: $objectName');
    });
    return controller.sink;
  }

  @override
  Future<ObjectInfo> writeBytes(String name, List<int> bytes,
      {ObjectMetadata? metadata,
      Acl? acl,
      PredefinedAcl? predefinedAcl,
      String? contentType}) async {
    _validateObjectName(name);
    final sink = write(
      name,
      metadata: metadata,
      acl: acl,
      predefinedAcl: predefinedAcl,
      contentType: contentType,
    );
    sink.add(bytes);
    await sink.close();
    return _files[name]!;
  }

  @override
  Future<void> delete(String name) async {
    _validateObjectName(name);
    _files.remove(name);
  }

  @override
  Future<ObjectInfo> info(String name) async {
    _validateObjectName(name);
    final info = _files[name];
    if (info == null) {
      throw DetailedApiRequestError(404, '$name does not exists');
    }
    return info;
  }

  @override
  Stream<List<int>> read(String objectName, {int? offset, int? length}) async* {
    _validateObjectName(objectName);
    final file = _files[objectName];
    if (file == null) {
      throw DetailedApiRequestError(404, '$objectName does not exists');
    }
    final bytes = file.content;
    if (offset != null) {
      yield bytes.sublist(offset, offset + length!);
    } else {
      yield bytes;
    }
  }

  @override
  Stream<BucketEntry> list({String? prefix, String? delimiter}) async* {
    _validateObjectName(prefix, allowNull: true);
    prefix ??= '';
    delimiter ??= '/';
    final isDirPrefix =
        prefix.isEmpty || (delimiter.isNotEmpty && prefix.endsWith(delimiter));
    final segments = <String>{};
    for (final name in _files.keys) {
      bool matchesPrefix() {
        // without prefix, return everything
        if (prefix!.isEmpty) return true;
        // exclude everything that does not match the prefix
        if (!name.startsWith(prefix)) return false;
        // prefix does not end with directory separator, only files are matched
        if (!isDirPrefix &&
            delimiter!.isNotEmpty &&
            name.substring(prefix.length).contains(delimiter)) {
          return false;
        }
        return true;
      }

      if (matchesPrefix()) {
        final lastPartOfName = name.substring(prefix.length);
        final subDirSegments = delimiter.isEmpty
            ? [lastPartOfName]
            : lastPartOfName.split(delimiter);
        final isSubDirMatch = subDirSegments.length > 1;

        if (isDirPrefix && isSubDirMatch) {
          // extract path
          segments.add(subDirSegments.first);
        } else if (isDirPrefix && !isSubDirMatch) {
          // directory match
          yield _BucketEntry(name, true);
        } else if (!isDirPrefix && isSubDirMatch) {
          // ignore prefix match
        } else if (!isDirPrefix && !isSubDirMatch) {
          // file prefix match
          yield _BucketEntry(name, true);
        }
      }
    }

    for (final s in segments) {
      yield _BucketEntry('$prefix$s$delimiter', false);
    }
  }

  @override
  Future<Page<BucketEntry>> page(
      {String? prefix, String? delimiter, int pageSize = 50}) async {
    final entries = await list(prefix: prefix, delimiter: delimiter).toList();
    entries.sort((a, b) => a.name.compareTo(b.name));
    return _Page<BucketEntry>(entries, pageSize, 0);
  }

  @override
  Future<void> updateMetadata(
      String objectName, ObjectMetadata metadata) async {
    _logger.severe(
        'UpdateMetadata: $objectName not yet implemented, call ignored.');
  }
}

class _BucketEntry implements BucketEntry {
  @override
  final String name;

  @override
  final bool isObject;

  @override
  bool get isDirectory => !isObject;

  _BucketEntry(this.name, this.isObject);
}

class _Page<T> implements Page<T> {
  final List<T> _allItems;
  final List<T> _pageItems;
  final int _pageSize;
  final int _pageNum;

  @override
  final bool isLast;

  @override
  List<T> get items => _pageItems;

  @override
  Future<Page<T>> next({int? pageSize}) async {
    if (isLast) {
      return Future.value(_Page([], _pageSize, _pageNum + 1));
    }
    return _Page(_allItems, _pageSize, _pageNum + 1);
  }

  _Page(this._allItems, this._pageSize, this._pageNum)
      : _pageItems =
            _allItems.skip(_pageNum * _pageSize).take(_pageSize).toList(),
        isLast = _allItems.length <= _pageSize * (_pageNum + 1);
}

void _validateObjectName(String? objectName, {bool allowNull = false}) {
  if (allowNull && objectName == null) {
    return;
  }
  if (objectName!.startsWith('/')) {
    throw Exception('ObjectName must not start with / ($objectName)');
  }
}
