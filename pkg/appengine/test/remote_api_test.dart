// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:unittest/unittest.dart';

import 'package:appengine/api/remote_api.dart';
import 'package:appengine/api/errors.dart';
import 'package:appengine/src/protobuf_api/rpc/rpc_service.dart';
import 'package:appengine/src/appengine_context.dart';
import 'package:appengine/src/api_impl/remote_api_impl.dart';
import 'package:appengine/src/protobuf_api/internal/remote_api.pb.dart' as pb;

import 'utils/error_matchers.dart';

class MockRPCService extends RPCService {
  final pb.Request _expectedPbRequest;
  final List<int> _responseBytes;
  final String _expectedTicket;

  MockRPCService(
      this._expectedPbRequest, this._responseBytes, this._expectedTicket);

  Future<List<int>> call(String apiPackage,
                         String method,
                         List<int> requestProtocolBuffer,
                         {String ticket: 'invalid-ticket'}) {
    expect(apiPackage, equals(_expectedPbRequest.serviceName));
    expect(method, equals(_expectedPbRequest.method));
    expect(requestProtocolBuffer, equals(_expectedPbRequest.request));
    expect(ticket, equals(_expectedTicket));
    return new Future.value(_responseBytes);
  }
}

class ErrorMockRPCService extends RPCService {
  static const RPC_ERROR_CODE = 42;
  static const RPC_ERROR_MESSAGE = "rpc error from mock";

  final bool throwNetworkError;
  final bool throwProtocolError;
  final bool throwRpcError;

  ErrorMockRPCService({this.throwNetworkError: false,
                       this.throwProtocolError: false,
                       this.throwRpcError: false});

  Future<List<int>> call(String apiPackage,
                         String method,
                         List<int> requestProtocolBuffer,
                         {String ticket: 'invalid-ticket'}) {
    return new Future.sync(() {
      if (throwNetworkError) {
        throw new NetworkError("network error from mock");
      } else if (throwProtocolError) {
        throw new ProtocolError("protocol error from mock");
      } else if (throwRpcError) {
        throw new RpcApplicationError(RPC_ERROR_CODE, RPC_ERROR_MESSAGE);
      }
      throw "Unknown error from mock";
    });
  }
}

Future<List<Future>> testRemoteApi(RemoteApi remoteApi, Function client) {
  return HttpServer.bind('127.0.0.1', 0).then((HttpServer server) {
    var serverFuture = server.first.then((HttpRequest request) {
      return remoteApi.handleRemoteApiRequest(request);
    }).whenComplete(() => server.close(force: true));
    var clientFuture = client(server.address.address, server.port);
    return [serverFuture, clientFuture];
  });
}

void runTests() {
  var INVALID_PROTOBUF = [1, 2, 3, 4, 5];
  var serverResponseBytes = [4, 5, 6];

  pb.Request pbRequest = new pb.Request();
  pbRequest.requestId = 'test-id';
  pbRequest.serviceName = 'test-service';
  pbRequest.method = 'test-method';
  pbRequest.request = [1, 2, 3];

  runClient(String address, int port,
            List<int> requestData, Function validate,
            {String path: '/foobar', method: 'POST'}) {
    var client = new HttpClient();
    return client.open(method, address, port, path).then((request) {
      request.add(requestData);
      return request.close().then((HttpClientResponse response) {
        return response
            .fold([], (buffer, data) => buffer..addAll(data))
            .then(validate);
      });
    }).whenComplete(client.close);
  }

  runClientAndCheckRtokResponse(String address, int port) {
    var rtok = 'RR';
    validate(List<int> bytes) {
      var json = JSON.decode(UTF8.decode(bytes));
      expect(json, isMap);
      expect(json['app_id'], equals('dev~application'));
      expect(json['rtok'], equals(rtok));
    }

    return runClient(
        address, port, [], validate, path: '/foobar?rtok=$rtok', method: 'GET');
  }

  runClientAndCheckApiCallResponse(String address, int port) {
    validate(List<int> bytes) {
      pb.Response response = new pb.Response.fromBuffer(bytes);
      expect(response.response, equals(serverResponseBytes));
    }
    return runClient(address, port, pbRequest.writeToBuffer(), validate);
  }

  runClientWithInvalidMethod(String address, int port) {
    return runClient(
        address, port, [], (_) {}, path: '/foobar?rtok=foo', method: 'HEAD');
  }

  runClientWithInvalidProtobuf(String address, int port) {
    return runClient(address, port, INVALID_PROTOBUF, (_) {},
        path: '/foobar?rtok=foo');
  }

  runClientAndCheckRpcError(String address, int port) {
    validate(List<int> bytes) {
      pb.Response pbResponse = new pb.Response.fromBuffer(bytes);
      expect(pbResponse.applicationError.code,
             equals(ErrorMockRPCService.RPC_ERROR_CODE));
      expect(pbResponse.applicationError.detail,
             equals(ErrorMockRPCService.RPC_ERROR_MESSAGE));
    }

    return runClient(address, port, pbRequest.writeToBuffer(), validate);
  }

  runClientWithoutValidation(String address, int port) {
    return runClient(address, port, pbRequest.writeToBuffer(), (){});
  }

  group('remote_api', () {
    var invalidTicket = 'invalid-ticket';
    var context = new AppengineContext(
        'dev', 'application', 'version', null, null, null);

    test('get_rtok', () {
      var remoteApi = new RemoteApiImpl(null, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientAndCheckRtokResponse)
          .then((futures) => Future.wait(futures));
    });

    test('make_request', () {
      var rpcMock =
          new MockRPCService(pbRequest, serverResponseBytes, invalidTicket);
      var remoteApi = new RemoteApiImpl(rpcMock, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientAndCheckApiCallResponse)
          .then((futures) => Future.wait(futures));
    });

    test('invalid_method', () {
      var remoteApi = new RemoteApiImpl(null, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientWithInvalidMethod)
          .then((futures) {
            expect(futures[0], throwsA(isAppEngineApplicationError));
            return futures[1].catchError((_) {});
          });
    });

    test('invalid_protobuf_request', () {
      var remoteApi = new RemoteApiImpl(null, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientWithInvalidProtobuf)
          .then((futures) {
            expect(futures[0], throws);
            return futures[1].catchError((_) {});
          });
    });

    test('rpc_error', () {
      var rpcMock = new ErrorMockRPCService(throwRpcError: true);
      var remoteApi = new RemoteApiImpl(rpcMock, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientAndCheckRpcError)
          .then((futures) => Future.wait(futures));
    });

    test('network_error', () {
      var rpcMock = new ErrorMockRPCService(throwNetworkError: true);
      var remoteApi = new RemoteApiImpl(rpcMock, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientWithoutValidation)
          .then((futures) {
        expect(futures[0], throwsA(isNetworkError));
        return futures[1].catchError((e) {});
      });
    });

    test('protocol_error', () {
      var rpcMock = new ErrorMockRPCService(throwProtocolError: true);
      var remoteApi = new RemoteApiImpl(rpcMock, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientWithoutValidation)
          .then((futures) {
        expect(futures[0], throwsA(isProtocolError));
        return futures[1].catchError((e) {});
      });
    });

    test('unknown_error', () {
      var rpcMock = new ErrorMockRPCService();
      var remoteApi = new RemoteApiImpl(rpcMock, context, invalidTicket);

      return testRemoteApi(remoteApi, runClientWithoutValidation)
          .then((futures) {
        expect(futures[0], throws);
        return futures[1].catchError((e) {});
      });
    });
  });
}

main() {
  runTests();
}
