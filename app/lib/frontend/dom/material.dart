// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dom.dart' as d;

/// Renders a material button element.
d.Node button({
  String? id,
  String? customTypeClass,
  Iterable<String>? classes,
  bool raised = false,
  bool unelevated = false,
  Map<String, String>? attributes,
  String? iconUrl,
  required String label,
}) {
  final isSimpleLabel = iconUrl == null && customTypeClass == null;
  return d.element(
    'button',
    id: id,
    classes: [
      'mdc-button',
      if (raised) 'mdc-button--raised',
      if (unelevated) 'mdc-button--unelevated',
      if (customTypeClass != null) customTypeClass,
      if (classes != null) ...classes,
    ],
    attributes: {
      'data-mdc-auto-init': 'MDCRipple',
      if (attributes != null) ...attributes,
    },
    children: isSimpleLabel
        ? [d.text(label)]
        : [
            d.div(classes: ['mdc-button__ripple']),
            if (iconUrl != null)
              d.img(
                classes: [
                  'mdc-button__icon',
                  if (customTypeClass != null) '$customTypeClass-img',
                ],
                src: iconUrl,
                attributes: {'aria-hidden': 'true'},
              ),
            d.span(
              classes: [
                'mdc-button__label',
                if (customTypeClass != null) '$customTypeClass-label',
              ],
              text: label,
            ),
          ],
  );
}

/// Renders a material raised button.
d.Node raisedButton({
  String? id,
  Iterable<String>? classes,
  required String label,
}) {
  return button(
    id: id,
    classes: classes,
    raised: true,
    label: label,
  );
}
