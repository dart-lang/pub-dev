// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:mime/mime.dart' as mime;
import 'package:unittest/unittest.dart';

const CONTENT_TYPE_JSON_UTF8 = 'application/json; charset=utf-8';

const RESPONSE_HEADERS = const {
  'content-type': CONTENT_TYPE_JSON_UTF8
};

class MockClient extends http.BaseClient {
  final String rootPath;
  final Uri rootUri;

  Map<String, Map<Pattern, Function>> mocks = {};
  http_testing.MockClient client;

  MockClient(String rootPath) :
    rootPath = rootPath,
    rootUri = Uri.parse('https://www.googleapis.com${rootPath}') {
    client = new http_testing.MockClient(handler);
  }

  void register(String method, Pattern path,
      http_testing.MockClientHandler handler) {
    var map = mocks.putIfAbsent(method, () => new Map());
    if (path is RegExp) {
      map[new RegExp('$rootPath${path.pattern}')] = handler;
    } else {
      map['$rootPath$path'] = handler;
    }
  }

  void registerUpload(String method, Pattern path,
      http_testing.MockClientHandler handler) {
    var map = mocks.putIfAbsent(method, () => new Map());
    map['/upload$rootPath$path'] = handler;
  }

  void registerResumableUpload(String method, Pattern path,
      http_testing.MockClientHandler handler) {
    var map = mocks.putIfAbsent(method, () => new Map());
    map['/resumable/upload$rootPath$path'] = handler;
  }

  void clear() {
    mocks = {};
  }

  Future<http.Response> handler(http.Request request) {
    expect(request.url.host, 'www.googleapis.com');
    var path = request.url.path;
    if (mocks[request.method] == null) {
      throw 'No mock handler for method ${request.method} found. '
          'Request URL was: ${request.url}';
    }
    var mockHandler;
    mocks[request.method].forEach((pattern, handler) {
      if (pattern.matchAsPrefix(path) != null) {
        mockHandler = handler;
      }
    });
    if (mockHandler == null) {
      throw 'No mock handler for method ${request.method} and path '
          '[$path] found. Request URL was: ${request.url}';
    }
    return mockHandler(request);
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return client.send(request);
  }

  Future<http.Response> respond(response) {
    return new Future.value(
        new http.Response(
            JSON.encode(response.toJson()),
            200,
            headers: RESPONSE_HEADERS));
  }

  Future<http.Response> respondEmpty() {
    return new Future.value(
        new http.Response('', 200, headers: RESPONSE_HEADERS));
  }

  Future<http.Response> respondInitiateResumableUpload(project) {
    Map headers = new Map.from(RESPONSE_HEADERS);
    headers['location'] =
        'https://www.googleapis.com/resumable/upload$rootPath'
        'b/$project/o?uploadType=resumable&alt=json&'
        'upload_id=AEnB2UqucpaWy7d5cr5iVQzmbQcQlLDIKiClrm0SAX3rJ7UN'
        'Mu5bEoC9b4teJcJUKpqceCUeqKzuoP_jz2ps_dV0P0nT8OTuZQ';
    return new Future.value(
        new http.Response('', 200, headers: headers));
  }

  Future<http.Response> respondContinueResumableUpload() {
    return new Future.value(
        new http.Response('', 308, headers: RESPONSE_HEADERS));
  }

  Future<http.Response> respondBytes(List<int> bytes) {
    return new Future.value(
        new http.Response.bytes(bytes, 200, headers: RESPONSE_HEADERS));
  }

  Future<http.Response> respondError(statusCode) {
    var error = {
      'error': {
        'code': statusCode,
        'message': 'error'
      }
    };
    return new Future.value(
        new http.Response(
            JSON.encode(error), statusCode, headers: RESPONSE_HEADERS));
  }

  Future processNormalMediaUpload(http.Request request) {
    var completer = new Completer();

    var contentType = new http_parser.MediaType.parse(
        request.headers['content-type']);
    expect(contentType.mimeType, 'multipart/related');
    var boundary = contentType.parameters['boundary'];

    var partCount = 0;
    var json;
    new Stream.fromIterable([request.bodyBytes, [13, 10]])
        .transform(new mime.MimeMultipartTransformer(boundary))
        .listen(
            ((mime.MimeMultipart mimeMultipart) {
              var contentType = mimeMultipart.headers['content-type'];
              partCount++;
              if (partCount == 1) {
                // First part in the object JSON.
                expect(contentType, 'application/json; charset=utf-8');
                mimeMultipart
                    .transform(UTF8.decoder)
                    .fold('', (p, e) => '$p$e')
                    .then((j) => json = j);
              } else if (partCount == 2) {
                // Second part is the base64 encoded bytes.
                mimeMultipart
                    .transform(ASCII.decoder)
                    .fold('', (p, e) => '$p$e')
                    .then(crypto.CryptoUtils.base64StringToBytes)
                    .then((bytes) {
                      completer.complete(
                          new NormalMediaUpload(json, bytes, contentType));
                    });
              } else {
                // Exactly two parts expected.
                throw 'Unexpected part count';
              }
            }));

    return completer.future;
  }
}

class NormalMediaUpload {
  final String json;
  final List<int> bytes;
  final String contentType;
  NormalMediaUpload(this.json, this.bytes, this.contentType);
}

// Implementation of http.Client which traces all requests and responses.
// Mainly useful for local testing.
class TraceClient extends http.BaseClient {
  final http.Client client;

  TraceClient(this.client);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    print(request);
    return request.finalize().toBytes().then((body) {
      print('--- START REQUEST ---');
      print(UTF8.decode(body));
      print('--- END REQUEST ---');
      var r = new RequestImpl(request.method, request.url, body);
      r.headers.addAll(request.headers);
      return client.send(r).then((http.StreamedResponse rr) {
        return rr.stream.toBytes().then((body) {
          print('--- START RESPONSE ---');
          print(UTF8.decode(body));
          print('--- END RESPONSE ---');
          return new http.StreamedResponse(
              new http.ByteStream.fromBytes(body),
              rr.statusCode,
              headers: rr.headers);

        });
      });
    });
  }

  void close() {
    client.close();
  }
}

// http.BaseRequest implementationn used by the TraceClient.
class RequestImpl extends http.BaseRequest {
  final List<int> _body;

  RequestImpl(String method, Uri url, this._body)
      : super(method, url);

  http.ByteStream finalize() {
    super.finalize();
    return new http.ByteStream.fromBytes(_body);
  }
}
