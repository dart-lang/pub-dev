// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

final unauthenticatedNode = d.fragment([
  d.h1(text: 'Authentication required'),
  d.p(text: 'You need to be logged in to view this page.'),
  d.p(
    text:
        'You can sign in using your Google account '
        'by clicking on the top-right "Sign in" menu.',
  ),
  d.p(
    text:
        'If you have not signed in on pub.dev before, '
        'a pub.dev profile will be automatically created upon sign in.',
  ),
]);
