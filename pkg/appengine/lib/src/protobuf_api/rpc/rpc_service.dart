// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library rpc_service;

import 'dart:async';

class RpcApplicationError implements Exception {
  final int code;
  final String message;

  RpcApplicationError(this.code, this.message);
  String toString() => 'RpcApplicationError: $code ($message)';
}

abstract class RPCService {
  Future<List<int>> call(String apiPackage,
                         String method,
                         List<int> requestProtocolBuffer,
                         {String ticket: 'invalid-ticket'});
}
