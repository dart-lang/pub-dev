// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:mdc_web/mdc_web.dart' show MDCDialog;
import 'deferred/markdown.dart' deferred as md;

/// Displays a message via the modal window.
Future modalMessage(String title, Element content) async {
  await modalWindow(
    titleText: title,
    content: content,
    isQuestion: false,
  );
}

/// Display [content] to user (assumed it has a question format), and return
/// true if 'OK' was selected.
Future<bool> modalConfirm(Element content) async {
  return await modalWindow(
    titleText: 'Confirm',
    content: content,
    isQuestion: true,
  );
}

/// Displays a modal window with "OK" and "Cancel" buttons. If [isQuestion] is
/// false, it will omit the "Cancel" button.
///
/// Returns true if "OK" was pressed, false otherwise.
Future<bool> modalWindow({
  required String titleText,
  required Element content,
  required bool isQuestion,
  String? cancelButtonText,
  String? okButtonText,

  /// If specified, this callback function will be called on "OK" button clicks,
  /// and the dialog window will be kept open. Returns with the success status
  /// of the operation, and if `true`, the dialog will be closed, otherwise the
  /// dialog is kept open (e.g. the user may update the form).
  FutureOr<bool> Function()? onExecute,
}) async {
  final focusableElements =
      document.body!.querySelectorAll(_focusableSelectors.join(', '));
  final restoreFocusabilityFns = <Function>[];
  for (final e in focusableElements) {
    if (!_isInsideContent(e, content)) {
      restoreFocusabilityFns.add(_disableFocusability(e));
    }
  }
  final c = Completer<bool>();
  final root = _buildDialog(
    titleText: titleText,
    content: content,
    isQuestion: isQuestion,
    closing: (bool pushedOk) async {
      final complete = !pushedOk || onExecute == null || await onExecute();
      if (complete && !c.isCompleted) {
        c.complete(pushedOk);
      }
    },
    cancelButtonText: cancelButtonText,
    okButtonText: okButtonText,
  );
  document.body!.append(root);
  final dialog = MDCDialog(root);
  try {
    dialog.open();
    dialog.listen('MDCDialog:closed', (e) => c.complete(false));
    await c.future;
  } finally {
    for (final fn in restoreFocusabilityFns) {
      fn();
    }
    dialog.destroy();
    root.remove();
    // TODO: Investigate if this is a bug in the JS library or in `package:mdc_web`
    document.body!.classes.remove('mdc-dialog-scroll-lock');
  }
  return await c.future;
}

Element _buildDialog({
  required String titleText,
  required Element content,
  required bool isQuestion,
  String? cancelButtonText,
  String? okButtonText,

  /// The callback will be called with `true` when "OK" was clicked, and `false`
  /// when "Cancel" was clicked.
  required Function(bool) closing,
}) =>
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
                  ..children = [content],
                Element.footer()
                  ..classes.add('mdc-dialog__actions')
                  ..children = [
                    if (isQuestion)
                      Element.tag('button')
                        ..classes.addAll([
                          'mdc-button',
                          'mdc-dialog__button',
                          '-pub-dom-dialog-cancel-button',
                        ])
                        ..tabIndex = 2
                        ..onClick.listen((e) {
                          e.preventDefault();
                          closing(false);
                        })
                        ..children = [
                          Element.span()
                            ..classes.add('mdc-button__label')
                            ..innerText = cancelButtonText ?? 'Cancel',
                        ],
                    Element.tag('button')
                      ..classes.addAll([
                        'mdc-button',
                        'mdc-dialog__button',
                        '-pub-dom-dialog-ok-button',
                      ])
                      ..tabIndex = 1
                      ..onClick.listen((e) {
                        e.preventDefault();
                        closing(true);
                      })
                      ..children = [
                        Element.span()
                          ..classes.add('mdc-button__label')
                          ..innerText = okButtonText ?? 'Ok',
                      ],
                  ],
              ],
          ],
        Element.div()..classes.add('mdc-dialog__scrim'),
      ];

/// Creates an [Element] with unformatted [text] content.
Element text(String text) => Element.div()..text = text;

/// Creates an [Element] with Markdown-formatted content.
Future<Element> markdown(String text) async {
  await md.loadLibrary();
  return md.markdown(text);
}

/// Get the value of the material dropdown's selected element
/// (or null if none is selected).
String? materialDropdownSelected(Element? elem) {
  if (elem == null) return null;
  final item = elem.querySelector('.mdc-list-item--selected');
  return item?.dataset['value'];
}

/// These selectors provide the elements that are focusable through tab or
/// keyboard navigation.
const _focusableSelectors = <String>[
  'a',
  'audio',
  'button',
  'canvas',
  'details',
  'iframe',
  'input',
  'select',
  'summary',
  'textarea',
  'video',
  '[accesskey]',
  '[contenteditable]',
  '[tabindex]',
];

bool _isInsideContent(Element e, Element content) {
  // check if [e] is under [content].
  Element? p = e;
  while (p != null) {
    if (p == content) {
      return true;
    }
    p = p.parent;
  }
  return false;
}

/// Update [e] to disable focusability and return a [Function] that can be
/// called to revert its original state.
Function _disableFocusability(Element e) {
  final isLink = e.tagName.toLowerCase() == 'a';
  final attributesToSet = <String, String>{
    if (isLink) 'tabindex': '-1' else 'disabled': 'disabled',
    'aria-hidden': 'true',
  };
  final attributesToRestore =
      attributesToSet.map((key, _) => MapEntry(key, e.getAttribute(key)));
  for (final a in attributesToSet.entries) {
    e.setAttribute(a.key, a.value);
  }
  return () {
    for (final a in attributesToRestore.entries) {
      final value = a.value;
      if (value == null) {
        e.removeAttribute(a.key);
      } else {
        e.setAttribute(a.key, value);
      }
    }
  };
}
