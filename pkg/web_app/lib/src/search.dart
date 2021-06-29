// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:web_app/src/gtag_js.dart';

void setupSearch() {
  _setEventForKeyboardShortcut();
  _setEventForSearchInput();
  _setEventForFiltersToggle();
  _setEventForSortControl();
  _setEventForCheckboxChanges();
}

void _setEventForKeyboardShortcut() {
  final inputElem = document.querySelector('input.site-header-search-input');
  if (inputElem != null && inputElem is InputElement) {
    window.onKeyPress.listen((e) {
      // Ignore keys other than the shortcut key:
      if (e.key != '/') return;

      // Only trigger the input field and steal focus when nothing is focused,
      // or when the focused element is not an input element.
      final active = document.activeElement;
      final isRestricted = active is InputElement || active is TextAreaElement;
      if (!isRestricted) {
        inputElem.focus();

        // prevent the trigger character to get typed into the input field
        e.preventDefault();

        // notify analytics
        gtagEvent(
          'focus-search',
          category: 'keyboard-shortcut',
          label: 'path:${window.location.pathname}',
        );
      }
    });
  }
}

void _setEventForSearchInput() {
  final q = document.querySelector('input[name="q"]') as InputElement?;
  if (q == null) return null;
  final anchors = document.querySelectorAll('.list-filters > a');
  q.onChange.listen((_) {
    final newSearchQuery = q.value!.trim();
    for (final a in anchors) {
      final oldHref = a.getAttribute('href')!;
      final oldUri = Uri.parse(oldHref);
      final params = Map<String, String>.from(oldUri.queryParameters);
      params['q'] = newSearchQuery;
      final String newHref = oldUri.replace(queryParameters: params).toString();
      a.setAttribute('href', newHref);
    }
  });
}

void _setEventForFiltersToggle() {
  document.querySelectorAll('.search-filters-btn').forEach((e) {
    e.onClick.listen((_) {
      document
          .querySelectorAll('.search-filters-btn-wrapper')
          .forEach((e) => e.classes.toggle('-active'));
      document.querySelector('.search-controls')?.classes.toggle('-active');
    });
  });
}

void _setEventForSortControl() {
  // HTML-based dropdown
  document.querySelectorAll('.sort-control-option').forEach((e) {
    final isFirst = e.previousElementSibling == null;
    final value = isFirst ? null : e.dataset['value'];
    e.onClick.listen((_) => _updateSortField(value));
  });
}

/// Updates the form's `sort` field and submits the form.
/// When [value] is `null`, the `sort` field will be removed.
void _updateSortField(String? value) {
  final queryText = document.querySelector('input[name="q"]') as InputElement;
  var sortInput = document.querySelector('input[name="sort"]') as InputElement?;
  if (sortInput == null) {
    sortInput = InputElement(type: 'hidden')..name = 'sort';
    queryText.parent!.append(sortInput);
  }
  if (value == null) {
    sortInput.remove();
  } else {
    sortInput.value = value;
  }

  // Removes the q= part from the URL
  if (queryText.value!.isEmpty) {
    queryText.name = '';
  }

  // TODO: instead of submitting, compose the URL here (also removing the single `?`)
  queryText.form!.submit();
}

void _setEventForCheckboxChanges() {
  _setEventForHiddenCheckboxField(
      '-search-unlisted-field', '-search-unlisted-checkbox');
  _setEventForHiddenCheckboxField(
      '-search-discontinued-field', '-search-discontinued-checkbox');
  _setEventForHiddenCheckboxField(
      '-search-null-safe-field', '-search-null-safe-checkbox');
}

void _setEventForHiddenCheckboxField(
    String hiddenFieldId, String visibleCheckboxId) {
  final hiddenField = document.getElementById(hiddenFieldId) as InputElement?;
  final visibleCheckbox =
      document.getElementById(visibleCheckboxId) as CheckboxInputElement?;
  if (hiddenField != null && visibleCheckbox != null) {
    final formElement = hiddenField.form;
    visibleCheckbox.onChange.listen((_) {
      hiddenField.disabled = !(visibleCheckbox.checked!);
      // TODO: instead of submitting, compose the URL here (also removing the single `?`)
      formElement!.submit();
    });
  }
}
