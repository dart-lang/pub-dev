// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:web/web.dart';

import 'gtm_js.dart';
import 'page_updater.dart';
import 'web_util.dart';

void setupSearch() {
  _setEventForKeyboardShortcut();
  _setEventsForSearchForm();
  _setEventForFiltersToggle();
  _setEventForSortControl();
}

void _setEventForKeyboardShortcut() {
  final inputElem = document.querySelector('input.site-header-search-input');
  if (inputElem != null && inputElem is HTMLInputElement) {
    window.onKeyPress.listen((e) {
      // Ignore keys other than the shortcut key:
      if (e.key != '/') return;

      // Only trigger the input field and steal focus when nothing is focused,
      // or when the focused element is not an input element.
      final active = document.activeElement;
      final isRestricted =
          active is HTMLInputElement || active is HTMLTextAreaElement;
      if (!isRestricted) {
        inputElem.focus();

        // prevent the trigger character to get typed into the input field
        e.preventDefault();

        // notify analytics
        gtmCustomEvent(category: 'keyboard-shortcut', action: 'focus-search');
      }
    });
  }
}

/// When using the back button, or pulling a page state from cache or history,
/// the query text on the page may differ from the text inside the main input
/// field.
///
/// This method adjusts the input field's text to match the query parameter,
/// as if the page was freshly loaded.
void adjustQueryTextAfterPageShow() {
  final q = document.querySelector('input[name="q"]') as HTMLInputElement?;
  if (q == null) return null;
  final uri = Uri.tryParse(window.location.href);
  final qParameter = uri?.queryParameters['q'];
  if (q.value != qParameter) {
    q.value = qParameter ?? q.value;
  }
}

void _setEventsForSearchForm() {
  // When a search form checkbox has a linked search label,
  // checking the checkbox will trigger a click on the link.
  document
      .querySelectorAll('.search-form-linked-checkbox')
      .toElementList()
      .cast<HTMLElement>()
      .forEach((e) {
        final checkbox = e.querySelector('input') as HTMLElement?;
        final link = e.querySelector('a') as HTMLElement?;
        if (checkbox != null && link != null) {
          final tag = link.getAttribute('data-tag');
          final action = link.getAttribute('data-action');
          if (tag == null || tag.isEmpty) return;

          Future<void> handleClick(Event event) async {
            await _handleInputFieldUpdate(
              event,
              newQueryFn: (parsedQuery) => parsedQuery.change(
                tagsPredicate: parsedQuery.tagsPredicate.toggleRequired(tag),
              ),
              gtmActionFn: (o, n) =>
                  o.tagsPredicate.hasTag(tag) ? '$action-off' : '$action-on',
            );
          }

          checkbox.onChange.listen(handleClick);
          link.onClick.listen(handleClick);
          e.onClick.listen(handleClick);
        }
      });
}

// Shared state for concurrent click events.
Uri? _lastTargetUri;

Future<void> _handleInputFieldUpdate(
  Event event, {
  required ParsedQueryText Function(ParsedQueryText query) newQueryFn,
  required String? Function(ParsedQueryText oldQuery, ParsedQueryText newQuery)
  gtmActionFn,
}) async {
  event.preventDefault();
  event.stopPropagation();

  // create new URL based on the window state
  final windowUri = Uri.parse(window.location.href);
  final inputQElem =
      document.body!.querySelector('input[name="q"]') as HTMLInputElement;
  var queryText = inputQElem.value.trim();
  if (queryText.isEmpty) {
    queryText = windowUri.queryParameters['q']?.trim() ?? '';
  }
  final parsedQuery = ParsedQueryText.parse(queryText);
  final newQuery = newQueryFn(parsedQuery);
  queryText = newQuery.toString();
  inputQElem.value = queryText;

  // removes `page` to start the new search on page 1
  final newRequestParams = {
    ...windowUri.queryParameters,
    'q': queryText,
    'open-sections': _openSectionParams(),
  }..remove('page');
  final newRequestUri = windowUri.replace(queryParameters: newRequestParams);
  // removes `open-sections` as it is not intended to be linked to or bookmarked
  final newVisibleParams = {...newRequestParams}..remove('open-sections');
  final newVisibleUri = windowUri.replace(queryParameters: newVisibleParams);

  _lastTargetUri = newVisibleUri;
  await updateBodyWithHttpGet(
    requestUri: newRequestUri,
    navigationUrl: newVisibleUri.toString(),
    preUpdateCheck: () => _lastTargetUri == newVisibleUri,
  );

  // notify GTM on the click
  final action = gtmActionFn(parsedQuery, newQuery);
  if (action != null && action.isNotEmpty) {
    gtmCustomEvent(category: 'click', action: action);
  }
}

String _openSectionParams() {
  return document
      .querySelectorAll('.search-form-section')
      .toElementList()
      .cast<HTMLElement>()
      .where((e) => e.classList.contains('-active'))
      .map((e) => e.getAttribute('data-section-tag'))
      .nonNulls
      .where((t) => t.isNotEmpty)
      .join(' ');
}

void _setEventForFiltersToggle() {
  document.querySelectorAll('.search-filters-btn').toElementList().forEach((e) {
    e.onClick.listen((_) {
      document
          .querySelectorAll('.search-filters-btn-wrapper')
          .toElementList()
          .forEach((e) => e.classList.toggle('-active'));
      document
          .querySelector('.search-form-container')
          ?.classList
          .toggle('-active-on-mobile');
    });
  });
}

void _setEventForSortControl() {
  // HTML-based dropdown
  document
      .querySelectorAll('.sort-control-option')
      .toElementList()
      .cast<HTMLElement>()
      .forEach((e) {
        final isFirst = e.previousElementSibling == null;
        final value = isFirst ? null : e.getAttribute('data-value');
        e.onClick.listen((_) => _updateSortField(value));
      });
}

/// Updates the form's `sort` field and submits the form.
/// When [value] is `null`, the `sort` field will be removed.
void _updateSortField(String? value) {
  final queryText =
      document.querySelector('input[name="q"]') as HTMLInputElement;
  var sortInput =
      document.querySelector('input[name="sort"]') as HTMLInputElement?;
  if (sortInput == null) {
    sortInput = HTMLInputElement()
      ..type = 'hidden'
      ..name = 'sort';
    queryText.parentElement!.append(sortInput);
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
  queryText.form!.submit();
}
