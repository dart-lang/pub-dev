// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'result/capture_transformer.dart';
import 'result/error.dart';
import 'result/release_transformer.dart';
import 'result/value.dart';
import 'stream_sink_transformer.dart';

/// The result of a computation.
///
/// Capturing a result (either a returned value or a thrown error) means
/// converting it into a [Result] - either a [ValueResult] or an [ErrorResult].
///
/// This value can release itself by writing itself either to a [EventSink] or a
/// [Completer], or by becoming a [Future].
abstract class Result<T> {
  /// A stream transformer that captures a stream of events into [Result]s.
  ///
  /// The result of the transformation is a stream of [Result] values and no
  /// error events. This is the transformer used by [captureStream].
  static const StreamTransformer<Object, Result> captureStreamTransformer =
      const CaptureStreamTransformer();

  /// A stream transformer that releases a stream of result events.
  ///
  /// The result of the transformation is a stream of values and error events.
  /// This is the transformer used by [releaseStream].
  static const StreamTransformer<Object, Result> releaseStreamTransformer =
      const ReleaseStreamTransformer();

  /// A sink transformer that captures events into [Result]s.
  ///
  /// The result of the transformation is a sink that only forwards [Result]
  /// values and no error events.
  static const StreamSinkTransformer<Object, Result> captureSinkTransformer =
      const StreamSinkTransformer.fromStreamTransformer(
          const CaptureStreamTransformer());

  /// A sink transformer that releases result events.
  ///
  /// The result of the transformation is a sink that forwards of values and
  /// error events.
  static const StreamSinkTransformer<Object, Result> releaseSinkTransformer =
      const StreamSinkTransformer.fromStreamTransformer(
          const ReleaseStreamTransformer());

  /// Create a `Result` with the result of calling [computation].
  ///
  /// This generates either a [ValueResult] with the value returned by
  /// calling `computation`, or an [ErrorResult] with an error thrown by
  /// the call.
  factory Result(T computation()) {
    try {
      return new ValueResult(computation());
    } catch (e, s) {
      return new ErrorResult(e, s);
    }
  }

  /// Create a `Result` holding a value.
  ///
  /// Alias for [ValueResult.ValueResult].
  factory Result.value(T value) = ValueResult<T>;

  /// Create a `Result` holding an error.
  ///
  /// Alias for [ErrorResult.ErrorResult].
  factory Result.error(Object error, [StackTrace stackTrace]) =>
      new ErrorResult(error, stackTrace);

  /// Capture the result of a future into a `Result` future.
  ///
  /// The resulting future will never have an error.
  /// Errors have been converted to an [ErrorResult] value.
  static Future<Result<T>> capture<T>(Future<T> future) {
    return future.then((value) => new ValueResult(value),
        onError: (error, stackTrace) => new ErrorResult<T>(error, stackTrace));
  }

  /// Release the result of a captured future.
  ///
  /// Converts the [Result] value of the given [future] to a value or error
  /// completion of the returned future.
  ///
  /// If [future] completes with an error, the returned future completes with
  /// the same error.
  static Future<T> release<T>(Future<Result<T>> future) =>
      future.then<T>((result) => result.asFuture);

  /// Capture the results of a stream into a stream of [Result] values.
  ///
  /// The returned stream will not have any error events.
  /// Errors from the source stream have been converted to [ErrorResult]s.
  static Stream<Result<T>> captureStream<T>(Stream<T> source) =>
      source.transform(new CaptureStreamTransformer<T>());

  /// Release a stream of [result] values into a stream of the results.
  ///
  /// `Result` values of the source stream become value or error events in
  /// the returned stream as appropriate.
  /// Errors from the source stream become errors in the returned stream.
  static Stream<T> releaseStream<T>(Stream<Result<T>> source) =>
      source.transform(new ReleaseStreamTransformer<T>());

  /// Converts a result of a result to a single result.
  ///
  /// If the result is an error, or it is a `Result` value
  /// which is then an error, then a result with that error is returned.
  /// Otherwise both levels of results are value results, and a single
  /// result with the value is returned.
  static Result<T> flatten<T>(Result<Result<T>> result) {
    if (result.isValue) return result.asValue.value;
    return new ErrorResult<T>(result.asError.error, result.asError.stackTrace);
  }

  /// Whether this result is a value result.
  ///
  /// Always the opposite of [isError].
  bool get isValue;

  /// Whether this result is an error result.
  ///
  /// Always the opposite of [isValue].
  bool get isError;

  /// If this is a value result, return itself.
  ///
  /// Otherwise return `null`.
  ValueResult<T> get asValue;

  /// If this is an error result, return itself.
  ///
  /// Otherwise return `null`.
  ErrorResult<T> get asError;

  /// Complete a completer with this result.
  void complete(Completer<T> completer);

  /// Add this result to an [EventSink].
  ///
  /// Calls the sink's `add` or `addError` method as appropriate.
  void addTo(EventSink<T> sink);

  /// Creates a future completed with this result as a value or an error.
  Future<T> get asFuture;
}
