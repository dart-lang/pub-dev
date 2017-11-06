// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.storage;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unittest/unittest.dart';

import 'package:gcloud/storage.dart';

import 'package:googleapis/storage/v1.dart' as storage;

import '../common.dart';
import '../common_e2e.dart';

const String HOSTNAME = 'www.googleapis.com';
const String ROOT_PATH = '/storage/v1/';

http.Client mockClient() => new MockClient(HOSTNAME, ROOT_PATH);

withMockClient(function(MockClient client, Storage storage)) {
  var mock = mockClient();
  function(mock, new Storage(mock, PROJECT));
}

Future withMockClientAsync(
    Future function(MockClient client, Storage storage)) async {
  var mock = mockClient();
  await function(mock, new Storage(mock, PROJECT));
}

main() {
  group('bucket', () {
    var bucketName = 'test-bucket';

    test('create', () {
      withMockClient((mock, api) {
        mock.register('POST', 'b', expectAsync((request) {
          var requestBucket =
              new storage.Bucket.fromJson(JSON.decode(request.body));
          expect(requestBucket.name, bucketName);
          return mock.respond(new storage.Bucket()..name = bucketName);
        }));

        expect(api.createBucket(bucketName), completion(isNull));
      });
    });

    test('create-with-predefined-acl', () {
      var predefined = [
        [PredefinedAcl.authenticatedRead, 'authenticatedRead'],
        [PredefinedAcl.private, 'private'],
        [PredefinedAcl.projectPrivate, 'projectPrivate'],
        [PredefinedAcl.publicRead, 'publicRead'],
        [PredefinedAcl.publicReadWrite, 'publicReadWrite']
      ];

      withMockClient((mock, api) {
        int count = 0;

        mock.register(
            'POST',
            'b',
            expectAsync((request) {
              var requestBucket =
                  new storage.Bucket.fromJson(JSON.decode(request.body));
              expect(requestBucket.name, bucketName);
              expect(requestBucket.acl, isNull);
              expect(request.url.queryParameters['predefinedAcl'],
                  predefined[count++][1]);
              return mock.respond(new storage.Bucket()..name = bucketName);
            }, count: predefined.length));

        var futures = <Future>[];
        for (int i = 0; i < predefined.length; i++) {
          futures.add(
              api.createBucket(bucketName, predefinedAcl: predefined[i][0]));
        }
        return Future.wait(futures);
      });
    });

    test('create-with-acl', () {
      var acl1 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
      ]);
      var acl2 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
      ]);
      var acl3 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
        new AclEntry(new DomainScope('example.com'), AclPermission.READ),
      ]);

      var acls = [acl1, acl2, acl3];

      withMockClient((mock, api) {
        int count = 0;

        mock.register(
            'POST',
            'b',
            expectAsync((request) {
              var requestBucket =
                  new storage.Bucket.fromJson(JSON.decode(request.body));
              expect(requestBucket.name, bucketName);
              expect(request.url.queryParameters['predefinedAcl'], isNull);
              expect(requestBucket.acl, isNotNull);
              expect(requestBucket.acl.length, count + 1);
              expect(requestBucket.acl[0].entity, 'user-user@example.com');
              expect(requestBucket.acl[0].role, 'OWNER');
              if (count > 0) {
                expect(requestBucket.acl[1].entity, 'group-group@example.com');
                expect(requestBucket.acl[1].role, 'WRITER');
              }
              if (count > 2) {
                expect(requestBucket.acl[2].entity, 'domain-example.com');
                expect(requestBucket.acl[2].role, 'READER');
              }
              count++;
              return mock.respond(new storage.Bucket()..name = bucketName);
            }, count: acls.length));

        var futures = <Future>[];
        for (int i = 0; i < acls.length; i++) {
          futures.add(api.createBucket(bucketName, acl: acls[i]));
        }
        return Future.wait(futures);
      });
    });

    test('create-with-acl-and-predefined-acl', () {
      var predefined = [
        [PredefinedAcl.authenticatedRead, 'authenticatedRead'],
        [PredefinedAcl.private, 'private'],
        [PredefinedAcl.projectPrivate, 'projectPrivate'],
        [PredefinedAcl.publicRead, 'publicRead'],
        [PredefinedAcl.publicReadWrite, 'publicReadWrite']
      ];

      var acl1 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
      ]);
      var acl2 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
      ]);
      var acl3 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
        new AclEntry(new DomainScope('example.com'), AclPermission.READ),
      ]);

      var acls = [acl1, acl2, acl3];

      withMockClient((mock, api) {
        int count = 0;

        mock.register(
            'POST',
            'b',
            expectAsync((request) {
              var requestBucket =
                  new storage.Bucket.fromJson(JSON.decode(request.body));
              int predefinedIndex = count ~/ acls.length;
              int aclIndex = count % acls.length;
              expect(requestBucket.name, bucketName);
              expect(request.url.queryParameters['predefinedAcl'],
                  predefined[predefinedIndex][1]);
              expect(requestBucket.acl, isNotNull);
              expect(requestBucket.acl.length, aclIndex + 1);
              expect(requestBucket.acl[0].entity, 'user-user@example.com');
              expect(requestBucket.acl[0].role, 'OWNER');
              if (aclIndex > 0) {
                expect(requestBucket.acl[1].entity, 'group-group@example.com');
                expect(requestBucket.acl[1].role, 'WRITER');
              }
              if (aclIndex > 2) {
                expect(requestBucket.acl[2].entity, 'domain-example.com');
                expect(requestBucket.acl[2].role, 'READER');
              }
              count++;
              return mock.respond(new storage.Bucket()..name = bucketName);
            }, count: predefined.length * acls.length));

        var futures = <Future>[];
        for (int i = 0; i < predefined.length; i++) {
          for (int j = 0; j < acls.length; j++) {
            futures.add(api.createBucket(bucketName,
                predefinedAcl: predefined[i][0], acl: acls[j]));
          }
        }
        return Future.wait(futures);
      });
    });

    test('delete', () {
      withMockClient((mock, api) {
        mock.register('DELETE', new RegExp(r'b/[a-z/-]*$'),
            expectAsync((request) {
          expect(request.url.path, '${ROOT_PATH}b/$bucketName');
          expect(request.body.length, 0);
          return mock.respond(new storage.Bucket()..name = bucketName);
        }));

        expect(api.deleteBucket(bucketName), completion(isNull));
      });
    });

    test('exists', () {
      var exists = true;

      withMockClient((mock, api) {
        mock.register(
            'GET',
            new RegExp(r'b/[a-z/-]*$'),
            expectAsync((request) {
              expect(request.url.path, '${ROOT_PATH}b/$bucketName');
              expect(request.body.length, 0);
              if (exists) {
                return mock.respond(new storage.Bucket()..name = bucketName);
              } else {
                return mock.respondError(404);
              }
            }, count: 2));

        return api.bucketExists(bucketName).then(expectAsync((result) {
          expect(result, isTrue);
          exists = false;
          expect(api.bucketExists(bucketName), completion(isFalse));
        }));
      });
    });

    test('stat', () {
      withMockClient((mock, api) {
        mock.register('GET', new RegExp(r'b/[a-z/-]*$'), expectAsync((request) {
          expect(request.url.path, '${ROOT_PATH}b/$bucketName');
          expect(request.body.length, 0);
          return mock.respond(new storage.Bucket()
            ..name = bucketName
            ..timeCreated = new DateTime(2014));
        }));

        return api.bucketInfo(bucketName).then(expectAsync((result) {
          expect(result.bucketName, bucketName);
          expect(result.created, new DateTime(2014));
        }));
      });
    });

    group('list', () {
      test('empty', () {
        withMockClient((mock, api) {
          mock.register('GET', 'b', expectAsync((request) {
            expect(request.body.length, 0);
            return mock.respond(new storage.Buckets());
          }));

          api.listBucketNames().listen((_) => throw 'Unexpected',
              onDone: expectAsync(() => null));
        });
      });

      test('immediate-cancel', () {
        withMockClient((mock, api) {
          api.listBucketNames().listen((_) => throw 'Unexpected',
              onDone: () => throw 'Unexpected')
            ..cancel();
        });
      });

      test('list', () {
        // TODO: Test list.
      });

      test('page', () {
        // TODO: Test page.
      });
    });

    test('copy', () {
      withMockClient((mock, api) {
        mock.register(
            'POST', 'b/srcBucket/o/srcObject/copyTo/b/destBucket/o/destObject',
            expectAsync((request) {
          return mock.respond(new storage.Object()..name = 'destObject');
        }));
        expect(
            api.copyObject(
                'gs://srcBucket/srcObject', 'gs://destBucket/destObject'),
            completion(isNull));
      });
    });

    test('copy-invalid-args', () {
      withMockClient((mock, api) {
        expect(() => api.copyObject('a', 'b'), throwsA(isFormatException));
        expect(() => api.copyObject('a/b', 'c/d'), throwsA(isFormatException));
        expect(() => api.copyObject('gs://a/b', 'gs://c/'),
            throwsA(isFormatException));
        expect(() => api.copyObject('gs://a/b', 'gs:///c'),
            throwsA(isFormatException));
      });
    });
  });

  group('object', () {
    var bucketName = 'test-bucket';
    var objectName = 'test-object';

    var bytesNormalUpload = [1, 2, 3];

    // Generate a list just above the limit when changing to resumable upload.
    const int MB = 1024 * 1024;
    const int maxNormalUpload = 1 * MB;
    const int minResumableUpload = maxNormalUpload + 1;
    var bytesResumableUpload =
        new List.generate(minResumableUpload, (e) => e & 255);

    bool testArgumentError(e) => e is ArgumentError;
    bool testDetailedApiError(e) => e is storage.DetailedApiRequestError;
    Function expectNotNull(status) => (o) => expect(o, isNotNull);

    expectNormalUpload(mock, data, objectName) {
      var bytes = data.fold([], (p, e) => p..addAll(e));
      mock.registerUpload('POST', 'b/$bucketName/o', expectAsync((request) {
        return mock
            .processNormalMediaUpload(request)
            .then(expectAsync((mediaUpload) {
          var object =
              new storage.Object.fromJson(JSON.decode(mediaUpload.json));
          expect(object.name, objectName);
          expect(mediaUpload.bytes, bytes);
          expect(mediaUpload.contentType, 'application/octet-stream');
          return mock.respond(new storage.Object()..name = objectName);
        }));
      }));
    }

    expectResumableUpload(mock, data, objectName) {
      var bytes = data.fold([], (p, e) => p..addAll(e));
      expect(bytes.length, bytesResumableUpload.length);
      int count = 0;
      mock.registerResumableUpload('POST', 'b/$bucketName/o',
          expectAsync((request) {
        var requestObject =
            new storage.Object.fromJson(JSON.decode(request.body));
        expect(requestObject.name, objectName);
        return mock.respondInitiateResumableUpload(PROJECT);
      }));
      mock.registerResumableUpload(
          'PUT',
          'b/$PROJECT/o',
          expectAsync((request) {
            count++;
            if (count == 1) {
              expect(request.bodyBytes.length, MB);
              return mock.respondContinueResumableUpload();
            } else {
              expect(request.bodyBytes.length, 1);
              return mock.respond(new storage.Object()..name = objectName);
            }
          }, count: 2));
    }

    checkResult(result) {
      expect(result.name, objectName);
    }

    Future pipeToSink(sink, List<List<int>> data) {
      sink.done.then(expectAsync(checkResult));
      sink.done.catchError((e) => throw 'Unexpected $e');
      return new Stream.fromIterable(data)
          .pipe(sink)
          .then(expectAsync(checkResult))
          .catchError((e) => throw 'Unexpected $e');
    }

    Future addStreamToSink(sink, List<List<int>> data) {
      sink.done.then(expectAsync(checkResult));
      sink.done.catchError((e) => throw 'Unexpected $e');
      return sink
          .addStream(new Stream.fromIterable(data))
          .then((_) => sink.close())
          .then(expectAsync(checkResult))
          .catchError((e) => throw 'Unexpected $e');
    }

    Future addToSink(sink, List<List<int>> data) {
      sink.done.then(expectAsync(checkResult));
      sink.done.catchError((e) => throw 'Unexpected $e');
      data.forEach((bytes) => sink.add(bytes));
      return sink
          .close()
          .then(expectAsync(checkResult))
          .catchError((e) => throw 'Unexpected $e');
    }

    Future runTest(mock, api, data, length) {
      var bucket = api.bucket(bucketName);

      Future upload(fn, sendLength) {
        mock.clear();
        if (length <= maxNormalUpload) {
          expectNormalUpload(mock, data, objectName);
        } else {
          expectResumableUpload(mock, data, objectName);
        }
        var sink;
        if (sendLength) {
          sink = bucket.write(objectName, length: length);
        } else {
          sink = bucket.write(objectName);
        }
        return fn(sink, data);
      }

      return upload(pipeToSink, true)
          .then(expectAsync((_) => upload(pipeToSink, false)))
          .then(expectAsync((_) => upload(addStreamToSink, true)))
          .then(expectAsync((_) => upload(addStreamToSink, false)))
          .then(expectAsync((_) => upload(addToSink, true)))
          .then(expectAsync((_) => upload(addToSink, false)));
    }

    test('write-short-1', () {
      withMockClient((mock, api) {
        runTest(mock, api, [bytesNormalUpload], bytesNormalUpload.length);
      });
    });

    test('write-short-2', () {
      withMockClient((mock, api) {
        runTest(mock, api, [bytesNormalUpload, bytesNormalUpload],
            bytesNormalUpload.length * 2);
      });
    });

    test('write-long', () {
      withMockClient((mock, api) {
        runTest(mock, api, [bytesResumableUpload], bytesResumableUpload.length);
      });
    });

    test('write-short-error', () {
      withMockClient((mock, api) {
        Future test(length) {
          mock.clear();
          mock.registerUpload('POST', 'b/$bucketName/o', expectAsync((request) {
            return mock.respondError(500);
          }));

          var bucket = api.bucket(bucketName);
          var sink = bucket.write(bucketName, length: length);
          sink.done.then((_) => throw 'Unexpected').catchError(
              expectAsync(expectNotNull),
              test: testDetailedApiError);
          sink.done.catchError(expectAsync(expectNotNull),
              test: testDetailedApiError);
          return new Stream.fromIterable([bytesNormalUpload])
              .pipe(sink)
              .then((_) => throw 'Unexpected')
              .catchError(expectAsync(expectNotNull),
                  test: testDetailedApiError);
        }

        test(null) // Unknown length.
            .then(expectAsync((_) => test(1)))
            .then(expectAsync((_) => test(10)))
            .then(expectAsync((_) => test(maxNormalUpload)));
      });
    });

    // TODO: Mock the resumable upload timeout.
    test('write-long-error', () {
      withMockClient((mock, api) {
        Future test(length) {
          mock.clear();
          mock.registerResumableUpload('POST', 'b/$bucketName/o',
              expectAsync((request) {
            return mock.respondInitiateResumableUpload(PROJECT);
          }));
          mock.registerResumableUpload(
              'PUT',
              'b/$PROJECT/o',
              expectAsync((request) {
                return mock.respondError(502);
              }, count: 3)); // Default 3 retries in googleapis library.

          var bucket = api.bucket(bucketName);
          var sink = bucket.write(bucketName);
          sink.done.then((_) => throw 'Unexpected').catchError(
              expectAsync(expectNotNull),
              test: testDetailedApiError);
          return new Stream.fromIterable([bytesResumableUpload])
              .pipe(sink)
              .then((_) => throw 'Unexpected')
              .catchError(expectAsync(expectNotNull),
                  test: testDetailedApiError);
        }

        test(null) // Unknown length.
            .then(expectAsync((_) => test(minResumableUpload)));
      });
    });

    test('write-long-wrong-length', () {
      withMockClient((mock, api) {
        Future test(data, length) {
          mock.clear();
          mock.registerResumableUpload('POST', 'b/$bucketName/o',
              expectAsync((request) {
            return mock.respondInitiateResumableUpload(PROJECT);
          }));
          mock.registerResumableUpload('PUT', 'b/$PROJECT/o',
              expectAsync((request) {
            return mock.respondContinueResumableUpload();
          })); // Default 3 retries in googleapis library.

          var bucket = api.bucket(bucketName);
          var sink = bucket.write(bucketName, length: length);
          sink.done.then((_) => throw 'Unexpected').catchError(
              expectAsync(expectNotNull),
              test: (e) => e is String || e is storage.ApiRequestError);
          return new Stream.fromIterable(data)
              .pipe(sink)
              .then((_) => throw 'Unexpected')
              .catchError(expectAsync(expectNotNull),
                  test: (e) => e is String || e is storage.ApiRequestError);
        }

        test([bytesResumableUpload], bytesResumableUpload.length + 1)
            .then(expectAsync((_) => test([
                  bytesResumableUpload,
                  [1, 2]
                ], bytesResumableUpload.length + 1)));
      });
    });

    test('write-add-error', () {
      withMockClient((mock, api) {
        var bucket = api.bucket(bucketName);
        var sink = bucket.write(bucketName);
        sink.done
            .then((_) => throw 'Unexpected')
            .catchError(expectAsync(expectNotNull), test: testArgumentError);
        var stream = new Stream.fromIterable([
          [1, 2, 3]
        ]);
        sink.addStream(stream).then((_) {
          sink.addError(new ArgumentError());
          sink
              .close()
              .catchError(expectAsync(expectNotNull), test: testArgumentError);
        });
      });
    });

    test('write-long-add-error', () {
      withMockClient((mock, api) {
        mock.registerResumableUpload('POST', 'b/$bucketName/o',
            expectAsync((request) {
          return mock.respondInitiateResumableUpload(PROJECT);
        }));
        // The resumable upload will buffer until either close or a full chunk,
        // so when we add an error the last byte is never sent. Therefore this
        // PUT is only called once.
        mock.registerResumableUpload('PUT', 'b/$PROJECT/o',
            expectAsync((request) {
          expect(request.bodyBytes.length, 1024 * 1024);
          return mock.respondContinueResumableUpload();
        }));

        var bucket = api.bucket(bucketName);
        var sink = bucket.write(bucketName);
        sink.done
            .then((_) => throw 'Unexpected')
            .catchError(expectAsync(expectNotNull), test: testArgumentError);
        var stream = new Stream.fromIterable([bytesResumableUpload]);
        sink.addStream(stream).then((_) {
          sink.addError(new ArgumentError());
          sink
              .close()
              .catchError(expectAsync(expectNotNull), test: testArgumentError);
        });
      });
    });

    test('write-with-metadata-short', () {
      var metadata = [
        new ObjectMetadata(contentType: 'mime/type'),
        new ObjectMetadata(
            contentType: 'type/mime', cacheControl: 'control-cache'),
        new ObjectMetadata(cacheControl: 'control-cache'),
        new ObjectMetadata(
            cacheControl: 'control-cache', contentDisposition: 'disp-content'),
        new ObjectMetadata(
            contentDisposition: 'disp-content',
            contentEncoding: 'encoding',
            contentLanguage: 'language'),
        new ObjectMetadata(custom: {'x': 'y'}),
        new ObjectMetadata(custom: {'a': 'b', 'x': 'y'})
      ];

      withMockClient((mock, api) {
        int count = 0;
        var bytes = [1, 2, 3];

        mock.registerUpload(
            'POST',
            'b/$bucketName/o',
            expectAsync((request) {
              return mock
                  .processNormalMediaUpload(request)
                  .then(expectAsync((mediaUpload) {
                var object =
                    new storage.Object.fromJson(JSON.decode(mediaUpload.json));
                ObjectMetadata m = metadata[count];
                expect(object.name, objectName);
                expect(mediaUpload.bytes, bytes);
                var contentType = m.contentType != null
                    ? m.contentType
                    : 'application/octet-stream';
                expect(mediaUpload.contentType, contentType);
                expect(object.cacheControl, m.cacheControl);
                expect(object.contentDisposition, m.contentDisposition);
                expect(object.contentEncoding, m.contentEncoding);
                expect(object.contentLanguage, m.contentLanguage);
                expect(object.metadata, m.custom);
                count++;
                return mock.respond(new storage.Object()..name = objectName);
              }));
            }, count: metadata.length));

        var bucket = api.bucket(bucketName);
        var futures = <Future>[];
        for (int i = 0; i < metadata.length; i++) {
          futures
              .add(bucket.writeBytes(objectName, bytes, metadata: metadata[i]));
        }
        return Future.wait(futures);
      });
    });

    test('write-with-metadata-long', () {
      var metadata = [
        new ObjectMetadata(contentType: 'mime/type'),
        new ObjectMetadata(
            contentType: 'type/mime', cacheControl: 'control-cache'),
        new ObjectMetadata(cacheControl: 'control-cache'),
        new ObjectMetadata(
            cacheControl: 'control-cache', contentDisposition: 'disp-content'),
        new ObjectMetadata(
            contentDisposition: 'disp-content',
            contentEncoding: 'encoding',
            contentLanguage: 'language'),
        new ObjectMetadata(custom: {'x': 'y'}),
        new ObjectMetadata(custom: {'a': 'b', 'x': 'y'})
      ];

      withMockClient((mock, api) {
        int countInitial = 0;
        int countData = 0;

        mock.registerResumableUpload(
            'POST',
            'b/$bucketName/o',
            expectAsync((request) {
              var object =
                  new storage.Object.fromJson(JSON.decode(request.body));
              ObjectMetadata m = metadata[countInitial];
              expect(object.name, objectName);
              expect(object.cacheControl, m.cacheControl);
              expect(object.contentDisposition, m.contentDisposition);
              expect(object.contentEncoding, m.contentEncoding);
              expect(object.contentLanguage, m.contentLanguage);
              expect(object.metadata, m.custom);
              countInitial++;
              return mock.respondInitiateResumableUpload(PROJECT);
            }, count: metadata.length));
        mock.registerResumableUpload(
            'PUT',
            'b/$PROJECT/o',
            expectAsync((request) {
              ObjectMetadata m = metadata[countData % metadata.length];
              var contentType = m.contentType != null
                  ? m.contentType
                  : 'application/octet-stream';
              expect(request.headers['content-type'], contentType);
              bool firstPart = countData < metadata.length;
              countData++;
              if (firstPart) {
                expect(request.bodyBytes.length, MB);
                return mock.respondContinueResumableUpload();
              } else {
                expect(request.bodyBytes.length, 1);
                return mock.respond(new storage.Object()..name = objectName);
              }
            }, count: metadata.length * 2));

        var bucket = api.bucket(bucketName);
        var futures = <Future>[];
        for (int i = 0; i < metadata.length; i++) {
          futures.add(bucket.writeBytes(objectName, bytesResumableUpload,
              metadata: metadata[i]));
        }
        return Future.wait(futures);
      });
    });

    test('write-with-predefined-acl', () {
      var predefined = [
        [PredefinedAcl.authenticatedRead, 'authenticatedRead'],
        [PredefinedAcl.private, 'private'],
        [PredefinedAcl.projectPrivate, 'projectPrivate'],
        [PredefinedAcl.publicRead, 'publicRead'],
        [PredefinedAcl.bucketOwnerFullControl, 'bucketOwnerFullControl'],
        [PredefinedAcl.bucketOwnerRead, 'bucketOwnerRead']
      ];

      withMockClient((mock, api) {
        int count = 0;
        var bytes = [1, 2, 3];

        mock.registerUpload(
            'POST',
            'b/$bucketName/o',
            expectAsync((request) {
              return mock
                  .processNormalMediaUpload(request)
                  .then(expectAsync((mediaUpload) {
                var object =
                    new storage.Object.fromJson(JSON.decode(mediaUpload.json));
                expect(object.name, objectName);
                expect(mediaUpload.bytes, bytes);
                expect(mediaUpload.contentType, 'application/octet-stream');
                expect(request.url.queryParameters['predefinedAcl'],
                    predefined[count++][1]);
                expect(object.acl, isNull);
                return mock.respond(new storage.Object()..name = objectName);
              }));
            }, count: predefined.length));

        var bucket = api.bucket(bucketName);
        var futures = <Future>[];
        for (int i = 0; i < predefined.length; i++) {
          futures.add(bucket.writeBytes(objectName, bytes,
              predefinedAcl: predefined[i][0]));
        }
        return Future.wait(futures);
      });
    });

    test('write-with-acl', () {
      var acl1 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
      ]);
      var acl2 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
      ]);
      var acl3 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
        new AclEntry(new DomainScope('example.com'), AclPermission.READ),
      ]);

      var acls = [acl1, acl2, acl3];

      withMockClient((mock, api) {
        int count = 0;
        var bytes = [1, 2, 3];

        mock.registerUpload(
            'POST',
            'b/$bucketName/o',
            expectAsync((request) {
              return mock
                  .processNormalMediaUpload(request)
                  .then(expectAsync((mediaUpload) {
                var object =
                    new storage.Object.fromJson(JSON.decode(mediaUpload.json));
                expect(object.name, objectName);
                expect(mediaUpload.bytes, bytes);
                expect(mediaUpload.contentType, 'application/octet-stream');
                expect(request.url.queryParameters['predefinedAcl'], isNull);
                expect(object.acl, isNotNull);
                expect(object.acl.length, count + 1);
                expect(object.acl[0].entity, 'user-user@example.com');
                expect(object.acl[0].role, 'OWNER');
                if (count > 0) {
                  expect(object.acl[1].entity, 'group-group@example.com');
                  expect(object.acl[1].role, 'OWNER');
                }
                if (count > 2) {
                  expect(object.acl[2].entity, 'domain-example.com');
                  expect(object.acl[2].role, 'READER');
                }
                count++;
                return mock.respond(new storage.Object()..name = objectName);
              }));
            }, count: acls.length));

        var bucket = api.bucket(bucketName);
        var futures = <Future>[];
        for (int i = 0; i < acls.length; i++) {
          futures.add(bucket.writeBytes(objectName, bytes, acl: acls[i]));
        }
        return Future.wait(futures);
      });
    });

    test('write-with-acl-and-predefined-acl', () {
      var predefined = [
        [PredefinedAcl.authenticatedRead, 'authenticatedRead'],
        [PredefinedAcl.private, 'private'],
        [PredefinedAcl.projectPrivate, 'projectPrivate'],
        [PredefinedAcl.publicRead, 'publicRead'],
        [PredefinedAcl.bucketOwnerFullControl, 'bucketOwnerFullControl'],
        [PredefinedAcl.bucketOwnerRead, 'bucketOwnerRead']
      ];

      var acl1 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
      ]);
      var acl2 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
      ]);
      var acl3 = new Acl([
        new AclEntry(
            new AccountScope('user@example.com'), AclPermission.FULL_CONTROL),
        new AclEntry(new GroupScope('group@example.com'), AclPermission.WRITE),
        new AclEntry(new DomainScope('example.com'), AclPermission.READ),
      ]);

      var acls = [acl1, acl2, acl3];

      withMockClient((mock, api) {
        int count = 0;
        var bytes = [1, 2, 3];

        mock.registerUpload(
            'POST',
            'b/$bucketName/o',
            expectAsync((request) {
              return mock
                  .processNormalMediaUpload(request)
                  .then(expectAsync((mediaUpload) {
                int predefinedIndex = count ~/ acls.length;
                int aclIndex = count % acls.length;
                var object =
                    new storage.Object.fromJson(JSON.decode(mediaUpload.json));
                expect(object.name, objectName);
                expect(mediaUpload.bytes, bytes);
                expect(mediaUpload.contentType, 'application/octet-stream');
                expect(request.url.queryParameters['predefinedAcl'],
                    predefined[predefinedIndex][1]);
                expect(object.acl, isNotNull);
                expect(object.acl.length, aclIndex + 1);
                expect(object.acl[0].entity, 'user-user@example.com');
                expect(object.acl[0].role, 'OWNER');
                if (aclIndex > 0) {
                  expect(object.acl[1].entity, 'group-group@example.com');
                  expect(object.acl[1].role, 'OWNER');
                }
                if (aclIndex > 2) {
                  expect(object.acl[2].entity, 'domain-example.com');
                  expect(object.acl[2].role, 'READER');
                }
                count++;
                return mock.respond(new storage.Object()..name = objectName);
              }));
            }, count: predefined.length * acls.length));

        var bucket = api.bucket(bucketName);
        var futures = <Future>[];
        for (int i = 0; i < predefined.length; i++) {
          for (int j = 0; j < acls.length; j++) {
            futures.add(bucket.writeBytes(objectName, bytes,
                acl: acls[j], predefinedAcl: predefined[i][0]));
          }
        }
        return Future.wait(futures);
      });
    });

    group('read', () {
      test('success', () async {
        await withMockClientAsync((MockClient mock, Storage api) async {
          mock.register('GET', 'b/$bucketName/o/$objectName',
              expectAsync(mock.respondBytes));

          var bucket = api.bucket(bucketName);
          var data = [];

          await bucket.read(objectName).forEach(data.addAll);
          expect(data, MockClient.bytes);
        });
      });

      test('with offset, without length', () async {
        await withMockClientAsync((MockClient mock, Storage api) async {
          var bucket = api.bucket(bucketName);

          try {
            await bucket.read(objectName, offset: 1).toList();
            fail('An exception should be thrown');
          } on ArgumentError catch (e) {
            expect(
                e.message, "length must have a value if offset is non-zero.");
          }
        });
      });

      test('with offset and length zero', () async {
        await withMockClientAsync((MockClient mock, Storage api) async {
          var bucket = api.bucket(bucketName);

          try {
            await bucket.read(objectName, offset: 1, length: 0).toList();
            fail('An exception should be thrown');
          } on ArgumentError catch (e) {
            expect(e.message, "If provided, length must greater than zero.");
          }
        });
      });

      test('with invalid length', () async {
        await withMockClientAsync((MockClient mock, Storage api) async {
          var bucket = api.bucket(bucketName);

          try {
            await bucket.read(objectName, length: -1).toList();
            fail('An exception should be thrown');
          } on ArgumentError catch (e) {
            expect(e.message, "If provided, length must greater than zero.");
          }
        });
      });

      test('with length', () async {
        await withMockClientAsync((MockClient mock, Storage api) async {
          mock.register('GET', 'b/$bucketName/o/$objectName',
              expectAsync(mock.respondBytes));

          var bucket = api.bucket(bucketName);
          var data = [];

          await bucket.read(objectName, length: 4).forEach(data.addAll);
          expect(data, MockClient.bytes.sublist(0, 4));
        });
      });

      test('with offset and length', () async {
        await withMockClientAsync((MockClient mock, Storage api) async {
          mock.register('GET', 'b/$bucketName/o/$objectName',
              expectAsync(mock.respondBytes));

          var bucket = api.bucket(bucketName);
          var data = [];

          await bucket
              .read(objectName, offset: 1, length: 3)
              .forEach(data.addAll);
          expect(data, MockClient.bytes.sublist(1, 4));
        });
      });

      test('file does not exist', () async {
        await withMockClientAsync((MockClient mock, Storage api) async {
          mock.register('GET', 'b/$bucketName/o/$objectName',
              expectAsync((request) {
            expect(request.url.queryParameters['alt'], 'media');
            return mock.respondError(404);
          }));

          var bucket = api.bucket(bucketName);

          try {
            await bucket.read(objectName).toList();
            fail('An exception should be thrown');
          } on storage.DetailedApiRequestError catch (e) {
            expect(e.status, 404);
          }
        });
      });
    });

    test('stat', () {
      withMockClient((mock, api) {
        mock.register('GET', 'b/$bucketName/o/$objectName',
            expectAsync((request) {
          expect(request.url.queryParameters['alt'], 'json');
          return mock.respond(new storage.Object()
            ..name = objectName
            ..updated = new DateTime(2014)
            ..contentType = 'mime/type');
        }));

        var api = new Storage(mock, PROJECT);
        var bucket = api.bucket(bucketName);
        bucket.info(objectName).then(expectAsync((stat) {
          expect(stat.name, objectName);
          expect(stat.updated, new DateTime(2014));
          expect(stat.metadata.contentType, 'mime/type');
        }));
      });
    });

    test('stat-acl', () {
      withMockClient((mock, api) {
        mock.register('GET', 'b/$bucketName/o/$objectName',
            expectAsync((request) {
          expect(request.url.queryParameters['alt'], 'json');
          var acl1 = new storage.ObjectAccessControl();
          acl1.entity = 'user-1234567890';
          acl1.role = 'OWNER';
          var acl2 = new storage.ObjectAccessControl();
          acl2.entity = 'user-xxx@yyy.zzz';
          acl2.role = 'OWNER';
          var acl3 = new storage.ObjectAccessControl();
          acl3.entity = 'xxx-1234567890';
          acl3.role = 'OWNER';
          return mock.respond(new storage.Object()
            ..name = objectName
            ..acl = [acl1, acl2, acl3]);
        }));

        var api = new Storage(mock, PROJECT);
        var bucket = api.bucket(bucketName);
        bucket.info(objectName).then(expectAsync((ObjectInfo info) {
          expect(info.name, objectName);
          expect(info.metadata.acl.entries.length, 3);
          expect(info.metadata.acl.entries[0] is AclEntry, isTrue);
          expect(info.metadata.acl.entries[0].scope is StorageIdScope, isTrue);
          expect(info.metadata.acl.entries[1] is AclEntry, isTrue);
          expect(info.metadata.acl.entries[1].scope is AccountScope, isTrue);
          expect(info.metadata.acl.entries[2] is AclEntry, isTrue);
          expect(info.metadata.acl.entries[2].scope is OpaqueScope, isTrue);
        }));
      });
    });

    group('list', () {
      test('empty', () {
        withMockClient((mock, api) {
          mock.register('GET', 'b/$bucketName/o', expectAsync((request) {
            expect(request.body.length, 0);
            return mock.respond(new storage.Objects());
          }));

          var bucket = api.bucket(bucketName);
          bucket.list().listen((_) => throw 'Unexpected',
              onDone: expectAsync(() => null));
        });
      });

      test('immediate-cancel', () {
        withMockClient((mock, api) {
          var bucket = api.bucket(bucketName);
          bucket.list().listen((_) => throw 'Unexpected',
              onDone: () => throw 'Unexpected')
            ..cancel();
        });
      });

      test('list', () {
        // TODO: Test list.
      });

      test('page', () {
        // TODO: Test page.
      });
    });
  });

  group('acl', () {
    var id = new StorageIdScope('1234567890');
    var user = new AccountScope('sgjesse@google.com');
    var group = new GroupScope('dart');
    var domain = new DomainScope('dartlang.org');

    var userRead = new AclEntry(user, AclPermission.READ);
    var groupWrite = new AclEntry(group, AclPermission.WRITE);
    var domainFullControl = new AclEntry(domain, AclPermission.FULL_CONTROL);

    test('compare-scope', () {
      expect(id, new StorageIdScope('1234567890'));
      expect(user, new AccountScope('sgjesse@google.com'));
      expect(group, new GroupScope('dart'));
      expect(domain, new DomainScope('dartlang.org'));
      expect(AclScope.allAuthenticated, new AllAuthenticatedScope());
      expect(AclScope.allUsers, new AllUsersScope());
    });

    test('compare-entries', () {
      expect(userRead, new AclEntry(user, AclPermission.READ));
      expect(groupWrite, new AclEntry(group, AclPermission.WRITE));
      expect(
          domainFullControl, new AclEntry(domain, AclPermission.FULL_CONTROL));
    });

    test('compare-acls', () {
      var acl = new Acl([userRead, groupWrite, domainFullControl]);
      expect(
          acl,
          new Acl([
            new AclEntry(user, AclPermission.READ),
            new AclEntry(group, AclPermission.WRITE),
            new AclEntry(domain, AclPermission.FULL_CONTROL)
          ]));
      expect(
          acl,
          isNot(equals(new Acl([
            new AclEntry(group, AclPermission.WRITE),
            new AclEntry(user, AclPermission.READ),
            new AclEntry(domain, AclPermission.FULL_CONTROL)
          ]))));
    });

    test('compare-predefined-acls', () {
      expect(PredefinedAcl.private, PredefinedAcl.private);
      expect(PredefinedAcl.private, isNot(equals(PredefinedAcl.publicRead)));
    });
  });
}
