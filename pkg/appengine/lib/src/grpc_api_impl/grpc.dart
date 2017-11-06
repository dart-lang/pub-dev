// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library grpc;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http2/transport.dart' as http2;
import 'package:protobuf/protobuf.dart' as protobuf;

import 'auth_utils.dart';

Future<Client> connectToEndpoint(Uri uri,
    {AccessTokenProvider accessTokenProvider, int timeout}) async {
  final Dialer dialer = new Dialer(uri);
  return new Client(dialer, accessTokenProvider, timeout);
}

/// Represents a grpc channel which client stubs will use to make RPCs.
///
/// NOTE: Currently the protoc-generated client stubs will use only the method
/// name but don't take the service package into account.
///
/// Though When making API calls we need the full qualified
/// "<service-package>.<service-name>".
///
/// This [Channel] will therefore take care of using the full-qualified name.
class Channel extends protobuf.RpcClient {
  final String servicePackage;
  final Client client;

  Channel(this.servicePackage, this.client);

  Future<protobuf.GeneratedMessage> invoke(
      protobuf.ClientContext ctx,
      String serviceName,
      String methodName,
      protobuf.GeneratedMessage request,
      protobuf.GeneratedMessage response) async {
    return client.invoke(
        '$servicePackage.$serviceName', methodName, request, response);
  }
}

/// Represents a grpc client which will connect to grpc servers to make RPCs.
///
/// If the underlying http/2 connection has issues it will create a new one.
class Client {
  static final http2.Header _postHeader =
      new http2.Header.ascii(':method', 'POST');
  static final http2.Header _httpSchemeHeader =
      new http2.Header.ascii(':scheme', 'http');
  static final http2.Header _httpsSchemeHeader =
      new http2.Header.ascii(':scheme', 'https');
  static final http2.Header _contentTypeHeader =
      new http2.Header.ascii('content-type', 'application/grpc');
  static final http2.Header _trailersHeader =
      new http2.Header.ascii('te', 'trailers');
  static final http2.Header _compressionHeader =
      new http2.Header.ascii('grpc-accept-encoding', 'identity');
  static final http2.Header _userAgentHeader =
      new http2.Header.ascii('user-agent', 'dart-grpc/0.1.0');

  http2.Header _authorityHeader;
  http2.Header _timeoutHeader;
  http2.Header _schemeHeader;
  final AccessTokenProvider _accessTokenProvider;
  final Dialer _dialer;

  // If the current http/2 connection is faulty, broke, ran out of stream
  // ids ... we will use the [Dialer] to make a new connection.
  // While the connection is being made, all callers should wait on the
  // [_connectionCompleter].
  final Stopwatch _stopwatch = new Stopwatch()..start();
  http2.ClientTransportConnection _connection;

  // In case a [AccessTokenProvider] was given we cache the access token and
  // a [http2.Header] object while it is valid.
  auth.AccessToken _cachedAccessToken = null;
  http2.Header _cachedAuthorizationHeader = null;

  Client(Dialer dialer, AccessTokenProvider accessTokenProvider, int timeout)
      : _authorityHeader =
            new http2.Header.ascii(':authority', dialer.endpoint.host),
        _timeoutHeader =
            new http2.Header.ascii('grpc-timeout', '${timeout ?? 5}S'),
        _schemeHeader = dialer.isHttps ? _httpsSchemeHeader : _httpSchemeHeader,
        _accessTokenProvider = accessTokenProvider != null
            ? new LimitOutstandingRequests(accessTokenProvider)
            : null,
        _dialer = dialer;

  Future invoke(
      String service,
      String method,
      protobuf.GeneratedMessage request,
      protobuf.GeneratedMessage response) async {
    // If the current connection is not healthy we'll make a new one:
    // NOTE: Several concurrent callers will end up using the same dialer and
    // will therefore obtain the same connection.
    // NOTE: It seems like Google's gRPC endpoints will forcefully close the
    // connection after precisely 1 hour. So we *proactively* refresh our
    // connection after 50 minutes. This will avoid one failed RPC call.
    final bool isHealthy = _connection != null && _connection.isOpen;
    final bool shouldRefresh = _stopwatch.elapsed.inMinutes > 50;
    if (!isHealthy || shouldRefresh) {
      if (isHealthy) _connection.finish();
      _connection = await _dialer.dial();
      _stopwatch.reset();
    }

    if (!_connection.isOpen) {
      throw new NetworkException('The http/2 connection is no longer open.');
    }
    final headers = [
      _postHeader,
      _schemeHeader,
      new http2.Header.ascii(':path', '/$service/$method'),
      _authorityHeader,
      _timeoutHeader,
      _contentTypeHeader,
      _trailersHeader,
      _compressionHeader,
      _userAgentHeader,
    ];

    // If we need authorization and the current access token is expired
    // we'll get a new one.
    // NOTE: Several concurrent callers will end up using the same token
    // provider and will therefore obtain the same access token.
    if (_accessTokenProvider != null) {
      if (_cachedAccessToken == null || _cachedAccessToken.hasExpired) {
        try {
          _cachedAccessToken = await _accessTokenProvider.obtainAccessToken();
          _cachedAuthorizationHeader = new http2.Header.ascii(
              'authorization', 'Bearer ${_cachedAccessToken.data}');
        } catch (error) {
          throw new AuthenticationException(error);
        }
      }
      headers.add(_cachedAuthorizationHeader);
    }

    // We remember the connection this RPC call is using since other
    // concurrent calls might change `this._connection` while this method
    // is being asynchronously executed.
    final http2.ClientTransportConnection connection = _connection;
    final http2.TransportStream stream = connection.makeRequest(headers);
    final messageIterator = new StreamIterator<http2.StreamMessage>(stream.incomingMessages);

    final messageBody = request.writeToBuffer();

    final messageHeader = new Uint8List(1 + 4);
    final bytedata = new ByteData.view(messageHeader.buffer);
    // Byte [0]:   Is Compressed (0/1).
    // Byte [1-4]: Length in big endian.
    bytedata.setUint8(0, 0);
    bytedata.setUint32(1, messageBody.length, Endianness.BIG_ENDIAN);

    stream.sendData(messageHeader);
    stream.sendData(messageBody, endStream: true);

    try {
      // Part 1: Get first headers message.
      //    Headers: {
      //       ':status' : '200',
      //       'content-type' : 'application/grpc',
      //        ...
      //    }
      if (!await messageIterator.moveNext()) {
        stream.terminate();
        throw new ProtocolException('No initial headers from server.');
      }
      final Map responseHeaders = _getHeaders(messageIterator.current.headers);
      final status = responseHeaders[':status'];
      if (status != '200') {
        stream.terminate();
        throw new ProtocolException('Unexpected response status "$status".');
      }
      final contentType = responseHeaders['content-type'];
      if (contentType.toLowerCase() != 'application/grpc') {
        stream.terminate();
        throw new ProtocolException('Unknown response type "$contentType".');
      }

      // Part 2: Get the data.
      final resultBytes = new BytesBuilder(copy: false);
      while (await messageIterator.moveNext() &&
          messageIterator.current is http2.DataStreamMessage) {
        resultBytes.add(messageIterator.current.bytes);
      }
      if (messageIterator.current == null) {
        stream.terminate();
        throw new ProtocolException('No trailing headers from server.');
      }

      // Part 3: Get the trailing headers.
      //    Headers: {
      //      'grpc-status': ...,
      //      'grpc-message': ...,
      //      'google.rpc.debuginfo-bin': ...,
      //    }
      assert(messageIterator.current is http2.HeadersStreamMessage);
      final Map trailingHeaders = _getHeaders(messageIterator.current.headers);
      final int grpcStatus =
          int.parse(trailingHeaders['grpc-status'], onError: (_) => null);
      if (grpcStatus != 0) {
        stream.terminate();
        final message =
            trailingHeaders['grpc-message'] ?? 'Missing "grpc-message".';
        throw new RpcException(message, grpcStatus);
      }

      final List<int> responseData = resultBytes.takeBytes();
      if (responseData.length < 5) {
        stream.terminate();
        throw new ProtocolException(
            'Response data was an invalid grpc message.');
      }

      final bool compressed = responseData[0] == 1;

      final int lengthBytes = responseData[1] << 24 |
          responseData[2] << 16 |
          responseData[3] << 8 |
          responseData[4];
      final int expectedLength = responseData.length - 5;
      if (compressed) {
        stream.terminate();
        throw new ProtocolException(
            'Grpc response was compressed and this library does '
            'not handle compression yet.');
      }
      if (lengthBytes != expectedLength) {
        stream.terminate();
        throw new ProtocolException('Unexpected length in grpc response '
            '(was: $lengthBytes, expected: $expectedLength).');
      }

      final List<int> realData = responseData is Uint8List
          ? new Uint8List.view(responseData.buffer,
              responseData.offsetInBytes + 5, responseData.length - 5)
          : responseData.sublist(5);
      try {
        response.mergeFromBuffer(realData);
      } catch (_) {
        stream.terminate();
        throw new ProtocolException(
            'Failed to decode grpc response protobuf message.');
      }
    } on http2.StreamTransportException catch (error) {
      // If there was a stream error, we'll just kill the whole connection.
      // There is a high chance that something is not right.
      if (connection.isOpen) await connection.terminate();
      throw new NetworkException('Stream error during grpc call', error: error);
    } on http2.TransportConnectionException catch (error) {
      if (connection.isOpen) await connection.terminate();
      throw new NetworkException('Connection error during grpc call',
          error: error);
    }

    return response;
  }

  Future close() => _connection?.finish();

  Map<String, String> _getHeaders(List<http2.Header> headers) {
    final Map headerMap = {};
    for (var header in headers) {
      final name = ASCII.decode(header.name);
      if (!headerMap.containsKey(name)) {
        headerMap[name] = ASCII.decode(header.value);
      }
    }
    return headerMap;
  }
}

/// Used for dialing http/2 endpoints.
///
/// If several callers attempt to dial at the same point in time, only the first
/// one will trigger a http/2 connection attempt and all of them will receive
/// the same connection (or an error).
///
/// The number of http/2 dialing attempts will be rate-limited in order to not
/// flood the server and avoid busy loops where callers constantly attempt
/// to dial a nonexistent/down peer.
class Dialer {
  static const Duration MinimumTimeBetweenConnects = const Duration(seconds: 2);

  final Uri endpoint;

  Completer _completer;
  DateTime _lastDial;

  Dialer(this.endpoint);

  bool get isHttps => endpoint.scheme == 'https';

  /// Dials the remote [endpoint] and returns the http/2 connection or results
  /// in a [NetworkException].
  ///
  /// Concurrent dialing attempts will result in the same connection (or error).
  ///
  /// The number of dials a second is rate-limited.
  Future<http2.TransportConnection> dial() {
    if (_completer != null) return _completer.future;
    _completer = new Completer<http2.TransportConnection>();
    _performSingleDial();
    return _completer.future;
  }

  _performSingleDial() async {
    // We rate-limit the number of dials to `1/MinimumTimeBetweenConnects`.
    if (_lastDial != null) {
      final now = new DateTime.now();
      final duration = now.difference(_lastDial);
      if (duration < MinimumTimeBetweenConnects) {
        await new Future.delayed(MinimumTimeBetweenConnects - duration);
      }
    }
    _lastDial = new DateTime.now();

    if (isHttps) {
      try {
        final socket = await SecureSocket
            .connect(endpoint.host, endpoint.port, supportedProtocols: ['h2']);
        socket.setOption(SocketOption.TCP_NODELAY, true);
        if (socket.selectedProtocol == 'h2') {
          final connection =
              new http2.ClientTransportConnection.viaStreams(socket, socket);
          _completer.complete(connection);
          _completer = null;
        } else {
          socket.destroy();
          _completer.completeError(new NetworkException(
              'Endpoint $endpoint does not support http/2 via ALPN'));
          _completer = null;
        }
      } catch (error) {
        _completer.completeError(new NetworkException(
            'Could not connect to endpoint "$endpoint"',
            error: error));
        _completer = null;
      }
    } else {
      try {
        final socket = await Socket.connect(endpoint.host, endpoint.port);
        socket.setOption(SocketOption.TCP_NODELAY, true);
        final connection =
            new http2.ClientTransportConnection.viaStreams(socket, socket);
        _completer.complete(connection);
        _completer = null;
      } catch (error) {
        _completer.completeError(new NetworkException(
            'Could not connect to endpoint "$endpoint"',
            error: error));
        _completer = null;
      }
    }
  }
}

/// Base class for all grpc related errors.
abstract class BaseException {}

/// The grpc call resulted in a specific error service returned (see
/// [ErrorCode] for possible values).
class RpcException extends BaseException {
  final String message;

  /// See [ErrorCode] for possible values.
  final int code;

  RpcException(this.message, this.code);

  String toString() => 'GrpcError: "$message" (code: $code)';
}

class NetworkException extends BaseException {
  final String message;
  final Object error;

  NetworkException(this.message, {this.error});

  String toString() {
    var str = 'GrpcNetworkException: $message';
    if (error != null) {
      str = '$str ($error)';
    }
    return str;
  }
}

class ProtocolException extends BaseException {
  final String message;

  ProtocolException(this.message);

  String toString() => 'GrpcProtocolException: $message';
}

class AuthenticationException extends BaseException {
  final Object error;

  AuthenticationException(this.error);

  String toString() => 'GrpcAuthenticationException: $error';
}

/// The known error codes used in gRPC calls and will be represented in
/// [RpcException.code].
abstract class ErrorCode {
  // These error codes and the comments were taken from the Go implementation.
  // (see https://github.com/grpc/grpc-go/blob/master/codes/codes.go).

  // OK is returned on success.
  static const int OK = 0;

  // Canceled indicates the operation was cancelled (typically by the caller).
  static const int Canceled = 1;

  // Unknown error.  An example of where this error may be returned is
  // if a Status value received from another address space belongs to
  // an error-space that is not known in this address space.  Also
  // errors raised by APIs that do not return enough error information
  // may be converted to this error.
  static const int Unknown = 2;

  // InvalidArgument indicates client specified an invalid argument.
  // Note that this differs from FailedPrecondition. It indicates arguments
  // that are problematic regardless of the state of the system
  // (e.g., a malformed file name).
  static const int InvalidArgument = 3;

  // DeadlineExceeded means operation expired before completion.
  // For operations that change the state of the system, this error may be
  // returned even if the operation has completed successfully. For
  // example, a successful response from a server could have been delayed
  // long enough for the deadline to expire.
  static const int DeadlineExceeded = 4;

  // NotFound means some requested entity (e.g., file or directory) was
  // not found.
  static const int NotFound = 5;

  // AlreadyExists means an attempt to create an entity failed because one
  // already exists.
  static const int AlreadyExists = 6;

  // PermissionDenied indicates the caller does not have permission to
  // execute the specified operation. It must not be used for rejections
  // caused by exhausting some resource (use ResourceExhausted
  // instead for those errors).  It must not be
  // used if the caller cannot be identified (use Unauthenticated
  // instead for those errors).
  static const int PermissionDenied = 7;

  // Unauthenticated indicates the request does not have valid
  // authentication credentials for the operation.
  static const int Unauthenticated = 16;

  // a per-user quota, or perhaps the entire file system is out of space.
  static const int ResourceExhausted = 8;

  // FailedPrecondition indicates operation was rejected because the
  // system is not in a state required for the operation's execution.
  // For example, directory to be deleted may be non-empty, an rmdir
  // operation is applied to a non-directory, etc.
  //
  // A litmus test that may help a service implementor in deciding
  // between FailedPrecondition, Aborted, and Unavailable:
  //  (a) Use Unavailable if the client can retry just the failing call.
  //  (b) Use Aborted if the client should retry at a higher-level
  //      (e.g., restarting a read-modify-write sequence).
  //  (c) Use FailedPrecondition if the client should not retry until
  //      the system state has been explicitly fixed.  E.g., if an "rmdir"
  //      fails because the directory is non-empty, FailedPrecondition
  //      should be returned since the client should not retry unless
  //      they have first fixed up the directory by deleting files from it.
  //  (d) Use FailedPrecondition if the client performs conditional
  //      REST Get/Update/Delete on a resource and the resource on the
  //      server does not match the condition. E.g., conflicting
  //      read-modify-write on the same resource.
  static const int FailedPrecondition = 9;

  // Aborted indicates the operation was aborted, typically due to a
  // concurrency issue like sequencer check failures, transaction aborts,
  // etc.
  //
  // See litmus test above for deciding between FailedPrecondition,
  // Aborted, and Unavailable.
  static const int Aborted = 10;

  // OutOfRange means operation was attempted past the valid range.
  // E.g., seeking or reading past end of file.
  //
  // Unlike InvalidArgument, this error indicates a problem that may
  // be fixed if the system state changes. For example, a 32-bit file
  // system will generate InvalidArgument if asked to read at an
  // offset that is not in the range [0,2^32-1], but it will generate
  // OutOfRange if asked to read from an offset past the current
  // file size.
  //
  // There is a fair bit of overlap between FailedPrecondition and
  // OutOfRange.  We recommend using OutOfRange (the more specific
  // error) when it applies so that callers who are iterating through
  // a space can easily look for an OutOfRange error to detect when
  // they are done.
  static const int OutOfRange = 11;

  // Unimplemented indicates operation is not implemented or not
  // supported/enabled in this service.
  static const int Unimplemented = 12;

  // Internal errors.  Means some invariants expected by underlying
  // system has been broken.  If you see one of these errors,
  // something is very broken.
  static const int Internal = 13;

  // Unavailable indicates the service is currently unavailable.
  // This is a most likely a transient condition and may be corrected
  // by retrying with a backoff.
  //
  // See litmus test above for deciding between FailedPrecondition,
  // Aborted, and Unavailable.
  static const int Unavailable = 14;

  // DataLoss indicates unrecoverable data loss or corruption.
  static const int DataLoss = 15;
}
