// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:web_app/src/page_data.dart';

void setupSearch() {
  _setBackToReferrer();
  _setEventForSearchInput();
  _setEventForFiltersToggle();
  _setEventForSortControl();
  _setEventForCheckboxChanges();
}

void _setBackToReferrer() {
  final bannerContainerElem = document.getElementById('banner-container');
  if (bannerContainerElem == null) return;

  // abort if not on a package page
  if (!pageData.isPackagePage) return;

  // TODO: remove this after finalizing the new new design
  // abort if on old design
  if (document.body.classes.contains('non-experimental')) return;

  // Abort if there is no referrer or if it is not a valid URL.
  final ref = document.referrer;
  if (ref == null || ref.isEmpty) return;
  final refUri = Uri.tryParse(ref);
  if (refUri == null) return;

  // abort if the scheme://hostname[:port]/ is different
  // - location.protocol already contains the colon
  // - location.host already contains the :port
  final loc = window.location;
  final prefix = '${loc.protocol}//${loc.host}/';
  if (!ref.startsWith(prefix)) return;

  // Abort if the referrer was not search (packages) page.
  if (!refUri.path.endsWith('/packages')) return;

  // create Element
  bannerContainerElem.append(Element.div()
    ..classes.add('back-to-referrer')
    ..append(Element.a()
      ..classes.add('back-to-referrer-link')
      ..attributes['href'] = ref
      ..text = 'Back to search'));
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

void _setEventForFiltersToggle() {
  document.querySelectorAll('.search-filters-btn').forEach((e) {
    e.onClick.listen((_) {
      document
          .querySelectorAll('.search-filters-btn-wrapper')
          .forEach((e) => e.classes.toggle('-active'));
      document.querySelector('.search-controls')?.classes?.toggle('-active');
    });
  });
}

void _setEventForSortControl() {
  // HTML-based dropdown
  // TODO: remove once we have migrated to the new UI
  final sortControl = document.getElementById('sort-control') as SelectElement;
  sortControl?.onChange?.listen((_) {
    final selectedValue = sortControl.selectedOptions.first.value;
    final isFirst = selectedValue == sortControl.options.first.value;
    _updateSortField(isFirst ? null : selectedValue);
  });

  // new UI design
  document.querySelectorAll('.sort-control-option').forEach((e) {
    final isFirst = e.previousElementSibling == null;
    final value = isFirst ? null : e.dataset['value'];
    e.onClick.listen((_) => _updateSortField(value));
  });
}

/// Updates the form's `sort` field and submits the form.
/// When [value] is `null`, the `sort` field will be removed.
void _updateSortField(String value) {
  final queryText = document.querySelector('input[name="q"]') as InputElement;
  InputElement sortInput =
      document.querySelector('input[name="sort"]') as InputElement;
  if (sortInput == null) {
    sortInput = InputElement(type: 'hidden')..name = 'sort';
    queryText.parent.append(sortInput);
  }
  if (value == null) {
    sortInput.remove();
  } else {
    sortInput.value = value;
  }

  // Removes the q= part from the URL
  if (queryText.value.isEmpty) {
    queryText.name = '';
  }

  // TODO: instead of submitting, compose the URL here (also removing the single `?`)
  queryText.form.submit();
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
