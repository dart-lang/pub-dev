// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'chain.dart';
import 'frame.dart';
import 'lazy_trace.dart';
import 'trace.dart';

/// A thunk for lazily constructing a [Chain].
typedef Chain ChainThunk();

/// A wrapper around a [ChainThunk]. This works around issue 9579 by avoiding
/// the conversion of native [StackTrace]s to strings until it's absolutely
/// necessary.
class LazyChain implements Chain {
  final ChainThunk _thunk;
  Chain _inner;

  LazyChain(this._thunk);

  Chain get _chain {
    if (_inner == null) _inner = _thunk();
    return _inner;
  }

  List<Trace> get traces => _chain.traces;
  Chain get terse => _chain.terse;
  Chain foldFrames(bool predicate(Frame frame), {bool terse: false}) =>
      new LazyChain(() => _chain.foldFrames(predicate, terse: terse));
  Trace toTrace() => new LazyTrace(() => _chain.toTrace());
  String toString() => _chain.toString();
}
