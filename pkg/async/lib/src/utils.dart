// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// A generic typedef for a function that takes one type and returns another.
typedef F UnaryFunction<E, F>(E argument);

/// A typedef for a function that takes no arguments and returns a Future or a
/// value.
typedef FutureOr<T> FutureOrCallback<T>();
