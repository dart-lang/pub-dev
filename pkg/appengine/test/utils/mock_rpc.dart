// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:mirrors';

import 'package:appengine/src/protobuf_api/rpc/rpc_service.dart';

class MockRPCService extends RPCService {
  String _service;
  Map<String, Function> _handlers = {};

  MockRPCService(this._service);

  register(String method, Type requestType, Function handler) {
    if (handler == null) {
      _handlers.remove(method);
    } else {
      _handlers[method] = (List<int> bytes) {
        var decodedRequest =
            reflectClass(requestType).newInstance(#fromBuffer, [bytes]);
        return handler(decodedRequest.reflectee);
      };
    }
  }

  Future<List<int>> call(String apiPackage,
                         String method,
                         List<int> requestProtocolBuffer,
                         {String ticket}) {
    if (_service != apiPackage) {
      throw "This Mock only works for the $_service service.";
    }

    if (_handlers.containsKey(method)) {
      return _handlers[method](requestProtocolBuffer);
    }
    throw "Not mock handler for $apiPackage.$method found";
  }
}
