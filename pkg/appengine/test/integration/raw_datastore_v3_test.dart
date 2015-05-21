// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:appengine/src/appengine_context.dart';
import 'package:appengine/src/api_impl/raw_datastore_v3_impl.dart';
import 'package:appengine/src/protobuf_api/rpc/rpc_service_remote_api.dart';

import 'raw_datastore_test_impl.dart';

main() {
  var rpcService = new RPCServiceRemoteApi('127.0.0.1', 4444);
  var appengineContext = new AppengineContext(
      'dev', 'test-application', 'test-version', null, null, null);
  var datastore =
      new DatastoreV3RpcImpl(rpcService, appengineContext, '<invalid-ticket>');

  runTests(datastore);
}
