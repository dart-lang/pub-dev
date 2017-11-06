// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import "package:async/src/typed/future.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  group("with valid types, forwards", () {
    var wrapper;
    TypeSafeFuture<int> errorWrapper;
    setUp(() {
      wrapper = new TypeSafeFuture<int>(new Future<Object>.value(12));

      var error = new Future<Object>.error("oh no");
      error.catchError((_) {}); // Don't let the error cause the test to fail.
      errorWrapper = new TypeSafeFuture<int>(error);
    });

    test("asStream()", () {
      expect(wrapper.asStream().toList(), completion(equals([12])));
      expect(errorWrapper.asStream().first, throwsA("oh no"));
    });

    test("catchError()", () {
      expect(
          wrapper.catchError(expectAsync1((_) {}, count: 0),
              test: expectAsync1((_) {}, count: 0)),
          completion(equals(12)));

      expect(
          errorWrapper.catchError(expectAsync1((error) {
            expect(error, equals("oh no"));
            return 42;
          }), test: expectAsync1((error) {
            expect(error, equals("oh no"));
            return true;
          })),
          completion(equals(42)));
    });

    test("then()", () {
      expect(
          wrapper.then((value) => value.toString()), completion(equals("12")));
      expect(
          errorWrapper.then(expectAsync1((_) {}, count: 0)), throwsA("oh no"));
    });

    test("whenComplete()", () {
      expect(wrapper.whenComplete(expectAsync0(() {})), completion(equals(12)));
      expect(errorWrapper.whenComplete(expectAsync0(() {})), throwsA("oh no"));
    });

    test("timeout()", () {
      expect(wrapper.timeout(new Duration(seconds: 1)), completion(equals(12)));
      expect(errorWrapper.timeout(new Duration(seconds: 1)), throwsA("oh no"));

      expect(
          new TypeSafeFuture<int>(new Completer<Object>().future)
              .timeout(Duration.ZERO),
          throwsA(new isInstanceOf<TimeoutException>()));

      expect(
          new TypeSafeFuture<int>(new Completer<Object>().future)
              .timeout(Duration.ZERO, onTimeout: expectAsync0(() => 15)),
          completion(equals(15)));
    });
  });

  group("with invalid types", () {
    TypeSafeFuture<int> wrapper;
    setUp(() {
      wrapper = new TypeSafeFuture<int>(new Future<Object>.value("foo"));
    });

    group("throws a CastError for", () {
      test("asStream()", () {
        expect(wrapper.asStream().first, throwsCastError);
      });

      test("then()", () {
        expect(
            wrapper.then(expectAsync1((_) {}, count: 0),
                onError: expectAsync1((_) {}, count: 0)),
            throwsCastError);
      });

      test("whenComplete()", () {
        expect(wrapper.whenComplete(expectAsync0(() {})).then((_) {}),
            throwsCastError);
      });

      test("timeout()", () {
        expect(wrapper.timeout(new Duration(seconds: 3)).then((_) {}),
            throwsCastError);

        expect(
            new TypeSafeFuture<int>(new Completer<Object>().future)
                .timeout(Duration.ZERO, onTimeout: expectAsync0(() => "foo"))
                .then((_) {}),
            throwsCastError);
      });
    });
  });
}
