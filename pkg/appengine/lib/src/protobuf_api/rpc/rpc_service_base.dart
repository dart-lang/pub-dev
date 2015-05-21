// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library rpc_service_base;

import 'dart:async';
import 'dart:io';

import '../../../api/errors.dart';

abstract class RPCServiceBase {
  static ContentType RPC_CONTENT_TYPE =
      new ContentType('application', 'octet-stream');

  HttpClient _client;

  RPCServiceBase() : _client = new HttpClient();

  Future<List<int>> makeRequest(String host,
                                int port,
                                String path,
                                List<int> data,
                                Map<String, String> additionalHeaders) {
    return _client.post(host, port, path).then((HttpClientRequest request) {
      var headers = request.headers;
      headers.contentType = RPC_CONTENT_TYPE;
      headers.contentLength = data.length;

      for (var key in additionalHeaders.keys) {
        headers.set(key, additionalHeaders[key]);
      }

      request.add(data);
      return request.close().then((HttpClientResponse response) {
        if (response.statusCode != HttpStatus.OK) {
          return response.drain().then((_) {
            throw new ProtocolError("Http statusCode was "
                "${response.statusCode} instead of ${HttpStatus.OK}");
          });
        }
        return response.fold(new BytesBuilder(), (buffer, data) {
          buffer.add(data);
          return buffer;
        }).then((BytesBuilder buffer) => buffer.takeBytes());
      });
    }).catchError((error) {
      throw new NetworkError('$error $port $host');
    });
  }
}
