// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dart_style.src.error_listener;

import 'package:analyzer/analyzer.dart';

import 'exceptions.dart';

/// A simple [AnalysisErrorListener] that just collects the reported errors.
class ErrorListener implements AnalysisErrorListener {
  final _errors = <AnalysisError>[];

  void onError(AnalysisError error) {
    _errors.add(error);
  }

  /// Throws a [FormatterException] if any errors have been reported.
  void throwIfErrors() {
    if (_errors.isEmpty) return;

    throw new FormatterException(_errors);
  }
}
