// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/format/x_ago_format.dart';
import 'package:web/web.dart';
import 'package:web_app/src/web_util.dart';

void setupHoverable() {
  _setEventForHoverable();
  _setEventForPackageTitleCopyToClipboard();
  _setEventForPreCodeCopyToClipboard();
  _updateXAgoLabels();
  _setEventForXAgo();
}

Element? _activeHover;

/// Elements with the `hoverable` class provide hover tooltip for both desktop
/// browsers and touchscreen devices:
///   - when clicked, they are added a `hover` class (toggled on repeated clicks)
///   - when any outside part is clicked, the `hover` class is removed
///   - when the mouse enters *another* `hoverable` element, the previously
///     active has its style removed
///
///  Their `:hover` and `.hover` style must match to have the same effect.
void _setEventForHoverable() {
  document.body!.onClick.listen(deactivateHover);
  window.onKeyDown.listen((e) {
    if (e.key != 'Escape') return;
    final activeElement = document.activeElement;
    final focusedHoverable = activeElement is Element
        ? activeElement.closest('.hoverable')
        : null;
    deactivateHover(e);
    for (final h
        in document.querySelectorAll('.hoverable:hover').toElementList()) {
      h.classList.add('-hover-dismissed');
    }
    if (focusedHoverable != null) {
      _hoverableTrigger(focusedHoverable)?.focus();
    }
  });
  for (final h in document.querySelectorAll('.hoverable').toElementList()) {
    registerHoverable(h);
  }
}

HTMLElement? _hoverableTrigger(Element h) =>
    h.querySelector(
          '.nav-main-button, .nav-profile-img, .sort-control-selected',
        )
        as HTMLElement?;

List<HTMLElement> _hoverableMenuItems(Element h) => h
    .querySelectorAll(
      '.nav-hover-popup a, .nav-hover-popup button, .sort-control-popup button',
    )
    .toElementList<HTMLElement>();

/// Deactivates the active hover (hiding the hovering panel).
void deactivateHover(_) {
  if (_activeHover case final activeHoverElement?) {
    activeHoverElement.classList.remove('hover');
    _activeHover = null;
  }
}

void _activateHover(Element h, {bool focusFirstItem = false}) {
  if (h != _activeHover) {
    deactivateHover(null);
    _activeHover = h;
    h.classList.add('hover');
  }
  h.classList.remove('-hover-dismissed');
  if (focusFirstItem) {
    final items = _hoverableMenuItems(h);
    if (items.isNotEmpty) {
      items.first.focus();
    }
  }
}

/// Registers the given Element to follow hoverable events.
void registerHoverable(Element h) {
  h.onClick.listen((e) {
    final target = e.target;
    if (target is Element &&
        target.closest('.nav-hover-popup, .sort-control-popup') != null) {
      return;
    }
    if (h != _activeHover) {
      _activateHover(h, focusFirstItem: true);
      e.stopPropagation();
    } else {
      deactivateHover(e);
      e.stopPropagation();
    }
  });
  h.onMouseEnter.listen((e) {
    h.classList.remove('-hover-dismissed');
    if (h != _activeHover) {
      deactivateHover(e);
    }
  });
  h.onMouseLeave.listen((_) {
    h.classList.remove('-hover-dismissed');
  });
  EventStreamProvider<FocusEvent>('focusout').forTarget(h).listen((e) {
    final related = e.relatedTarget;
    if (related is! Node || !h.contains(related)) {
      if (_activeHover == h) {
        deactivateHover(e);
      }
    }
  });
  h.onKeyDown.listen((e) {
    if (e.key != 'ArrowDown' && e.key != 'ArrowUp') return;
    final items = _hoverableMenuItems(h);
    if (items.isEmpty) return;
    e.preventDefault();
    _activateHover(h);
    final active = document.activeElement;
    final currentIndex = active is HTMLElement ? items.indexOf(active) : -1;
    if (e.key == 'ArrowDown') {
      final nextIndex = currentIndex < 0
          ? 0
          : (currentIndex + 1) % items.length;
      items[nextIndex].focus();
    } else {
      final prevIndex = currentIndex <= 0 ? items.length - 1 : currentIndex - 1;
      items[prevIndex].focus();
    }
  });
}

void _setEventForPackageTitleCopyToClipboard() {
  final roots = document.querySelectorAll('.pkg-page-title-copy');
  for (final root in roots.toList().whereType<Element>()) {
    final icon =
        root.querySelector('.pkg-page-title-copy-icon') as HTMLElement?;
    if (icon == null) continue;
    final feedback = root.querySelector('.pkg-page-title-copy-feedback');
    if (feedback == null) continue;
    final copyContent = icon.getAttribute('data-copy-content');
    if (copyContent == null || copyContent.isEmpty) continue;
    _setupCopyAndFeedbackButton(
      copy: icon,
      feedback: feedback,
      textFn: () => copyContent,
    );
  }
}

Future<void> _animateCopyFeedback(Element feedback) async {
  feedback.classList.add('visible');
  await window.animationFrame;
  await Future<void>.delayed(Duration(milliseconds: 1600));
  feedback.classList.add('fadeout');
  await window.animationFrame;
  // NOTE: keep in sync with _variables.scss 0.9s animation with the key
  //       $copy-feedback-transition-opacity-delay
  await Future<void>.delayed(Duration(milliseconds: 900));
  await window.animationFrame;

  feedback.classList
    ..remove('visible')
    ..remove('fadeout');
}

void _copyToClipboard(String text) {
  final ta = HTMLTextAreaElement();
  ta.value = text;
  document.body!.append(ta);
  ta.select();
  document.execCommand('copy');
  ta.remove();
}

void _setEventForPreCodeCopyToClipboard() {
  final elements = document
      .querySelectorAll('.markdown-body pre')
      .toElementList<HTMLElement>();
  elements.forEach((pre) {
    final container = HTMLDivElement()
      ..classList.add('-pub-pre-copy-container');
    pre.replaceWith(container);
    container.append(pre);

    final button = HTMLDivElement()
      ..classList.addAll(['-pub-pre-copy-button', 'filter-invert-on-dark'])
      ..setAttribute('title', 'copy to clipboard');
    container.append(button);

    final feedback = HTMLDivElement()
      ..classList.add('-pub-pre-copy-feedback')
      ..textContent = 'copied to clipboard';
    container.append(feedback);

    _setupCopyAndFeedbackButton(
      copy: button,
      feedback: feedback,
      textFn: () {
        final text = pre.getAttribute('data-text-to-copy')?.trim();
        if (text != null && text.isNotEmpty) {
          return text;
        }
        return pre.textContent?.trim() ?? '';
      },
    );
  });
}

void _setupCopyAndFeedbackButton({
  required HTMLElement copy,
  required Element feedback,
  required String Function() textFn,
}) {
  copy.setAttribute('tabindex', '0');

  Future<void> doCopy() async {
    final text = textFn();
    _copyToClipboard(text);
    await _animateCopyFeedback(feedback);
    // return focus to the icon
    copy.focus();
  }

  copy.onClick.listen((_) => doCopy());
  copy.onKeyDown.listen((event) async {
    if (event.key == 'Enter') {
      event.preventDefault();
      await doCopy();
    }
  });
}

// Update x-ago labels at load time in case the page was stale in the cache.
void _updateXAgoLabels() {
  document.querySelectorAll('a.-x-ago').toElementList().forEach((e) {
    final timestampMillisAttr = e.getAttribute('data-timestamp');
    final timestampMillisValue = timestampMillisAttr == null
        ? null
        : int.tryParse(timestampMillisAttr);
    if (timestampMillisValue == null) {
      return;
    }
    final timestamp = DateTime.fromMillisecondsSinceEpoch(timestampMillisValue);
    final newLabel = formatXAgo(DateTime.now().difference(timestamp));
    final oldLabel = e.textContent;
    if (oldLabel != newLabel) {
      e.textContent = newLabel;
    }
  });
}

// Bind click events to switch between the title and the label on x-ago blocks.
void _setEventForXAgo() {
  document.querySelectorAll('a.-x-ago').toElementList().forEach((e) {
    e.onClick.listen((event) {
      event.preventDefault();
      event.stopPropagation();
      final text = e.textContent;
      e.textContent = e.getAttribute('title') ?? '';
      e.setAttribute('title', text!);
    });
  });
}
