// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:appengine/api/errors.dart';
import 'package:appengine/src/api_impl/logging_impl.dart';
import 'package:appengine/src/protobuf_api/internal/'
       'api_base.pb.dart' as pb_base;
import 'package:appengine/src/protobuf_api/internal/log_service.pb.dart' as pb;

import 'utils/mock_rpc.dart';

main() {
  const INVALID_PROTOBUF = const [1, 2, 3, 4, 5];

  group('logging', () {
    test('log_and_flush', () {
      var mock = new MockRPCService('logservice');
      var logging = new LoggingRpcImpl(mock, '');

      var utc42 = new DateTime.fromMillisecondsSinceEpoch(42, isUtc: true);

      // Make sure we can log without getting RPC requests.
      logging.debug('debug-custom-ts', timestamp: utc42);
      logging.debug('debug');
      logging.info('info');
      logging.warning('warning');
      logging.error('error');
      logging.critical('critical');

      // Now we register a Flush handler and call flush, and validate that
      // the generated protocol buffers are correct.
      mock.register('Flush', pb.FlushRequest, expectAsync((request) {
        var group = new pb.UserAppLogGroup.fromBuffer(request.logs);
        var logs = group.logLine;
        expect(logs.length, equals(6));

        expect(logs[0].message, equals('debug-custom-ts'));
        expect(logs[0].level.toInt(), equals(0));
        expect(logs[0].timestampUsec.toInt(), equals(42000));

        expect(logs[1].message, equals('debug'));
        expect(logs[1].level.toInt(), equals(0));

        expect(logs[2].message, equals('info'));
        expect(logs[2].level.toInt(), equals(1));

        expect(logs[3].message, equals('warning'));
        expect(logs[3].level.toInt(), equals(2));

        expect(logs[4].message, equals('error'));
        expect(logs[4].level.toInt(), equals(3));

        expect(logs[5].message, equals('critical'));
        expect(logs[5].level.toInt(), equals(4));

        return new Future.value(new pb_base.VoidProto().writeToBuffer());
      }));
      expect(logging.flush(), completes);
    });
    test('no_error', () {
      var mock = new MockRPCService('logservice');
      var logging = new LoggingRpcImpl(mock, '');

      // Protocol errors are silently ignored.
      logging.debug('debug');
      mock.register('Flush', pb.FlushRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(logging.flush(), completes);

      // Network errors are silently ignored.
      logging.debug('debug');
      mock.register('Flush', pb.FlushRequest, expectAsync((request) {
        return new Future.error(new NetworkError(''));
      }));
      expect(logging.flush(), completes);
    });
  });
}
