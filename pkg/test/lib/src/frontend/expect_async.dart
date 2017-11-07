// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../backend/invoker.dart';
import 'expect.dart';

/// An object used to detect unpassed arguments.
const _PLACEHOLDER = const Object();

// Function types returned by expectAsync# methods.

typedef T Func0<T>();
typedef T Func1<T, A>([A a]);
typedef T Func2<T, A, B>([A a, B b]);
typedef T Func3<T, A, B, C>([A a, B b, C c]);
typedef T Func4<T, A, B, C, D>([A a, B b, C c, D d]);
typedef T Func5<T, A, B, C, D, E>([A a, B b, C c, D d, E e]);
typedef T Func6<T, A, B, C, D, E, F>([A a, B b, C c, D d, E e, F f]);

// Functions used to check how many arguments a callback takes. We can't use the
// previous functions for this, because (a) {} is not a subtype of
// ([dynamic]) -> dynamic.

typedef _Func0();
typedef _Func1(Null a);
typedef _Func2(Null a, Null b);
typedef _Func3(Null a, Null b, Null c);
typedef _Func4(Null a, Null b, Null c, Null d);
typedef _Func5(Null a, Null b, Null c, Null d, Null e);
typedef _Func6(Null a, Null b, Null c, Null d, Null e, Null f);

typedef bool _IsDoneCallback();

/// A wrapper for a function that ensures that it's called the appropriate
/// number of times.
///
/// The containing test won't be considered to have completed successfully until
/// this function has been called the appropriate number of times.
///
/// The wrapper function is accessible via [func]. It supports up to six
/// optional and/or required positional arguments, but no named arguments.
class _ExpectedFunction<T> {
  /// The wrapped callback.
  final Function _callback;

  /// The minimum number of calls that are expected to be made to the function.
  ///
  /// If fewer calls than this are made, the test will fail.
  final int _minExpectedCalls;

  /// The maximum number of calls that are expected to be made to the function.
  ///
  /// If more calls than this are made, the test will fail.
  final int _maxExpectedCalls;

  /// A callback that should return whether the function is not expected to have
  /// any more calls.
  ///
  /// This will be called after every time the function is run. The test case
  /// won't be allowed to terminate until it returns `true`.
  ///
  /// This may be `null`. If so, the function is considered to be done after
  /// it's been run once.
  final _IsDoneCallback _isDone;

  /// A descriptive name for the function.
  final String _id;

  /// An optional description of why the function is expected to be called.
  ///
  /// If not passed, this will be an empty string.
  final String _reason;

  /// The number of times the function has been called.
  int _actualCalls = 0;

  /// The test invoker in which this function was wrapped.
  Invoker get _invoker => _zone[#test.invoker];

  /// The zone in which this function was wrapped.
  final Zone _zone;

  /// Whether this function has been called the requisite number of times.
  bool _complete;

  /// Wraps [callback] in a function that asserts that it's called at least
  /// [minExpected] times and no more than [maxExpected] times.
  ///
  /// If passed, [id] is used as a descriptive name fo the function and [reason]
  /// as a reason it's expected to be called. If [isDone] is passed, the test
  /// won't be allowed to complete until it returns `true`.
  _ExpectedFunction(Function callback, int minExpected, int maxExpected,
      {String id, String reason, bool isDone()})
      : this._callback = callback,
        _minExpectedCalls = minExpected,
        _maxExpectedCalls =
            (maxExpected == 0 && minExpected > 0) ? minExpected : maxExpected,
        this._isDone = isDone,
        this._reason = reason == null ? '' : '\n$reason',
        this._zone = Zone.current,
        this._id = _makeCallbackId(id, callback) {
    if (_invoker == null) {
      throw new StateError("[expectAsync] was called outside of a test.");
    } else if (maxExpected > 0 && minExpected > maxExpected) {
      throw new ArgumentError("max ($maxExpected) may not be less than count "
          "($minExpected).");
    }

    if (isDone != null || minExpected > 0) {
      _invoker.addOutstandingCallback();
      _complete = false;
    } else {
      _complete = true;
    }
  }

  /// Tries to find a reasonable name for [callback].
  ///
  /// If [id] is passed, uses that. Otherwise, tries to determine a name from
  /// calling `toString`. If no name can be found, returns the empty string.
  static String _makeCallbackId(String id, Function callback) {
    if (id != null) return "$id ";

    // If the callback is not an anonymous closure, try to get the
    // name.
    var toString = callback.toString();
    var prefix = "Function '";
    var start = toString.indexOf(prefix);
    if (start == -1) return '';

    start += prefix.length;
    var end = toString.indexOf("'", start);
    if (end == -1) return '';
    return "${toString.substring(start, end)} ";
  }

  /// Returns a function that has the same number of positional arguments as the
  /// wrapped function (up to a total of 6).
  Function get func {
    if (_callback is _Func6) return max6;
    if (_callback is _Func5) return max5;
    if (_callback is _Func4) return max4;
    if (_callback is _Func3) return max3;
    if (_callback is _Func2) return max2;
    if (_callback is _Func1) return max1;
    if (_callback is _Func0) return max0;

    _invoker.removeOutstandingCallback();
    throw new ArgumentError(
        'The wrapped function has more than 6 required arguments');
  }

  // This indirection is critical. It ensures the returned function has an
  // argument count of zero.
  T max0() => max6();

  T max1([Object a0 = _PLACEHOLDER]) => max6(a0);

  T max2([Object a0 = _PLACEHOLDER, Object a1 = _PLACEHOLDER]) => max6(a0, a1);

  T max3(
          [Object a0 = _PLACEHOLDER,
          Object a1 = _PLACEHOLDER,
          Object a2 = _PLACEHOLDER]) =>
      max6(a0, a1, a2);

  T max4(
          [Object a0 = _PLACEHOLDER,
          Object a1 = _PLACEHOLDER,
          Object a2 = _PLACEHOLDER,
          Object a3 = _PLACEHOLDER]) =>
      max6(a0, a1, a2, a3);

  T max5(
          [Object a0 = _PLACEHOLDER,
          Object a1 = _PLACEHOLDER,
          Object a2 = _PLACEHOLDER,
          Object a3 = _PLACEHOLDER,
          Object a4 = _PLACEHOLDER]) =>
      max6(a0, a1, a2, a3, a4);

  T max6(
          [Object a0 = _PLACEHOLDER,
          Object a1 = _PLACEHOLDER,
          Object a2 = _PLACEHOLDER,
          Object a3 = _PLACEHOLDER,
          Object a4 = _PLACEHOLDER,
          Object a5 = _PLACEHOLDER]) =>
      _run([a0, a1, a2, a3, a4, a5].where((a) => a != _PLACEHOLDER));

  /// Runs the wrapped function with [args] and returns its return value.
  T _run(Iterable args) {
    // Note that in the old test, this returned `null` if it encountered an
    // error, where now it just re-throws that error because Zone machinery will
    // pass it to the invoker anyway.
    try {
      _actualCalls++;
      if (_invoker.liveTest.state.shouldBeDone) {
        throw 'Callback ${_id}called ($_actualCalls) after test case '
            '${_invoker.liveTest.test.name} had already completed.$_reason';
      } else if (_maxExpectedCalls >= 0 && _actualCalls > _maxExpectedCalls) {
        throw new TestFailure('Callback ${_id}called more times than expected '
            '($_maxExpectedCalls).$_reason');
      }

      return Function.apply(_callback, args.toList()) as T;
    } catch (error, stackTrace) {
      _zone.handleUncaughtError(error, stackTrace);
      return null;
    } finally {
      _afterRun();
    }
  }

  /// After each time the function is run, check to see if it's complete.
  void _afterRun() {
    if (_complete) return;
    if (_minExpectedCalls > 0 && _actualCalls < _minExpectedCalls) return;
    if (_isDone != null && !_isDone()) return;

    // Mark this callback as complete and remove it from the test case's
    // oustanding callback count; if that hits zero the test is done.
    _complete = true;
    _invoker.removeOutstandingCallback();
  }
}

/// This function is deprecated because it doesn't work well with strong mode.
/// Use [expectAsync0], [expectAsync1],
/// [expectAsync2], [expectAsync3], [expectAsync4], [expectAsync5], or
/// [expectAsync6] instead.
@Deprecated("Will be removed in 0.13.0")
Function expectAsync(Function callback,
    {int count: 1, int max: 0, String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync() may only be called within a test.");
  }

  return new _ExpectedFunction(callback, count, max, id: id, reason: reason)
      .func;
}

/// Informs the framework that the given [callback] of arity 0 is expected to be
/// called [count] number of times (by default 1).
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// The test framework will wait for the callback to run the [count] times
/// before it considers the current test to be complete.
///
/// [max] can be used to specify an upper bound on the number of calls; if this
/// is exceeded the test will fail. If [max] is `0` (the default), the callback
/// is expected to be called exactly [count] times. If [max] is `-1`, the
/// callback is allowed to be called any number of times greater than [count].
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with zero arguments. See also
/// [expectAsync1], [expectAsync2], [expectAsync3], [expectAsync4],
/// [expectAsync5], and [expectAsync6] for callbacks with different arity.
Func0<T> expectAsync0<T>(T callback(),
    {int count: 1, int max: 0, String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync0() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, count, max, id: id, reason: reason)
      .max0;
}

/// Informs the framework that the given [callback] of arity 1 is expected to be
/// called [count] number of times (by default 1).
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// The test framework will wait for the callback to run the [count] times
/// before it considers the current test to be complete.
///
/// [max] can be used to specify an upper bound on the number of calls; if this
/// is exceeded the test will fail. If [max] is `0` (the default), the callback
/// is expected to be called exactly [count] times. If [max] is `-1`, the
/// callback is allowed to be called any number of times greater than [count].
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with one argument. See also
/// [expectAsync0], [expectAsync2], [expectAsync3], [expectAsync4],
/// [expectAsync5], and [expectAsync6] for callbacks with different arity.
Func1<T, A> expectAsync1<T, A>(T callback(A a),
    {int count: 1, int max: 0, String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync1() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, count, max, id: id, reason: reason)
      .max1;
}

/// Informs the framework that the given [callback] of arity 2 is expected to be
/// called [count] number of times (by default 1).
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// The test framework will wait for the callback to run the [count] times
/// before it considers the current test to be complete.
///
/// [max] can be used to specify an upper bound on the number of calls; if this
/// is exceeded the test will fail. If [max] is `0` (the default), the callback
/// is expected to be called exactly [count] times. If [max] is `-1`, the
/// callback is allowed to be called any number of times greater than [count].
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with two arguments. See also
/// [expectAsync0], [expectAsync1], [expectAsync3], [expectAsync4],
/// [expectAsync5], and [expectAsync6] for callbacks with different arity.
Func2<T, A, B> expectAsync2<T, A, B>(T callback(A a, B b),
    {int count: 1, int max: 0, String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync2() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, count, max, id: id, reason: reason)
      .max2;
}

/// Informs the framework that the given [callback] of arity 3 is expected to be
/// called [count] number of times (by default 1).
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// The test framework will wait for the callback to run the [count] times
/// before it considers the current test to be complete.
///
/// [max] can be used to specify an upper bound on the number of calls; if this
/// is exceeded the test will fail. If [max] is `0` (the default), the callback
/// is expected to be called exactly [count] times. If [max] is `-1`, the
/// callback is allowed to be called any number of times greater than [count].
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with three arguments. See also
/// [expectAsync0], [expectAsync1], [expectAsync2], [expectAsync4],
/// [expectAsync5], and [expectAsync6] for callbacks with different arity.
Func3<T, A, B, C> expectAsync3<T, A, B, C>(T callback(A a, B b, C c),
    {int count: 1, int max: 0, String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync3() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, count, max, id: id, reason: reason)
      .max3;
}

/// Informs the framework that the given [callback] of arity 4 is expected to be
/// called [count] number of times (by default 1).
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// The test framework will wait for the callback to run the [count] times
/// before it considers the current test to be complete.
///
/// [max] can be used to specify an upper bound on the number of calls; if this
/// is exceeded the test will fail. If [max] is `0` (the default), the callback
/// is expected to be called exactly [count] times. If [max] is `-1`, the
/// callback is allowed to be called any number of times greater than [count].
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with four arguments. See also
/// [expectAsync0], [expectAsync1], [expectAsync2], [expectAsync3],
/// [expectAsync5], and [expectAsync6] for callbacks with different arity.
Func4<T, A, B, C, D> expectAsync4<T, A, B, C, D>(T callback(A a, B b, C c, D d),
    {int count: 1, int max: 0, String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync4() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, count, max, id: id, reason: reason)
      .max4;
}

/// Informs the framework that the given [callback] of arity 5 is expected to be
/// called [count] number of times (by default 1).
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// The test framework will wait for the callback to run the [count] times
/// before it considers the current test to be complete.
///
/// [max] can be used to specify an upper bound on the number of calls; if this
/// is exceeded the test will fail. If [max] is `0` (the default), the callback
/// is expected to be called exactly [count] times. If [max] is `-1`, the
/// callback is allowed to be called any number of times greater than [count].
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with five arguments. See also
/// [expectAsync0], [expectAsync1], [expectAsync2], [expectAsync3],
/// [expectAsync4], and [expectAsync6] for callbacks with different arity.
Func5<T, A, B, C, D, E> expectAsync5<T, A, B, C, D, E>(
    T callback(A a, B b, C c, D d, E e),
    {int count: 1,
    int max: 0,
    String id,
    String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync5() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, count, max, id: id, reason: reason)
      .max5;
}

/// Informs the framework that the given [callback] of arity 6 is expected to be
/// called [count] number of times (by default 1).
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// The test framework will wait for the callback to run the [count] times
/// before it considers the current test to be complete.
///
/// [max] can be used to specify an upper bound on the number of calls; if this
/// is exceeded the test will fail. If [max] is `0` (the default), the callback
/// is expected to be called exactly [count] times. If [max] is `-1`, the
/// callback is allowed to be called any number of times greater than [count].
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with six arguments. See also
/// [expectAsync0], [expectAsync1], [expectAsync2], [expectAsync3],
/// [expectAsync4], and [expectAsync5] for callbacks with different arity.
Func6<T, A, B, C, D, E, F> expectAsync6<T, A, B, C, D, E, F>(
    T callback(A a, B b, C c, D d, E e, F f),
    {int count: 1,
    int max: 0,
    String id,
    String reason}) {
  if (Invoker.current == null) {
    throw new StateError("expectAsync6() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, count, max, id: id, reason: reason)
      .max6;
}

/// This function is deprecated because it doesn't work well with strong mode.
/// Use [expectAsyncUntil0], [expectAsyncUntil1],
/// [expectAsyncUntil2], [expectAsyncUntil3], [expectAsyncUntil4],
/// [expectAsyncUntil5], or [expectAsyncUntil6] instead.
@Deprecated("Will be removed in 0.13.0")
Function expectAsyncUntil(Function callback, bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil() may only be called within a test.");
  }

  return new _ExpectedFunction(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .func;
}

/// Informs the framework that the given [callback] of arity 0 is expected to be
/// called until [isDone] returns true.
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// [isDone] is called after each time the function is run. Only when it returns
/// true will the callback be considered complete.
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with zero arguments. See also
/// [expectAsyncUntil1], [expectAsyncUntil2], [expectAsyncUntil3],
/// [expectAsyncUntil4], [expectAsyncUntil5], and [expectAsyncUntil6] for
/// callbacks with different arity.
Func0<T> expectAsyncUntil0<T>(T callback(), bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil0() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .max0;
}

/// Informs the framework that the given [callback] of arity 1 is expected to be
/// called until [isDone] returns true.
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// [isDone] is called after each time the function is run. Only when it returns
/// true will the callback be considered complete.
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with one argument. See also
/// [expectAsyncUntil0], [expectAsyncUntil2], [expectAsyncUntil3],
/// [expectAsyncUntil4], [expectAsyncUntil5], and [expectAsyncUntil6] for
/// callbacks with different arity.
Func1<T, A> expectAsyncUntil1<T, A>(T callback(A a), bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil1() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .max1;
}

/// Informs the framework that the given [callback] of arity 2 is expected to be
/// called until [isDone] returns true.
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// [isDone] is called after each time the function is run. Only when it returns
/// true will the callback be considered complete.
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with two arguments. See also
/// [expectAsyncUntil0], [expectAsyncUntil1], [expectAsyncUntil3],
/// [expectAsyncUntil4], [expectAsyncUntil5], and [expectAsyncUntil6] for
/// callbacks with different arity.
Func2<T, A, B> expectAsyncUntil2<T, A, B>(T callback(A a, B b), bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil2() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .max2;
}

/// Informs the framework that the given [callback] of arity 3 is expected to be
/// called until [isDone] returns true.
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// [isDone] is called after each time the function is run. Only when it returns
/// true will the callback be considered complete.
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with three arguments. See also
/// [expectAsyncUntil0], [expectAsyncUntil1], [expectAsyncUntil2],
/// [expectAsyncUntil4], [expectAsyncUntil5], and [expectAsyncUntil6] for
/// callbacks with different arity.
Func3<T, A, B, C> expectAsyncUntil3<T, A, B, C>(
    T callback(A a, B b, C c), bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil3() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .max3;
}

/// Informs the framework that the given [callback] of arity 4 is expected to be
/// called until [isDone] returns true.
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// [isDone] is called after each time the function is run. Only when it returns
/// true will the callback be considered complete.
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with four arguments. See also
/// [expectAsyncUntil0], [expectAsyncUntil1], [expectAsyncUntil2],
/// [expectAsyncUntil3], [expectAsyncUntil5], and [expectAsyncUntil6] for
/// callbacks with different arity.
Func4<T, A, B, C, D> expectAsyncUntil4<T, A, B, C, D>(
    T callback(A a, B b, C c, D d), bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil4() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .max4;
}

/// Informs the framework that the given [callback] of arity 5 is expected to be
/// called until [isDone] returns true.
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// [isDone] is called after each time the function is run. Only when it returns
/// true will the callback be considered complete.
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with five arguments. See also
/// [expectAsyncUntil0], [expectAsyncUntil1], [expectAsyncUntil2],
/// [expectAsyncUntil3], [expectAsyncUntil4], and [expectAsyncUntil6] for
/// callbacks with different arity.
Func5<T, A, B, C, D, E> expectAsyncUntil5<T, A, B, C, D, E>(
    T callback(A a, B b, C c, D d, E e), bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil5() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .max5;
}

/// Informs the framework that the given [callback] of arity 6 is expected to be
/// called until [isDone] returns true.
///
/// Returns a wrapped function that should be used as a replacement of the
/// original callback.
///
/// [isDone] is called after each time the function is run. Only when it returns
/// true will the callback be considered complete.
///
/// Both [id] and [reason] are optional and provide extra information about the
/// callback when debugging. [id] should be the name of the callback, while
/// [reason] should be the reason the callback is expected to be called.
///
/// This method takes callbacks with six arguments. See also
/// [expectAsyncUntil0], [expectAsyncUntil1], [expectAsyncUntil2],
/// [expectAsyncUntil3], [expectAsyncUntil4], and [expectAsyncUntil5] for
/// callbacks with different arity.
Func6<T, A, B, C, D, E, F> expectAsyncUntil6<T, A, B, C, D, E, F>(
    T callback(A a, B b, C c, D d, E e, F f), bool isDone(),
    {String id, String reason}) {
  if (Invoker.current == null) {
    throw new StateError(
        "expectAsyncUntil() may only be called within a test.");
  }

  return new _ExpectedFunction<T>(callback, 0, -1,
          id: id, reason: reason, isDone: isDone)
      .max6;
}
