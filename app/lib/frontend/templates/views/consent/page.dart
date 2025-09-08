// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;

/// Render consent page content.
d.Node consentPageNode({required String title, required d.Node description}) {
  return d.fragment([
    d.h1(id: '-admin-consent-title', text: title),
    d.div(id: '-admin-consent-content', child: description),
    d.p(
      id: '-admin-consent-buttons',
      children: [
        material.raisedButton(
          id: '-admin-consent-reject-button',
          classes: ['pub-button-cancel'],
          label: 'Reject',
        ),
        material.raisedButton(
          id: '-admin-consent-accept-button',
          label: 'Accept',
        ),
      ],
    ),
  ]);
}
