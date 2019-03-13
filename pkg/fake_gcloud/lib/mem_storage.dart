import 'dart:async';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart';
import 'package:gcloud/storage.dart';
import 'package:meta/meta.dart';

class MemStorage implements Storage {
  final _buckets = <String, _Bucket>{};

  MemStorage({List<String> buckets}) {
    buckets?.forEach((name) {
      _buckets[name] = _Bucket(name);
    });
  }

  @override
  Future createBucket(String bucketName,
      {PredefinedAcl predefinedAcl, Acl acl}) async {
    _buckets.putIfAbsent(bucketName, () => _Bucket(bucketName));
  }

  @override
  Future deleteBucket(String bucketName) async {
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
    throw new UnimplementedError();
  }

  @override
  Stream<String> listBucketNames() async* {
    for (String name in _buckets.keys) {
      yield name;
    }
  }

  @override
  Future<Page<String>> pageBucketNames({int pageSize = 50}) {
    throw UnimplementedError();
  }

  @override
  Future copyObject(String src, String dest) async {
    final srcUri = Uri.parse(src);
    final destUri = Uri.parse(dest);
    await bucket(src).read(srcUri.path).pipe(bucket(dest).write(destUri.path));
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

  _File({
    @required this.bucketName,
    @required this.name,
    @required this.content,
  })  : crc32CChecksum = content.fold<int>(0, (a, b) => a + b) & 0xffffffff,
        updated = DateTime.now().toUtc();

  @override
  Uri get downloadLink => Uri(scheme: 'gs', host: bucketName, path: name);

  @override
  String get etag => crc32CChecksum.toRadixString(16);

  @override
  ObjectGeneration get generation {
    throw UnimplementedError();
  }

  @override
  int get length => content.length;

  @override
  List<int> get md5Hash => etag.codeUnits;

  @override
  ObjectMetadata get metadata {
    throw UnimplementedError();
  }
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
  Future delete(String name) async {
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
  Stream<List<int>> read(String objectName, {int offset, int length}) async* {
    _validateObjectName(objectName);
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
    throw UnimplementedError();
  }

  @override
  Future updateMetadata(String objectName, ObjectMetadata metadata) async {
    throw UnimplementedError();
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

void _validateObjectName(String objectName, {bool allowNull = false}) {
  if (allowNull && objectName == null) {
    return;
  }
  if (!objectName.startsWith('/')) {
    throw Exception('ObjectName must start with / ($objectName)');
  }
}
