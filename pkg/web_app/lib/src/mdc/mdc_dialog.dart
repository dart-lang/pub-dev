// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS('mdc.dialog')
library;

// TODO: migrate to package:web
// ignore: deprecated_member_use
import 'dart:html';
import 'dart:js_interop';

@JS('MDCDialog')
extension type MdcDialog(JSObject _) implements JSObject {
  @JS('attachTo')
  external static MdcDialog attachTo(Element root);
  external void open();
  external void listen(String type, JSFunction handler);
  external void close([String? action]);
  external void destroy();

  void listenOnClose(void Function() fn) {
    listen(
      'MDCDialog:closed',
      (Event event) {
        fn();
      }.toJS,
    );
  }
}
