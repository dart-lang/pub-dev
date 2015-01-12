// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pubserver.shelf_pubserver_test;

import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;
import 'package:pubserver/repository.dart';
import 'package:pubserver/shelf_pubserver.dart';
import 'package:unittest/unittest.dart';

class RepositoryMock implements PackageRepository {
  final Function downloadFun;
  final Function downloadUrlFun;
  final Function finishAsyncUploadFun;
  final Function lookupVersionFun;
  final Function startAsyncUploadFun;
  final Function uploadFun;
  final Function versionsFun;

  RepositoryMock(
      {this.downloadFun, this.downloadUrlFun, this.finishAsyncUploadFun,
      this.lookupVersionFun, this.startAsyncUploadFun, this.uploadFun,
      this.versionsFun, this.supportsAsyncUpload: false,
      this.supportsDownloadUrl: false, this.supportsUpload: false});

  Future<Stream> download(String package, String version) async {
    if (downloadFun != null) return downloadFun(package, version);
    throw 'download';
  }

  Future<Uri> downloadUrl(String package, String version) async {
    if (downloadUrlFun != null) return downloadUrlFun(package, version);
    throw 'downloadUrl';
  }

  Future finishAsyncUpload(Uri uri) async {
    if (finishAsyncUploadFun != null) return finishAsyncUploadFun(uri);
    throw 'finishAsyncUpload';
  }

  Future<PackageVersion> lookupVersion(String package, String version) async {
    if (lookupVersionFun != null) return lookupVersionFun(package, version);
    throw 'lookupVersion';
  }

  Future<AsyncUploadInfo> startAsyncUpload(Uri baseRedirectUrl) async {
    if (startAsyncUploadFun != null) {
      return startAsyncUploadFun(baseRedirectUrl);
    }
    throw 'startAsyncUpload';
  }

  final bool supportsAsyncUpload;

  final bool supportsDownloadUrl;

  final bool supportsUpload;

  Future upload(Stream<List<int>> data) async {
    if (uploadFun != null) return uploadFun(data);
    throw 'upload';
  }

  Stream<PackageVersion> versions(String package) {
    if (versionsFun != null) return versionsFun(package);
    return new Stream.fromFuture(new Future.error('versions'));
  }
}

Uri getUri(String path) => Uri.parse('http://www.example.com$path');

shelf.Request getRequest(String path) {
  var url = getUri(path);
  return new shelf.Request('GET', url);
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
          var body = await response.readAsString();

          expect(response.statusCode, equals(303));
          expect(response.headers['location'], equals('$expectedUrl'));
        });
      });
    });
    // TODO: Test upload protocol
    /*
        '/api/packages/versions/new' (asycn: yes no)
        '/api/packages/versions/newUploadFinish' (async: yes no)
        '/api/packages/versions/newUpload'
    */
  });
}
