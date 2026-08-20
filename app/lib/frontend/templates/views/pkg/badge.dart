// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

d.Node packageBadgeNode({
  required String label,
  String? title,
  d.Image? icon,
  String? color,
}) {
  return d.span(
    classes: ['package-badge', if (color != null) 'package-badge-$color'],
    attributes: title != null ? <String, String>{'title': title} : null,
    children: [
      if (icon != null) d.img(classes: ['package-badge-icon'], image: icon),
      d.text(label),
    ],
  );
}

/// Renders a shield badge with the SLSA provenance level (e.g. SLSA 2).
d.Node slsaShieldBadgeNode(int level) {
  return d.span(
    classes: ['package-badge', 'package-badge-slsa'],
    attributes: {
      'title':
          'Package provenance is verified with SLSA Level $level attestation.',
    },
    children: [
      d.unsafeRawHtml(
        '<svg class="slsa-shield-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="14" height="14" style="vertical-align: -2px; margin-right: 4px;"><path d="M12 2L4 5v6.09c0 5.05 3.41 9.76 8 10.91 4.59-1.15 8-5.86 8-10.91V5l-8-3z" fill="#0175C2"/><text x="12" y="15.5" font-family="Roboto, sans-serif" font-size="11" font-weight="bold" text-anchor="middle" fill="#FFFFFF">$level</text></svg>',
      ),
      d.text('SLSA $level'),
    ],
  );
}
