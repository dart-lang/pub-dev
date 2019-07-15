// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

/// Show/hide an element.
void updateDisplay(Element elem, bool show, {String display}) {
  elem.style.display = show ? display : 'none';
}
