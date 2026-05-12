// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:web/web.dart';

import '_focusability.dart';
import 'deferred/markdown.dart' deferred as md;
import 'mdc/mdc_dialog.dart';
import 'web_util.dart';

/// Displays a message via the modal window.
Future<void> modalMessage(String title, String message) async {
  await modalWindow(
    titleText: title,
    content: await markdown(message),
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
  final restoreFocusabilityFn = disableAllFocusability(
    allowedComponents: [content],
  );
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
  final dialog = MdcDialog.attachTo(root);
  try {
    dialog.open();
    dialog.listenOnClose(() => c.complete(false));
    await c.future;
  } finally {
    restoreFocusabilityFn();
    dialog.destroy();
    root.remove();
    // Note: This seems to be a bug in the JS library
    document.body!.classList.remove('mdc-dialog-scroll-lock');
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
  required void Function(bool) closing,
}) {
  final title = document.createElement('h2') as HTMLElement
    ..classList.add('mdc-dialog__title')
    ..id = 'pub-dialog-title'
    ..innerText = titleText;

  final contentDiv = HTMLDivElement()
    ..classList.add('mdc-dialog__content')
    ..id = 'pub-dialog-content'
    ..append(content);

  final footer = document.createElement('footer');
  footer.classList.add('mdc-dialog__actions');

  if (isQuestion) {
    final cancelBtn = HTMLButtonElement()
      ..classList.addAll([
        'mdc-button',
        'mdc-dialog__button',
        '-pub-dom-dialog-cancel-button',
      ])
      ..tabIndex = 2;
    cancelBtn.onClick.listen((e) {
      e.preventDefault();
      closing(false);
    });
    cancelBtn.append(
      HTMLSpanElement()
        ..classList.add('mdc-button__label')
        ..innerText = cancelButtonText ?? 'Cancel',
    );
    footer.append(cancelBtn);
  }

  final okBtn = HTMLButtonElement()
    ..classList.addAll([
      'mdc-button',
      'mdc-dialog__button',
      '-pub-dom-dialog-ok-button',
    ])
    ..tabIndex = 1;
  okBtn.onClick.listen((e) {
    e.preventDefault();
    closing(true);
  });
  okBtn.append(
    HTMLSpanElement()
      ..classList.add('mdc-button__label')
      ..innerText = okButtonText ?? 'Ok',
  );
  footer.append(okBtn);

  final surface = HTMLDivElement()
    ..classList.add('mdc-dialog__surface')
    ..append(title)
    ..append(contentDiv)
    ..append(footer);

  final container = HTMLDivElement()
    ..classList.add('mdc-dialog__container')
    ..append(surface);

  final root = HTMLDivElement()
    ..classList.add('mdc-dialog')
    ..setAttribute('role', 'alertdialog')
    ..setAttribute('aria-model', 'true')
    ..setAttribute('aria-labelledby', 'pub-dialog-title')
    ..setAttribute('aria-describedby', 'pub-dialog-content')
    ..append(container)
    ..append(HTMLDivElement()..classList.add('mdc-dialog__scrim'));

  return root;
}

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
  return item?.getAttribute('data-value');
}
