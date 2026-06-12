// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:web/web.dart';

import '../../web_util.dart';

/// Keeps the character counter of `.pub-text-field--textarea` components in
/// sync with the current content of their `<textarea>`.
void setupTextAreas() {
  final textAreas = document
      .querySelectorAll('.pub-text-field--textarea')
      .toElementList<HTMLElement>();
  for (final field in textAreas) {
    final textArea =
        field.querySelector('.pub-text-field-input') as HTMLTextAreaElement?;
    final counter = field.querySelector('.pub-text-field-character-counter');
    if (textArea == null || counter == null) continue;

    final maxLength = textArea.getAttribute('maxlength');
    void updateCounter() {
      counter.textContent = '${textArea.value.length} / $maxLength';
    }

    updateCounter();
    textArea.onInput.listen((_) => updateCounter());
  }
}
