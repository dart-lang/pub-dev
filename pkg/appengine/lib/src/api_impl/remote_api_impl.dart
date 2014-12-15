// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library remote_api_impl;

import 'dart:async';
import 'dart:io';
import 'dart:convert' show UTF8, JSON;

import '../../api/errors.dart' as errors;
import '../../api/remote_api.dart' as remote_api;
import '../appengine_context.dart';

import '../protobuf_api/rpc/rpc_service.dart';
import '../protobuf_api/internal/remote_api.pb.dart'
    as pb;

class RemoteApiImpl extends remote_api.RemoteApi {
  static final TEXT_CONTENT_TYPE =
      new ContentType('text', 'plain', charset: 'utf-8');
  static final JSON_CONTENT_TYPE =
      new ContentType('application', 'json', charset: 'utf-8');
  static final BINARY_CONTENT_TYPE =
      new ContentType('application', 'octet-stream');

  final RPCService _rpcService;
  final String _ticket;
  final AppengineContext _context;

  RemoteApiImpl(this._rpcService, this._context, this._ticket);

  Future handleRemoteApiRequest(HttpRequest httpRequest) {
    if (httpRequest.method == 'GET') {
      var rtok = httpRequest.uri.queryParameters['rtok'];
      if (rtok == null) rtok = '0';
      var json = {
        'app_id' : _context.fullQualifiedApplicationId,
        'rtok' : rtok,
      };
      return httpRequest.drain().then((_) {
        var data = UTF8.encode(JSON.encode(json));
        return _sendData(
            httpRequest.response, HttpStatus.OK, JSON_CONTENT_TYPE, data);
      });
    } else if (httpRequest.method == 'POST') {
      return httpRequest
          .fold(new BytesBuilder(), (buffer, data) => buffer..add(data))
          .then((BytesBuilder result) {
        var request = new pb.Request.fromBuffer(result.takeBytes());
        var response = new pb.Response();
        return _rpcService.call(request.serviceName, request.method,
                                request.request, ticket: _ticket)
            .then((result) {
          response.response = result;

          var data = response.writeToBuffer();
          return _sendData(
              httpRequest.response, HttpStatus.OK, BINARY_CONTENT_TYPE, data);
        }).catchError((error) {
          response.applicationError = new pb.ApplicationError();
          response.applicationError.code = error.code;
          response.applicationError.detail = error.message;

          var data = response.writeToBuffer();
          return _sendData(
              httpRequest.response, HttpStatus.OK, BINARY_CONTENT_TYPE, data);
        }, test: (error) => error is RpcApplicationError)
        .then((_) => null);
      });
    } else {
      return new Future.sync(() {
        throw new errors.ApplicationError(
            'RemoteApi will only handle GET and POST requests.');
      });
    }
  }

  Future _sendData(response, statusCode, contentType, data) {
    response.statusCode = statusCode;
    response.headers.contentType = contentType;
    response.headers.contentLength = data.length;
    response.add(data);
    return response.close();
  }
}
