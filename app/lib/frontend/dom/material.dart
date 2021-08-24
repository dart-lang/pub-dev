// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dom.dart' as d;

/// Renders a material button element.
d.Node button({
  String? id,
  Iterable<String>? classes,
  bool? raised,
  String? text,
}) {
  return d.element(
    'button',
    id: id,
    classes: [
      'mdc-button',
      if (raised ?? false) 'mdc-button--raised',
      if (classes != null) ...classes,
    ],
    attributes: {'data-mdc-auto-init': 'MDCRipple'},
    text: text,
  );
}

/// Renders a material raised button.
d.Node raisedButton({
  String? id,
  Iterable<String>? classes,
  String? text,
}) {
  return button(
    id: id,
    classes: classes,
    raised: true,
    text: text,
  );
}
