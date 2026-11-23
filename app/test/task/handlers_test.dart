// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart' show UploadInfo;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:indexed_blob/indexed_blob.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/frontend/handlers.dart';
import 'package:pub_dev/service/async_queue/async_queue.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

final _sampleWebpBytes = utf8.encode('RIFF\x00\x00\x00\x00WEBPVP8 fake-webp');
final _sampleWebpBytesGz = gzip.encode(_sampleWebpBytes);
final _sampleJsonBytes = utf8.encode('{"name":"oxygen"}');
final _sampleJsonBytesGz = gzip.encode(_sampleJsonBytes);

final _profile = TestProfile(
  defaultUser: 'admin@pub.dev',
  generatedPackages: [
    GeneratedTestPackage(
      name: 'oxygen',
      versions: [
        GeneratedTestVersion(version: '1.0.0'),
        GeneratedTestVersion(version: '2.0.0'),
      ],
    ),
  ],
  users: [TestUser(email: 'admin@pub.dev', likes: [])],
);

Future<void> _uploadFakeTaskResults() async {
  await taskBackend.backfillAndProcessAllPackages((payload) async {
    for (final v in payload.versions) {
      final api = createPubApiClient(authToken: v.token);
      final uploadInfo = await api.taskUploadResult(payload.package, v.version);
      final client = http.Client();
      try {
        final output = await BlobIndexPair.build(uploadInfo.blobId, (
          addFile,
        ) async {
          await addFile(
            'resources/gen/logo.webp',
            Stream.value(_sampleWebpBytesGz),
          );
          await addFile('doc/index.json', Stream.value(_sampleJsonBytesGz));
          await addFile(
            'log.txt',
            Stream.value(gzip.encode(utf8.encode('ok'))),
          );
        });
        await _upload(
          client,
          uploadInfo.blob,
          () => Stream.value(output.blob),
          output.blob.length,
          filename: uploadInfo.blobId,
        );
        await _upload(
          client,
          uploadInfo.index,
          () => Stream.value(output.index.asBytes()),
          output.index.asBytes().length,
          filename: 'blob.index',
          contentType: 'application/json',
        );
      } finally {
        client.close();
      }
      await api.taskUploadFinished(payload.package, v.version);
    }
  });
}

Future<void> _upload(
  http.Client client,
  UploadInfo destination,
  Stream<List<int>> Function() content,
  int length, {
  required String filename,
  String contentType = 'application/octet-stream',
}) async {
  final req = http.MultipartRequest('POST', Uri.parse(destination.url))
    ..fields.addAll(destination.fields ?? {})
    ..followRedirects = false
    ..files.add(
      http.MultipartFile(
        'file',
        content(),
        length,
        filename: filename,
        contentType: MediaType.parse(contentType),
      ),
    );
  final res = await http.Response.fromStream(await client.send(req));
  expect(res.statusCode, inInclusiveRange(200, 299), reason: res.body);
}

void main() {
  group('handleTaskResource and non-HTML handleDartDoc', () {
    testWithProfile(
      'GET and HEAD headers for /gen-res/* and non-HTML dartdoc assets',
      testProfile: _profile,
      fn: () async {
        await _uploadFakeTaskResults();

        const resPath = '/packages/oxygen/versions/2.0.0/gen-res/gen/logo.webp';

        // GET without gzip
        final getPlain = await issueGet(resPath);
        expect(getPlain.statusCode, 200);
        expect(getPlain.headers['content-type'], 'image/webp');
        expect(getPlain.headers['cache-control'], 'public, max-age=1800');
        expect(getPlain.headers['expires'], isNotNull);
        expect(getPlain.headers['vary'], 'Accept-Encoding');
        expect(getPlain.headers['content-encoding'], isNull);
        expect(
          getPlain.headers['content-length'],
          '${_sampleWebpBytes.length}',
        );
        expect(getPlain.headers['content-security-policy'], isNull);
        expect(
          await getPlain.read().expand((b) => b).toList(),
          _sampleWebpBytes,
        );

        // GET with gzip
        final getGzip = await issueGet(
          resPath,
          headers: {'accept-encoding': 'gzip'},
        );
        expect(getGzip.statusCode, 200);
        expect(getGzip.headers['content-type'], 'image/webp');
        expect(getGzip.headers['cache-control'], 'public, max-age=1800');
        expect(getGzip.headers['vary'], 'Accept-Encoding');
        expect(getGzip.headers['content-encoding'], 'gzip');
        expect(
          getGzip.headers['content-length'],
          '${_sampleWebpBytesGz.length}',
        );
        expect(
          await getGzip.read().expand((b) => b).toList(),
          _sampleWebpBytesGz,
        );

        // HEAD without gzip
        final headPlain = await issueHttp('HEAD', resPath);
        expect(headPlain.statusCode, 200);
        expect(headPlain.headers['content-type'], 'image/webp');
        expect(headPlain.headers['cache-control'], 'public, max-age=1800');
        expect(headPlain.headers['expires'], isNotNull);
        expect(headPlain.headers['vary'], 'Accept-Encoding');
        expect(headPlain.headers['content-encoding'], isNull);
        expect(
          headPlain.headers['content-length'],
          '${_sampleWebpBytes.length}',
        );
        expect(headPlain.headers['content-security-policy'], isNull);
        expect(headPlain.headers['x-frame-options'], isNull);
        expect(await headPlain.read().expand((b) => b).toList(), isEmpty);

        // HEAD with gzip
        final headGzip = await issueHttp(
          'HEAD',
          resPath,
          headers: {'accept-encoding': 'gzip'},
        );
        expect(headGzip.statusCode, 200);
        expect(headGzip.headers['content-type'], 'image/webp');
        expect(headGzip.headers['cache-control'], 'public, max-age=1800');
        expect(headGzip.headers['vary'], 'Accept-Encoding');
        expect(headGzip.headers['content-encoding'], 'gzip');
        expect(
          headGzip.headers['content-length'],
          '${_sampleWebpBytesGz.length}',
        );
        expect(headGzip.headers['content-security-policy'], isNull);
        expect(await headGzip.read().expand((b) => b).toList(), isEmpty);

        // Non-HTML dartdoc HEAD preserves JSON Content-Type and Content-Length
        const docJsonPath = '/documentation/oxygen/2.0.0/index.json';
        final docHead = await issueHttp(
          'HEAD',
          docJsonPath,
          headers: {'accept-encoding': 'gzip'},
        );
        expect(docHead.statusCode, 200);
        expect(docHead.headers['content-type'], 'application/json');
        expect(docHead.headers['cache-control'], 'public, max-age=1800');
        expect(docHead.headers['vary'], 'Accept-Encoding');
        expect(docHead.headers['content-encoding'], 'gzip');
        expect(
          docHead.headers['content-length'],
          '${_sampleJsonBytesGz.length}',
        );
        expect(docHead.headers['content-security-policy'], isNull);
        expect(await docHead.read().expand((b) => b).toList(), isEmpty);

        // Disallowed MIME types return 404
        await expectNotFoundResponse(
          await issueGet('/packages/oxygen/versions/2.0.0/gen-res/gen/bad.svg'),
        );
        await expectNotFoundResponse(
          await issueGet(
            '/packages/oxygen/versions/2.0.0/gen-res/gen/bad.html',
          ),
        );

        // Real HTTP wire test via shelf_io to verify dart:io handles HEAD
        // with non-zero Content-Length and empty body cleanly.
        final handler = wrapHandler(
          Logger('test'),
          createAppHandler(),
          sanitize: true,
        );
        final server = await shelf_io.serve(
          (request) async =>
              await ss.fork(() async => await handler(request))
                  as shelf.Response,
          InternetAddress.loopbackIPv4,
          0,
        );
        final httpClient = HttpClient()..autoUncompress = false;
        try {
          final rq = await httpClient.headUrl(
            Uri.http('127.0.0.1:${server.port}', resPath),
          );
          rq.headers.set(HttpHeaders.acceptEncodingHeader, 'gzip');
          final rs = await rq.close();
          final body = await rs.expand((b) => b).toList();
          expect(rs.statusCode, 200);
          expect(rs.headers.value(HttpHeaders.contentTypeHeader), 'image/webp');
          expect(
            rs.headers.value(HttpHeaders.cacheControlHeader),
            'public, max-age=1800',
          );
          expect(rs.headers.value(HttpHeaders.contentEncodingHeader), 'gzip');
          expect(rs.contentLength, _sampleWebpBytesGz.length);
          expect(body, isEmpty);
        } finally {
          httpClient.close(force: true);
          await server.close(force: true);
        }
      },
    );

    testWithProfile(
      'moderated package returns 404 for /gen-res/* immediately',
      testProfile: _profile,
      expectedLogMessages: [
        RegExp(
          r'SHOUT Deleting object from public bucket: ".*/api/archives/oxygen-1.0.0.tar.gz".',
        ),
        RegExp(
          r'SHOUT Deleting object from public bucket: ".*/api/archives/oxygen-2.0.0.tar.gz".',
        ),
      ],
      fn: () async {
        await _uploadFakeTaskResults();

        const resPath = '/packages/oxygen/versions/2.0.0/gen-res/gen/logo.webp';
        // Warm packageVisible, taskPackageStatus, taskResultIndex, and gzippedTaskResult caches.
        expect((await issueGet(resPath)).statusCode, 200);

        final adminApi = createPubApiClient(authToken: siteAdminToken);
        await adminApi.adminInvokeAction(
          'moderate-package',
          AdminInvokeActionArguments(
            arguments: {'case': 'none', 'package': 'oxygen', 'state': 'true'},
          ),
        );
        await asyncQueue.ongoingProcessing;

        await expectNotFoundResponse(await issueGet(resPath));
        await expectNotFoundResponse(await issueHttp('HEAD', resPath));
        expect(
          await taskBackend.gzippedTaskResult(
            'oxygen',
            '2.0.0',
            'resources/gen/logo.webp',
          ),
          isNull,
        );
      },
    );

    testWithProfile(
      'moderated package version returns 404 for /gen-res/* immediately',
      testProfile: _profile,
      expectedLogMessages: [
        RegExp(
          r'SHOUT Deleting object from public bucket: ".*/api/archives/oxygen-1.0.0.tar.gz".',
        ),
      ],
      fn: () async {
        await _uploadFakeTaskResults();

        const v1Path = '/packages/oxygen/versions/1.0.0/gen-res/gen/logo.webp';
        const v2Path = '/packages/oxygen/versions/2.0.0/gen-res/gen/logo.webp';
        // Warm taskResultIndex caches for both versions.
        expect((await issueGet(v1Path)).statusCode, 200);
        expect((await issueGet(v2Path)).statusCode, 200);

        final adminApi = createPubApiClient(authToken: siteAdminToken);
        await adminApi.adminInvokeAction(
          'moderate-package-version',
          AdminInvokeActionArguments(
            arguments: {
              'case': 'none',
              'package': 'oxygen',
              'version': '1.0.0',
              'state': 'true',
            },
          ),
        );
        await asyncQueue.ongoingProcessing;

        await expectNotFoundResponse(await issueGet(v1Path));
        await expectNotFoundResponse(await issueHttp('HEAD', v1Path));
        expect((await issueGet(v2Path)).statusCode, 200);
      },
    );
  });
}
