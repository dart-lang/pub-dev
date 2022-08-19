// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:_pub_shared/search/search_form.dart';
import 'package:web_app/src/gtm_js.dart';

import 'gtm_js.dart';
import 'page_updater.dart';

void setupSearch() {
  _setEventForKeyboardShortcut();
  _setEventForSearchInput();
  _setEventsForSearchForm();
  _setEventForFiltersToggle();
  _setEventForSortControl();
  _setEventForScreenshot();
}

void _setEventForScreenshot() {
  final thumbnails = document.querySelectorAll('.screenshot-thumbnail');
  final carousel = document.getElementById('-screenshot-carousel')!;
  final imageContainer = document.getElementById('-image-container')!;
  final prev = document.getElementById('-carousel-prev')!;
  final next = document.getElementById('-carousel-next')!;
  ImageElement? imageElement =
      document.getElementById('-carousel-image') as ImageElement?;

  if (imageElement == null) {
    imageElement = ImageElement();
    imageElement.id = '-carousel-image';
    imageContainer.children.add(imageElement);
    imageElement.className = 'carousel_image';
  }

  List<String> images = [];

  void hideElement(Element element) {
    element.style.display = 'none';
  }

  void showElement(Element element) {
    element.style.display = 'flex';
  }

  void showImage(int index, UIEvent event) {
    event.stopPropagation();
    imageElement!.src = images[index];
    if (index == images.length - 1) {
      hideElement(next);
    }
    if (index == 0) {
      hideElement(prev);
    }
    if (index > 0) {
      showElement(prev);
    }
    if (index < images.length - 1) {
      showElement(next);
    }
  }

  int screenshotIndex = 0;
  for (final thumbnail in thumbnails) {
    thumbnail.onClick.listen((event) {
      showElement(carousel);
      images = thumbnail.attributes['data']!.split(',');
      showImage(screenshotIndex, event);
    });
  }

  prev.onClick.listen((event) {
    showImage(--screenshotIndex, event);
  });

  next.onClick.listen((event) {
    showImage(++screenshotIndex, event);
  });

  imageElement.onClick.listen((event) {
    event.stopPropagation();
  });

  void closeCarousel() {
    hideElement(carousel);
    hideElement(next);
    hideElement(prev);
    screenshotIndex = 0;
  }

  carousel.onClick.listen((event) {
    event.stopPropagation;
    closeCarousel();
  });

  document.onKeyDown.listen((event) {
    if (carousel.style.display != 'none') {
      event.stopPropagation();
      if (event.key == 'Escape') {
        closeCarousel();
      }
      if (event.key == 'ArrowLeft') {
        if (screenshotIndex > 0) {
          showImage(--screenshotIndex, event);
        }
      }
      if (event.key == 'ArrowRight') {
        if (screenshotIndex < images.length - 1) {
          showImage(++screenshotIndex, event);
        }
      }
    }
  });
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
        gtmCustomEvent(
          category: 'keyboard-shortcut',
          action: 'focus-search',
        );
      }
    });
  }
}

void _setEventForSearchInput() {
  final q = document.querySelector('input[name="q"]') as InputElement?;
  if (q == null) return null;
  final anchors = document.querySelectorAll('.search-link');
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

/// When using the back button, or pulling a page state from cache or history,
/// the query text on the page may differ from the text inside the main input
/// field.
///
/// This method adjusts the input field's text to match the query parameter,
/// as if the page was freshly loaded.
void adjustQueryTextAfterPageShow() {
  final q = document.querySelector('input[name="q"]') as InputElement?;
  if (q == null) return null;
  final uri = Uri.tryParse(window.location.href);
  if (q.value != uri?.queryParameters['q']) {
    q.value = uri?.queryParameters['q'] ?? q.value;
  }
}

void _setEventsForSearchForm() {
  // Shared state for concurrent click events.
  Uri? lastTargetUri;

  // When a search form checkbox has a linked search label,
  //checking the checkbox will trigger a click on the link.
  document.querySelectorAll('.search-form-linked-checkbox').forEach((e) {
    final checkbox = e.querySelector('input');
    final link = e.querySelector('a');
    if (checkbox != null && link != null) {
      final originalHrefUri = Uri.parse(link.getAttribute('href')!);
      Future<void> handleClick(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        // create new URL based on the window state
        final windowUri = Uri.parse(window.location.href);
        final inputQElem =
            document.body!.querySelector('input[name="q"]') as InputElement;
        var queryText =
            inputQElem.value ?? originalHrefUri.queryParameters['q'] ?? '';
        queryText = queryText.trim();
        final tag = link.dataset['tag'];
        var actionPostfix = '-on';
        if (tag != null) {
          final parsedQuery = ParsedQueryText.parse(queryText);
          final newQuery = parsedQuery.change(
            tagsPredicate: parsedQuery.tagsPredicate.toggleRequired(tag),
          );
          queryText = newQuery.toString();
          if (parsedQuery.tagsPredicate.hasTag(tag)) {
            actionPostfix = '-off';
          }
        }
        inputQElem.value = queryText;

        final newVisibleUri = originalHrefUri.replace(
          queryParameters: {
            ...originalHrefUri.queryParameters,
            'q': queryText,
          },
        );

        final openSections = document
            .querySelectorAll('.search-form-section')
            .where((e) =>
                e.dataset.containsKey('section-tag') &&
                e.classes.contains('-active'))
            .map((e) => e.dataset['section-tag'])
            .whereType<String>()
            .join(' ');

        final requestUri = newVisibleUri.replace(
          path: newVisibleUri.path,
          queryParameters: {
            ...newVisibleUri.queryParameters,
            'open-sections': openSections,
          },
        );
        lastTargetUri = newVisibleUri;

        await updateBodyWithHttpGet(
          requestUri: requestUri,
          navigationUrl: windowUri.resolveUri(newVisibleUri).toString(),
          preupdateCheck: () => lastTargetUri == newVisibleUri,
        );

        // notify GTM on the click
        final action = link.dataset['action'];
        if (action != null && action.isNotEmpty) {
          gtmCustomEvent(
            category: 'click',
            action: '$action-$actionPostfix',
          );
        }
      }

      checkbox.onChange.listen(handleClick);
      link.onClick.listen(handleClick);
      e.onClick.listen(handleClick);
    }
  });
}

void _setEventForFiltersToggle() {
  document.querySelectorAll('.search-filters-btn').forEach((e) {
    e.onClick.listen((_) {
      document
          .querySelectorAll('.search-filters-btn-wrapper')
          .forEach((e) => e.classes.toggle('-active'));
      document
          .querySelector('.search-form-container')
          ?.classes
          .toggle('-active-on-mobile');
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
