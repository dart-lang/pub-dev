// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';

import 'package:collection/collection.dart';
import 'package:web/web.dart';

import '../../web_util.dart';

/// Forget dismissed messages that are more than 2 years old
late final _deadline = DateTime.now().subtract(Duration(days: 365 * 2));

/// Don't save more than 50 entries
const _maxMissedMessages = 50;

/// Create a dismiss widget on [element].
///
/// A `data-dismiss-target` is required, this must be a CSS selector for the
/// element(s) that are to be dismissed when this widget is clicked.
///
/// A `data-dismiss-message-id` is required, this must be a string identifying
/// the message being dismissed. Once dismissed this identifier will be stored
/// in `localStorage`. And next time this widget is instantiated with the same
/// `data-dismiss-message-id` it'll be removed immediately.
///
/// When in a dismissed state the `data-dismiss-target` elements will have a
/// `dismissed` class added to them. If they have this class initially, it will
/// be removed unless, the message has already been dismissed previously.
///
/// Identifiers of dismissed messages will be stored for up to 2 years.
/// No more than 50 dismissed messages are retained in `localStorage`.
void create(HTMLElement element, Map<String, String> options) {
  final target = options['target'];
  if (target == null) {
    throw UnsupportedError('data-dismissible-target required');
  }
  final messageId = options['message-id'];
  if (messageId == null) {
    throw UnsupportedError('data-dismissible-message-id required');
  }

  void applyDismissed(bool enabled) {
    for (final e in document.querySelectorAll(target).toList()) {
      if (e.isA<HTMLElement>()) {
        final element = e as HTMLHtmlElement;
        if (enabled) {
          element.classList.add('dismissed');
        } else {
          element.classList.remove('dismissed');
        }
      }
    }
  }

  if (_dismissed.any((e) => e.id == messageId)) {
    applyDismissed(true);
    return;
  } else {
    applyDismissed(false);
  }

  void dismiss(Event e) {
    e.preventDefault();

    applyDismissed(true);
    _dismissed.add((
      id: messageId,
      date: DateTime.now(),
    ));
    _saveDismissed();
  }

  element.addEventListener('click', dismiss.toJS);
}

/// LocalStorage key where we store the hashes of messages that have been
/// dismissed.
///
/// Data is stored on the format: `<hash>@<date>;<hash>@<date>;...`
const _dismissedMessageslocalStorageKey = 'dismissed-messages';

late final _dismissed = [
  ...?window.localStorage
      .getItem(_dismissedMessageslocalStorageKey)
      ?.split(';')
      .where((e) => e.contains('@'))
      .map((entry) {
    final [id, date, ...] = entry.split('@');
    return (
      id: id,
      date: DateTime.tryParse(date) ?? DateTime.fromMicrosecondsSinceEpoch(0),
    );
  }).where((entry) => entry.date.isAfter(_deadline)),
];

void _saveDismissed() {
  window.localStorage.setItem(
    _dismissedMessageslocalStorageKey,
    _dismissed
        .sortedBy((e) => e.date) // Sort by date
        .reversed // Reverse ordering to prefer newest dates
        .take(_maxMissedMessages) // Limit how many entries we save
        .map((e) => e.id + '@' + e.date.toIso8601String().split('T').first)
        .join(';'),
  );
}
