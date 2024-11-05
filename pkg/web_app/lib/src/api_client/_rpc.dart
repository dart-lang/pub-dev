// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:_pub_shared/pubapi.dart';

import '../_dom_helper.dart';

/// Wraps asynchronous server calls with an optional confirm window, a spinner,
/// error- and success handling.
Future<R?> rpc<R>({
  /// The optional confirmation question to ask before initiating the RPC.
  /// When confirmation is missing, the method returns `null`.
  Element? confirmQuestion,

  /// The async RPC call. If this throws, the error will be displayed as a modal
  /// popup, and then it will be re-thrown (or `onError` will be called).
  required Future<R?> Function() fn,

  /// Message to show when the RPC returns without exceptions.
  required Element? successMessage,

  /// Callback that will be called with the value of the RPC call, when it was
  /// successful.
  FutureOr<void> Function(R? value)? onSuccess,

  /// Callback that will be called with the error object, when executing
  /// `fn` was not successful. The return value of this callback will be used
  /// to return from the method.
  ///
  /// If not specified, the error will be thrown instead.
  FutureOr<R?> Function(Object error)? onError,
}) async {
  if (confirmQuestion != null && !await modalConfirm(confirmQuestion)) {
    return null;
  }

  // Capture key down events.
  final keyDownSubscription = window.onKeyDown.listen((event) {
    event.preventDefault();
    event.stopPropagation();
  });
  // Disable inputs and buttons that are not already disabled.
  final inputs = document
      .querySelectorAll('input')
      .cast<InputElement>()
      .where((e) => e.disabled != true)
      .toList();
  final buttons = document
      .querySelectorAll('button')
      .cast<ButtonElement>()
      .where((e) => !e.disabled)
      .toList();
  buttons.forEach((e) => e.disabled = true);
  inputs.forEach((e) => e.disabled = true);

  final spinner = _createSpinner();
  document.body!.append(spinner);

  Future<void> cancelSpinner() async {
    spinner.remove();
    await keyDownSubscription.cancel();
    buttons.forEach((e) => e.disabled = false);
    inputs.forEach((e) => e.disabled = false);
  }

  R? result;
  ({Exception exception, String message})? error;
  try {
    result = await fn();
  } on RequestException catch (e) {
    final asJson = e.bodyAsJson();
    if (e.status == 401 && asJson.containsKey('go')) {
      final location = asJson['go'] as String;
      final locationUri = Uri.tryParse(location);
      if (locationUri != null && locationUri.toString().isNotEmpty) {
        await cancelSpinner();
        final errorObject = asJson['error'] as Map?;
        final message = errorObject?['message'];
        await modalMessage(
          'Further consent needed.',
          ParagraphElement()
            ..text = [
              if (message != null) message,
              'You will be redirected, please authorize the action.',
            ].join(' '),
        );

        final windowUri = Uri.parse(window.location.href);
        final newUri = Uri(
          scheme: windowUri.scheme,
          host: windowUri.host,
          port: windowUri.port,
          path: locationUri.path,
          query: locationUri.hasQuery ? locationUri.query : null,
        );
        window.location.assign(newUri.toString());
        return null;
      }
    }
    error = (
      exception: e,
      message: _requestExceptionMessage(asJson) ?? 'Unexpected error: $e'
    );
  } catch (e) {
    error = (
      exception: Exception('Unexpected error: $e'),
      message: 'Unexpected error: $e'
    );
  } finally {
    await cancelSpinner();
  }

  if (error != null) {
    await modalMessage('Error', await markdown(error.message));
    if (onError != null) {
      return await onError(error.exception);
    } else {
      throw error.exception;
    }
  }

  if (successMessage != null) {
    await modalMessage('Success', successMessage);
  }
  if (onSuccess != null) {
    await onSuccess(result);
  }
  return result;
}

String? _requestExceptionMessage(Map<String, Object?> jsonBody) =>
    switch (jsonBody) {
      {'error': {'message': final String errorMessage}} => errorMessage,
      // TODO: Remove after the server is migrated to return only `{'error': {'message': 'XX'}}`.
      {'message': final String errorMessage} => errorMessage,
      // TODO: Check if we ever send responses like this and remove if not.
      {'error': final String errorMessage} => errorMessage,
      _ => null,
    };

Element _createSpinner() => DivElement()
  ..className = 'spinner-frame'
  ..children = [
    DivElement()..className = 'spinner',
  ];
