// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/storage.dart';
import 'package:stack_trace/stack_trace.dart';

const _skippedFirstFrames = {
  'package:fake_gcloud/retry_enforcer_storage.dart',
  'package:pub_dev/shared/storage.dart',
};

void _verifyRetryOnStack() {
  final trace = Trace.current();

  // The first frame index outside of this file.
  var startFrameIndex = 0;
  while (_skippedFirstFrames.any((skipped) =>
      trace.frames[startFrameIndex].uri.toString().contains(skipped))) {
    startFrameIndex++;
  }

  final firstRealFrame =
      trace.frames.skip(startFrameIndex).firstOrNull?.toString();
  if (firstRealFrame == null) {
    return;
  }

  // detect direct test calls
  if (firstRealFrame.contains('_test.dart')) {
    return;
  }

  // detect retry library
  if (firstRealFrame.contains('package:retry/')) {
    return;
  }
  // detect lib/shared/utils.dart use
  if (firstRealFrame.contains('retryAsync')) {
    return;
  }

  print('Missing retry detected:\n$trace\n');
  throw AssertionError('retry is not present in stacktrace: $trace');
}

Future<R> _verifyRetry<R>(
  Future<R> Function() fn, {
  bool ignore = false,
}) async {
  if (!ignore) {
    _verifyRetryOnStack();
  }
  return await fn();
}

/// A storage implementation that enforces (or just report) retry wrapper
/// on [Storage] API calls.
class RetryEnforcerStorage implements Storage {
  final Storage _storage;

  RetryEnforcerStorage(this._storage);

  @override
  Bucket bucket(
    String bucketName, {
    PredefinedAcl? defaultPredefinedObjectAcl,
    Acl? defaultObjectAcl,
  }) {
    return _RetryEnforcerBucket(_storage.bucket(
      bucketName,
      defaultObjectAcl: defaultObjectAcl,
      defaultPredefinedObjectAcl: defaultPredefinedObjectAcl,
    ));
  }

  @override
  Future<bool> bucketExists(String bucketName) async {
    return await _verifyRetry(
      () => _storage.bucketExists(bucketName),
    );
  }

  @override
  Future<BucketInfo> bucketInfo(String bucketName) async {
    return await _verifyRetry(
      () async => await _storage.bucketInfo(bucketName),
    );
  }

  @override
  Future copyObject(String src, String dest, {ObjectMetadata? metadata}) async {
    return await _verifyRetry(
      () => _storage.copyObject(src, dest, metadata: metadata),
    );
  }

  @override
  Future createBucket(
    String bucketName, {
    PredefinedAcl? predefinedAcl,
    Acl? acl,
  }) async {
    return await _verifyRetry(
      () async => await _storage.createBucket(
        bucketName,
        predefinedAcl: predefinedAcl,
        acl: acl,
      ),
    );
  }

  @override
  Future deleteBucket(String bucketName) async {
    return await _verifyRetry(
      () => _storage.deleteBucket(bucketName),
    );
  }

  @override
  Stream<String> listBucketNames() {
    return _storage.listBucketNames();
  }

  @override
  Future<Page<String>> pageBucketNames({int pageSize = 50}) async {
    return await _verifyRetry(
      () => _storage.pageBucketNames(pageSize: pageSize),
    );
  }
}

class _RetryEnforcerBucket implements Bucket {
  final Bucket _bucket;

  _RetryEnforcerBucket(this._bucket);

  @override
  String absoluteObjectName(String objectName) {
    return _bucket.absoluteObjectName(objectName);
  }

  @override
  String get bucketName => _bucket.bucketName;

  @override
  Future delete(String name) async {
    return await _verifyRetry(
      () async => await _bucket.delete(name),
    );
  }

  @override
  Future<ObjectInfo> info(String name) async {
    return await _verifyRetry(
      () async => await _bucket.info(name),
    );
  }

  @override
  Stream<BucketEntry> list({String? prefix, String? delimiter}) {
    // TODO: verify retry wrapper here
    _verifyRetryOnStack();
    return _bucket.list(
      prefix: prefix,
      delimiter: delimiter,
    );
  }

  @override
  Future<Page<BucketEntry>> page({
    String? prefix,
    String? delimiter,
    int pageSize = 50,
  }) async {
    return await _verifyRetry(
      () async => _RetryEnforcerPage(await _bucket.page(
        prefix: prefix,
        delimiter: delimiter,
        pageSize: pageSize,
      )),
    );
  }

  @override
  Stream<List<int>> read(String objectName, {int? offset, int? length}) {
    _verifyRetryOnStack();
    return _bucket.read(objectName, offset: offset, length: length);
  }

  @override
  Future updateMetadata(String objectName, ObjectMetadata metadata) async {
    return await _verifyRetry(
      () async => await _bucket.updateMetadata(objectName, metadata),
    );
  }

  @override
  StreamSink<List<int>> write(
    String objectName, {
    int? length,
    ObjectMetadata? metadata,
    Acl? acl,
    PredefinedAcl? predefinedAcl,
    String? contentType,
  }) {
    _verifyRetryOnStack();
    return _bucket.write(
      objectName,
      length: length,
      metadata: metadata,
      acl: acl,
      predefinedAcl: predefinedAcl,
      contentType: contentType,
    );
  }

  @override
  Future<ObjectInfo> writeBytes(
    String name,
    List<int> bytes, {
    ObjectMetadata? metadata,
    Acl? acl,
    PredefinedAcl? predefinedAcl,
    String? contentType,
  }) async {
    return await _verifyRetry(
      () async => await _bucket.writeBytes(
        name,
        bytes,
        metadata: metadata,
        acl: acl,
        predefinedAcl: predefinedAcl,
        contentType: contentType,
      ),
    );
  }
}

class _RetryEnforcerPage<T> implements Page<T> {
  final Page<T> _page;
  _RetryEnforcerPage(this._page);

  @override
  bool get isLast => _page.isLast;

  @override
  List<T> get items => _page.items;

  @override
  Future<Page<T>> next({int pageSize = 50}) async {
    return await _verifyRetry(
      () async => _RetryEnforcerPage(await _page.next(pageSize: pageSize)),
    );
  }
}
