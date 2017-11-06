// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import "package:async/src/typed/stream.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  group("with valid types, forwards", () {
    var controller;
    var wrapper;
    var emptyWrapper;
    var singleWrapper;
    var errorWrapper;
    setUp(() {
      controller = new StreamController<Object>()
        ..add(1)
        ..add(2)
        ..add(3)
        ..add(4)
        ..add(5)
        ..close();

      // TODO(nweiz): Use public methods when test#414 is fixed and we can run
      // this on DDC.
      wrapper = new TypeSafeStream<int>(controller.stream);
      emptyWrapper = new TypeSafeStream<int>(new Stream<Object>.empty());
      singleWrapper =
          new TypeSafeStream<int>(new Stream<Object>.fromIterable([1]));
      errorWrapper = new TypeSafeStream<int>(
          new Stream<Object>.fromFuture(new Future.error("oh no")));
    });

    test("first", () {
      expect(wrapper.first, completion(equals(1)));
      expect(emptyWrapper.first, throwsStateError);
    });

    test("last", () {
      expect(wrapper.last, completion(equals(5)));
      expect(emptyWrapper.last, throwsStateError);
    });

    test("single", () {
      expect(wrapper.single, throwsStateError);
      expect(singleWrapper.single, completion(equals(1)));
    });

    test("isBroadcast", () {
      expect(wrapper.isBroadcast, isFalse);
      var broadcastWrapper = new TypeSafeStream<int>(
          new Stream<Object>.empty().asBroadcastStream());
      expect(broadcastWrapper.isBroadcast, isTrue);
    });

    test("isEmpty", () {
      expect(wrapper.isEmpty, completion(isFalse));
      expect(emptyWrapper.isEmpty, completion(isTrue));
    });

    test("length", () {
      expect(wrapper.length, completion(equals(5)));
      expect(emptyWrapper.length, completion(equals(0)));
    });

    group("asBroadcastStream()", () {
      test("with no parameters", () {
        var broadcast = wrapper.asBroadcastStream();
        expect(broadcast.toList(), completion(equals([1, 2, 3, 4, 5])));
        expect(broadcast.toList(), completion(equals([1, 2, 3, 4, 5])));
      });

      test("with onListen", () {
        var broadcast =
            wrapper.asBroadcastStream(onListen: expectAsync1((subscription) {
          expect(subscription, new isInstanceOf<StreamSubscription<int>>());
          subscription.pause();
        }));

        broadcast.listen(null);
        expect(controller.isPaused, isTrue);
      });

      test("with onCancel", () {
        var broadcast =
            wrapper.asBroadcastStream(onCancel: expectAsync1((subscription) {
          expect(subscription, new isInstanceOf<StreamSubscription<int>>());
          subscription.pause();
        }));

        broadcast.listen(null).cancel();
        expect(controller.isPaused, isTrue);
      });
    });

    test("asyncExpand()", () {
      expect(
          wrapper.asyncExpand((i) => new Stream.fromIterable([i, i])).toList(),
          completion(equals([1, 1, 2, 2, 3, 3, 4, 4, 5, 5])));
    });

    test("asyncMap()", () {
      expect(wrapper.asyncMap((i) => new Future.value(i * 2)).toList(),
          completion(equals([2, 4, 6, 8, 10])));
    });

    group("distinct()", () {
      test("without equals", () {
        expect(
            wrapper.distinct().toList(), completion(equals([1, 2, 3, 4, 5])));

        expect(
            new TypeSafeStream<int>(
                    new Stream<Object>.fromIterable([1, 1, 2, 2, 3, 3]))
                .distinct()
                .toList(),
            completion(equals([1, 2, 3])));
      });

      test("with equals", () {
        expect(wrapper.distinct((i1, i2) => (i1 ~/ 2 == i2 ~/ 2)).toList(),
            completion(equals([1, 2, 4])));
      });
    });

    group("drain()", () {
      test("without a value", () {
        expect(wrapper.drain(), completes);
        expect(() => wrapper.drain(), throwsStateError);
      });

      test("with a value", () {
        expect(wrapper.drain(12), completion(equals(12)));
      });
    });

    test("expand()", () {
      expect(wrapper.expand((i) => [i, i]).toList(),
          completion(equals([1, 1, 2, 2, 3, 3, 4, 4, 5, 5])));
    });

    group("firstWhere()", () {
      test("finding a value", () {
        expect(wrapper.firstWhere((i) => i > 3), completion(equals(4)));
      });

      test("finding no value", () {
        expect(wrapper.firstWhere((i) => i > 5), throwsStateError);
      });

      test("with a default value", () {
        expect(wrapper.firstWhere((i) => i > 5, defaultValue: () => "value"),
            completion(equals("value")));
      });
    });

    group("lastWhere()", () {
      test("finding a value", () {
        expect(wrapper.lastWhere((i) => i < 3), completion(equals(2)));
      });

      test("finding no value", () {
        expect(wrapper.lastWhere((i) => i > 5), throwsStateError);
      });

      test("with a default value", () {
        expect(wrapper.lastWhere((i) => i > 5, defaultValue: () => "value"),
            completion(equals("value")));
      });
    });

    group("singleWhere()", () {
      test("finding a single value", () {
        expect(wrapper.singleWhere((i) => i == 3), completion(equals(3)));
      });

      test("finding no value", () {
        expect(wrapper.singleWhere((i) => i == 6), throwsStateError);
      });

      test("finding multiple values", () {
        expect(wrapper.singleWhere((i) => i.isOdd), throwsStateError);
      });
    });

    test("fold()", () {
      expect(wrapper.fold("foo", (previous, i) => previous + i.toString()),
          completion(equals("foo12345")));
    });

    test("forEach()", () async {
      emptyWrapper.forEach(expectAsync1((_) {}, count: 0));

      var results = [];
      await wrapper.forEach(results.add);
      expect(results, equals([1, 2, 3, 4, 5]));
    });

    group("handleError()", () {
      test("without a test", () {
        expect(
            errorWrapper.handleError(expectAsync1((error) {
              expect(error, equals("oh no"));
            })).toList(),
            completion(isEmpty));
      });

      test("with a matching test", () {
        expect(
            errorWrapper.handleError(expectAsync1((error) {
              expect(error, equals("oh no"));
            }), test: expectAsync1((error) {
              expect(error, equals("oh no"));
              return true;
            })).toList(),
            completion(isEmpty));
      });

      test("with a matching test", () {
        expect(
            errorWrapper.handleError(expectAsync1((_) {}, count: 0),
                test: expectAsync1((error) {
              expect(error, equals("oh no"));
              return false;
            })).toList(),
            throwsA("oh no"));
      });
    });

    group("listen()", () {
      test("with a callback", () {
        var subscription;
        subscription = wrapper.listen(expectAsync1((data) {
          expect(data, equals(1));

          subscription.onData(expectAsync1((data) {
            expect(data, equals(2));
            subscription.cancel();
          }));
        }));
      });

      test("with a null callback", () {
        expect(wrapper.listen(null).asFuture(), completes);
      });
    });

    test("map()", () {
      expect(wrapper.map((i) => i * 2).toList(),
          completion(equals([2, 4, 6, 8, 10])));
    });

    test("pipe()", () {
      var consumer = new StreamController();
      expect(wrapper.pipe(consumer), completes);
      expect(consumer.stream.toList(), completion(equals([1, 2, 3, 4, 5])));
    });

    test("reduce()", () {
      expect(wrapper.reduce((value, i) => value + i), completion(equals(15)));
      expect(emptyWrapper.reduce((value, i) => value + i), throwsStateError);
    });

    test("skipWhile()", () {
      expect(wrapper.skipWhile((i) => i < 3).toList(),
          completion(equals([3, 4, 5])));
    });

    test("takeWhile()", () {
      expect(
          wrapper.takeWhile((i) => i < 3).toList(), completion(equals([1, 2])));
    });

    test("toSet()", () {
      expect(wrapper.toSet(), completion(unorderedEquals([1, 2, 3, 4, 5])));
      expect(
          new TypeSafeStream<int>(
              new Stream<Object>.fromIterable([1, 1, 2, 2, 3, 3])).toSet(),
          completion(unorderedEquals([1, 2, 3])));
    });

    test("transform()", () {
      var transformer = new StreamTransformer<int, String>.fromHandlers(
          handleData: (data, sink) {
        sink.add(data.toString());
      });

      expect(wrapper.transform(transformer).toList(),
          completion(equals(["1", "2", "3", "4", "5"])));
    });

    test("where()", () {
      expect(wrapper.where((i) => i.isOdd).toList(),
          completion(equals([1, 3, 5])));
    });

    group("any()", () {
      test("with matches", () {
        expect(wrapper.any((i) => i > 3), completion(isTrue));
      });

      test("without matches", () {
        expect(wrapper.any((i) => i > 5), completion(isFalse));
      });
    });

    group("every()", () {
      test("with all matches", () {
        expect(wrapper.every((i) => i < 6), completion(isTrue));
      });

      test("with some non-matches", () {
        expect(wrapper.every((i) => i > 3), completion(isFalse));
      });
    });

    group("skip()", () {
      test("with a valid index", () {
        expect(wrapper.skip(3).toList(), completion(equals([4, 5])));
      });

      test("with a longer index than length", () {
        expect(wrapper.skip(6).toList(), completion(isEmpty));
      });

      test("with a negative index", () {
        expect(() => wrapper.skip(-1), throwsArgumentError);
      });
    });

    group("take()", () {
      test("with a valid index", () {
        expect(wrapper.take(3).toList(), completion(equals([1, 2, 3])));
      });

      test("with a longer index than length", () {
        expect(wrapper.take(6).toList(), completion(equals([1, 2, 3, 4, 5])));
      });

      test("with a negative index", () {
        expect(wrapper.take(-1).toList(), completion(isEmpty));
      });
    });

    group("elementAt()", () {
      test("with a valid index", () {
        expect(wrapper.elementAt(3), completion(equals(4)));
      });

      test("with too high an index", () {
        expect(wrapper.elementAt(6), throwsRangeError);
      });

      test("with a negative index", () {
        expect(wrapper.elementAt(-1), throwsArgumentError);
      });
    });

    group("contains()", () {
      test("with an element", () {
        expect(wrapper.contains(2), completion(isTrue));
      });

      test("with a non-element", () {
        expect(wrapper.contains(6), completion(isFalse));
      });

      test("with a non-element of a different type", () {
        expect(wrapper.contains("foo"), completion(isFalse));
      });
    });

    group("join()", () {
      test("without a separator", () {
        expect(wrapper.join(), completion(equals("12345")));
      });

      test("with a separator", () {
        expect(wrapper.join(" "), completion(equals("1 2 3 4 5")));
      });
    });

    test("toString()", () {
      expect(wrapper.toString(), contains("Stream"));
    });
  });

  group("with invalid types", () {
    var wrapper;
    var singleWrapper;
    setUp(() {
      wrapper = new TypeSafeStream<int>(
          new Stream<Object>.fromIterable(["foo", "bar", "baz"]));
      singleWrapper =
          new TypeSafeStream<int>(new Stream<Object>.fromIterable(["foo"]));
    });

    group("throws a CastError for", () {
      test("first", () {
        expect(wrapper.first, throwsCastError);
      });

      test("last", () {
        expect(wrapper.last, throwsCastError);
      });

      test("single", () {
        expect(singleWrapper.single, throwsCastError);
      });

      test("asBroadcastStream()", () {
        var broadcast = wrapper.asBroadcastStream();
        expect(broadcast.first, throwsCastError);
      });

      test("asyncExpand()", () {
        expect(wrapper.asyncExpand(expectAsync1((_) {}, count: 0)).first,
            throwsCastError);
      });

      test("asyncMap()", () {
        expect(wrapper.asyncMap(expectAsync1((_) {}, count: 0)).first,
            throwsCastError);
      });

      group("distinct()", () {
        test("without equals", () {
          expect(wrapper.distinct().first, throwsCastError);
        });

        test("with equals", () {
          expect(wrapper.distinct(expectAsync2((_, __) {}, count: 0)).first,
              throwsCastError);
        });
      });

      test("expand()", () {
        expect(wrapper.expand(expectAsync1((_) {}, count: 0)).first,
            throwsCastError);
      });

      test("firstWhere()", () {
        expect(wrapper.firstWhere(expectAsync1((_) {}, count: 0)),
            throwsCastError);
      });

      test("lastWhere()", () {
        expect(
            wrapper.lastWhere(expectAsync1((_) {}, count: 0)), throwsCastError);
      });

      test("singleWhere()", () {
        expect(wrapper.singleWhere(expectAsync1((_) {}, count: 0)),
            throwsCastError);
      });

      test("fold()", () {
        expect(wrapper.fold("foo", expectAsync2((_, __) {}, count: 0)),
            throwsCastError);
      });

      test("forEach()", () async {
        expect(
            wrapper.forEach(expectAsync1((_) {}, count: 0)), throwsCastError);
      });

      test("handleError()", () {
        expect(wrapper.handleError(expectAsync1((_) {}, count: 0)).first,
            throwsCastError);
      });

      test("listen()", () {
        expect(() => wrapper.take(1).listen(expectAsync1((_) {}, count: 0)),
            throwsZonedCastError);
      });

      test("map()", () {
        expect(
            wrapper.map(expectAsync1((_) {}, count: 0)).first, throwsCastError);
      });

      test("reduce()", () {
        expect(wrapper.reduce(expectAsync2((_, __) {}, count: 0)),
            throwsCastError);
      });

      test("skipWhile()", () {
        expect(wrapper.skipWhile(expectAsync1((_) {}, count: 0)).first,
            throwsCastError);
      });

      test("takeWhile()", () {
        expect(wrapper.takeWhile(expectAsync1((_) {}, count: 0)).first,
            throwsCastError);
      });

      test("toList()", () async {
        var list = await wrapper.toList();
        expect(() => list.first, throwsCastError);
      }, skip: "Re-enable this when test can run DDC (test#414).");

      test("toSet()", () async {
        var asSet = await wrapper.toSet();
        expect(() => asSet.first, throwsCastError);
      }, skip: "Re-enable this when test can run DDC (test#414).");

      test("where()", () {
        expect(wrapper.where(expectAsync1((_) {}, count: 0)).first,
            throwsCastError);
      });

      test("any()", () {
        expect(wrapper.any(expectAsync1((_) {}, count: 0)), throwsCastError);
      });

      test("every()", () {
        expect(wrapper.every(expectAsync1((_) {}, count: 0)), throwsCastError);
      });

      test("skip()", () {
        expect(wrapper.skip(1).first, throwsCastError);
      });

      test("take()", () {
        expect(wrapper.take(1).first, throwsCastError);
      });

      test("elementAt()", () {
        expect(wrapper.elementAt(1), throwsCastError);
      });
    });

    group("doesn't throw a CastError for", () {
      test("single", () {
        expect(wrapper.single, throwsStateError);
      });

      test("length", () {
        expect(wrapper.length, completion(equals(3)));
      });

      test("isBroadcast", () {
        expect(wrapper.isBroadcast, isFalse);
      });

      test("isEmpty", () {
        expect(wrapper.isEmpty, completion(isFalse));
      });

      group("drain()", () {
        test("without a value", () {
          expect(wrapper.drain(), completes);
          expect(() => wrapper.drain(), throwsStateError);
        });

        test("with a value", () {
          expect(wrapper.drain(12), completion(equals(12)));
        });
      });

      test("skip()", () {
        expect(() => wrapper.skip(-1), throwsArgumentError);
      });

      group("elementAt()", () {
        test("with too high an index", () {
          expect(wrapper.elementAt(6), throwsRangeError);
        });

        test("with a negative index", () {
          expect(wrapper.elementAt(-1), throwsArgumentError);
        });
      });

      group("contains()", () {
        test("with an element", () {
          expect(wrapper.contains("foo"), completion(isTrue));
        });

        test("with a non-element", () {
          expect(wrapper.contains("qux"), completion(isFalse));
        });

        test("with a non-element of a different type", () {
          expect(wrapper.contains(1), completion(isFalse));
        });
      });

      group("join()", () {
        test("without a separator", () {
          expect(wrapper.join(), completion(equals("foobarbaz")));
        });

        test("with a separator", () {
          expect(wrapper.join(" "), completion(equals("foo bar baz")));
        });
      });

      test("toString()", () {
        expect(wrapper.toString(), contains("Stream"));
      });
    });
  });
}
