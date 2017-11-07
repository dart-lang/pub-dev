// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async";
import "dart:typed_data";
import "cancelable_operation.dart";

/// Collects an asynchronous sequence of byte lists into a single list of bytes.
///
/// If the [source] stream emits an error event,
/// the collection fails and the returned future completes with the same error.
///
/// If any of the input data are not valid bytes, they will be truncated to
/// an eight-bit unsigned value in the resulting list.
Future<Uint8List> collectBytes(Stream<List<int>> source) {
  return _collectBytes(source, (_, result) => result);
}

/// Collects an asynchronous sequence of byte lists into a single list of bytes.
///
/// Returns a [CancelableOperation] that provides the result future and a way
/// to cancel the collection early.
///
/// If the [source] stream emits an error event,
/// the collection fails and the returned future completes with the same error.
///
/// If any of the input data are not valid bytes, they will be truncated to
/// an eight-bit unsigned value in the resulting list.
CancelableOperation<Uint8List> collectBytesCancelable(
    Stream<List<int>> source) {
  return _collectBytes(
      source,
      (subscription, result) => new CancelableOperation.fromFuture(result,
          onCancel: subscription.cancel));
}

/// Generalization over [collectBytes] and [collectBytesCancelable].
///
/// Performs all the same operations, but the final result is created
/// by the [result] function, which has access to the stream subscription
/// so it can cancel the operation.
T _collectBytes<T>(
    Stream<List<int>> source,
    T result(
        StreamSubscription<List<int>> subscription, Future<Uint8List> result)) {
  var byteLists = <List<int>>[];
  var length = 0;
  var completer = new Completer<Uint8List>.sync();
  var subscription = source.listen(
      (bytes) {
        byteLists.add(bytes);
        length += bytes.length;
      },
      onError: completer.completeError,
      onDone: () {
        completer.complete(_collect(length, byteLists));
      },
      cancelOnError: true);
  return result(subscription, completer.future);
}

// Join a lists of bytes with a known total length into a single [Uint8List].
Uint8List _collect(int length, List<List<int>> byteLists) {
  var result = new Uint8List(length);
  int i = 0;
  for (var byteList in byteLists) {
    var end = i + byteList.length;
    result.setRange(i, end, byteList);
    i = end;
  }
  return result;
}
