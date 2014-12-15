// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library rpc_service_remote_api;

import 'dart:async';
import 'dart:io';

import 'rpc_service.dart';
import 'rpc_service_base.dart';
import '../internal/remote_api.pb.dart' as remote_api;


class RPCServiceRemoteApi extends RPCServiceBase implements RPCService {
  static const Map<String, String> ADDITIONAL_HEADERS = const <String,String> {
      'X-Google-RPC-Service-Endpoint': 'app-engine-apis',
      'X-Google-RPC-Service-Method': '/VMRemoteAPI.CallRemoteAPI',
  };

  final String hostname;
  final int port;
  final String path;
  HttpClient _client;

  RPCServiceRemoteApi(this.hostname, this.port, {this.path: '/rpc_http'}) {
    _client = new HttpClient();
  }

  Future<List<int>> call(String apiPackage,
                         String method,
                         List<int> requestProtocolBuffer,
                         {String ticket: 'invalid-ticket'}) {
    var apiRequest = new remote_api.Request();
    apiRequest.serviceName = apiPackage;
    apiRequest.method = method;
    apiRequest.request = requestProtocolBuffer;
    apiRequest.requestId = ticket;
    return _call(apiRequest).then((remote_api.Response apiResponse) {
      if (apiResponse.hasApplicationError()) {
        throw new RpcApplicationError(
            apiResponse.applicationError.code,
            apiResponse.applicationError.detail);
      }
      // This can e.g. happen if the request ticket is invalid.
      if (apiResponse.hasRpcError()) {
        throw new Exception('An internal error occured while making a RPC call '
            '(${apiResponse.rpcError.toString().replaceAll('\n','  ')}).');
      }
      return apiResponse.response;
    });
  }

  Future<remote_api.Response> _call(remote_api.Request rpcRequest) {
    return makeRequest(hostname,
                       port,
                       path,
                       rpcRequest.writeToBuffer(),
                       ADDITIONAL_HEADERS).then((List<int> responseData) {
      return new remote_api.Response.fromBuffer(responseData);
    });
  }
}
