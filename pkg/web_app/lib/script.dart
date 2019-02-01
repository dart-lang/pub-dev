// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';

Element tabRoot;
List<Element> tabContents;

void main() {
  tabRoot = document.querySelector('.js-tabs');
  tabContents = document.querySelectorAll('.js-content');
  _setEventsForTabs();
  _setEventForAnchorScroll();
  _setEventForHoverable();
  _setEventForMobileNav();
  _setEventForHashChange();
  _setEventForSearchInput();
  _guardReportIssue();
  _fixIssueLinks();
  _setEventForSortControl();
  _setEventForCheckboxChanges();
  _updateDartdocStatus();
}

void _setEventsForTabs() {
  if (tabRoot != null && tabContents.isNotEmpty) {
    tabRoot.onClick.listen((e) {
      // locate the <li> tag
      Element target = e.target as Element;
      while (target != null &&
          target.tagName.toLowerCase() != 'li' &&
          target.tagName.toLowerCase() != 'body') {
        target = target.parent;
      }
      final String targetName = target?.dataset['name'];
      if (targetName != null) {
        window.location.hash = '#$targetName';
      }
    });
  }
}

void _setEventForAnchorScroll() {
  document.body.onClick.listen((e) {
    // locate the <a> tag
    Element target = e.target as Element;
    while (target != null &&
        target.tagName.toLowerCase() != 'a' &&
        target.tagName.toLowerCase() != 'body') {
      target = target.parent;
    }
    if (target is AnchorElement &&
        target.getAttribute('href') == target.hash &&
        target.hash != null &&
        target.hash.isNotEmpty) {
      final Element elem = document.querySelector(target.hash);
      if (elem != null) {
        window.history.pushState({}, document.title, target.hash);
        e.preventDefault();
        _scrollTo(elem);
      }
    }
  });
}

/// Elements with the `hoverable` class provide hover tooltip for both desktop
/// browsers and touchscreen devices:
///   - when clicked, they are added a `hover` class (toggled on repeated clicks)
///   - when any outside part is clicked, the `hover` class is removed
///   - when the mouse enters *another* `hoverable` element, the previously
///     active has its style removed
///
///  Their `:hover` and `.hover` style must match to have the same effect.
void _setEventForHoverable() {
  Element activeHover;
  void deactivateHover(_) {
    if (activeHover != null) {
      activeHover.classes.remove('hover');
      activeHover = null;
    }
  }

  document.body.onClick.listen(deactivateHover);

  for (Element h in document.querySelectorAll('.hoverable')) {
    h.onClick.listen((e) {
      if (h != activeHover) {
        deactivateHover(e);
        activeHover = h;
        activeHover.classes.add('hover');
        e.stopPropagation();
      }
    });
    h.onMouseEnter.listen((e) {
      if (h != activeHover) {
        deactivateHover(e);
      }
    });
  }
}

void _setEventForMobileNav() {
  // hamburger menu on mobile
  final Element hamburger = document.querySelector('.hamburger');
  final Element close = document.querySelector('.close');
  final Element mask = document.querySelector('.mask');
  final Element nav = document.querySelector('.nav-wrap');

  hamburger.onClick.listen((_) {
    nav.classes.add('-show');
    mask.classes.add('-show');
  });
  close.onClick.listen((_) {
    nav.classes.remove('-show');
    mask.classes.remove('-show');
  });
  mask.onClick.listen((_) {
    nav.classes.remove('-show');
    mask.classes.remove('-show');
  });
}

/// change the tab based on URL hash
void _changeTabOnUrlHash() {
  if (tabRoot == null) return;
  String hash = window.location.hash ?? '';
  if (hash.startsWith('#')) {
    hash = hash.substring(1);
  }
  // Navigating back to a non-hashed package page will result an empty hash.
  // Displaying the default tab: readme.
  if (hash.isEmpty) {
    _changeTab('-readme-tab-');
  } else {
    if (hash.startsWith('pub-pkg-tab-')) {
      hash = '-${hash.substring(12)}-tab-';
      window.location.hash = '#$hash';
    }
    _changeTab(hash);
  }
}

String _getTabName(Element elem) {
  final isTabContainer =
      elem.classes.contains('tab') || elem.classes.contains('content');
  if (isTabContainer && elem.dataset['name'] != null) {
    return elem.dataset['name'];
  }
  if (elem.parent == null) {
    return null;
  }
  return _getTabName(elem.parent);
}

void _changeTab(String name) {
  final tabOrContentElem =
      tabRoot.querySelector('[data-name="${Uri.encodeQueryComponent(name)}"]');
  if (tabOrContentElem != null) {
    // toggle tab highlights
    tabRoot.children.forEach((node) {
      if (node.dataset['name'] != name) {
        node.classes.remove('-active');
      } else {
        node.classes.add('-active');
      }
    });
    // toggle content
    tabContents.forEach((node) {
      if (node.dataset['name'] != name) {
        node.classes.remove('-active');
      } else {
        node.classes.add('-active');
      }
    });
  }
}

void _scrollToHash() {
  final String hash = window.location.hash ?? '';
  if (hash.isNotEmpty) {
    final id = hash.startsWith('#') ? hash.substring(1) : hash;
    final list =
        document.querySelectorAll('[id="${Uri.encodeQueryComponent(id)}"]');
    if (list.isEmpty) {
      return;
    }
    // if there is an element on the current tab, scroll to it
    final firstVisible =
        list.firstWhere((e) => e.offsetHeight > 0, orElse: () => null);
    if (firstVisible != null) {
      _scrollTo(firstVisible);
      return;
    }
    // switch to the first tab that has the element
    for (Element elem in list) {
      final tabName = _getTabName(elem);
      if (tabName != null) {
        _changeTab(tabName);
        _scrollTo(elem);
        return;
      }
    }
    // fallback, should not happen
    _scrollTo(list.first);
  }
}

void _setEventForHashChange() {
  window.onHashChange.listen((_) {
    _changeTabOnUrlHash();
    _fixIssueLinks();
    _scrollToHash();
  });
  _changeTabOnUrlHash();
  _fixIssueLinks();
  _scrollToHash();
}

Future _scrollTo(Element elem) async {
  // Chrome could provide inconsistent position data just after the page has
  // been loaded. The first animation frame makes sure that the rendering is
  // stabilized and the position data is correct.
  await window.animationFrame;
  final int stepCount = 30;
  for (int i = 0; i < stepCount; i++) {
    await window.animationFrame;
    final int offsetTop = elem.offsetTop - 12;
    final int scrollY = window.scrollY;
    final int diff = offsetTop - scrollY;
    // Stop early if the browser already jumped to it.
    if (i == 0 && diff <= 12) {
      break;
    }
    window.scrollTo(window.scrollX, scrollY + diff * (i + 1) ~/ stepCount);
  }
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
  final Element sortControl = document.getElementById('sort-control');
  final queryText = document.querySelector('input[name="q"]') as InputElement;
  if (sortControl == null || queryText == null) return;
  final formElement = queryText.form;

  final String originalSort = sortControl.dataset['sort'] ?? '';
  sortControl.innerHtml = '';
  final select = new SelectElement();

  void add(String sort, String label) {
    select.append(new OptionElement(
        value: sort, data: label, selected: originalSort == sort));
  }

  // Synchronize with `_consts.dart`'s SortDict.
  if (queryText.value.trim().isEmpty) {
    add('listing_relevance', 'listing relevance');
  } else {
    add('search_relevance', 'search relevance');
  }
  add('top', 'overall score');
  add('updated', 'recently updated');
  add('created', 'newest package');
  add('popularity', 'popularity');

  select.onChange.listen((_) {
    final String value = select.selectedOptions.first.value;
    InputElement sortInput =
        document.querySelector('input[name="sort"]') as InputElement;
    if (sortInput == null) {
      sortInput = new InputElement(type: 'hidden')..name = 'sort';
      queryText.parent.append(sortInput);
    }
    if (value == 'listing_relevance' || value == 'search_relevance') {
      sortInput.remove();
    } else {
      sortInput.value = value;
    }

    // Removes the q= part from the URL
    if (queryText.value.isEmpty) {
      queryText.name = '';
    }

    // TODO: instead of submitting, compose the URL here (also removing the single `?`)
    formElement.submit();
  });
  sortControl.append(select);
}

void _setEventForCheckboxChanges() {
  final hiddenApiField =
      document.getElementById('search-api-field') as InputElement;
  final visibleApiCheckbox =
      document.getElementById('search-api-checkbox') as CheckboxInputElement;
  if (hiddenApiField != null && visibleApiCheckbox != null) {
    final formElement = hiddenApiField.form;
    visibleApiCheckbox.onChange.listen((_) {
      hiddenApiField.disabled = visibleApiCheckbox.checked;
      // TODO: instead of submitting, compose the URL here (also removing the single `?`)
      formElement.submit();
    });
  }

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

void _guardReportIssue() {
  for (AnchorElement bugLink in document.querySelectorAll('a.github_issue')) {
    bugLink.onClick.listen((event) {
      if (!window.confirm('This link is for reporting issues for the pub site. '
          'If you would like to report a problem with a package, please visit '
          'its homepage or contact its developers.')) {
        event.preventDefault();
      }
    });
  }
}

void _fixIssueLinks() {
  for (AnchorElement bugLink in document.querySelectorAll('a.github_issue')) {
    var url = Uri.parse(bugLink.href);
    final lines = <String>[
      'URL: ${window.location.href}',
      '',
      '<Describe your issue or suggestion here>'
    ];

    final issueLabels = ['Area: site feedback'];

    var bugTitle = '<Summarize your issues here>';
    final bugTag = bugLink.dataset['bugTag'];
    if (bugTag != null) {
      bugTitle = '[$bugTag] $bugTitle';
      if (bugTag == 'analysis') {
        issueLabels.add('Area: package analysis');
      }
    }

    final queryParams = {
      'body': lines.join('\n'),
      'title': bugTitle,
      'labels': issueLabels.join(',')
    };

    url = url.replace(queryParameters: queryParams);
    bugLink.href = url.toString();
  }
}

void _updateDartdocStatus() {
  final List<String> packages = document
      .querySelectorAll('.version-table')
      .map((e) => e.dataset['package'])
      .where((s) => s != null && s.isNotEmpty)
      .toSet()
      .toList();

  Future update(String package) async {
    final List<Element> tables = document
        .querySelectorAll('.version-table')
        .where((e) => e.dataset['package'] == package)
        .toList();
    for (Element table in tables) {
      table.querySelectorAll('td.documentation').forEach((e) {
        e.dataset[_hasDocumentationAttr] = '-'; // unknown value
      });
    }

    try {
      final content =
          await HttpRequest.getString('/api/documentation/$package');
      final map = json.decode(content) as Map;
      final versionsList = map['versions'] as List;
      for (Map versionMap in versionsList.cast<Map>()) {
        final version = versionMap['version'] as String;
        final hasDocumentation = versionMap['hasDocumentation'] as bool;
        final status = versionMap['status'] as String;
        for (Element table in tables) {
          table
              .querySelectorAll('tr')
              .where((e) => e.dataset['version'] == version)
              .forEach(
            (row) {
              final docCol = row.querySelector('.documentation');
              if (docCol == null) return;
              final docLink = docCol.querySelector('a') as AnchorElement;
              if (docLink == null) return;
              if (status == 'awaiting') {
                docCol.dataset[_hasDocumentationAttr] = '...';
                docLink.text = 'awaiting';
              } else if (hasDocumentation) {
                docCol.dataset[_hasDocumentationAttr] = '1';
              } else {
                docCol.dataset[_hasDocumentationAttr] = '0';
                docLink.href += 'log.txt';
                docLink.text = 'failed';
              }
            },
          );
        }
      }

      // clear unknown values
      for (Element table in tables) {
        table.querySelectorAll('td.documentation').forEach((docCol) {
          if (docCol.dataset[_hasDocumentationAttr] == '-') {
            final docLink = docCol.querySelector('a') as AnchorElement;
            if (docLink != null) {
              docLink.remove();
            }
          }
        });
      }
    } catch (_) {
      // ignore errors
    }
  }

  for (String package in packages) {
    update(package);
  }
}

const _hasDocumentationAttr = 'hasDocumentation';
