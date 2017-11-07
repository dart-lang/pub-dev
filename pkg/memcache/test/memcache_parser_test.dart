// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:io";
import "dart:async";
import "dart:math" as Math;

import 'package:test/test.dart';

import 'package:memcache/src/memcache_native_connection.dart';

// Add the full message in different chunks.
int fillChunks(List<int> message, StreamController controller) {
  int count = 0;
  for (int chunkSize = 1; chunkSize <= message.length; chunkSize++) {
    for (int from = 0; from < message.length; from += chunkSize) {
      int numBytes = Math.min(chunkSize, message.length - from);
      controller.add(message.sublist(from, from + numBytes));
    }
    count++;
  }

  return count;
}

int fillTestData(List<int> message, StreamController controller) {
  var totalMessages = 0;

  // Add the full message.
  controller.add(message);
  totalMessages++;

  // Add message in chunks.
  totalMessages += fillChunks(message, controller);

  // Add double message in chunks.
  var doubleMessage = new List();
  doubleMessage.addAll(message);
  doubleMessage.addAll(message);
  totalMessages += 2 * fillChunks(doubleMessage, controller);

  controller.close();

  return totalMessages;
}

Future testParser(List<int> message, Function f) {
  var completer = new Completer();
  var controller = new StreamController();
  var count = fillTestData(message, controller);
  controller.stream.transform(new ResponseTransformer()).listen(
      expectAsync(f, count: count),
      onDone: expectAsync(completer.complete));
  return completer.future;
}

Future testParserError(List<int> message, Function f) {
  var completer = new Completer();
  var controller = new StreamController();
  controller.add(message);
  controller.close();
  controller.stream.transform(new ResponseTransformer()).listen(
      (_) => completer.completeError('Unexpected message'),
      onError: f,
      onDone: expectAsync(() {
        if (!completer.isCompleted) completer.complete();
      }));
  return completer.future;
}

main() {
  group('response-parser', () {
    test('get-not-found', () {
      // Response for get request:
      // 'key not found' with opaque 0, cas 0 and no value.
      var bytes = [129, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0,
                   0, 0, 0, 0, 0, 78, 111, 116, 32, 102, 111, 117, 110, 100];
      var statusMessage = 'Not found';
      testParser(bytes, (Response response) {
        expect(response.magic, Header.RESPOSE_MAGIC);
        expect(response.opcode, Opcode.OPCODE_GET);
        expect(response.keyLength, 0);
        expect(response.extrasLength, 0);
        expect(response.dataType, 0);
        expect(response.status, ResponseStatus.KEY_NOT_FOUND);
        expect(response.totalBodyLength, statusMessage.length);
        expect(response.valueLength, statusMessage.length);
        expect(response.opaque, 0);
        expect(response.cas, 0);
        expect(response.statusMessage, statusMessage);
      });
    });

    test('get-found', () {
      // Response for get request:
      // 'key found' with opaque 1, cas 1, flags 1 and value [1].
      var bytes = [129, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0,
                   0, 0, 0, 0, 1, 0, 0, 0, 1, 1];
      testParser(bytes, (Response response) {
        expect(response.magic, Header.RESPOSE_MAGIC);
        expect(response.opcode, Opcode.OPCODE_GET);
        expect(response.keyLength, 0);
        expect(response.extrasLength, 4);
        expect(response.dataType, 0);
        expect(response.status, ResponseStatus.NO_ERROR);
        expect(response.totalBodyLength, 5);  // Includes extras length.
        expect(response.valueLength, 1);
        expect(response.opaque, 1);
        expect(response.cas, 1);
        expect(response.flags, 1);
        expect(response.statusMessage, isNull);
        expect(response.key, isNull);
        expect(response.value, [1]);
      });
    });

    test('getk-found', () {
      // Response for getk request:
      // 'key found' with opaque 2, cas 1, flags 1, key [1] and value [1].
      var bytes = [129, 12, 0, 1, 4, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 2, 0, 0, 0,
                   0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1];
      testParser(bytes, (Response response) {
        expect(response.magic, Header.RESPOSE_MAGIC);
        expect(response.opcode, Opcode.OPCODE_GETK);
        expect(response.keyLength, 1);
        expect(response.extrasLength, 4);
        expect(response.dataType, 0);
        expect(response.status, ResponseStatus.NO_ERROR);
        expect(response.totalBodyLength, 6);  // Includes extras length.
        expect(response.valueLength, 1);
        expect(response.opaque, 2);
        expect(response.cas, 1);
        expect(response.flags, 1);
        expect(response.statusMessage, isNull);
        expect(response.key, [1]);
        expect(response.value, [1]);
      });
    });

    test('version', () {
      // Response for 'version' with version 1.4.13.
      var bytes = [129, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,
                   0, 0, 0, 0, 0, 49, 46, 52, 46, 49, 51];
      var version = '1.4.13';
      testParser(bytes, (Response response) {
        expect(response.magic, Header.RESPOSE_MAGIC);
        expect(response.opcode, Opcode.OPCODE_VERSION);
        expect(response.keyLength, 0);
        expect(response.extrasLength, 0);
        expect(response.dataType, 0);
        expect(response.status, ResponseStatus.NO_ERROR);
        expect(response.totalBodyLength, version.length);
        expect(response.valueLength, version.length);
        expect(response.opaque, 0);
        expect(response.cas, 0);
        expect(response.statusMessage, isNull);
        expect(response.key, isNull);
        expect(response.valueAsString, version);
      });
    });
  });

  group('parser-errors', () {
    test('invalid-magic', () {
      // Response for get request:
      // 'key not found' with opaque 0, cas 0 and no value with magic changed
      // from 129 to 128.
      var bytes = [128, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0,
                   0, 0, 0, 0, 0, 78, 111, 116, 32, 102, 111, 117, 110, 100];
      return testParserError(
          bytes,
          expectAsync((error) => expect(error is MemCacheError, isTrue)));
    });

    test('short-message', () {
      // Response for get request:
      // 'key not found' with opaque 0, cas 0 and no value missing last byte.
      var bytes = [129, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0,
                   0, 0, 0, 0, 0, 78, 111, 116, 32, 102, 111, 117, 110];
      return testParserError(
          bytes,
          expectAsync((error) => expect(error is MemCacheError, isTrue)));
    });

    test('invalid-key-length', () {
      // Response for getk request:
      // 'key found' with opaque 2, cas 1, key [1] and value [1], but with
      // key length changed from 1 to 3.
      var bytes = [129, 12, 0, 3, 4, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 2, 0, 0, 0,
                   0, 0, 0, 0, 1, 13, 234, 222, 239, 1, 1];
      return testParserError(
          bytes,
          expectAsync((error) => expect(error is MemCacheError, isTrue)));
    });

    test('invalid-extras-length', () {
      // Response for getk request:
      // 'key found' with opaque 2, cas 1, key [1] and value [1], but with
      // extras length changed from 4 to 6.
      var bytes = [129, 12, 0, 1, 6, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 2, 0, 0, 0,
                   0, 0, 0, 0, 1, 13, 234, 222, 239, 1, 1];
      return testParserError(
          bytes,
          expectAsync((error) => expect(error is MemCacheError, isTrue)));
    });

    test('invalid-get-extras-length', () {
      // Response for getk request:
      // 'key found' with opaque 2, cas 1, key [1] and value [1], but with
      // key length changed from 1 to 2 and extras length changed from 4 to 5.
      var bytes = [129, 12, 0, 2, 5, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 2, 0, 0, 0,
                   0, 0, 0, 0, 1, 13, 234, 222, 239, 1, 1];
      return testParserError(
          bytes,
          expectAsync((error) => expect(error is MemCacheError, isTrue)));
    });
  });

  group('parser-exceptions', () {
    Future testStreamError(error, Function f) {
      var completer = new Completer();
      var controller = new StreamController();
      controller.addError(error);
      controller.close();
      controller.stream.transform(new ResponseTransformer()).listen(
          (_) => completer.completeError('Unexpected message'),
          onError: f,
          onDone: () {
            if (!completer.isCompleted) completer.complete();
          });
      return completer.future;
    }

    test('stream-error-string', () {
      return testStreamError(
          "error",
          expectAsync((error) => expect(error is MemCacheError, isTrue)));
    });

    test('stream-error-socket', () {
      return testStreamError(
          new SocketException("socket exception"),
          expectAsync((error) => expect(error is MemCacheError, isTrue)));
    });
  });
}
