// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:web/web.dart';

import '../../web_util.dart';

/// Reflects the `data-indeterminate` attribute of `.pub-checkbox-input`
/// elements onto the native `indeterminate` property, as the indeterminate
/// state of a checkbox cannot be expressed through HTML markup alone.
void setupCheckboxes() {
  final inputs = document
      .querySelectorAll('.pub-checkbox-input')
      .toElementList<HTMLInputElement>();
  for (final input in inputs) {
    input.indeterminate = input.getAttribute('data-indeterminate') == 'true';
  }
}
