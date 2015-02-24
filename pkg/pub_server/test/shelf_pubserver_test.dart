// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_server.shelf_pubserver_test;

import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;
import 'package:pub_server/repository.dart';
import 'package:pub_server/shelf_pubserver.dart';
import 'package:unittest/unittest.dart';

class RepositoryMock implements PackageRepository {
  final Function downloadFun;
  final Function downloadUrlFun;
  final Function finishAsyncUploadFun;
  final Function lookupVersionFun;
  final Function startAsyncUploadFun;
  final Function uploadFun;
  final Function versionsFun;
  final Function addUploaderFun;
  final Function removeUploaderFun;

  RepositoryMock(
      {this.downloadFun, this.downloadUrlFun, this.finishAsyncUploadFun,
       this.lookupVersionFun, this.startAsyncUploadFun, this.uploadFun,
       this.versionsFun, this.supportsAsyncUpload: false,
       this.supportsDownloadUrl: false, this.supportsUpload: false,
       this.addUploaderFun, this.removeUploaderFun,
       this.supportsUploaders: false});

  Future<Stream> download(String package, String version) async {
    if (downloadFun != null) return downloadFun(package, version);
    throw 'download';
  }

  Future<Uri> downloadUrl(String package, String version) async {
    if (downloadUrlFun != null) return downloadUrlFun(package, version);
    throw 'downloadUrl';
  }

  Future<PackageVersion> finishAsyncUpload(Uri uri) async {
    if (finishAsyncUploadFun != null) return finishAsyncUploadFun(uri);
    throw 'finishAsyncUpload';
  }

  Future<PackageVersion> lookupVersion(String package, String version) async {
    if (lookupVersionFun != null) return lookupVersionFun(package, version);
    throw 'lookupVersion';
  }

  Future<AsyncUploadInfo> startAsyncUpload(Uri redirectUrl) async {
    if (startAsyncUploadFun != null) {
      return startAsyncUploadFun(redirectUrl);
    }
    throw 'startAsyncUpload';
  }

  final bool supportsAsyncUpload;

  final bool supportsDownloadUrl;

  final bool supportsUpload;

  final bool supportsUploaders;

  Future<PackageVersion> upload(Stream<List<int>> data) {
    if (uploadFun != null) return uploadFun(data);
    throw 'upload';
  }

  Stream<PackageVersion> versions(String package) {
    if (versionsFun != null) return versionsFun(package);
    return new Stream.fromFuture(new Future.error('versions'));
  }

  Future addUploader(String package, String userEmail) {
    if (addUploaderFun != null) {
      return addUploaderFun(package, userEmail);
    }
    throw 'addUploader';
  }

  Future removeUploader(String package, String userEmail) {
    if (removeUploaderFun != null) {
      return removeUploaderFun(package, userEmail);
    }
    throw 'removeUploader';
  }
}

class PackageCacheMock implements PackageCache {
  final Function getFun;
  final Function setFun;
  final Function invalidateFun;

  PackageCacheMock({this.getFun, this.setFun, this.invalidateFun});

  Future<List<int>> getPackageData(String package) async {
    if (getFun != null) return getFun(package);
    throw 'no get function';
  }

  Future setPackageData(String package, List<int> data) async {
    if (setFun != null) return setFun(package, data);
    throw 'no set function';
  }

  Future invalidatePackageData(String package) async {
    if (invalidateFun != null) return invalidateFun(package);
    throw 'no invalidate function';
  }

}

Uri getUri(String path) => Uri.parse('http://www.example.com$path');

shelf.Request getRequest(String path) {
  var url = getUri(path);
  return new shelf.Request('GET', url);
}

shelf.Request multipartRequest(Uri uri, List<int> bytes) {
  var requestBytes = [];
  String boundary = 'testboundary';

  requestBytes.addAll(ASCII.encode('--$boundary\r\n'));
  requestBytes.addAll(
      ASCII.encode('Content-Type: application/octet-stream\r\n'));
  requestBytes.addAll(ASCII.encode('Content-Length: ${bytes.length}\r\n'));
  requestBytes.addAll(ASCII.encode('Content-Disposition: '
                                   'form-data; name="file"; '
                                   'filename="package.tar.gz"\r\n\r\n'));
  requestBytes.addAll(bytes);
  requestBytes.addAll(ASCII.encode('\r\n--$boundary--\r\n'));

  var headers = {
      'Content-Type' : 'multipart/form-data; boundary="$boundary"',
      'Content-Length' : '${requestBytes.length}',
  };

  var body = new Stream.fromIterable([requestBytes]);
  return new shelf.Request('POST', uri, headers: headers, body: body);
}

main() {
  group('shelf_pubserver', () {
    test('invalid endpoint', () async {
      var mock = new RepositoryMock();
      var server = new ShelfPubServer(mock);

      testInvalidUrl(String path) async {
        var request = getRequest(path);
        var response = await server.requestHandler(request);
        await response.read().drain();
        expect(response.statusCode, equals(404));
      }

      await testInvalidUrl('/foobar');
      await testInvalidUrl('/api');
      await testInvalidUrl('/api/');
      await testInvalidUrl('/api/packages/analyzer/0.1.0');
    });

    group('/api/packages/<package>', () {
      var expectedVersionJson = {
        'pubspec': {'foo': 1},
        'version': '0.1.0',
        'archive_url':
            '${getUri('/packages/analyzer/versions/0.1.0.tar.gz')}',
      };
      var expectedJson = {
        'name': 'analyzer',
        'latest': expectedVersionJson,
        'versions': [expectedVersionJson],
      };


      test('does not exist', () async {
        var mock =
            new RepositoryMock(versionsFun: (_) => new Stream.fromIterable([]));
        var server = new ShelfPubServer(mock);
        var request = getRequest('/api/packages/analyzer');

        var response = await server.requestHandler(request);
        await response.read().drain();
        expect(response.statusCode, equals(404));
      });

      test('success full retrieval of version', () async {
        var mock = new RepositoryMock(versionsFun: (String package) {
          // The pubspec is invalid, but that is irrelevant for this test.
          var pubspec = JSON.encode({'foo': 1});
          var analyzer = new PackageVersion('analyzer', '0.1.0', pubspec);
          return new Stream.fromIterable([analyzer]);
        });
        var server = new ShelfPubServer(mock);
        var request = getRequest('/api/packages/analyzer');
        var response = await server.requestHandler(request);
        var body = await response.readAsString();

        expect(response.mimeType, equals('application/json'));
        expect(response.statusCode, equals(200));
        expect(JSON.decode(body), equals(expectedJson));
      });

      test('success full retrieval of version - from cache', () async {
        var mock = new RepositoryMock();
        var cacheMock = new PackageCacheMock(getFun: expectAsync((String pkg) {
          expect(pkg, equals('analyzer'));
          return UTF8.encode('json response');
        }));
        var server = new ShelfPubServer(mock, cache: cacheMock);
        var request = getRequest('/api/packages/analyzer');
        var response = await server.requestHandler(request);
        var body = await response.readAsString();

        expect(response.mimeType, equals('application/json'));
        expect(response.statusCode, equals(200));
        expect(body, 'json response');
      });

      test('success full retrieval of version - populate cache', () async {
        var mock = new RepositoryMock(versionsFun: (String package) {
          // The pubspec is invalid, but that is irrelevant for this test.
          var pubspec = JSON.encode({'foo': 1});
          var analyzer = new PackageVersion('analyzer', '0.1.0', pubspec);
          return new Stream.fromIterable([analyzer]);
        });
        var cacheMock = new PackageCacheMock(
            getFun: expectAsync((String pkg) {
          expect(pkg, equals('analyzer'));
          return null;
        }), setFun: expectAsync((String package, List<int> data) {
          expect(package, equals('analyzer'));
          expect(JSON.decode(UTF8.decode(data)), equals(expectedJson));
        }));
        var server = new ShelfPubServer(mock, cache: cacheMock);
        var request = getRequest('/api/packages/analyzer');
        var response = await server.requestHandler(request);
        var body = await response.readAsString();

        expect(response.mimeType, equals('application/json'));
        expect(response.statusCode, equals(200));
        expect(JSON.decode(body), equals(expectedJson));
      });
    });

    group('/api/packages/<package>/versions/<version>', () {
      test('does not exist', () async {
        var mock = new RepositoryMock(lookupVersionFun: (_, __) => null);
        var server = new ShelfPubServer(mock);
        var request = getRequest('/api/packages/analyzer/versions/0.1.0');

        var response = await server.requestHandler(request);
        await response.read().drain();
        expect(response.statusCode, equals(404));
      });

      test('success full retrieval of version', () async {
        var mock = new RepositoryMock(
            lookupVersionFun: (String package, String version) {
          // The pubspec is invalid, but that is irrelevant for this test.
          var pubspec = JSON.encode({'foo': 1});
          return new PackageVersion(package, version, pubspec);
        });
        var server = new ShelfPubServer(mock);
        var request = getRequest('/api/packages/analyzer/versions/0.1.0');
        var response = await server.requestHandler(request);
        var body = await response.readAsString();

        var expectedJson = {
          'pubspec': {'foo': 1},
          'version': '0.1.0',
          'archive_url':
              '${getUri('/packages/analyzer/versions/0.1.0.tar.gz')}',
        };

        expect(response.mimeType, equals('application/json'));
        expect(response.statusCode, equals(200));
        expect(JSON.decode(body), equals(expectedJson));
      });
    });

    group('/packages/<package>/versions/<version>.tar.gz', () {
      group('download', () {
        test('successfull redirect', () async {
          var mock = new RepositoryMock(
              downloadFun: (String package, String version) {
            return new Stream.fromIterable([[1, 2, 3]]);
          });
          var server = new ShelfPubServer(mock);
          var request = getRequest('/packages/analyzer/versions/0.1.0.tar.gz');
          var response = await server.requestHandler(request);
          var body = await response.read().fold([], (b, d) => b..addAll(d));

          expect(response.statusCode, equals(200));
          expect(body, equals([1, 2, 3]));
        });
      });

      group('download url', () {
        test('successfull redirect', () async {
          var expectedUrl =
              Uri.parse('https://blobs.com/analyzer-0.1.0.tar.gz');
          var mock = new RepositoryMock(supportsDownloadUrl: true,
              downloadUrlFun: (String package, String version) {
            return expectedUrl;
          });
          var server = new ShelfPubServer(mock);
          var request = getRequest('/packages/analyzer/versions/0.1.0.tar.gz');
          var response = await server.requestHandler(request);

          expect(response.statusCode, equals(303));
          expect(response.headers['location'], equals('$expectedUrl'));

          var body = await response.readAsString();
          expect(body, isEmpty);
        });
      });
    });

    group('/api/packages/versions/new', () {
      for (bool useMemcache in [false, true]) {
        test('async successfull use-memcache($useMemcache)', () async {
          var expectedUrl = Uri.parse('https://storage.googleapis.com');
          var foobarUrl = Uri.parse('https://foobar.com/package/done');
          var newUrl = getUri('/api/packages/versions/new');
          var finishUrl = getUri('/api/packages/versions/newUploadFinish');
          var mock = new RepositoryMock(
              supportsUpload: true,
              supportsAsyncUpload: true,
              startAsyncUploadFun: (Uri redirectUri) {
            expect(redirectUri, equals(finishUrl));
            return new Future.value(
                new AsyncUploadInfo(expectedUrl, {'a' : '$foobarUrl'}));
          }, finishAsyncUploadFun: (Uri uri) {
            expect('$uri', equals('$finishUrl'));
            return new PackageVersion('foobar', '0.1.0', '');
          });
          var cacheMock;
          if (useMemcache) {
            cacheMock = new PackageCacheMock(
                invalidateFun: expectAsync((String package) {
              expect(package, equals('foobar'));
            }));
          }

          var server = new ShelfPubServer(mock, cache: cacheMock);

          // Start upload
          var request =  new shelf.Request('GET', newUrl);
          var response = await server.requestHandler(request);

          expect(response.statusCode, equals(200));
          expect(response.headers['content-type'], equals('application/json'));

          var jsonBody = JSON.decode(await response.readAsString());
          expect(jsonBody, equals({
            'url' : '$expectedUrl',
            'fields' : {
              'a' : '$foobarUrl',
            },
          }));

          // We would do now a multipart POST to `expectedUrl` which would
          // redirect us back to the pub.dartlang.org app via `finishUrl`.

          // Call the `finishUrl`.
          request = new shelf.Request('GET', finishUrl);
          response = await server.requestHandler(request);
          jsonBody = JSON.decode(await response.readAsString());
          expect(jsonBody, equals({
            'success' : {
              'message' : 'Successfully uploaded package.'
            },
          }));
        });
      }

      for (bool useMemcache in [false, true]) {
        test('sync successfull use-memcache($useMemcache)', () async {
          var tarballBytes = const [1, 2, 3];
          var newUrl = getUri('/api/packages/versions/new');
          var uploadUrl = getUri('/api/packages/versions/newUpload');
          var finishUrl = getUri('/api/packages/versions/newUploadFinish');
          var mock = new RepositoryMock(
              supportsUpload: true,
              uploadFun: (Stream<List<int>> stream) {
            return stream.fold([], (b, d) => b..addAll(d)).then((List<int> d) {
              expect(d, equals(tarballBytes));
              return new PackageVersion('foobar', '0.1.0', '');
            });
          });
          var cacheMock;
          if (useMemcache) {
            cacheMock = new PackageCacheMock(
                invalidateFun: expectAsync((String package) {
              expect(package, equals('foobar'));
            }));
          }
          var server = new ShelfPubServer(mock, cache: cacheMock);

          // Start upload
          var request =  new shelf.Request('GET', newUrl);
          var response = await server.requestHandler(request);
          expect(response.statusCode, equals(200));
          expect(response.headers['content-type'], equals('application/json'));
          var jsonBody = JSON.decode(await response.readAsString());
          expect(jsonBody, equals({
            'url' : '$uploadUrl',
            'fields' : {},
          }));

          // Post data via a multipart request.
          request =  multipartRequest(uploadUrl, tarballBytes);
          response = await server.requestHandler(request);
          await response.read();
          expect(response.statusCode, equals(302));
          expect(response.headers['location'], equals('$finishUrl'));

          // Call the `finishUrl`.
          request = new shelf.Request('GET', finishUrl);
          response = await server.requestHandler(request);
          jsonBody = JSON.decode(await response.readAsString());
          expect(jsonBody, equals({
            'success' : {
              'message' : 'Successfully uploaded package.'
            },
          }));
        });
      }

      test('sync failure', () async {
        var tarballBytes = const [1, 2, 3];
        var uploadUrl = getUri('/api/packages/versions/newUpload');
        var finishUrl =
            getUri('/api/packages/versions/newUploadFinish?error=abc');
        var mock = new RepositoryMock(
            supportsUpload: true,
            uploadFun: (Stream<List<int>> stream) {
          return new Future.error('abc');
        });
        var server = new ShelfPubServer(mock);

        // Start upload - would happen here.

        // Post data via a multipart request.
        var request =  multipartRequest(uploadUrl, tarballBytes);
        var response = await server.requestHandler(request);
        await response.read();
        expect(response.statusCode, equals(302));
        expect(response.headers['location'], equals('$finishUrl'));

        // Call the `finishUrl`.
        request = new shelf.Request('GET', finishUrl);
        response = await server.requestHandler(request);
        var jsonBody = JSON.decode(await response.readAsString());
        expect(jsonBody, equals({
          'error' : {
            'message' : 'abc'
          },
        }));
      });

      test('unsupported', () async {
        var newUrl = getUri('/api/packages/versions/new');
        var mock = new RepositoryMock();
        var server = new ShelfPubServer(mock);
        var request =  new shelf.Request('GET', newUrl);
        var response = await server.requestHandler(request);

        expect(response.statusCode, equals(404));
      });
    });

    group('uploaders', () {
      group('add uploader', () {
        var url = getUri('/api/packages/pkg/uploaders');
        var formEncodedBody = 'email=hans';

        test('no support', () async {
          var mock = new RepositoryMock();
          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('POST', url, body: formEncodedBody);
          var response = await server.requestHandler(request);

          expect(response.statusCode, equals(404));
        });

        test('success', () async {
          var mock = new RepositoryMock(
              supportsUploaders: true,
              addUploaderFun: expectAsync((package, user) {
            expect(package, equals('pkg'));
            expect(user, equals('hans'));
          }));

          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('POST', url, body: formEncodedBody);
          var response = await server.requestHandler(request);

          expect(response.statusCode, equals(200));
        });

        test('already exists', () async {
          var mock = new RepositoryMock(
              supportsUploaders: true,
              addUploaderFun: (package, user) {
            throw new UploaderAlreadyExistsException();
          });

          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('POST', url, body: formEncodedBody);
          shelf.Response response = await server.requestHandler(request);

          expect(response.statusCode, equals(400));
        });

        test('unauthorized', () async {
          var mock = new RepositoryMock(
              supportsUploaders: true,
              addUploaderFun: (package, user) {
            throw new UnauthorizedAccessException('');
          });

          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('POST', url, body: formEncodedBody);
          shelf.Response response = await server.requestHandler(request);

          expect(response.statusCode, equals(403));
        });
      });

      group('remove uploader', () {
        var url = getUri('/api/packages/pkg/uploaders/hans');

        test('no support', () async {
          var mock = new RepositoryMock();
          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('DELETE', url);
          var response = await server.requestHandler(request);

          expect(response.statusCode, equals(404));
        });

        test('success', () async {
          var mock = new RepositoryMock(
              supportsUploaders: true,
              removeUploaderFun: expectAsync((package, user) {
            expect(package, equals('pkg'));
            expect(user, equals('hans'));
          }));

          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('DELETE', url);
          var response = await server.requestHandler(request);

          expect(response.statusCode, equals(200));
        });

        test('cannot remove last uploader', () async {
          var mock = new RepositoryMock(
              supportsUploaders: true,
              removeUploaderFun: (package, user) {
            throw new LastUploaderRemoveException();
          });

          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('DELETE', url);
          shelf.Response response = await server.requestHandler(request);

          expect(response.statusCode, equals(400));
        });

        test('unauthorized', () async {
          var mock = new RepositoryMock(
              supportsUploaders: true,
              removeUploaderFun: (package, user) {
            throw new UnauthorizedAccessException('');
          });

          var server = new ShelfPubServer(mock);
          var request = new shelf.Request('DELETE', url);
          shelf.Response response = await server.requestHandler(request);

          expect(response.statusCode, equals(403));
        });
      });
    });
  });
}
