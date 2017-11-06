// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:collection/collection.dart';

import '../utils.dart';
import 'stream_subscription.dart';
import '../delegate/event_sink.dart';

class TypeSafeStream<T> extends Stream<T> {
  final Stream _stream;

  Future<T> get first async => (await _stream.first) as T;
  Future<T> get last async => (await _stream.last) as T;
  Future<T> get single async => (await _stream.single) as T;

  bool get isBroadcast => _stream.isBroadcast;
  Future<bool> get isEmpty => _stream.isEmpty;
  Future<int> get length => _stream.length;

  TypeSafeStream(this._stream);

  Stream<T> asBroadcastStream(
      {void onListen(StreamSubscription<T> subscription),
      void onCancel(StreamSubscription<T> subscription)}) {
    return new TypeSafeStream<T>(_stream.asBroadcastStream(
        onListen: onListen == null
            ? null
            : (subscription) =>
                onListen(new TypeSafeStreamSubscription<T>(subscription)),
        onCancel: onCancel == null
            ? null
            : (subscription) =>
                onCancel(new TypeSafeStreamSubscription<T>(subscription))));
  }

  Stream<E> asyncExpand<E>(Stream<E> convert(T event)) =>
      _stream.asyncExpand(_validateType(convert));

  Stream<E> asyncMap<E>(convert(T event)) =>
      _stream.asyncMap(_validateType(convert));

  Stream<T> distinct([bool equals(T previous, T next)]) =>
      new TypeSafeStream<T>(_stream.distinct(equals == null
          ? null
          : (previous, next) => equals(previous as T, next as T)));

  Future<E> drain<E>([E futureValue]) => _stream.drain(futureValue);

  Stream<S> expand<S>(Iterable<S> convert(T value)) =>
      _stream.expand(_validateType(convert));

  Future firstWhere(bool test(T element), {Object defaultValue()}) =>
      _stream.firstWhere(_validateType(test), defaultValue: defaultValue);

  Future lastWhere(bool test(T element), {Object defaultValue()}) =>
      _stream.lastWhere(_validateType(test), defaultValue: defaultValue);

  Future<T> singleWhere(bool test(T element)) async =>
      (await _stream.singleWhere(_validateType(test))) as T;

  Future<S> fold<S>(S initialValue, S combine(S previous, T element)) =>
      _stream.fold(
          initialValue, (previous, element) => combine(previous, element as T));

  Future forEach(void action(T element)) =>
      _stream.forEach(_validateType(action));

  Stream<T> handleError(Function onError, {bool test(error)}) =>
      new TypeSafeStream<T>(_stream.handleError(onError, test: test));

  StreamSubscription<T> listen(void onData(T value),
          {Function onError, void onDone(), bool cancelOnError}) =>
      new TypeSafeStreamSubscription<T>(_stream.listen(_validateType(onData),
          onError: onError, onDone: onDone, cancelOnError: cancelOnError));

  Stream<S> map<S>(S convert(T event)) => _stream.map(_validateType(convert));

  // Don't forward to `_stream.pipe` because we want the consumer to see the
  // type-asserted stream.
  Future pipe(StreamConsumer<T> consumer) =>
      consumer.addStream(this).then((_) => consumer.close());

  Future<T> reduce(T combine(T previous, T element)) async {
    var result = await _stream
        .reduce((previous, element) => combine(previous as T, element as T));
    return result as T;
  }

  Stream<T> skipWhile(bool test(T element)) =>
      new TypeSafeStream<T>(_stream.skipWhile(_validateType(test)));

  Stream<T> takeWhile(bool test(T element)) =>
      new TypeSafeStream<T>(_stream.takeWhile(_validateType(test)));

  Stream<T> timeout(Duration timeLimit, {void onTimeout(EventSink<T> sink)}) =>
      new TypeSafeStream<T>(_stream.timeout(timeLimit,
          onTimeout: (sink) => onTimeout(DelegatingEventSink.typed(sink))));

  Future<List<T>> toList() async =>
      DelegatingList.typed<T>(await _stream.toList());

  Future<Set<T>> toSet() async => DelegatingSet.typed<T>(await _stream.toSet());

  // Don't forward to `_stream.transform` because we want the transformer to see
  // the type-asserted stream.
  Stream<S> transform<S>(StreamTransformer<T, S> transformer) =>
      transformer.bind(this);

  Stream<T> where(bool test(T element)) =>
      new TypeSafeStream<T>(_stream.where(_validateType(test)));

  Future<bool> every(bool test(T element)) =>
      _stream.every(_validateType(test));

  Future<bool> any(bool test(T element)) => _stream.any(_validateType(test));
  Stream<T> skip(int count) => new TypeSafeStream<T>(_stream.skip(count));
  Stream<T> take(int count) => new TypeSafeStream<T>(_stream.take(count));
  Future<T> elementAt(int index) async => (await _stream.elementAt(index)) as T;
  Future<bool> contains(Object needle) => _stream.contains(needle);
  Future<String> join([String separator = ""]) => _stream.join(separator);
  String toString() => _stream.toString();

  /// Returns a version of [function] that asserts that its argument is an
  /// instance of `T`.
  UnaryFunction<dynamic, S> _validateType<S>(S function(T value)) =>
      function == null ? null : (value) => function(value as T);
}
