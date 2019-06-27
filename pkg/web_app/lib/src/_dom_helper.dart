// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

/// Creates a DOM Element.
Element elem(
  String tag, {
  String id,
  Map<String, String> attrs,
  Iterable<String> classes,
  String text,
  List<Element> children,
  dynamic Function(MouseEvent event) onClick,
}) {
  final elem = Element.tag(tag);
  if (id != null) {
    elem.id = id;
  }
  if (attrs != null) {
    elem.attributes.addAll(attrs);
  }
  if (classes != null) {
    elem.classes.addAll(classes);
  }
  if (text != null) {
    elem.text = text;
  }
  children?.forEach(elem.append);
  if (onClick != null) {
    elem.onClick.listen(onClick);
  }
  return elem;
}

/// Show/hide an element.
void updateDisplay(Element elem, bool show) {
  elem.style.display = show ? null : 'none';
}
