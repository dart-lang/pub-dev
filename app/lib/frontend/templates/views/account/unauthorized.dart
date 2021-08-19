// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

d.Node unauthorizedNode() {
  return d.fragment([
    d.h1(text: 'Authorization required'),
    d.p(text: 'You have insufficient permissions to view this page.'),
  ]);
}
