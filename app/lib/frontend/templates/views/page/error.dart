// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

d.Node errorPageNode({required String title, required d.Node content}) {
  return d.fragment([d.h2(text: title), content]);
}
