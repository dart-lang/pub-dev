// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

/// Show/hide an element.
void updateDisplay(Element elem, bool show, {String display}) {
  elem.style.display = show ? display : 'none';
}

/// Displays a message via the modal window.
Future modalMessage(String title, String messageHtml) async {
  await _modalWindow(title, messageHtml, false);
}

/// Ask [question] to user, return true if 'OK' was selected.
Future<bool> modalConfirm(String question) async {
  return await _modalWindow('Confirm', question, true);
}

/// Displays a modal window with "OK" and "Cancel" buttons. If [isQuestion] is
/// false, it will omit the "Cancel" button.
///
/// Returns true if "OK" was pressed, false otherwise.
Future<bool> _modalWindow(String title, String contentHtml, bool isQuestion) {
  final completer = Completer<bool>();
  final cancelButton = Element.tag('button')
    ..className = 'pub-button secondary'
    ..text = 'Cancel';
  final elem = Element.div()
    ..className = 'pub-modal'
    ..children = [
      Element.div()
        ..className = 'pub-modal-panel'
        ..children = [
          Element.tag('h2')..text = title,
          Element.div()
            ..className = 'pub-modal-content'
            ..innerHtml = contentHtml,
          Element.div()
            ..className = 'pub-modal-buttons'
            ..children = [
              if (isQuestion) cancelButton,
              Element.tag('button')
                ..className = 'pub-button'
                ..text = 'OK'
                ..onClick.listen((e) {
                  completer.complete(true);
                  e.stopPropagation();
                }),
            ]
        ],
    ];
  elem.onClick.listen((_) {
    if (!completer.isCompleted) {
      completer.complete(false);
    }
  });
  document.body.append(elem);
  completer.future.then((_) {
    elem.remove();
  });
  return completer.future;
}
