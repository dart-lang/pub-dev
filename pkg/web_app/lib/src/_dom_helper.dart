// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:markdown/markdown.dart' as md;
import 'package:mdc_web/mdc_web.dart' show MDCDialog;
import 'package:meta/meta.dart';

import 'pubapi.client.dart';

/// Wraps asynchronous server calls with an optional confirm window, a spinner,
/// error- and success handling.
Future<R> rpc<R>({
  /// The optional confirmation question to ask before initiating the RPC.
  Element confirmQuestion,

  /// The async RPC call. If this throws, the error will be displayed as a modal
  /// popup, and then it will be re-thrown.
  Future<R> Function() fn,

  /// Message to show when the RPC returns without exceptions.
  @required Element successMessage,

  /// Callback that will be called with the value of the RPC call, when it was
  /// successful.
  FutureOr Function(R value) onSuccess,
}) async {
  if (confirmQuestion != null && !await modalConfirm(confirmQuestion)) {
    return null;
  }

  // capture keys
  final keyDownSubscription = window.onKeyDown.listen((event) {
    event.preventDefault();
    event.stopPropagation();
  });
  // disable inputs and buttons that are not already disabled
  final inputs = document
      .querySelectorAll('input')
      .cast<InputElement>()
      .where((e) => !e.disabled)
      .toList();
  final buttons = document
      .querySelectorAll('button')
      .cast<ButtonElement>()
      .where((e) => !e.disabled)
      .toList();
  buttons.forEach((e) => e.disabled = true);
  inputs.forEach((e) => e.disabled = true);

  final spinner = _createSpinner();
  document.body.append(spinner);
  R result;
  dynamic error;
  String errorMessage;
  try {
    result = await fn();
  } on RequestException catch (e) {
    error = e;
    errorMessage = _requestExceptionMessage(e) ?? 'Unexpected error: $e';
  } catch (e) {
    error = e;
    errorMessage = 'Unexpected error: $e';
  } finally {
    spinner.remove();
    await keyDownSubscription.cancel();
    buttons.forEach((e) => e.disabled = false);
    inputs.forEach((e) => e.disabled = false);
  }

  if (error != null) {
    await modalMessage('Error', markdown(errorMessage));
    throw error;
  }

  await modalMessage('Success', successMessage);
  if (onSuccess != null) {
    await onSuccess(result);
  }
  return result;
}

String _requestExceptionMessage(RequestException e) {
  try {
    final map = e.bodyAsJson();
    String message;

    if (map['error'] is Map) {
      final errorMap = map['error'] as Map;
      if (errorMap['message'] is String) {
        message = errorMap['message'] as String;
      }
    }

    // TODO: remove after the server is migrated to returns only `{'error': {'message': 'XX'}}`
    if (message == null && map['message'] is String) {
      message = map['message'] as String;
    }

    // TODO: check if we ever send responses like this and remove if not
    if (message == null && map['error'] is String) {
      message = map['error'] as String;
    }

    return message;
  } on FormatException catch (_) {
    // ignore bad body
  }
  return null;
}

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
  @required String titleText,
  @required Element content,
  @required bool isQuestion,
  String cancelButtonText,
  String okButtonText,

  /// If specified, this callback function will be called on "OK" button clicks,
  /// and the dialog window will be kept open. Returns with the success status
  /// of the operation, and if `true`, the dialog will be closed, otherwise the
  /// dialog is kept open (e.g. the user may update the form).
  FutureOr<bool> Function() onExecute,
}) async {
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

Element _buildDialog({
  @required String titleText,
  @required Element content,
  @required bool isQuestion,
  String cancelButtonText,
  String okButtonText,

  /// The callback will be called with `true` when "OK" was clicked, and `false`
  /// when "Cancel" was clicked.
  @required Function(bool) closing,
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
                        ])
                        ..tabIndex = 2
                        ..onClick.listen((_) {
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
                      ])
                      ..tabIndex = 1
                      ..onClick.listen((_) {
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
Element markdown(String text) => Element.div()
  ..setInnerHtml(
    md.markdownToHtml(text),
    validator: NodeValidator(uriPolicy: _UnsafeUriPolicy()),
  );

/// Allows any [Uri].
///
/// This shouldn't be a problem as we only render HTML we trust.
class _UnsafeUriPolicy implements UriPolicy {
  @override
  bool allowsUri(String uri) {
    return true;
  }
}

Element _createSpinner() => Element.div()
  ..className = 'spinner-frame'
  ..children = [
    Element.div()..className = 'spinner',
  ];
