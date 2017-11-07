// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../result.dart';
import 'error.dart';

/// A result representing a returned value.
class ValueResult<T> implements Result<T> {
  final T value;

  bool get isValue => true;
  bool get isError => false;
  ValueResult<T> get asValue => this;
  ErrorResult<T> get asError => null;

  ValueResult(this.value);

  void complete(Completer<T> completer) {
    completer.complete(value);
  }

  void addTo(EventSink<T> sink) {
    sink.add(value);
  }

  Future<T> get asFuture => new Future.value(value);
}
