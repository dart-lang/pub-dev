// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.backend_test_utils;

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/storage.dart';
import 'package:unittest/unittest.dart';

import 'package:pub_server/repository.dart' show AsyncUploadInfo;
import 'package:pub_dartlang_org/backend.dart';
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'utils.dart';

class DatastoreDBMock extends db.DatastoreDB {
  final Function commitFun;
  final Function lookupFun;
  final Function queryFun;
  final TransactionMock transactionMock;
  final QueryMock queryMock;

  DatastoreDBMock({this.commitFun, this.lookupFun, this.queryFun,
                   this.queryMock, this.transactionMock})
      : super(null);

  Future commit({List<db.Model> inserts, List<db.Key> deletes}) async {
    if (commitFun == null) throw 'no commitFun';
    return commitFun(inserts: inserts, deletes: deletes);
  }

  Future<List<db.Model>> lookup(List<db.Key> keys) async {
    if (lookupFun == null) throw 'no lookupFun';
    return lookupFun(keys);
  }

  db.Query query(Type kind, {db.Partition partition, db.Key ancestorKey}) {
    if (queryMock == null) throw 'no queryMock';
    queryMock._kind = kind;
    queryMock._partition = partition;
    queryMock._ancestorKey = ancestorKey;
    return queryMock;
  }

  Future withTransaction(Future handler(db.Transaction transaction)) async {
    if (transactionMock == null) throw 'no transactionMock';
    return handler(transactionMock);
  }
}

class TransactionMock implements db.Transaction {
  final Function commitFun;
  final Function lookupFun;
  final Function queueMutationFun;
  final Function rollbackFun;
  final QueryMock queryMock;

  db.DatastoreDB get db => throw 'db not supported';

  TransactionMock({this.commitFun, this.lookupFun, this.queueMutationFun,
                   this.rollbackFun, this.queryMock});

  Future commit() async {
    if (commitFun == null) throw 'no commitFun';
    return commitFun();
  }

  Future<List<db.Model>> lookup(List<db.Key> keys) async {
    if (lookupFun == null) throw 'no lookupFun';
    return lookupFun(keys);
  }

  db.Query query(Type kind, db.Key ancestorKey, {db.Partition partition}) {
    if (queryMock == null) throw 'no queryMock';
    queryMock._kind = kind;
    queryMock._partition = partition;
    queryMock._ancestorKey = ancestorKey;
    return queryMock;
  }

  void queueMutations({List<db.Model> inserts, List<db.Key> deletes}) {
    if (queueMutationFun == null) throw 'no queueMutationFun';
    queueMutationFun(inserts: inserts, deletes: deletes);
  }

  Future rollback() async {
    if (rollbackFun == null) throw 'no rollbackFun';
    return rollbackFun();
  }
}

class QueryMock implements db.Query {
  final QueryMockHandler runFun;

  QueryMock(this.runFun);

  // These will will be set by the query() methods on `Transaction` or
  // `DatastoreDB`.
  Type _kind;
  db.Partition _partition;
  db.Key _ancestorKey;

  // These will be manipulated during method calls on the query object.
  List<String> _filters = [];
  List<String> _filterComparisonObjects = [];
  int _offset;
  int _limit;
  List<String> _orders = [];

  void filter(String filterString, Object comparisonObject) {
    _filters.add(filterString);
    _filterComparisonObjects.add(comparisonObject);
  }

  void limit(int limit) {
    _limit = limit;
  }

  void offset(int offset) {
    _offset = offset;
  }

  void order(String orderString) => _orders.add(orderString);

  Stream<db.Model> run() {
    return runFun(kind: _kind, partition: _partition, ancestorKey: _ancestorKey,
                  filters: _filters,
                  filterComparisonObjects: _filterComparisonObjects,
                  offset: _offset, limit: _limit, orders: _orders);
  }
}

typedef Stream<db.Model> QueryMockHandler({
    Type kind, db.Partition partition, db.Key ancestorKey, List<String> filters,
    List filterComparisonObjects, int offset, int limit,
    List<String> orders});


class TarballStorageMock implements TarballStorage {
  final Function downloadFun;
  final Function downloadUrlFun;
  final Function readTempObjectFun;
  final Function removeTempObjectFun;
  final Function tmpObjectNameFun;
  final Function uploadFun;
  final Function uploadViaTempObjectFun;
  final BucketMock bucketMock;

  TarballStorageMock({this.downloadFun, this.downloadUrlFun,
                      this.readTempObjectFun, this.removeTempObjectFun,
                      this.tmpObjectNameFun, this.uploadFun,
                      this.uploadViaTempObjectFun, this.bucketMock});

  get bucket => bucketMock;
  get storage => throw 'no storage support';
  get namer => throw 'no namer support';

  Stream<List<int>> download(String package, String version) {
    if (downloadFun == null) throw 'no downloadFun';
    return downloadFun(package, version);
  }

  Future<Uri> downloadUrl(String package, String version) async {
    if (downloadUrlFun == null) throw 'no downloadUrlFun';
    return downloadUrlFun(package, version);
  }

  Stream<List<int>> readTempObject(String guid) {
    if (readTempObjectFun == null) throw 'no readTempObjectFun';
    return readTempObjectFun(guid);
  }

  Future removeTempObject(String guid) async {
    if (removeTempObjectFun == null) throw 'no removeTempObjectFun';
    return removeTempObjectFun(guid);
  }


  String tempObjectName(String guid) {
    if (tmpObjectNameFun == null) throw 'no tmpObjectNameFun';
    return tmpObjectNameFun(guid);
  }

  Future upload(String package, String version, Stream<List<int>> tarball) {
    if (uploadFun == null) throw 'no uploadFun';
    return uploadFun(package, version, tarball);
  }

  Future uploadViaTempObject(
      String guid, String package, String version) async {
    if (uploadViaTempObjectFun == null) throw 'no uploadViaTempObjectFun';
    return uploadViaTempObjectFun(guid, package, version);
  }
}

class UploadSignerServiceMock implements UploadSignerService {
  final Function buildUploadFun;

  UploadSignerServiceMock(this.buildUploadFun);

  get serviceAccountEmail => throw 'no serviceAccountEmail support';

  AsyncUploadInfo buildUpload(
      String bucket, String object, Duration lifetime,
      String successRedirectUrl, {String predefinedAcl: 'project-private',
      int maxUploadSize: UploadSignerService.MAX_UPLOAD_SIZE}) {
    return buildUploadFun(bucket, object, lifetime, successRedirectUrl,
        predefinedAcl: predefinedAcl, maxUploadSize: maxUploadSize);
  }
}

class BucketMock implements Bucket {
  final String bucketName;

  BucketMock(this.bucketName);

  String absoluteObjectName(String objectName) {
    throw 'no absoluteObjectName support';
  }

  Future delete(String name) {
    throw 'no delete support';
  }

  Future<ObjectInfo> info(String name) {
    throw 'no info support';
  }

  Stream<BucketEntry> list({String prefix}) {
    throw 'no list support';
  }

  Future<Page<BucketEntry>> page({String prefix, int pageSize: 50}) {
    throw 'no page support';
  }

  Stream<List<int>> read(String objectName, {int offset: 0, int length}) {
    throw 'no read support';
  }

  Future updateMetadata(String objectName, ObjectMetadata metadata) async {
    throw 'no updateMetadata support';
  }

  StreamSink<List<int>> write(String objectName,
      {int length, ObjectMetadata metadata, Acl acl,
       PredefinedAcl predefinedAcl, String contentType}) {
    throw 'no write support';
  }

  Future<ObjectInfo> writeBytes(String name, List<int> bytes,
      {ObjectMetadata metadata, Acl acl, PredefinedAcl predefinedAcl,
       String contentType}) async {
    throw 'no writeBytes support';
  }
}

Future withTempDirectory(Future func(temp)) async {
  Directory dir =
      await Directory.systemTemp.createTemp('pub.dartlang.org-backend-test');
  return func(dir.absolute.path).whenComplete(() {
    return dir.delete(recursive: true);
  });
}

Future withTestPackage(Future func(List<int> tarball)) {
  return withTempDirectory((String tmp) async {
    var readme = new File('$tmp/README.md');
    var changelog = new File('$tmp/CHANGELOG.md');
    var pubspec = new File('$tmp/pubspec.yaml');

    await readme.writeAsString(TestPackageReadme);
    await changelog.writeAsString(TestPackageChangelog);
    await pubspec.writeAsString(TestPackagePubspec);

    await new Directory('$tmp/lib').create();
    new File('$tmp/lib/test_library.dart')
        .writeAsString('hello() => print("hello");');

    var files =
        ['README.md', 'CHANGELOG.md', 'pubspec.yaml', 'lib/test_library.dart'];
    var args = ['cz']..addAll(files);
    Process p = await Process.start('tar', args, workingDirectory: '$tmp');
    p.stderr.drain();
    var bytes = await p.stdout.fold([], (b, d) => b..addAll(d));
    var exitCode = await p.exitCode;
    if (exitCode != 0) throw 'Failed to make tarball of test package.';
    return func(bytes);
  });
}
