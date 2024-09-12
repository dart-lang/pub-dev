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

/// Create a dismissible widget on [element].
///
/// A `data-dismissible-by` is required, this must be a CSS selected for a
/// child element that when clicked will dismiss the message by removing
/// [element].
///
/// A hash is computed from `innerText` of [element], once dismissed this hash
/// will be stored in `localStorage`. And next time this widget is instantiated
/// with the same `innerText` it'll be removed immediately.
///
/// Hashes of dismissed messages will be stored for up to 2 years.
/// No more than 50 dismissed messages are retained in `localStorage`.
void create(HTMLElement element, Map<String, String> options) {
  final by = options['by'];
  if (by == null) throw UnsupportedError('data-dismissible-by required');

  late final hash = _cheapNaiveHash(element.innerText);
  if (_dismissed.any((e) => e.hash == hash)) {
    element.remove();
    return;
  } else {
    element.style.display = 'revert';
  }

  final dismiss = (Event e) {
    e.preventDefault();

    element.remove();
    _dismissed.add((
      hash: hash,
      date: DateTime.now(),
    ));
    _saveDismissed();
  };

  var dismissible = false;
  for (final dismisser in element.querySelectorAll(by).toList()) {
    if (!dismisser.isA<HTMLElement>()) continue;
    dismisser.addEventListener('click', dismiss.toJS);
    dismissible = true;
  }
  if (!dismissible) {
    throw UnsupportedError(
      'data-dismissible-by must point to a child element',
    );
  }
}

/// Create a cheap naive hash from [text].
String _cheapNaiveHash(String text) {
  final half = (text.length / 2).floor();
  return text.length.toRadixString(16).padLeft(2, '0') +
      text.hashCode.toRadixString(16).padLeft(2, '0') +
      text.substring(0, half).hashCode.toRadixString(16).padLeft(2, '0') +
      text.substring(half).hashCode.toRadixString(16).padLeft(2, '0');
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
    final [hash, date, ...] = entry.split('@');
    return (
      hash: hash,
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
        .map((e) => e.hash + '@' + e.date.toIso8601String().split('T').first)
        .join(';'),
  );
}
