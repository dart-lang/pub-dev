// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'package:mdc_web/mdc_web.dart' show MDCDialog;

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
Future<bool> _modalWindow(
  String titleText,
  String contentHtml,
  bool isQuestion,
) async {
  final c = Completer<bool>();
  final root = _buildDialog(titleText, contentHtml, isQuestion, c.complete);
  document.body.append(root);
  final dialog = MDCDialog(root);
  try {
    dialog.open();
    dialog.listen('MDCDialog:closed', (e) => c.complete(false));
    await c.future;
  } finally {
    dialog.destroy();
    root.remove();
  }
  return await c.future;
}

Element _buildDialog(
  String titleText,
  String contentHtml,
  bool isQuestion,
  void Function(bool) close,
) =>
    Element.div()
      ..classes.add('mdc-dialog')
      ..attributes.addAll({
        'role': 'alertdialog',
        'aria-model': 'true',
        'aria-labelledby': 'pub-dialog-title',
        'aria-describedby': 'pub-dialog-content',
      })
      ..children = [
        Element.div()
          ..classes.add('mdc-dialog__container')
          ..children = [
            Element.div()
              ..classes.add('mdc-dialog__surface')
              ..children = [
                Element.tag('h2')
                  ..classes.add('mdc-dialog__title')
                  ..id = 'pub-dialog-title'
                  ..innerText = titleText,
                Element.div()
                  ..classes.add('mdc-dialog__content')
                  ..id = 'pub-dialog-content'
                  ..innerHtml = contentHtml,
                Element.footer()
                  ..classes.add('mdc-dialog__actions')
                  ..children = [
                    if (isQuestion)
                      Element.tag('button')
                        ..classes.addAll([
                          'mdc-button',
                          'mdc-dialog__button',
                        ])
                        ..tabIndex = 2
                        ..onClick.first.whenComplete(() => close(false))
                        ..children = [
                          Element.span()
                            ..classes.add('mdc-button__label')
                            ..innerText = 'Cancel',
                        ],
                    Element.tag('button')
                      ..classes.addAll([
                        'mdc-button',
                        'mdc-dialog__button',
                      ])
                      ..tabIndex = 1
                      ..onClick.first.whenComplete(() => close(true))
                      ..children = [
                        Element.span()
                          ..classes.add('mdc-button__label')
                          ..innerText = 'Ok',
                      ],
                  ],
              ],
          ],
        Element.div()..classes.add('mdc-dialog__scrim'),
      ];
