// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.storage;

import 'dart:async';

import 'package:googleapis/storage/v1.dart' as storage_api;
import 'package:gcloud/storage.dart';
import 'package:unittest/unittest.dart';

import '../common_e2e.dart';

String generateBucketName() {
  var id = new DateTime.now().millisecondsSinceEpoch;
  return 'dart-e2e-test-$id';
}

bool testDetailedApiError(e) => e is storage_api.DetailedApiRequestError;

// Generate a list just above the limit when changing to resumable upload.
const int MB = 1024 * 1024;
const int maxNormalUpload = 1 * MB;
const int minResumableUpload = maxNormalUpload + 1;
final bytesResumableUpload =
    new List<int>.generate(minResumableUpload, (e) => e & 255);

runTests(Storage storage, Bucket testBucket) {
  group('bucket', () {
    test('create-info-delete', () {
      var bucketName = generateBucketName();
      return storage.createBucket(bucketName).then(expectAsync((result) {
        expect(result, isNull);
        return storage.bucketInfo(bucketName).then(expectAsync((info) {
          expect(info.bucketName, bucketName);
          expect(info.etag, isNotNull);
          expect(info.created is DateTime, isTrue);
          expect(info.id, isNotNull);
          return storage.deleteBucket(bucketName).then(expectAsync((result) {
            expect(result, isNull);
          }));
        }));
      }));
    });

    test('create-with-predefined-acl-delete', () {
      Future<Acl> test(predefinedAcl, expectedLength) {
        var bucketName = generateBucketName();
        return storage
            .createBucket(bucketName, predefinedAcl: predefinedAcl)
            .then(expectAsync((result) {
          expect(result, isNull);
          return storage.bucketInfo(bucketName).then(expectAsync((info) {
            var acl = info.acl;
            expect(info.bucketName, bucketName);
            expect(acl.entries.length, expectedLength);
            return storage.deleteBucket(bucketName).then(expectAsync((result) {
              expect(result, isNull);
            }));
          }));
        }));
      }

      return Future.forEach([
        // TODO: Figure out why some returned ACLs are empty.
        () => test(PredefinedAcl.authenticatedRead, 0),
        // [test, [PredefinedAcl.private, 0]],  // TODO: Cannot delete.
        () => test(PredefinedAcl.projectPrivate, 3),
        () => test(PredefinedAcl.publicRead, 0),
        () => test(PredefinedAcl.publicReadWrite, 0)
      ], (f) => f().then(expectAsync((_) {})));
    });

    test('create-error', () {
      storage.createBucket('goog-reserved').catchError(expectAsync((e) {
        expect(e, isNotNull);
      }), test: testDetailedApiError);
    });
  });

  solo_group('object', () {
    // Run all object tests in the same bucket to try to avoid the rate-limit
    // for creating and deleting buckets while testing.
    Future withTestBucket(function) {
      return function(testBucket).whenComplete(() {
        // TODO: Clean the bucket.
      });
    }

    test('create-read-delete', () {
      Future test(name, bytes) {
        return withTestBucket((Bucket bucket) {
          return bucket.writeBytes('test', bytes).then(expectAsync((info) {
            expect(info, isNotNull);
            return bucket
                .read('test')
                .fold([], (p, e) => p..addAll(e)).then(expectAsync((result) {
              expect(result, bytes);
              return bucket.delete('test').then(expectAsync((result) {
                expect(result, isNull);
              }));
            }));
          }));
        });
      }

      return Future.forEach([
        () => test('test-1', [1, 2, 3]),
        () => test('test-2', bytesResumableUpload)
      ], (f) => f().then(expectAsync((_) {})));
    });

    test('create-with-predefined-acl-delete', () {
      return withTestBucket((Bucket bucket) {
        Future test(objectName, predefinedAcl, expectedLength) {
          return bucket
              .writeBytes(objectName, [1, 2, 3], predefinedAcl: predefinedAcl)
              .then(expectAsync((result) {
            expect(result, isNotNull);
            return bucket.info(objectName).then(expectAsync((info) {
              var acl = info.metadata.acl;
              expect(info.name, objectName);
              expect(info.etag, isNotNull);
              expect(acl.entries.length, expectedLength);
              return bucket.delete(objectName).then(expectAsync((result) {
                expect(result, isNull);
              }));
            }));
          }));
        }

        return Future.forEach([
          () => test('test-1', PredefinedAcl.authenticatedRead, 2),
          () => test('test-2', PredefinedAcl.private, 1),
          () => test('test-3', PredefinedAcl.projectPrivate, 4),
          () => test('test-4', PredefinedAcl.publicRead, 2),
          () => test('test-5', PredefinedAcl.bucketOwnerFullControl, 2),
          () => test('test-6', PredefinedAcl.bucketOwnerRead, 2)
        ], (f) => f().then(expectAsync((_) {})));
      });
    });

    test('create-with-acl-delete', () {
      return withTestBucket((Bucket bucket) {
        Future test(objectName, acl, expectedLength) {
          return bucket
              .writeBytes(objectName, [1, 2, 3], acl: acl)
              .then(expectAsync((result) {
            expect(result, isNotNull);
            return bucket.info(objectName).then(expectAsync((info) {
              var acl = info.metadata.acl;
              expect(info.name, objectName);
              expect(info.etag, isNotNull);
              expect(acl.entries.length, expectedLength);
              return bucket.delete(objectName).then(expectAsync((result) {
                expect(result, isNull);
              }));
            }));
          }));
        }

        Acl acl1 = new Acl(
            [new AclEntry(AclScope.allAuthenticated, AclPermission.WRITE)]);
        Acl acl2 = new Acl([
          new AclEntry(AclScope.allUsers, AclPermission.WRITE),
          new AclEntry(
              new AccountScope('sgjesse@google.com'), AclPermission.WRITE)
        ]);
        Acl acl3 = new Acl([
          new AclEntry(AclScope.allUsers, AclPermission.WRITE),
          new AclEntry(
              new AccountScope('sgjesse@google.com'), AclPermission.WRITE),
          new AclEntry(new GroupScope('misc@dartlang.org'), AclPermission.READ)
        ]);
        Acl acl4 = new Acl([
          new AclEntry(AclScope.allUsers, AclPermission.WRITE),
          new AclEntry(
              new AccountScope('sgjesse@google.com'), AclPermission.WRITE),
          new AclEntry(new GroupScope('misc@dartlang.org'), AclPermission.READ),
          new AclEntry(
              new DomainScope('dartlang.org'), AclPermission.FULL_CONTROL)
        ]);

        // The expected length of the returned ACL is one longer than the one
        // use during creation as an additional 'used-ID' ACL entry is added
        // by cloud storage during creation.
        return Future.forEach([
          () => test('test-1', acl1, acl1.entries.length + 1),
          () => test('test-2', acl2, acl2.entries.length + 1),
          () => test('test-3', acl3, acl3.entries.length + 1),
          () => test('test-4', acl4, acl4.entries.length + 1)
        ], (f) => f().then(expectAsync((_) {})));
      });
    });

    test('create-with-metadata-delete', () {
      return withTestBucket((Bucket bucket) {
        Future test(objectName, metadata, bytes) {
          return bucket
              .writeBytes(objectName, bytes, metadata: metadata)
              .then(expectAsync((result) {
            expect(result, isNotNull);
            return bucket.info(objectName).then(expectAsync((info) {
              expect(info.name, objectName);
              expect(info.length, bytes.length);
              expect(info.updated is DateTime, isTrue);
              expect(info.md5Hash, isNotNull);
              expect(info.crc32CChecksum, isNotNull);
              expect(info.downloadLink is Uri, isTrue);
              expect(info.generation.objectGeneration, isNotNull);
              expect(info.generation.metaGeneration, 1);
              expect(info.metadata.contentType, metadata.contentType);
              expect(info.metadata.cacheControl, metadata.cacheControl);
              expect(info.metadata.contentDisposition,
                  metadata.contentDisposition);
              expect(info.metadata.contentEncoding, metadata.contentEncoding);
              expect(info.metadata.contentLanguage, metadata.contentLanguage);
              expect(info.metadata.custom, metadata.custom);
              return bucket.delete(objectName).then(expectAsync((result) {
                expect(result, isNull);
              }));
            }));
          }));
        }

        var metadata1 = new ObjectMetadata(contentType: 'text/plain');
        var metadata2 = new ObjectMetadata(
            contentType: 'text/plain',
            cacheControl: 'no-cache',
            contentDisposition: 'attachment; filename="test.txt"',
            contentEncoding: 'gzip',
            contentLanguage: 'da',
            custom: {'a': 'b', 'c': 'd'});

        return Future.forEach([
          () => test('test-1', metadata1, [65, 66, 67]),
          () => test('test-2', metadata2, [65, 66, 67]),
          () => test('test-3', metadata1, bytesResumableUpload),
          () => test('test-4', metadata2, bytesResumableUpload)
        ], (f) => f().then(expectAsync((_) {})));
      });
    });
  });
}

main() {
  withAuthClient(Storage.SCOPES, (String project, httpClient) {
    var testBucket = generateBucketName();

    // Share the same storage connection for all tests.
    var storage = new Storage(httpClient, project);

    // Create a shared bucket for all object tests.
    return storage.createBucket(testBucket).then((_) {
      return runE2EUnittest(() {
        runTests(storage, storage.bucket(testBucket));
      }).whenComplete(() {
        // Deleting a bucket relies on eventually consistent behaviour, hence
        // the delay in attempt to prevent test flakiness.
        return new Future.delayed(STORAGE_LIST_DELAY, () {
          return storage.deleteBucket(testBucket);
        });
      });
    });
  });
}
