import 'dart:async';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart';
import 'package:gcloud/storage.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

final _logger = Logger('mem_storage');

class MemStorage implements Storage {
  final _buckets = <String, _Bucket>{};

  MemStorage({List<String> buckets}) {
    buckets?.forEach((name) {
      _buckets[name] = _Bucket(name);
    });
  }

  @override
  Future<void> createBucket(String bucketName,
      {PredefinedAcl predefinedAcl, Acl acl}) async {
    _buckets.putIfAbsent(bucketName, () => _Bucket(bucketName));
  }

  @override
  Future<void> deleteBucket(String bucketName) async {
    _buckets.remove(bucketName);
  }

  @override
  Bucket bucket(String bucketName,
      {PredefinedAcl defaultPredefinedObjectAcl, Acl defaultObjectAcl}) {
    return _buckets[bucketName];
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
    for (String name in _buckets.keys) {
      yield name;
    }
  }

  @override
  Future<Page<String>> pageBucketNames({int pageSize = 50}) {
    throw UnimplementedError(
        'fake_gcloud.Storage.pageBucketNames is not implemented.');
  }

  @override
  Future<void> copyObject(String src, String dest) async {
    _logger.info('Copy object from $src to $dest');
    final srcUri = Uri.parse(src);
    final destUri = Uri.parse(dest);
    await bucket(srcUri.host)
        .read(srcUri.path.substring(1))
        .pipe(bucket(destUri.host).write(destUri.path.substring(1)));
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
  final DateTime updated;
  @override
  final ObjectMetadata metadata;

  _File({
    @required this.bucketName,
    @required this.name,
    @required this.content,
  })  : // TODO: use a real CRC32 check
        crc32CChecksum = content.fold<int>(0, (a, b) => a + b) & 0xffffffff,
        updated = DateTime.now().toUtc(),
        metadata = ObjectMetadata(acl: Acl([]));

  @override
  Uri get downloadLink => Uri(scheme: 'gs', host: bucketName, path: name);

  @override
  String get etag => crc32CChecksum.toRadixString(16);

  @override
  ObjectGeneration get generation {
    throw UnimplementedError(
        'fake_gcloud.ObjectInfo.generation is not implemented.');
  }

  @override
  int get length => content.length;

  @override
  List<int> get md5Hash => etag.codeUnits;
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
      {int length,
      ObjectMetadata metadata,
      Acl acl,
      PredefinedAcl predefinedAcl,
      String contentType}) {
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
      {ObjectMetadata metadata,
      Acl acl,
      PredefinedAcl predefinedAcl,
      String contentType}) async {
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
    return _files[name];
  }

  @override
  Future<void> delete(String name) async {
    _validateObjectName(name);
    _files.remove(name);
  }

  @override
  Future<ObjectInfo> info(String name) async {
    _validateObjectName(name);
    _logger.info('info request for $name');
    final info = _files[name];
    if (info == null) {
      throw DetailedApiRequestError(404, '$name does not exists');
    }
    return info;
  }

  @override
  Stream<List<int>> read(String objectName, {int offset, int length}) async* {
    _validateObjectName(objectName);
    _logger.info('read request for $objectName');
    final file = _files[objectName];
    yield file.content;
  }

  @override
  Stream<BucketEntry> list({String prefix}) async* {
    _validateObjectName(prefix, allowNull: true);
    for (String name in _files.keys) {
      if (prefix == null || name.startsWith(prefix)) {
        yield _BucketEntry(name, true);
      }
    }
  }

  @override
  Future<Page<BucketEntry>> page({String prefix, int pageSize = 50}) async {
    return _Page<BucketEntry>(_BucketEntry('name', true));
  }

  @override
  Future<void> updateMetadata(
      String objectName, ObjectMetadata metadata) async {
    _logger.severe(
        'UpdateMeadata: $objectName not yet implemented, call ignored.');
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
  final T _item;
  @override
  bool get isLast => true;

  @override
  List<T> get items => <T>[_item];

  @override
  Future<Page<T>> next({int pageSize}) {
    return null;
  }

  _Page(this._item);
}

void _validateObjectName(String objectName, {bool allowNull = false}) {
  if (allowNull && objectName == null) {
    return;
  }
  if (objectName.startsWith('/')) {
    throw Exception('ObjectName must not start with / ($objectName)');
  }
}
