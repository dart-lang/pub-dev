// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void setupSearch() {
  _setEventForSearchInput();
  _setEventForSortControl();
  _setEventForCheckboxChanges();
}

void _setEventForSearchInput() {
  final q = document.querySelector('input[name="q"]') as InputElement;
  if (q == null) return null;
  final List<Element> anchors = document.querySelectorAll('.list-filters > a');
  q.onChange.listen((_) {
    final String newSearchQuery = q.value.trim();
    for (Element a in anchors) {
      final String oldHref = a.getAttribute('href');
      final Uri oldUri = Uri.parse(oldHref);
      final params = Map<String, String>.from(oldUri.queryParameters);
      params['q'] = newSearchQuery;
      final String newHref = oldUri.replace(queryParameters: params).toString();
      a.setAttribute('href', newHref);
    }
  });
}

void _setEventForSortControl() {
  final sortControl = document.getElementById('sort-control');
  final queryText = document.querySelector('input[name="q"]') as InputElement;
  if (sortControl == null || queryText == null) return;
  final formElement = queryText.form;
  final select = sortControl as SelectElement;
  select.onChange.listen((_) {
    final selected = select.selectedOptions.first;
    InputElement sortInput =
        document.querySelector('input[name="sort"]') as InputElement;
    if (sortInput == null) {
      sortInput = InputElement(type: 'hidden')..name = 'sort';
      queryText.parent.append(sortInput);
    }
    // The first value of the selection list is the implied default sort order,
    // and can be removed from the from to make a nicer query string.
    if (select.options.first.value == selected.value) {
      sortInput.remove();
    } else {
      sortInput.value = selected.value;
    }

    // Removes the q= part from the URL
    if (queryText.value.isEmpty) {
      queryText.name = '';
    }

    // TODO: instead of submitting, compose the URL here (also removing the single `?`)
    formElement.submit();
  });
}

void _setEventForCheckboxChanges() {
  final hiddenLegacyField =
      document.getElementById('search-legacy-field') as InputElement;
  final visibleLegacyCheckbox =
      document.getElementById('search-legacy-checkbox') as CheckboxInputElement;
  if (hiddenLegacyField != null && visibleLegacyCheckbox != null) {
    final formElement = hiddenLegacyField.form;
    visibleLegacyCheckbox.onChange.listen((_) {
      hiddenLegacyField.disabled = !visibleLegacyCheckbox.checked;
      // TODO: instead of submitting, compose the URL here (also removing the single `?`)
      formElement.submit();
    });
  }
}
