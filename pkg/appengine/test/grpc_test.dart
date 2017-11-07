// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library grpc_test;

import 'dart:async';
import 'dart:convert' show ASCII;
import 'dart:typed_data' show ByteData;

import 'package:http2/transport.dart' as http2;
import 'package:protobuf/protobuf.dart' as protobuf;
import 'package:test/test.dart';

import 'package:appengine/src/grpc_api_impl/auth_utils.dart';
import 'package:appengine/src/grpc_api_impl/grpc.dart' as grpc;
import 'package:googleapis_auth/auth_io.dart' as auth;

// The `package:test` framework *does not* allow sequencing things like
//
//     expect(client.invoke(...), throws);
//     expect(client.invoke(...), does-not-throw);
//
// if `invoke` is asynchronous.
//
// It will execute both concurrently, since `expect` returns `void`!
//
// But we often want the two `invoke()`s to be in sequence, but still validate
// the result of both calls. So what we do is this:
//
//     1) var future = client.invoke('a', 'b', a, b);
//     2) try { await future; } catch (error) {}
//     3) expect(future, throwsA(isProtocolException));
//
// -> This way we make the call, wait until it's done and do the validation.
asyncExpect(Future future, matcher) async {
  // Wait for [future] irrespective of whether it completes with an error or
  // without.
  try {
    await future;
  } catch (error) {}

  // Validate the result, where [match]er can check for an error or a value.
  expect(future, matcher);
}

main() {
  final a = new MockGeneratedMessage();
  final b = new MockGeneratedMessage();

  group('grpc', () {
    group('channel', () {
      test('invoke', () async {

        final mockClient = new MockClient();
        final channel = new grpc.Channel('<fqn>', mockClient);
        final result = await channel.invoke(null, 'service', 'method', a, b);

        expect(mockClient.invokeService, '<fqn>.service');
        expect(mockClient.invokeMethod, 'method');
        expect(identical(mockClient.invokeRequest, a), true);
        expect(identical(mockClient.invokeResponse, b), true);
        expect(identical(result, b), true);
      });
    });

    group('client', () {
      final timeout = 42;

      test('dialing-error', () {
        final dialer = new MockDialer(true);
        final tokenProvider = new ValidMockAccessTokenProvider();
        final client = new grpc.Client(dialer, tokenProvider, timeout);

        expect(client.invoke('a', 'b', a, b), throwsA(isNetworkException));
      });

      test('token-provider-error', () {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(
              (new StreamController()..close()).stream);
        });
        final tokenProvider = new ThrowingMockAccessTokenProvider();
        final client = new grpc.Client(dialer, tokenProvider, timeout);

        expect(
            client.invoke('a', 'b', a, b), throwsA(isAuthenticationException));
      });

      test('wrong-status', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(buildGrpcResponseMessages(status: 400));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isProtocolException));
        expect(dialer.usedConnection.usedMockStream.wasTerminated, true);
      });

      test('wrong-content-type', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(
              buildGrpcResponseMessages(contentType: 'foobar'));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isProtocolException));
        expect(dialer.usedConnection.usedMockStream.wasTerminated, true);
      });

      test('wrong-length', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(
              buildGrpcResponseMessages(wrongLength: true));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isProtocolException));
        expect(dialer.usedConnection.usedMockStream.wasTerminated, true);
      });

      test('invalid-proto', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(
              buildGrpcResponseMessages(invalidProto: true));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isProtocolException));
        expect(dialer.usedConnection.usedMockStream.wasTerminated, true);
      });

      test('unsupported-compressed', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(
              buildGrpcResponseMessages(compressed: true));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isProtocolException));
        expect(dialer.usedConnection.usedMockStream.wasTerminated, true);
      });

      test('missing-trailing-headers', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(
              buildGrpcResponseMessages(failure: Failure.MissingTrailers));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isProtocolException));
        expect(dialer.usedConnection.usedMockStream.wasTerminated, true);
      });

      test('http2-stream-error', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(buildGrpcResponseMessages(
              failure: Failure.StreamException));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isNetworkException));

        final mockConnection = dialer.usedConnection;
        final mockStream = mockConnection.usedMockStream;

        expect(mockStream.wasTerminated, true);
        expect(mockConnection.wasTerminated, true);
      });

      test('http2-connection-error', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(buildGrpcResponseMessages(
              failure: Failure.ConnectionException));
        });
        final client = new grpc.Client(dialer, null, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isNetworkException));

        final mockConnection = dialer.usedConnection;
        final mockStream = mockConnection.usedMockStream;

        expect(mockStream.wasTerminated, true);
        expect(mockConnection.wasTerminated, true);
      });

      test('rpc-error', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(
              buildGrpcResponseMessages(grpcStatus: grpc.ErrorCode.Aborted));
        });
        final client = new grpc.Client(dialer, null, timeout);

        expect(client.invoke('a', 'b', a, b),
            throwsA(isRpcException(grpc.ErrorCode.Aborted)));
      });

      test('successful-grpc-call', () async {
        final dialer = new MockDialer(false, () {
          return new OpenMockConnection(buildGrpcResponseMessages());
        });
        final tokenProvider = new ValidMockAccessTokenProvider();
        final client = new grpc.Client(dialer, tokenProvider, timeout);

        final result = await client.invoke('a', 'b', a, b);
        expect(identical(result, b), true);

        final mockConnection = dialer.usedConnection;
        final receivedHeaders = mockConnection.usedHeaders;

        expect(receivedHeaders[':method'], 'POST');
        expect(receivedHeaders[':scheme'], 'https');
        expect(receivedHeaders[':authority'], 'googleapis.com');
        expect(receivedHeaders['content-type'], 'application/grpc');
        expect(receivedHeaders['te'], 'trailers');
        expect(receivedHeaders['grpc-accept-encoding'], 'identity');
        expect(receivedHeaders['user-agent'], 'dart-grpc/0.1.0');
        expect(receivedHeaders['grpc-timeout'], '42S');
        expect(receivedHeaders['authorization'], 'Bearer xxx');
      });

      test('successful-grpc-call--with-reconnect', () async {
        int attempt = 0;
        final dialer = new MockDialer(false, () {
          if (attempt++ < 1) {
            return new ClosedMockConnection();
          }
          return new OpenMockConnection(buildGrpcResponseMessages());
        });
        final tokenProvider = new ValidMockAccessTokenProvider();
        final client = new grpc.Client(dialer, tokenProvider, timeout);

        await asyncExpect(
            client.invoke('a', 'b', a, b), throwsA(isNetworkException));
        expect(identical(await client.invoke('a', 'b', a, b), b), true);

        final mockConnection = dialer.usedConnection;
        final receivedHeaders = mockConnection.usedHeaders;

        expect(receivedHeaders[':method'], 'POST');
        expect(receivedHeaders[':scheme'], 'https');
        expect(receivedHeaders[':authority'], 'googleapis.com');
        expect(receivedHeaders['content-type'], 'application/grpc');
        expect(receivedHeaders['te'], 'trailers');
        expect(receivedHeaders['grpc-accept-encoding'], 'identity');
        expect(receivedHeaders['user-agent'], 'dart-grpc/0.1.0');
        expect(receivedHeaders['grpc-timeout'], '42S');
        expect(receivedHeaders['authorization'], 'Bearer xxx');
      });
    });
  });
}

enum Failure {
  MissingTrailers,
  StreamException,
  ConnectionException,
  None,
}

buildGrpcResponseMessages(
    {int status: 200,
    int grpcStatus: 0,
    String contentType: 'application/grpc',
    bool wrongLength: false,
    bool invalidProto: false,
    bool compressed: false,
    Failure failure: Failure.None}) {
  final controller = new StreamController<http2.StreamMessage>();
  final responseMessages = <http2.StreamMessage>[
    new http2.HeadersStreamMessage([
      new http2.Header.ascii(':status', '$status'),
      new http2.Header.ascii('content-type', contentType),
    ]),
    new http2.DataStreamMessage(
        buildValidGrpcResponseData(compressed, wrongLength, invalidProto)),
  ];
  switch (failure) {
    case Failure.MissingTrailers:
      break;
    case Failure.StreamException:
      controller.addError(new http2.StreamTransportException('42'));
      break;
    case Failure.ConnectionException:
      controller.addError(new http2.TransportConnectionException(42, '42'));
      break;
    case Failure.None:
      responseMessages.add(new http2.HeadersStreamMessage(
          [new http2.Header.ascii('grpc-status', '$grpcStatus')]));
      break;
  }

  responseMessages.forEach(controller.add);
  controller.close();

  return controller.stream;
}

buildValidGrpcResponseData(
    bool compressed, bool wrongLength, bool invalidProto) {
  final message = invalidProto
      ? [99, 88, 77, 66]
      : new MockGeneratedMessage().writeToBuffer();
  final int length = wrongLength ? 1 : message.length;
  final grpcData = new ByteData(5 + message.length)
      ..setUint8(0, compressed ? 1 : 0)
      ..setUint32(1, length)
      ..buffer.asUint8List().setAll(5, message);
  return grpcData.buffer.asUint8List();
}

class MockClient implements grpc.Client {
  var invokeService, invokeMethod, invokeRequest, invokeResponse;

  Future invoke(
      String service,
      String method,
      protobuf.GeneratedMessage request,
      protobuf.GeneratedMessage response) async {
    invokeService = service;
    invokeMethod = method;
    invokeRequest = request;
    invokeResponse = response;
    return response;
  }

  Future close() async { throw 'unsupported call'; }
}

class MockGeneratedMessage extends protobuf.GeneratedMessage {
  static final protobuf.BuilderInfo _i = new protobuf.BuilderInfo('VoidProto')
    ..hasRequiredFields = false;

  MockGeneratedMessage() : super();
  MockGeneratedMessage clone() =>
      new MockGeneratedMessage()..mergeFromMessage(this);
  protobuf.BuilderInfo get info_ => _i;
}

class MockDialer implements grpc.Dialer {
  final Uri endpoint = Uri.parse('https://googleapis.com');
  bool get isHttps => endpoint.scheme == 'https';

  final bool throwOnDial;
  final Function connectionCreator;

  MockConnection usedConnection;

  MockDialer([this.throwOnDial = false, this.connectionCreator]);

  Future<http2.TransportConnection> dial() async {
    if (throwOnDial) {
      throw new grpc.NetworkException('dialing error');
    }
    return usedConnection = connectionCreator();
  }
}

abstract class MockConnection
    implements http2.ClientTransportConnection {

  MockStream makeRequest(List<http2.Header> headers,
                         {bool endStream: false}) {
    throw 'unsupported call';
  }

  Future terminate() async {
    throw 'unsupported call';
  }

  Future ping() async {
    throw 'unsupported call';
  }

  Future finish() async {
    throw 'unsupported call';
  }
}

class OpenMockConnection extends MockConnection {
  final Stream<http2.StreamMessage> responseMessages;

  Map<String, String> usedHeaders;
  MockStream usedMockStream;
  bool wasTerminated = false;

  bool get isOpen => true;

  OpenMockConnection(this.responseMessages);

  MockStream makeRequest(List<http2.Header> headers,
                         {bool endStream: false}) {
    if (usedHeaders != null) throw 'Already have headers';

    usedHeaders = {};
    for (final http2.Header h in headers) {
      usedHeaders[ASCII.decode(h.name)] = ASCII.decode(h.value);
    }

    return usedMockStream = new MockStream(responseMessages);
  }

  Future terminate() async {
    wasTerminated = true;
    if (usedMockStream != null) usedMockStream.wasTerminated = true;
  }
}

class ClosedMockConnection extends MockConnection {
  bool get isOpen => false;
}

class MockStream extends http2.ClientTransportStream {
  final StreamController<http2.StreamMessage> _outgoingMessages =
      new StreamController<http2.StreamMessage>();
  final StreamController<http2.StreamMessage> _incomingMessages =
      new StreamController<http2.StreamMessage>();
  final Stream<http2.StreamMessage> responseMessages;

  List<int> usedData = [];
  bool wasClosed = false;
  bool wasTerminated = false;

  MockStream(this.responseMessages) {
    _outgoingMessages.stream.listen((http2.StreamMessage message) {
      if (message is http2.DataStreamMessage) {
        usedData.addAll(message.bytes);
      } else {
        throw 'received unexpected http2 message';
      }
    }, onDone: () {
      wasClosed = true;

      responseMessages.pipe(_incomingMessages);
    });
  }

  Stream<http2.TransportStreamPush> get peerPushes => throw 'unsupported call';

  int get id => throw 'unsupported call';

  Stream<http2.StreamMessage> get incomingMessages => _incomingMessages.stream;
  StreamSink<http2.StreamMessage> get outgoingMessages => _outgoingMessages;

  void terminate() {
    wasTerminated = true;
  }
}

class ThrowingMockAccessTokenProvider implements AccessTokenProvider {
  ThrowingMockAccessTokenProvider();

  Future<auth.AccessToken> obtainAccessToken() async {
    throw 'token provider error';
  }

  Future close() async {}
}

class ValidMockAccessTokenProvider implements AccessTokenProvider {
  Future<auth.AccessToken> obtainAccessToken() async {
    return new auth.AccessToken('Bearer', 'xxx',
        new DateTime.now().toUtc().add(const Duration(hours: 1)));
  }

  Future close() async {}
}

class ExpiredMockAccessTokenProvider implements AccessTokenProvider {
  Future<auth.AccessToken> obtainAccessToken() async {
    return new auth.AccessToken('Bearer', 'xxx',
        new DateTime.now().toUtc().subtract(const Duration(hours: 1)));
  }

  Future close() async {}
}

class _AuthenticationException extends TypeMatcher {
  const _AuthenticationException() : super("AuthenticationException");
  bool matches(item, Map matchState) => item is grpc.AuthenticationException;
}

class _NetworkException extends TypeMatcher {
  const _NetworkException() : super("NetworkException");
  bool matches(item, Map matchState) => item is grpc.NetworkException;
}

class _ProtocolException extends TypeMatcher {
  const _ProtocolException() : super("ProtocolException");
  bool matches(item, Map matchState) => item is grpc.ProtocolException;
}

class _RpcException extends TypeMatcher {
  final int expectedCode;
  const _RpcException(this.expectedCode) : super("RpcException");
  bool matches(item, Map matchState) {
    return item is grpc.RpcException && item.code == expectedCode;
  }
}

const isNetworkException = const _NetworkException();
const isAuthenticationException = const _AuthenticationException();
const isProtocolException = const _ProtocolException();
isRpcException(int code) => new _RpcException(code);
