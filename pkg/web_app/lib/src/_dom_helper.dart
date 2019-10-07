// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:markdown/markdown.dart' as markdown;
import 'package:mdc_web/mdc_web.dart' show MDCDialog;
import 'package:meta/meta.dart';

import 'pubapi.client.dart';

/// Wraps asynchronous server calls with an optional confirm window, a spinner,
/// error- and success handling.
Future<R> rpc<R>({
  /// The optional confirmation question to ask before initiating the RPC.
  String confirmQuestion,

  /// The async RPC call. If this throws, the error will be displayed as a modal
  /// popup, and then it will be re-thrown.
  @required Future<R> fn(),

  /// Message to show when the RPC returns without exceptions.
  @required String successMessage,

  /// Callback that will be called with the value of the RPC call, when it was
  /// successful.
  FutureOr onSuccess(R value),
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
    errorMessage = markdown
        .markdownToHtml(_requestExceptionMessage(e) ?? 'Unexpected error: $e');
  } catch (e) {
    error = e;
    errorMessage = markdown.markdownToHtml('Unexpected error: $e');
  } finally {
    spinner.remove();
    await keyDownSubscription.cancel();
    buttons.forEach((e) => e.disabled = false);
    inputs.forEach((e) => e.disabled = false);
  }

  if (error != null) {
    await modalMessage('Error', errorMessage);
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
    return (map['message'] as String) ?? (map['error'] as String);
  } on FormatException catch (_) {
    // ignore bad body
  }
  return null;
}

/// Displays a message via the modal window.
///
/// Note: [messageHtml] must be trusted HTML.
Future modalMessage(String title, String messageHtml) async {
  await _modalWindow(title, messageHtml, false);
}

/// Ask [questionHtml] to user, return true if 'OK' was selected.
///
/// Note: [questionHtml] must be trusted HTML.
Future<bool> modalConfirm(String questionHtml) async {
  return await _modalWindow('Confirm', questionHtml, true);
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
                  ..setInnerHtml(
                    contentHtml,
                    validator: NodeValidator(uriPolicy: _UnsafeUriPolicy()),
                  ),
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
