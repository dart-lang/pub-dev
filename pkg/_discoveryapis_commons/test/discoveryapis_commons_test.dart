// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library discoveryapis_commons_test;

import 'dart:async';
import 'dart:convert' hide Base64Encoder;

import 'package:_discoveryapis_commons/src/clients.dart';
import 'package:_discoveryapis_commons/src/requests.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

const String USER_AGENT = 'google-api-dart-client test.client/0.1.0-dev';

class HttpServerMock extends http.BaseClient {
  Function _callback;
  bool _expectJson;

  void register(Function callback, bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request
          .finalize()
          .transform(UTF8.decoder)
          .join('')
          .then((String jsonString) {
        if (jsonString.isEmpty) {
          return _callback(request, null);
        } else {
          return _callback(request, JSON.decode(jsonString));
        }
      });
    } else {
      var stream = request.finalize();
      if (stream == null) {
        return _callback(request, []);
      } else {
        return stream.toBytes().then((data) {
          return _callback(request, data);
        });
      }
    }
  }
}

http.StreamedResponse stringResponse(
    int status, Map<String, String> headers, String body) {
  var stream = new Stream<List<int>>.fromIterable([UTF8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

http.StreamedResponse binaryResponse(
    int status, Map<String, String> headers, List<int> bytes) {
  var stream = new Stream<List<int>>.fromIterable([bytes]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

Stream<List<int>> byteStream(String s) {
  var bodyController = new StreamController<List<int>>();
  bodyController.add(UTF8.encode(s));
  bodyController.close();
  return bodyController.stream;
}

class _ApiRequestError extends TypeMatcher {
  const _ApiRequestError() : super("ApiRequestError");
  bool matches(item, Map matchState) => item is ApiRequestError;
}

class _DetailedApiRequestError extends TypeMatcher {
  const _DetailedApiRequestError() : super("DetailedApiRequestError");
  bool matches(item, Map matchState) => item is DetailedApiRequestError;
}

class TestError {}

class _TestError extends TypeMatcher {
  const _TestError() : super("TestError");
  bool matches(item, Map matchState) => item is TestError;
}

const isApiRequestError = const _ApiRequestError();
const isDetailedApiRequestError = const _DetailedApiRequestError();
const isTestError = const _TestError();

main() {
  group('discoveryapi_commons', () {
    test('escaper', () {
      expect(Escaper.ecapePathComponent('a/b%c '), equals('a%2Fb%25c%20'));
      expect(Escaper.ecapeVariable('a/b%c '), equals('a%2Fb%25c%20'));
      expect(Escaper.ecapeVariableReserved('a/b%c+ '), equals('a/b%25c+%20'));
      expect(Escaper.escapeQueryComponent('a/b%c '), equals('a%2Fb%25c%20'));
    });

    test('mapMap', () {
      newTestMap() => {
            's': 'string',
            'i': 42,
          };

      final mod =
          mapMap<dynamic, String>(newTestMap(), (dynamic x) => '$x foobar');
      expect(mod, hasLength(2));
      expect(mod['s'], equals('string foobar'));
      expect(mod['i'], equals('42 foobar'));
    });

    test('base64-encoder', () {
      var base64encoder = new Base64Encoder();

      testString(String msg, String expectedBase64) {
        var msgBytes = UTF8.encode(msg);

        Stream singleByteStream(List<int> msgBytes) {
          var controller = new StreamController();
          for (var byte in msgBytes) {
            controller.add([byte]);
          }
          controller.close();
          return controller.stream;
        }

        Stream allByteStream(List<int> msgBytes) {
          var controller = new StreamController();
          controller.add(msgBytes);
          controller.close();
          return controller.stream;
        }

        singleByteStream(msgBytes)
            .transform(base64encoder)
            .join('')
            .then(expectAsync1((String result) {
          expect(result, equals(expectedBase64));
        }));

        allByteStream(msgBytes)
            .transform(base64encoder)
            .join('')
            .then(expectAsync1((String result) {
          expect(result, equals(expectedBase64));
        }));

        expect(Base64Encoder.lengthOfBase64Stream(msg.length),
            equals(expectedBase64.length));
      }

      testString('pleasure.', 'cGxlYXN1cmUu');
      testString('leasure.', 'bGVhc3VyZS4=');
      testString('easure.', 'ZWFzdXJlLg==');
      testString('asure.', 'YXN1cmUu');
      testString('sure.', 'c3VyZS4=');
      testString('', '');
    });

    group('chunk-stack', () {
      var chunkSize = 9;

      folded(List<List<int>> byteArrays) {
        return byteArrays.fold([], (buf, e) => buf..addAll(e));
      }

      test('finalize', () {
        var chunkStack = new ChunkStack(9);
        chunkStack.finalize();
        expect(() => chunkStack.addBytes([1]), throwsA(isStateError));
        expect(() => chunkStack.finalize(), throwsA(isStateError));
      });

      test('empty', () {
        var chunkStack = new ChunkStack(9);
        expect(chunkStack.length, equals(0));
        chunkStack.finalize();
        expect(chunkStack.length, equals(0));
      });

      test('sub-chunk-size', () {
        var bytes = [1, 2, 3];

        var chunkStack = new ChunkStack(9);
        chunkStack.addBytes(bytes);
        expect(chunkStack.length, equals(0));
        chunkStack.finalize();
        expect(chunkStack.length, equals(1));
        expect(chunkStack.totalByteLength, equals(bytes.length));

        var chunks = chunkStack.removeSublist(0, chunkStack.length);
        expect(chunkStack.length, equals(0));
        expect(chunks, hasLength(1));

        expect(folded(chunks.first.byteArrays), equals(bytes));
        expect(chunks.first.offset, equals(0));
        expect(chunks.first.length, equals(3));
        expect(chunks.first.endOfChunk, equals(bytes.length));
      });

      test('exact-chunk-size', () {
        var bytes = [1, 2, 3, 4, 5, 6, 7, 8, 9];

        var chunkStack = new ChunkStack(9);
        chunkStack.addBytes(bytes);
        expect(chunkStack.length, equals(1));
        chunkStack.finalize();
        expect(chunkStack.length, equals(1));
        expect(chunkStack.totalByteLength, equals(bytes.length));

        var chunks = chunkStack.removeSublist(0, chunkStack.length);
        expect(chunkStack.length, equals(0));
        expect(chunks, hasLength(1));

        expect(folded(chunks.first.byteArrays), equals(bytes));
        expect(chunks.first.offset, equals(0));
        expect(chunks.first.length, equals(bytes.length));
        expect(chunks.first.endOfChunk, equals(bytes.length));
      });

      test('super-chunk-size', () {
        var bytes0 = [1, 2, 3, 4];
        var bytes1 = [1, 2, 3, 4];
        var bytes2 = [5, 6, 7, 8, 9, 10, 11];
        var bytes = folded([bytes0, bytes1, bytes2]);

        var chunkStack = new ChunkStack(9);
        chunkStack.addBytes(bytes0);
        chunkStack.addBytes(bytes1);
        chunkStack.addBytes(bytes2);
        expect(chunkStack.length, equals(1));
        chunkStack.finalize();
        expect(chunkStack.length, equals(2));
        expect(chunkStack.totalByteLength, equals(bytes.length));

        var chunks = chunkStack.removeSublist(0, chunkStack.length);
        expect(chunkStack.length, equals(0));
        expect(chunks, hasLength(2));

        expect(folded(chunks.first.byteArrays),
            equals(bytes.sublist(0, chunkSize)));
        expect(chunks.first.offset, equals(0));
        expect(chunks.first.length, equals(chunkSize));
        expect(chunks.first.endOfChunk, equals(chunkSize));

        expect(
            folded(chunks.last.byteArrays), equals(bytes.sublist(chunkSize)));
        expect(chunks.last.offset, equals(chunkSize));
        expect(chunks.last.length, equals(bytes.length - chunkSize));
        expect(chunks.last.endOfChunk, equals(bytes.length));
      });
    });

    test('media', () {
      // Tests for [MediaRange]
      var partialRange = new ByteRange(1, 100);
      expect(partialRange.start, equals(1));
      expect(partialRange.end, equals(100));

      var fullRange = new ByteRange(0, -1);
      expect(fullRange.start, equals(0));
      expect(fullRange.end, equals(-1));

      expect(() => new ByteRange(0, 0), throwsA(anything));
      expect(() => new ByteRange(-1, 0), throwsA(anything));
      expect(() => new ByteRange(-1, 1), throwsA(anything));

      // Tests for [DownloadOptions]
      expect(DownloadOptions.Metadata.isMetadataDownload, isTrue);

      expect(DownloadOptions.FullMedia.isFullDownload, isTrue);
      expect(DownloadOptions.FullMedia.isMetadataDownload, isFalse);

      // Tests for [Media]
      var stream = new StreamController<List<int>>().stream;
      expect(() => new Media(null, 0, contentType: 'foobar'),
          throwsA(isArgumentError));
      expect(() => new Media(stream, 0, contentType: null),
          throwsA(isArgumentError));
      expect(() => new Media(stream, -1, contentType: 'foobar'),
          throwsA(isArgumentError));

      var lengthUnknownMedia = new Media(stream, null);
      expect(lengthUnknownMedia.stream, equals(stream));
      expect(lengthUnknownMedia.length, equals(null));

      var media = new Media(stream, 10, contentType: 'foobar');
      expect(media.stream, equals(stream));
      expect(media.length, equals(10));
      expect(media.contentType, equals('foobar'));

      // Tests for [ResumableUploadOptions]
      expect(() => new ResumableUploadOptions(numberOfAttempts: 0),
          throwsA(isArgumentError));
      expect(() => new ResumableUploadOptions(chunkSize: 1),
          throwsA(isArgumentError));
    });

    group('api-requester', () {
      var httpMock, rootUrl, basePath;
      ApiRequester requester;

      var responseHeaders = {
        'content-type': 'application/json; charset=utf-8',
      };

      setUp(() {
        httpMock = new HttpServerMock();
        rootUrl = 'http://example.com/';
        basePath = 'base/';
        requester = new ApiRequester(httpMock, rootUrl, basePath, USER_AGENT);
      });

      // Tests for Request, Response

      group('metadata-request-response', () {
        test('empty-request-empty-response', () {
          httpMock.register(expectAsync2((http.BaseRequest request, json) {
            expect(request.method, equals('GET'));
            expect('${request.url}',
                equals('http://example.com/base/abc?alt=json'));
            return stringResponse(200, responseHeaders, '');
          }), true);
          requester.request('abc', 'GET').then(expectAsync1((response) {
            expect(response, isNull);
          }));
        });

        test('json-map-request-json-map-response', () {
          httpMock.register(expectAsync2((http.BaseRequest request, json) {
            expect(request.method, equals('GET'));
            expect('${request.url}',
                equals('http://example.com/base/abc?alt=json'));
            expect(json is Map, isTrue);
            expect(json, hasLength(1));
            expect(json['foo'], equals('bar'));
            return stringResponse(200, responseHeaders, '{"foo2" : "bar2"}');
          }), true);
          requester
              .request('abc', 'GET', body: JSON.encode({'foo': 'bar'}))
              .then(expectAsync1((response) {
            expect(response is Map, isTrue);
            expect(response, hasLength(1));
            expect(response['foo2'], equals('bar2'));
          }));
        });

        test('json-list-request-json-list-response', () {
          httpMock.register(expectAsync2((http.BaseRequest request, json) {
            expect(request.method, equals('GET'));
            expect('${request.url}',
                equals('http://example.com/base/abc?alt=json'));
            expect(json is List, isTrue);
            expect(json, hasLength(2));
            expect(json[0], equals('a'));
            expect(json[1], equals(1));
            return stringResponse(200, responseHeaders, '["b", 2]');
          }), true);
          requester
              .request('abc', 'GET', body: JSON.encode(['a', 1]))
              .then(expectAsync1((response) {
            expect(response is List, isTrue);
            expect(response[0], equals('b'));
            expect(response[1], equals(2));
          }));
        });
      });

      group('media-download', () {
        test('media-download', () {
          var data256 = new List.generate(256, (i) => i);
          httpMock.register(expectAsync2((http.BaseRequest request, data) {
            expect(request.method, equals('GET'));
            expect('${request.url}',
                equals('http://example.com/base/abc?alt=media'));
            expect(data, isEmpty);
            var headers = {
              'content-length': '${data256.length}',
              'content-type': 'foobar',
            };
            return binaryResponse(200, headers, data256);
          }), false);
          requester
              .request('abc', 'GET',
                  body: '', downloadOptions: DownloadOptions.FullMedia)
              .then(expectAsync1((Media media) {
            expect(media.contentType, equals('foobar'));
            expect(media.length, equals(data256.length));
            media.stream
                .fold([], (b, d) => b..addAll(d)).then(expectAsync1((d) {
              expect(d, equals(data256));
            }));
          }));
        });

        test('media-download-partial', () {
          var data256 = new List.generate(256, (i) => i);
          var data64 = data256.sublist(128, 128 + 64);

          httpMock.register(expectAsync2((http.BaseRequest request, data) {
            expect(request.method, equals('GET'));
            expect('${request.url}',
                equals('http://example.com/base/abc?alt=media'));
            expect(data, isEmpty);
            expect(request.headers['range'], equals('bytes=128-191'));
            var headers = {
              'content-length': '${data64.length}',
              'content-type': 'foobar',
              'content-range': 'bytes 128-191/256',
            };
            return binaryResponse(200, headers, data64);
          }), false);
          var range = new ByteRange(128, 128 + 64 - 1);
          var options = new PartialDownloadOptions(range);
          requester
              .request('abc', 'GET', body: '', downloadOptions: options)
              .then(expectAsync1((Media media) {
            expect(media.contentType, equals('foobar'));
            expect(media.length, equals(data64.length));
            media.stream
                .fold([], (b, d) => b..addAll(d)).then(expectAsync1((d) {
              expect(d, equals(data64));
            }));
          }));
        });

        test('json-upload-media-download', () {
          var data256 = new List.generate(256, (i) => i);
          httpMock.register(expectAsync2((http.BaseRequest request, json) {
            expect(request.method, equals('GET'));
            expect('${request.url}',
                equals('http://example.com/base/abc?alt=media'));
            expect(json is List, isTrue);
            expect(json, hasLength(2));
            expect(json[0], equals('a'));
            expect(json[1], equals(1));

            var headers = {
              'content-length': '${data256.length}',
              'content-type': 'foobar',
            };
            return binaryResponse(200, headers, data256);
          }), true);
          requester
              .request('abc', 'GET',
                  body: JSON.encode(['a', 1]),
                  downloadOptions: DownloadOptions.FullMedia)
              .then(expectAsync1((Media media) {
            expect(media.contentType, equals('foobar'));
            expect(media.length, equals(data256.length));
            media.stream
                .fold([], (b, d) => b..addAll(d)).then(expectAsync1((d) {
              expect(d, equals(data256));
            }));
          }));
        });
      });

      // Tests for media uploads

      group('media-upload', () {
        Stream<List<int>> streamFromByteArrays(byteArrays) {
          var controller = new StreamController<List<int>>();
          for (var array in byteArrays) {
            controller.add(array);
          }
          controller.close();
          return controller.stream;
        }

        Media mediaFromByteArrays(byteArrays, {bool withLen: true}) {
          int len = 0;
          byteArrays.forEach((array) {
            len += array.length;
          });
          if (!withLen) len = null;
          return new Media(streamFromByteArrays(byteArrays), len,
              contentType: 'foobar');
        }

        validateServerRequest(e, http.BaseRequest request, List<int> data) {
          return new Future.sync(() {
            var h = e['headers'];
            var r = e['response'];

            expect(request.url.toString(), equals(e['url']));
            expect(request.method, equals(e['method']));
            h.forEach((k, v) {
              expect(request.headers[k], equals(v));
            });

            expect(data, equals(e['data']));
            return r;
          });
        }

        serverRequestValidator(List expectations) {
          int i = 0;
          return (http.BaseRequest request, List<int> data) {
            return validateServerRequest(expectations[i++], request, data);
          };
        }

        test('simple', () {
          var bytes = new List.generate(10 * 256 * 1024 + 1, (i) => i % 256);
          var expectations = [
            {
              'url': 'http://example.com/xyz?uploadType=media&alt=json',
              'method': 'POST',
              'data': bytes,
              'headers': {
                'content-length': '${bytes.length}',
                'content-type': 'foobar',
              },
              'response': stringResponse(200, responseHeaders, '')
            },
          ];

          httpMock.register(
              expectAsync2(serverRequestValidator(expectations)), false);
          var media = mediaFromByteArrays([bytes]);
          requester
              .request('/xyz', 'POST', uploadMedia: media)
              .then(expectAsync1((response) {}));
        });

        test('multipart-upload', () {
          var bytes = new List.generate(10 * 256 * 1024 + 1, (i) => i % 256);
          var contentBytes = '--314159265358979323846\r\n'
              'Content-Type: $CONTENT_TYPE_JSON_UTF8\r\n\r\n'
              'BODY'
              '\r\n--314159265358979323846\r\n'
              'Content-Type: foobar\r\n'
              'Content-Transfer-Encoding: base64\r\n\r\n'
              '${BASE64.encode(bytes)}'
              '\r\n--314159265358979323846--';

          var expectations = [
            {
              'url': 'http://example.com/xyz?uploadType=multipart&alt=json',
              'method': 'POST',
              'data': UTF8.encode('$contentBytes'),
              'headers': {
                'content-length': '${contentBytes.length}',
                'content-type':
                    'multipart/related; boundary="314159265358979323846"',
              },
              'response': stringResponse(200, responseHeaders, '')
            },
          ];

          httpMock.register(
              expectAsync2(serverRequestValidator(expectations)), false);
          var media = mediaFromByteArrays([bytes]);
          requester
              .request('/xyz', 'POST', body: 'BODY', uploadMedia: media)
              .then(expectAsync1((response) {}));
        });

        group('resumable-upload', () {
          // TODO: respect [stream]
          buildExpectations(List<int> bytes, int chunkSize, bool stream,
              {int numberOfServerErrors: 0}) {
            int totalLength = bytes.length;
            int numberOfChunks = totalLength ~/ chunkSize;
            int numberOfBytesInLastChunk = totalLength % chunkSize;

            if (numberOfBytesInLastChunk > 0) {
              numberOfChunks++;
            } else {
              numberOfBytesInLastChunk = chunkSize;
            }

            var expectations = [];

            // First request is making a POST and gets the upload URL.
            expectations.add({
              'url': 'http://example.com/xyz?uploadType=resumable&alt=json',
              'method': 'POST',
              'data': [],
              'headers': {
                'content-length': '0',
                'content-type': 'application/json; charset=utf-8',
                'x-upload-content-type': 'foobar',
              }
                ..addAll(stream
                    ? {}
                    : {
                        'x-upload-content-length': '$totalLength',
                      }),
              'response':
                  stringResponse(200, {'location': 'http://upload.com/'}, '')
            });

            for (int i = 0; i < numberOfChunks; i++) {
              bool isLast = i == (numberOfChunks - 1);
              var lengthMarker = stream && !isLast ? '*' : '$totalLength';

              int bytesToExpect = chunkSize;
              if (isLast) {
                bytesToExpect = numberOfBytesInLastChunk;
              }

              var start = i * chunkSize;
              var end = start + bytesToExpect;
              var sublist = bytes.sublist(start, end);

              var firstContentRange = 'bytes $start-${end-1}/$lengthMarker';
              var firstRange = 'bytes=0-${end-1}';

              // We issue [numberOfServerErrors] 503 errors first, and then a
              // successfull response.
              for (var j = 0; j < (numberOfServerErrors + 1); j++) {
                bool successfullResponse = j == numberOfServerErrors;

                var response;
                if (successfullResponse) {
                  final headers = isLast
                      ? {'content-type': 'application/json; charset=utf-8'}
                      : {'range': firstRange};
                  response = stringResponse(isLast ? 200 : 308, headers, '');
                } else {
                  final headers = <String, String>{};
                  response = stringResponse(503, headers, '');
                }

                expectations.add({
                  'url': 'http://upload.com/',
                  'method': 'PUT',
                  'data': sublist,
                  'headers': {
                    'content-length': '${sublist.length}',
                    'content-range': firstContentRange,
                    'content-type': 'foobar',
                  },
                  'response': response,
                });
              }
            }
            return expectations;
          }

          List<List<int>> makeParts(List<int> bytes, List<int> splits) {
            var parts = <List<int>>[];
            int lastEnd = 0;
            for (int i = 0; i < splits.length; i++) {
              parts.add(bytes.sublist(lastEnd, splits[i]));
              lastEnd = splits[i];
            }
            return parts;
          }

          runTest(
              int chunkSizeInBlocks, int length, List<int> splits, bool stream,
              {int numberOfServerErrors: 0,
              resumableOptions,
              int expectedErrorStatus,
              int messagesNrOfFailure}) {
            int chunkSize = chunkSizeInBlocks * 256 * 1024;

            var bytes = new List<int>.generate(length, (i) => i % 256);
            var parts = makeParts(bytes, splits);

            // Simulation of our server
            var expectations = buildExpectations(bytes, chunkSize, false,
                numberOfServerErrors: numberOfServerErrors);
            // If the server simulates 50X errors and the client resumes only
            // a limited amount of time, we'll trunkate the number of requests
            // the server expects.
            // [The client will give up and if the server expects more, the test
            //  would timeout.]
            if (expectedErrorStatus != null) {
              expectations = expectations.sublist(0, messagesNrOfFailure);
            }
            httpMock.register(
                expectAsync2(serverRequestValidator(expectations),
                    count: expectations.length),
                false);

            // Our client
            var media = mediaFromByteArrays(parts);
            if (resumableOptions == null) {
              resumableOptions =
                  new ResumableUploadOptions(chunkSize: chunkSize);
            }
            var result = requester.request('/xyz', 'POST',
                uploadMedia: media, uploadOptions: resumableOptions);
            if (expectedErrorStatus != null) {
              result.catchError(expectAsync1((error) {
                expect(error is DetailedApiRequestError, isTrue);
                expect(error.status, equals(expectedErrorStatus));
              }));
            } else {
              result.then(expectAsync1((_) {}));
            }
          }

          Function backoffWrapper(int callCount) {
            return expectAsync1((int failedAttempts) {
              var exp = ResumableUploadOptions.ExponentialBackoff;
              Duration duration = exp(failedAttempts);
              expect(duration.inSeconds, equals(1 << (failedAttempts - 1)));
              return const Duration(milliseconds: 1);
            }, count: callCount);
          }

          test('length-small-block', () {
            runTest(1, 10, [10], false);
          });

          test('length-small-block-parts', () {
            runTest(1, 20, [1, 2, 3, 4, 5, 6, 7, 19, 20], false);
          });

          test('length-big-block', () {
            runTest(1, 1024 * 1024, [1024 * 1024], false);
          });

          test('length-big-block-parts', () {
            runTest(
                1,
                1024 * 1024,
                [
                  1,
                  256 * 1024 - 1,
                  256 * 1024,
                  256 * 1024 + 1,
                  1024 * 1024 - 1,
                  1024 * 1024
                ],
                false);
          });

          test('length-big-block-parts-non-divisible', () {
            runTest(
                1,
                1024 * 1024 + 1,
                [
                  1,
                  256 * 1024 - 1,
                  256 * 1024,
                  256 * 1024 + 1,
                  1024 * 1024 - 1,
                  1024 * 1024,
                  1024 * 1024 + 1
                ],
                false);
          });

          test('stream-small-block', () {
            runTest(1, 10, [10], true);
          });

          test('stream-small-block-parts', () {
            runTest(1, 20, [1, 2, 3, 4, 5, 6, 7, 19, 20], true);
          });

          test('stream-big-block', () {
            runTest(1, 1024 * 1024, [1024 * 1024], true);
          });

          test('stream-big-block-parts', () {
            runTest(
                1,
                1024 * 1024,
                [
                  1,
                  256 * 1024 - 1,
                  256 * 1024,
                  256 * 1024 + 1,
                  1024 * 1024 - 1,
                  1024 * 1024
                ],
                true);
          });

          test('stream-big-block-parts--with-server-error-recovery', () {
            var numFailedAttempts = 4 * 3;
            var options = new ResumableUploadOptions(
                chunkSize: 256 * 1024,
                numberOfAttempts: 4,
                backoffFunction: backoffWrapper(numFailedAttempts));
            runTest(
                1,
                1024 * 1024,
                [
                  1,
                  256 * 1024 - 1,
                  256 * 1024,
                  256 * 1024 + 1,
                  1024 * 1024 - 1,
                  1024 * 1024
                ],
                true,
                numberOfServerErrors: 3,
                resumableOptions: options);
          });

          test('stream-big-block-parts--server-error', () {
            var numFailedAttempts = 2;
            var options = new ResumableUploadOptions(
                chunkSize: 256 * 1024,
                numberOfAttempts: 3,
                backoffFunction: backoffWrapper(numFailedAttempts));
            runTest(
                1,
                1024 * 1024,
                [
                  1,
                  256 * 1024 - 1,
                  256 * 1024,
                  256 * 1024 + 1,
                  1024 * 1024 - 1,
                  1024 * 1024
                ],
                true,
                numberOfServerErrors: 3,
                resumableOptions: options,
                expectedErrorStatus: 503,
                messagesNrOfFailure: 4);
          });
        });
      });

      // Tests for error responses
      group('request-errors', () {
        makeTestError() {
          // All errors from the [http.Client] propagate through.
          // We use [TestError] to simulate it.
          httpMock.register(expectAsync2((http.BaseRequest request, string) {
            return new Future.error(new TestError());
          }), false);
        }

        makeDetailed400Error() {
          httpMock.register(expectAsync2((http.BaseRequest request, string) {
            return stringResponse(400, responseHeaders,
                '{"error" : {"code" : 42, "message": "foo"}}');
          }), false);
        }

        makeErrorsError() {
          var errorJson = '''
          { "error" :
            { "code" : 42,
              "message" : "foo",
              "errors" : [
                {"reason" : "InvalidEmailError"},
                {"domain" : "account", "message": "error"}
              ]
            }
          }
          ''';
          httpMock.register(expectAsync2((http.BaseRequest request, string) {
            return stringResponse(400, responseHeaders, errorJson);
          }), false);
        }

        makeNormal199Error() {
          httpMock.register(expectAsync2((http.BaseRequest request, string) {
            return stringResponse(199, {}, '');
          }), false);
        }

        makeInvalidContentTypeError() {
          httpMock.register(expectAsync2((http.BaseRequest request, string) {
            var responseHeaders = {'content-type': 'image/png'};
            return stringResponse(200, responseHeaders, '');
          }), false);
        }

        test('normal-http-client', () {
          makeTestError();
          expect(requester.request('abc', 'GET'), throwsA(isTestError));
        });

        test('normal-detailed-400', () {
          makeDetailed400Error();
          requester
              .request('abc', 'GET')
              .catchError(expectAsync2((error, stack) {
            expect(error, isDetailedApiRequestError);
            DetailedApiRequestError e = error;
            expect(e.status, equals(42));
            expect(e.message, equals('foo'));
          }));
        });

        test('error-with-multiple-errors', () {
          makeErrorsError();
          requester
              .request('abc', 'GET')
              .catchError(expectAsync2((error, stack) {
            expect(error, isDetailedApiRequestError);
            DetailedApiRequestError e = error;
            expect(e.status, equals(42));
            expect(e.message, equals('foo'));
            expect(e.errors.length, equals(2));
            expect(e.errors.first.reason, equals('InvalidEmailError'));
            expect(e.errors.last.domain, equals('account'));
            expect(e.errors.last.message, equals('error'));
          }));
        });

        test('normal-199', () {
          makeNormal199Error();
          expect(requester.request('abc', 'GET'), throwsA(isApiRequestError));
        });

        test('normal-invalid-content-type', () {
          makeInvalidContentTypeError();
          expect(requester.request('abc', 'GET'), throwsA(isApiRequestError));
        });

        var options = DownloadOptions.FullMedia;
        test('media-http-client', () {
          makeTestError();
          expect(requester.request('abc', 'GET', downloadOptions: options),
              throwsA(isTestError));
        });

        test('media-detailed-400', () {
          makeDetailed400Error();
          requester
              .request('abc', 'GET')
              .catchError(expectAsync2((error, stack) {
            expect(error, isDetailedApiRequestError);
            DetailedApiRequestError e = error;
            expect(e.status, equals(42));
            expect(e.message, equals('foo'));
          }));
        });

        test('media-199', () {
          makeNormal199Error();
          expect(requester.request('abc', 'GET', downloadOptions: options),
              throwsA(isApiRequestError));
        });
      });

      // Tests for path/query parameters

      test('request-parameters-query', () {
        var queryParams = {
          'a': ['a1', 'a2'],
          's': ['s1']
        };
        httpMock.register(expectAsync2((http.BaseRequest request, json) {
          expect(request.method, equals('GET'));
          expect('${request.url}',
              equals('http://example.com/base/abc?a=a1&a=a2&s=s1&alt=json'));
          return stringResponse(200, responseHeaders, '');
        }), true);
        requester
            .request('abc', 'GET', queryParams: queryParams)
            .then(expectAsync1((response) {
          expect(response, isNull);
        }));
      });

      test('request-parameters-path', () {
        httpMock.register(expectAsync2((http.BaseRequest request, json) {
          expect(request.method, equals('GET'));
          expect('${request.url}',
              equals('http://example.com/base/s/foo/a1/a2/bar/s1/e?alt=json'));
          return stringResponse(200, responseHeaders, '');
        }), true);
        requester
            .request('s/foo/a1/a2/bar/s1/e', 'GET')
            .then(expectAsync1((response) {
          expect(response, isNull);
        }));
      });
    });
    group('errors', () {
      test('error-detail-from-json', () {
        var detail = new ApiRequestErrorDetail.fromJson({});
        expect(detail.domain, isNull);
        expect(detail.reason, isNull);
        expect(detail.message, isNull);
        expect(detail.location, isNull);
        expect(detail.locationType, isNull);
        expect(detail.extendedHelp, isNull);
        expect(detail.sendReport, isNull);

        var json = {
          'domain': 'value-domain',
          'reason': 'value-reason',
          'message': 'value-message',
          'location': 'value-location',
          'locationType': 'value-locationType',
          'extendedHelp': 'value-extendedHelp',
          'sendReport': 'value-sendReport'
        };

        detail = new ApiRequestErrorDetail.fromJson(json);
        expect(detail.originalJson, json);
        expect(detail.domain, json['domain']);
        expect(detail.reason, json['reason']);
        expect(detail.message, json['message']);
        expect(detail.location, json['location']);
        expect(detail.locationType, json['locationType']);
        expect(detail.extendedHelp, json['extendedHelp']);
        expect(detail.sendReport, json['sendReport']);
      });
    });
  });
}
