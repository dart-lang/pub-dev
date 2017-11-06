// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:typed_data";

import 'package:test/test.dart';

import 'package:memcache/src/memcache_native_connection.dart';

// Control a memcached instance running.
class Memcached {
  Process process;
  final StringBuffer stdout = new StringBuffer();
  final StringBuffer stderr = new StringBuffer();
  int port = -1;

  Memcached._(this.process);

  static Future<Memcached> start() {
    var completer = new Completer();
    Directory.systemTemp.createTemp().then((tempDir) {
      // Start memcached asking for an empheral port and set a file in the
      // process environment for writing the actual port used.
      var portFileName =
          '${tempDir.path}${Platform.pathSeparator}memcached_port';
      Process.start(
          "/usr/bin/memcached",
          ['-vvv', '-l', '127.0.0.1', '-p', '-1', '-U', '0'],
          environment: {'MEMCACHED_PORT_FILENAME': portFileName})
        .then((process) {
          var memcached = new Memcached._(process);
          bool listening = false;
          // Write all stdout to a string buffer.
          process.stdout.transform(UTF8.decoder).listen(memcached.stdout.write);
          process.stderr.transform(UTF8.decoder).listen((s) {
            // Write all stderr to a string buffer.
            memcached.stderr.write(s);
            // Wait for the server to be listening. This is signalled by the
            // string "server listening" being written on stderr.
            if (!listening) {
              if (memcached.stderr.toString().contains("server listening")) {
                listening = true;
                // When server is listening get the port form the file.
                new File(portFileName).readAsString().then((fileContent) {
                  // When only listening on a TCP port the file contains the
                  // following text:
                  // TCP INET: <port>
                  RegExp portMatch =
                      new RegExp(r"^\s*TCP INET:\s*([0-9]*)\s*$", multiLine: true);
                  try {
                    memcached.port =
                        int.parse(portMatch.firstMatch(fileContent).group(1));
                  } catch (e) {
                    completer.completeError('Unable to get memcached port: $e');
                    return;
                  }
                  completer.complete(memcached);
                });
              }
            }
          });
        });
    });
    return completer.future;
  }

  Future stop() {
    process.kill();
    return process.exitCode;
  }
}

Memcached memcached;

Future startMemcached() {
  assert(memcached == null);
  return Memcached.start().then((m) {
    memcached = m;
    return null;
  });
}

Future stopMemcached() {
  assert(memcached != null);
  return memcached.stop().then((_) => memcached = null);
}

main() {
  checkResponseKey(response, key) {
    if (response.opcode == Opcode.OPCODE_GETK ||
        response.opcode == Opcode.OPCODE_GETKQ) {
      expect(response.key, key);
    } else {
      expect(response.key, isNull);
    }
  }

  checkUint64Value(response, int value) {
    var bytes = new Uint8List(8);
    var data = new ByteData.view(bytes.buffer);
    data.setUint64(0, value, Endianness.BIG_ENDIAN);
    expect(response.value, bytes);
  }

  group('memcache', () {
    setUp(startMemcached);
    tearDown(stopMemcached);

    Future testGetUpdateGet(Request getRequest, Request updateRequest) {
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(getRequest).then((response) {
          expect(response.status, ResponseStatus.KEY_NOT_FOUND);
          expect(response.opcode, getRequest.opcode);
          checkResponseKey(response, getRequest.key);
          return connection.sendRequest(updateRequest).then((response) {
            expect(response.status, ResponseStatus.NO_ERROR);
            expect(response.opcode, updateRequest.opcode);
            return connection.sendRequest(getRequest).then((response) {
              expect(response.status, ResponseStatus.NO_ERROR);
              expect(response.opcode, getRequest.opcode);
              checkResponseKey(response, getRequest.key);
              expect(response.flags, updateRequest.flags);
              expect(response.value, updateRequest.value);
            });
          });
        });
      });
    }

    // Adds a key with the specified exipration. Keeps checking for the key
    // until it is not found anymore.
    Future testExpire(int expiration) {
      var connection;
      var completer = new Completer();
      var add = new Request.add([1], [1], expiration: expiration);
      var get = new Request.get([1]);

      void checkExpired() {
        connection.sendRequest(get).then((response) {
          if (response.status == ResponseStatus.KEY_NOT_FOUND) {
            completer.complete(null);
          } else {
            expect(response.status, ResponseStatus.NO_ERROR);
            expect(response.opcode, get.opcode);
            expect(response.value, add.value);
            new Timer(new Duration(milliseconds: 200), checkExpired);
          }
        }).catchError(completer.completeError);
      };

      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((conn) {
        connection = conn;
        return connection.sendRequest(add).then((response) {
          expect(response.status, ResponseStatus.NO_ERROR);
          expect(response.opcode, add.opcode);
          Timer.run(checkExpired);
          return completer.future;
        });
      });
    }

    test('get-set-get', () {
      return testGetUpdateGet(new Request.get([1]), new Request.set([1], [1]));
    });

    test('get-set-get long key and value', () {
      return testGetUpdateGet(
          new Request.get(new Uint8List(64)),
          new Request.set(new Uint8List(64), new Uint8List(1024)));
    });

    test('get-set-get max key and value', () {
      return testGetUpdateGet(
          new Request.get(new Uint8List(250)),
          new Request.set(new Uint8List(250), new Uint8List(1024)));
    });

    test('get-set-get with flags', () {
      return testGetUpdateGet(
          new Request.get([1]), new Request.set([1], [1], flags: 1234));
    });

    test('getk-set-getk', () {
      return testGetUpdateGet(new Request.getk([1]), new Request.set([1], [1]));
    });

    test('get-add-get', () {
      return testGetUpdateGet(new Request.get([1]), new Request.add([1], [1]));
    });
// TODO(sgjesse): Add a getq test.
/*
    test('add-getq-get', () {
      var add = new Request.add([1], [1]);
      var getq = new Request.getq([1]);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(add).then((response) {
          expect(response.status, ResponseStatus.STATUS_NO_ERROR);
          expect(response.opcode, add.opcode);
          return connection.sendRequest(getq).then((response) {
            print(response);
            expect(response.status, ResponseStatus.STATUS_KEY_EXISTS);
            expect(response.opcode, getq.opcode);
          });
        });
      });
    });
*/
    test('add-add', () {
      var request = new Request.add([1], [1]);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(request).then((response) {
          expect(response.status, ResponseStatus.NO_ERROR);
          expect(response.opcode, request.opcode);
          return connection.sendRequest(request).then((response) {
            expect(response.status, ResponseStatus.KEY_EXISTS);
            expect(response.opcode, request.opcode);
          });
        });
      });
    });

    test('replace-add-replace-get', () {
      var add = new Request.add([1], [1]);
      var replace = new Request.replace([1], [2]);
      var get = new Request.get([1]);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(replace).then((response) {
          expect(response.status, ResponseStatus.KEY_NOT_FOUND);
          expect(response.opcode, replace.opcode);
          return connection.sendRequest(add).then((response) {
            expect(response.status, ResponseStatus.NO_ERROR);
            expect(response.opcode, add.opcode);
            return connection.sendRequest(replace).then((response) {
              expect(response.status, ResponseStatus.NO_ERROR);
              expect(response.opcode, replace.opcode);
              return connection.sendRequest(get).then((response) {
                expect(response.status, ResponseStatus.NO_ERROR);
                expect(response.opcode, get.opcode);
                expect(response.value, replace.value);
              });
            });
          });
        });
      });
    });

    test('add-get-delete-get', () {
      var add = new Request.add([1], [1]);
      var get = new Request.get([1]);
      var delete = new Request.delete([1]);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(add).then((response) {
          expect(response.status, ResponseStatus.NO_ERROR);
          expect(response.opcode, add.opcode);
          return connection.sendRequest(get).then((response) {
            expect(response.status, ResponseStatus.NO_ERROR);
            expect(response.opcode, get.opcode);
            expect(response.value, add.value);
            return connection.sendRequest(delete).then((response) {
              expect(response.status, ResponseStatus.NO_ERROR);
              expect(response.opcode, delete.opcode);
              return connection.sendRequest(get).then((response) {
                expect(response.status, ResponseStatus.KEY_NOT_FOUND);
                expect(response.opcode, get.opcode);
              });
            });
          });
        });
      });
    });

    test('expire relative', () {
      return testExpire(1);
    });

    test('expire absolute', () {
      return testExpire(new DateTime.now().millisecondsSinceEpoch ~/ 1000 + 1);
    });

    test('version', () {
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(new Request.version()).then((response) {
          expect(response.valueAsString.contains('.'), isTrue);
        });
      });
    });

    test('invalid key', () {
      // Max key length is 250.
      var invalidKey = new Uint8List(251);
      var get = new Request.get(invalidKey);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {

        Future testError(Request request, int expectedError) {
          return connection.sendRequest(get).then((response) {
            expect(response.status, expectedError);
          });
        }

        return testError(new Request.get(invalidKey),
                         ResponseStatus.INVALID_ARGUMENTS);
      });
    });

    test('increment', () {
      var incr = new Request.increment([1], 1, 0);
      var incr2 = new Request.increment([1], 0xffffffffffffffff, 0);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(incr).then((response) {
          expect(response.status, ResponseStatus.NO_ERROR);
          expect(response.opcode, incr.opcode);
          checkUint64Value(response, 0);
          return connection.sendRequest(incr).then((response) {
            expect(response.status, ResponseStatus.NO_ERROR);
            expect(response.opcode, incr.opcode);
            checkUint64Value(response, 1);
            return connection.sendRequest(incr).then((response) {
              expect(response.status, ResponseStatus.NO_ERROR);
              expect(response.opcode, incr.opcode);
              checkUint64Value(response, 2);
              return connection.sendRequest(incr2).then((response) {
                expect(response.status, ResponseStatus.NO_ERROR);
                expect(response.opcode, incr.opcode);
                checkUint64Value(response, 1);
              });
            });
          });
        });
      });
    });

    test('decrement', () {
      var decr = new Request.decrement([1], 1, 10);
      var decr2 = new Request.decrement([1], 0xffffffffffffffffffff, 10);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(decr).then((response) {
          expect(response.status, ResponseStatus.NO_ERROR);
          expect(response.opcode, decr.opcode);
          checkUint64Value(response, 10);
          return connection.sendRequest(decr).then((response) {
            expect(response.status, ResponseStatus.NO_ERROR);
            expect(response.opcode, decr.opcode);
            checkUint64Value(response, 9);
            return connection.sendRequest(decr).then((response) {
              expect(response.status, ResponseStatus.NO_ERROR);
              expect(response.opcode, decr.opcode);
              checkUint64Value(response, 8);
              return connection.sendRequest(decr2).then((response) {
                expect(response.status, ResponseStatus.NO_ERROR);
                expect(response.opcode, decr.opcode);
                checkUint64Value(response, 0);
              });
            });
          });
        });
      });
    });

    test('incr-decr-no-initial', () {
      // The an expiration with all 1-bits signals that a default value
      // should not be set.
      var incr = new Request.increment([1], 1, 0, expiration: 0xffffffff);
      var decr = new Request.increment([1], 1, 0, expiration: 0xffffffff);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(incr).then((response) {
          expect(response.status, ResponseStatus.KEY_NOT_FOUND);
          expect(response.opcode, incr.opcode);
          return connection.sendRequest(decr).then((response) {
            expect(response.status, ResponseStatus.KEY_NOT_FOUND);
            expect(response.opcode, decr.opcode);
          });
        });
      });
    });

    test('set-incr', () {
      // Use string number representation for setting.
      var set = new Request.set([1], '42'.codeUnits);
      var incr = new Request.increment([1], 1, 0);
      return MemCacheNativeConnection.connect(
          "127.0.0.1", memcached.port).then((connection) {
        return connection.sendRequest(set).then((response) {
          expect(response.status, ResponseStatus.NO_ERROR);
          expect(response.opcode, set.opcode);
          return connection.sendRequest(incr).then((response) {
            expect(response.status, ResponseStatus.NO_ERROR);
            expect(response.opcode, incr.opcode);
            checkUint64Value(response, 43);
          });
        });
      });
    });
  });
}
