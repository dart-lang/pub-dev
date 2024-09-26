// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';

import 'package:collection/collection.dart';
import 'package:web/web.dart';

import '../../web_util.dart';

/// Create a switch widget on [element].
///
/// A `data-switch-target` is required, this must be a CSS selector for the
/// element(s) that are affected when this widget is clicked.
///
/// The optional `data-switch-initial-state` property may be used to provide an
/// initial state. The initial state is used if state can be loaded from
/// `localStorage` (because there is none). If not provided, initial state is
/// derived from document state.
///
/// The optional `data-switch-state-id` property may be used to provide an
/// identifier for the sttae of this switch in `localStorage`. If supplied state
/// will be sync'ed across windows.
///
/// The optional `data-switch-enabled` property may be used to specify a space
/// separated list of classes to be applied to `data-switch-target` when the
/// switch is enabled.
///
/// The optional `data-switch-disabled` property may be used to specify a space
/// separated list of classes to be applied to `data-switch-target` when the
/// switch is disabled.
void create(HTMLElement element, Map<String, String> options) {
  final target = options['target'];
  if (target == null) {
    throw UnsupportedError('data-switch-target required');
  }
  final initialState_ = options['initial-state'];
  final stateId = options['state-id'];
  final enabledClassList = (options['enabled'] ?? '')
      .split(' ')
      .where((s) => s.isNotEmpty)
      .toSet()
      .toList();
  final disabledClassList = (options['disabled'] ?? '')
      .split(' ')
      .where((s) => s.isNotEmpty)
      .toSet()
      .toList();

  void applyState(bool enabled) {
    for (final e in document.querySelectorAll(target).toList()) {
      if (e.isA<HTMLElement>()) {
        final element = e as HTMLHtmlElement;
        if (enabled) {
          for (final c in enabledClassList) {
            element.classList.add(c);
          }
          for (final c in disabledClassList) {
            element.classList.remove(c);
          }
        } else {
          for (final c in enabledClassList) {
            element.classList.remove(c);
          }
          for (final c in disabledClassList) {
            element.classList.add(c);
          }
        }
      }
    }
  }

  bool? initialState;
  if (stateId != null) {
    void onStorage(StorageEvent e) {
      if (e.key == 'switch-$stateId' && e.storageArea == window.localStorage) {
        applyState(e.newValue == 'true');
      }
    }

    window.addEventListener('storage', onStorage.toJS);
    final state = window.localStorage.getItem('switch-$stateId');
    if (state != null) {
      initialState = state == 'true';
    }
  }

  // Set initialState, if present
  if (initialState_ != null) {
    initialState ??= initialState_ == 'true';
  }
  // If there are no classes to be applied, this is weird, but then we can't
  // infer an initial state.
  if (enabledClassList.isEmpty && disabledClassList.isEmpty) {
    initialState ??= false;
  }
  // Infer initial state from document state, unless loaded from localStorage
  initialState ??= document
      .querySelectorAll(target)
      .toList()
      .where((e) => e.isA<HTMLElement>())
      .map((e) => e as HTMLElement)
      .every(
        (e) =>
            enabledClassList.every((c) => e.classList.contains(c)) &&
            disabledClassList.none((c) => e.classList.contains(c)),
      );

  applyState(initialState);
  var state = initialState;

  void onClick(MouseEvent e) {
    if (e.defaultPrevented) {
      return;
    }
    e.preventDefault();

    state = !state;
    applyState(state);
    if (stateId != null) {
      window.localStorage.setItem('switch-$stateId', state.toString());
    }
  }

  element.addEventListener('click', onClick.toJS);
}
