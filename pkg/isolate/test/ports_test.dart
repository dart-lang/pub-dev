// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library isolate.test.ports_test;

import 'dart:async';
import 'dart:isolate';

import 'package:isolate/ports.dart';
import 'package:test/test.dart';

const Duration MS = const Duration(milliseconds: 1);

main() {
  group('SingleCallbackPort', testSingleCallbackPort);
  group('SingleCompletePort', testSingleCompletePort);
  group('SingleResponseFuture', testSingleResponseFuture);
  group('SingleResponseFuture', testSingleResultFuture);
  group('SingleResponseChannel', testSingleResponseChannel);
}

void testSingleCallbackPort() {
  test("Value", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCallbackPort(completer.complete);
    p.send(42);
    return completer.future.then((v) {
      expect(v, 42);
    });
  });

  test("FirstValue", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCallbackPort(completer.complete);
    p.send(42);
    p.send(37);
    return completer.future.then((v) {
      expect(v, 42);
    });
  });
  test("Value", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCallbackPort(completer.complete);
    p.send(42);
    return completer.future.then((v) {
      expect(v, 42);
    });
  });

  test("ValueBeforeTimeout", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCallbackPort(completer.complete, timeout: MS * 500);
    p.send(42);
    return completer.future.then((v) {
      expect(v, 42);
    });
  });

  test("Timeout", () {
    Completer completer = new Completer.sync();
    singleCallbackPort(completer.complete, timeout: MS * 100, timeoutValue: 37);
    return completer.future.then((v) {
      expect(v, 37);
    });
  });

  test("TimeoutFirst", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCallbackPort(completer.complete,
        timeout: MS * 100, timeoutValue: 37);
    new Timer(MS * 500, () => p.send(42));
    return completer.future.then((v) {
      expect(v, 37);
    });
  });
}

void testSingleCompletePort() {
  test("Value", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer);
    p.send(42);
    return completer.future.then((v) {
      expect(v, 42);
    });
  });

  test("ValueCallback", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer, callback: (v) {
      expect(42, v);
      return 87;
    });
    p.send(42);
    return completer.future.then((v) {
      expect(v, 87);
    });
  });

  test("ValueCallbackFuture", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer, callback: (v) {
      expect(42, v);
      return new Future.delayed(MS * 500, () => 88);
    });
    p.send(42);
    return completer.future.then((v) {
      expect(v, 88);
    });
  });

  test("ValueCallbackThrows", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer, callback: (v) {
      expect(42, v);
      throw 89;
    });
    p.send(42);
    return completer.future.then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e, 89);
    });
  });

  test("ValueCallbackThrowsFuture", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer, callback: (v) {
      expect(42, v);
      return new Future.error(90);
    });
    p.send(42);
    return completer.future.then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e, 90);
    });
  });

  test("FirstValue", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer);
    p.send(42);
    p.send(37);
    return completer.future.then((v) {
      expect(v, 42);
    });
  });

  test("FirstValueCallback", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer, callback: (v) {
      expect(v, 42);
      return 87;
    });
    p.send(42);
    p.send(37);
    return completer.future.then((v) {
      expect(v, 87);
    });
  });

  test("ValueBeforeTimeout", () {
    Completer completer = new Completer.sync();
    SendPort p = singleCompletePort(completer, timeout: MS * 500);
    p.send(42);
    return completer.future.then((v) {
      expect(v, 42);
    });
  });

  test("Timeout", () {
    Completer completer = new Completer.sync();
    singleCompletePort(completer, timeout: MS * 100);
    return completer.future.then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e is TimeoutException, isTrue);
    });
  });

  test("TimeoutCallback", () {
    Completer completer = new Completer.sync();
    singleCompletePort(completer, timeout: MS * 100, onTimeout: () => 87);
    return completer.future.then((v) {
      expect(v, 87);
    });
  });

  test("TimeoutCallbackThrows", () {
    Completer completer = new Completer.sync();
    singleCompletePort(completer, timeout: MS * 100, onTimeout: () => throw 91);
    return completer.future.then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e, 91);
    });
  });

  test("TimeoutCallbackFuture", () {
    Completer completer = new Completer.sync();
    singleCompletePort(completer,
        timeout: MS * 100, onTimeout: () => new Future.value(87));
    return completer.future.then((v) {
      expect(v, 87);
    });
  });

  test("TimeoutCallbackThrowsFuture", () {
    Completer completer = new Completer.sync();
    singleCompletePort(completer,
        timeout: MS * 100, onTimeout: () => new Future.error(92));
    return completer.future.then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e, 92);
    });
  });

  test("TimeoutCallbackSLow", () {
    Completer completer = new Completer.sync();
    singleCompletePort(completer,
        timeout: MS * 100,
        onTimeout: () => new Future.delayed(MS * 500, () => 87));
    return completer.future.then((v) {
      expect(v, 87);
    });
  });

  test("TimeoutCallbackThrowsSlow", () {
    Completer completer = new Completer.sync();
    singleCompletePort(completer,
        timeout: MS * 100,
        onTimeout: () => new Future.delayed(MS * 500, () => throw 87));
    return completer.future.then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e, 87);
    });
  });

  test("TimeoutFirst", () {
    Completer completer = new Completer.sync();
    SendPort p =
        singleCompletePort(completer, timeout: MS * 100, onTimeout: () => 37);
    new Timer(MS * 500, () => p.send(42));
    return completer.future.then((v) {
      expect(v, 37);
    });
  });
}

void testSingleResponseFuture() {
  test("FutureValue", () {
    return singleResponseFuture((SendPort p) {
      p.send(42);
    }).then((v) {
      expect(v, 42);
    });
  });

  test("FutureValueFirst", () {
    return singleResponseFuture((SendPort p) {
      p.send(42);
      p.send(37);
    }).then((v) {
      expect(v, 42);
    });
  });

  test("FutureError", () {
    return singleResponseFuture((SendPort p) {
      throw 93;
    }).then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e, 93);
    });
  });

  test("FutureTimeout", () {
    return singleResponseFuture((SendPort p) {
      // no-op.
    }, timeout: MS * 100).then((v) {
      expect(v, null);
    });
  });

  test("FutureTimeoutValue", () {
    return singleResponseFuture((SendPort p) {
      // no-op.
    }, timeout: MS * 100, timeoutValue: 42).then((v) {
      expect(v, 42);
    });
  });
}

void testSingleResultFuture() {
  test("Value", () {
    return singleResultFuture((SendPort p) {
      sendFutureResult(new Future.value(42), p);
    }).then((v) {
      expect(v, 42);
    });
  });

  test("ValueFirst", () {
    return singleResultFuture((SendPort p) {
      sendFutureResult(new Future.value(42), p);
      sendFutureResult(new Future.value(37), p);
    }).then((v) {
      expect(v, 42);
    });
  });

  test("Error", () {
    return singleResultFuture((SendPort p) {
      sendFutureResult(new Future.error(94), p);
    }).then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e is RemoteError, isTrue);
    });
  });

  test("ErrorFirst", () {
    return singleResultFuture((SendPort p) {
      sendFutureResult(new Future.error(95), p);
      sendFutureResult(new Future.error(96), p);
    }).then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e is RemoteError, isTrue);
    });
  });

  test("Error", () {
    return singleResultFuture((SendPort p) {
      throw 93;
    }).then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e is RemoteError, isTrue);
    });
  });

  test("Timeout", () {
    return singleResultFuture((SendPort p) {
      // no-op.
    }, timeout: MS * 100).then((v) {
      fail("unreachable");
    }, onError: (e, s) {
      expect(e is TimeoutException, isTrue);
    });
  });

  test("TimeoutValue", () {
    return singleResultFuture((SendPort p) {
      // no-op.
    }, timeout: MS * 100, onTimeout: () => 42).then((v) {
      expect(v, 42);
    });
  });

  test("TimeoutError", () {
    return singleResultFuture((SendPort p) {
      // no-op.
    }, timeout: MS * 100, onTimeout: () => throw 97).then((v) {
      expect(v, 42);
    }, onError: (e, s) {
      expect(e, 97);
    });
  });
}

void testSingleResponseChannel() {
  test("Value", () {
    var channel = new SingleResponseChannel();
    channel.port.send(42);
    return channel.result.then((v) {
      expect(v, 42);
    });
  });

  test("ValueFirst", () {
    var channel = new SingleResponseChannel();
    channel.port.send(42);
    channel.port.send(37);
    return channel.result.then((v) {
      expect(v, 42);
    });
  });

  test("ValueCallback", () {
    var channel = new SingleResponseChannel(callback: (v) => v * 2);
    channel.port.send(42);
    return channel.result.then((v) {
      expect(v, 84);
    });
  });

  test("ErrorCallback", () {
    var channel = new SingleResponseChannel(callback: (v) => throw 42);
    channel.port.send(37);
    return channel.result.then((v) {
      fail("unreachable");
    }, onError: (v, s) {
      expect(v, 42);
    });
  });

  test("AsyncValueCallback", () {
    var channel =
        new SingleResponseChannel(callback: (v) => new Future.value(v * 2));
    channel.port.send(42);
    return channel.result.then((v) {
      expect(v, 84);
    });
  });

  test("AsyncErrorCallback", () {
    var channel =
        new SingleResponseChannel(callback: (v) => new Future.error(42));
    channel.port.send(37);
    return channel.result.then((v) {
      fail("unreachable");
    }, onError: (v, s) {
      expect(v, 42);
    });
  });

  test("Timeout", () {
    var channel = new SingleResponseChannel(timeout: MS * 100);
    return channel.result.then((v) {
      expect(v, null);
    });
  });

  test("TimeoutThrow", () {
    var channel =
        new SingleResponseChannel(timeout: MS * 100, throwOnTimeout: true);
    return channel.result.then((v) {
      fail("unreachable");
    }, onError: (v, s) {
      expect(v is TimeoutException, isTrue);
    });
  });

  test("TimeoutThrowOnTimeoutAndValue", () {
    var channel = new SingleResponseChannel(
        timeout: MS * 100,
        throwOnTimeout: true,
        onTimeout: () => 42,
        timeoutValue: 42);
    return channel.result.then((v) {
      fail("unreachable");
    }, onError: (v, s) {
      expect(v is TimeoutException, isTrue);
    });
  });

  test("TimeoutOnTimeout", () {
    var channel =
        new SingleResponseChannel(timeout: MS * 100, onTimeout: () => 42);
    return channel.result.then((v) {
      expect(v, 42);
    });
  });

  test("TimeoutOnTimeoutAndValue", () {
    var channel = new SingleResponseChannel(
        timeout: MS * 100, onTimeout: () => 42, timeoutValue: 37);
    return channel.result.then((v) {
      expect(v, 42);
    });
  });

  test("TimeoutValue", () {
    var channel =
        new SingleResponseChannel(timeout: MS * 100, timeoutValue: 42);
    return channel.result.then((v) {
      expect(v, 42);
    });
  });

  test("TimeoutOnTimeoutError", () {
    var channel =
        new SingleResponseChannel(timeout: MS * 100, onTimeout: () => throw 42);
    return channel.result.then((v) {
      fail("unreachable");
    }, onError: (v, s) {
      expect(v, 42);
    });
  });

  test("TimeoutOnTimeoutAsync", () {
    var channel = new SingleResponseChannel(
        timeout: MS * 100, onTimeout: () => new Future.value(42));
    return channel.result.then((v) {
      expect(v, 42);
    });
  });

  test("TimeoutOnTimeoutAsyncError", () {
    var channel = new SingleResponseChannel(
        timeout: MS * 100, onTimeout: () => new Future.error(42));
    return channel.result.then((v) {
      fail("unreachable");
    }, onError: (v, s) {
      expect(v, 42);
    });
  });
}
