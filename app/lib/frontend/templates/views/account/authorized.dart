// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

final authorizedNode = d.fragment([
  d.h1(text: 'Pub Authorized Successfully'),
  d.p(
    children: [
      d.text('The '),
      d.code(text: 'pub'),
      d.text(
        ' client has been successfully authorized. '
        'You may now use it to upload packages and perform other tasks.',
      ),
    ],
  ),
]);
