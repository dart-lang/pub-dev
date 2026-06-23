// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:web/web.dart';

import '_focusability.dart';
import 'deferred/markdown.dart' deferred as md;
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

  void cancel() {
    if (!c.isCompleted) {
      c.complete(false);
    }
  }

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
    onDismiss: cancel,
    cancelButtonText: cancelButtonText,
    okButtonText: okButtonText,
  );

  // Close the dialog when the escape key was hit.
  final keySubscription = window.onKeyDown.listen((event) {
    if (event.key == 'Escape') {
      event.preventDefault();
      cancel();
    }
  });

  document.body!.append(root);
  document.body!.classList.add('pub-dialog-scroll-lock');
  // Note: this forces a layout event, so that the open transition animates from the hidden state.
  root.getBoundingClientRect();
  root.classList.add('pub-dialog--open');
  try {
    await c.future;
  } finally {
    await keySubscription.cancel();
    restoreFocusabilityFn();
    root.remove();
    document.body!.classList.remove('pub-dialog-scroll-lock');
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

  /// Called when the dialog is dismissed without pressing a button (e.g. click outside).
  required void Function() onDismiss,
}) {
  final title = document.createElement('h2') as HTMLElement
    ..classList.add('pub-dialog-title')
    ..id = 'pub-dialog-title'
    ..innerText = titleText;

  final contentDiv = HTMLDivElement()
    ..classList.add('pub-dialog-content')
    ..id = 'pub-dialog-content'
    ..append(content);

  final footer = document.createElement('footer')
    ..classList.add('pub-dialog-actions');

  if (isQuestion) {
    final cancelBtn = HTMLButtonElement()
      ..classList.addAll([
        'pub-button',
        '-pub-dom-dialog-cancel-button',
      ])
      ..tabIndex = 2
      ..innerText = cancelButtonText ?? 'Cancel';
    cancelBtn.onClick.listen((e) {
      e.preventDefault();
      closing(false);
    });
    footer.append(cancelBtn);
  }

  final okBtn = HTMLButtonElement()
    ..classList.addAll([
      'pub-button',
      '-pub-dom-dialog-ok-button',
    ])
    ..tabIndex = 1
    ..innerText = okButtonText ?? 'Ok';
  okBtn.onClick.listen((e) {
    e.preventDefault();
    closing(true);
  });
  footer.append(okBtn);

  final surface = HTMLDivElement()
    ..classList.add('pub-dialog-surface')
    ..append(title)
    ..append(contentDiv)
    ..append(footer);

  final container = HTMLDivElement()
    ..classList.add('pub-dialog-container')
    ..append(surface);

  final scrim = HTMLDivElement()..classList.add('pub-dialog-scrim');
  scrim.onClick.listen((e) {
    e.preventDefault();
    onDismiss();
  });

  final root = HTMLDivElement()
    ..classList.add('pub-dialog')
    ..setAttribute('role', 'alertdialog')
    ..setAttribute('aria-modal', 'true')
    ..setAttribute('aria-labelledby', 'pub-dialog-title')
    ..setAttribute('aria-describedby', 'pub-dialog-content')
    ..append(scrim)
    ..append(container);

  return root;
}

/// Creates an [Element] with Markdown-formatted content.
Future<Element> markdown(String text) async {
  await md.loadLibrary();
  return md.markdown(text);
}

/// Get the value of the dropdown's selected option
/// (or null if none is selected).
String? dropdownSelected(Element? elem) {
  if (elem is HTMLSelectElement) return elem.value;
  return null;
}
