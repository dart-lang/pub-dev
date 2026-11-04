// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart';

import 'web_util.dart';

bool _initialized = false;
String? _selectedVersion;
int? _selectedOrder;

/// Sets up two-click version comparison on the package Versions / Changelog tab.
void setupVersionCompare() {
  if (_initialized) return;
  _initialized = true;

  document.body?.onClick.listen((MouseEvent event) {
    final target = event.target;
    if (target == null || !target.isA<Element>()) return;
    final elem = target as Element;

    final compareBtn = elem.closest('.version-compare-btn');
    if (compareBtn != null && compareBtn.isA<HTMLElement>()) {
      event.preventDefault();
      _handleCompareButtonClick(compareBtn as HTMLElement);
      return;
    }

    final expandBtn = elem.closest('.changelog-expand-btn');
    if (expandBtn != null && expandBtn.isA<HTMLElement>()) {
      event.preventDefault();
      final entry = expandBtn.closest('.version-changelog-entry');
      if (entry != null) {
        final isCollapsed = entry.classList.toggle('-is-collapsed');
        expandBtn.textContent = isCollapsed ? 'Show more ▾' : 'Show less ▴';
      }
      return;
    }

    final toggleChangelogsBtn = elem.closest('.version-toggle-changelogs-btn');
    if (toggleChangelogsBtn != null && toggleChangelogsBtn.isA<HTMLElement>()) {
      event.preventDefault();
      final tables = document
          .querySelectorAll('table.version-table')
          .toElementList<HTMLElement>();
      var hidden = false;
      for (final t in tables) {
        hidden = t.classList.toggle('-hide-changelogs');
      }
      toggleChangelogsBtn.textContent = hidden
          ? 'Show changelogs'
          : 'Hide changelogs';
      return;
    }

    final swapOrReset = elem.closest(
      '.version-range-diff-swap, .version-range-diff-reset',
    );
    if (swapOrReset != null && swapOrReset.isA<HTMLAnchorElement>()) {
      final href = (swapOrReset as HTMLAnchorElement).getAttribute('href');
      if (href != null && href.isNotEmpty) {
        event.preventDefault();
        _selectedVersion = null;
        _selectedOrder = null;
        unawaited(_loadRangeDiff(href, scrollToDiff: href.contains('?')));
      }
    }
  });

  document.body?.onKeyDown.listen((KeyboardEvent event) {
    if (event.key == 'Escape' && _selectedVersion != null) {
      _clearSelection();
    }
  });
}

void _handleCompareButtonClick(HTMLElement btn) {
  final version = btn.getAttribute('data-compare-version');
  if (version == null || version.isEmpty) return;
  final order = int.tryParse(btn.getAttribute('data-compare-order') ?? '') ?? 0;

  // Clicking the already-selected first version cancels selection.
  if (_selectedVersion == version) {
    _clearSelection();
    return;
  }

  // First click: select this version as the anchor.
  if (_selectedVersion == null) {
    _selectedVersion = version;
    _selectedOrder = order;
    _updateRowsForFirstSelection(version, order);
    return;
  }

  // Second click: order (from, to) chronologically (larger order index is older).
  final firstVer = _selectedVersion!;
  final firstOrder = _selectedOrder ?? 0;
  _selectedVersion = null;
  _selectedOrder = null;

  final String fromVer;
  final String toVer;
  if (order > firstOrder) {
    fromVer = version;
    toVer = firstVer;
  } else {
    fromVer = firstVer;
    toVer = version;
  }

  final box = document.getElementById('range-diff');
  final actionUrl =
      box?.getAttribute('data-action-url') ?? window.location.pathname;
  final targetUrl =
      '$actionUrl?from=${Uri.encodeQueryComponent(fromVer)}'
      '&to=${Uri.encodeQueryComponent(toVer)}';
  unawaited(
    _loadRangeDiff(
      targetUrl,
      fromVer: fromVer,
      toVer: toVer,
      scrollToDiff: true,
    ),
  );
}

void _updateRowsForFirstSelection(String selectedVer, int selectedOrder) {
  final rows = document
      .querySelectorAll('tr.version-row')
      .toElementList<HTMLElement>();
  for (final row in rows) {
    row.classList.remove('-compare-selected');
  }
  final buttons = document
      .querySelectorAll('.version-compare-btn')
      .toElementList<HTMLElement>();
  for (final btn in buttons) {
    final ver = btn.getAttribute('data-compare-version') ?? '';
    final order =
        int.tryParse(btn.getAttribute('data-compare-order') ?? '') ?? 0;
    final row = btn.closest('tr.version-row');
    if (ver == selectedVer) {
      row?.classList.add('-compare-selected');
      btn.classList.add('-is-selected');
      btn.textContent = 'Selected ✕';
    } else {
      btn.classList.remove('-is-selected');
      final fromVer = order > selectedOrder ? ver : selectedVer;
      final toVer = order > selectedOrder ? selectedVer : ver;
      btn.textContent = '$fromVer → $toVer';
    }
  }
  final hint = document.querySelector('.version-range-diff-hint');
  if (hint != null) {
    hint.textContent =
        'Selected $selectedVer — click a second version below to diff (or Esc to cancel).';
  }
}

void _clearSelection() {
  _selectedVersion = null;
  _selectedOrder = null;
  final uri = Uri.parse(window.location.href);
  final activeFrom = uri.queryParameters['from'];
  final activeTo = uri.queryParameters['to'];
  _restoreEndpointLabels(activeFrom: activeFrom, activeTo: activeTo);
}

void _restoreEndpointLabels({String? activeFrom, String? activeTo}) {
  final rows = document
      .querySelectorAll('tr.version-row')
      .toElementList<HTMLElement>();
  for (final row in rows) {
    final ver = row.getAttribute('data-version');
    row.classList.remove('-compare-selected');
    row.classList.toggle('-compare-from', ver != null && ver == activeFrom);
    row.classList.toggle('-compare-to', ver != null && ver == activeTo);
    row.classList.toggle(
      '-compare-endpoint',
      ver != null && (ver == activeFrom || ver == activeTo),
    );
  }
  final buttons = document
      .querySelectorAll('.version-compare-btn')
      .toElementList<HTMLElement>();
  for (final btn in buttons) {
    final ver = btn.getAttribute('data-compare-version') ?? '';
    btn.classList.remove('-is-selected');
    final isFrom = ver == activeFrom;
    final isTo = ver == activeTo;
    btn.classList.toggle('-is-endpoint', isFrom || isTo);
    if (isFrom && isTo) {
      btn.textContent = 'Comparing';
    } else if (isFrom) {
      btn.textContent = 'Base';
    } else if (isTo) {
      btn.textContent = 'Target';
    } else {
      btn.textContent = '⇄';
    }
  }
  final hint = document.querySelector('.version-range-diff-hint');
  if (hint != null) {
    if (activeFrom != null && activeTo != null) {
      hint.textContent =
          'Comparing public API: $activeFrom → $activeTo '
          '(click ⇄ on any version to start a new comparison)';
    } else {
      hint.textContent =
          '⇄ Click ⇄ next to any two versions to diff their public APIs.';
    }
  }
}

Future<void> _loadRangeDiff(
  String targetUrl, {
  String? fromVer,
  String? toVer,
  bool scrollToDiff = false,
}) async {
  try {
    final response = await window.fetch(targetUrl.toJS).toDart;
    if (!response.ok) {
      window.location.href = targetUrl;
      return;
    }
    final htmlText = (await response.text().toDart).toDart;
    final parser = DOMParser();
    final doc = parser.parseFromString(htmlText.toJS, 'text/html');
    final newBox = doc.getElementById('range-diff');
    final currentBox = document.getElementById('range-diff');
    if (newBox == null || currentBox == null) {
      window.location.href = targetUrl;
      return;
    }
    currentBox.replaceWith(newBox);
    window.history.pushState(null, '', targetUrl);
    final parsedUri = Uri.parse(window.location.href);
    _restoreEndpointLabels(
      activeFrom: fromVer ?? parsedUri.queryParameters['from'],
      activeTo: toVer ?? parsedUri.queryParameters['to'],
    );
    if (scrollToDiff) {
      newBox.scrollIntoView();
    }
  } catch (_) {
    window.location.href = targetUrl;
  }
}
