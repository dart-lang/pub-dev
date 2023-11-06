// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:_pub_shared/format/x_ago_format.dart';

void setupHoverable() {
  _setEventForHoverable();
  _setEventForPackageTitleCopyToClipboard();
  _setEventForPreCodeCopyToClipboard();
  _setUpdateForXAgo();
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
  for (Element h in document.querySelectorAll('.hoverable')) {
    registerHoverable(h);
  }
}

/// Deactivates the active hover (hiding the hovering panel).
void deactivateHover(_) {
  if (_activeHover != null) {
    _activeHover!.classes.remove('hover');
    _activeHover = null;
  }
}

/// Registers the given Element to follow hoverable events.
void registerHoverable(Element h) {
  h.onClick.listen((e) {
    if (h != _activeHover) {
      deactivateHover(e);
      _activeHover = h;
      _activeHover!.classes.add('hover');
      e.stopPropagation();
    }
  });
  h.onMouseEnter.listen((e) {
    if (h != _activeHover) {
      deactivateHover(e);
    }
  });
}

void _setEventForPackageTitleCopyToClipboard() {
  final root = document.querySelector('.pkg-page-title-copy');
  final icon = root?.querySelector('.pkg-page-title-copy-icon');
  final feedback = root?.querySelector('.pkg-page-title-copy-feedback');
  if (root == null || icon == null || feedback == null) return;

  final copyContent = icon.dataset['copy-content'];
  if (copyContent == null || copyContent.isEmpty) return;

  icon.onClick.listen((_) async {
    _copyToClipboard(copyContent);
    await _animateCopyFeedback(feedback);
  });
}

Future<void> _animateCopyFeedback(Element feedback) async {
  feedback.classes.add('visible');
  await window.animationFrame;
  await Future.delayed(Duration(milliseconds: 1600));
  feedback.classes.add('fadeout');
  await window.animationFrame;
  // NOTE: keep in sync with _variables.scss 0.9s animation with the key
  //       $copy-feedback-transition-opacity-delay
  await Future.delayed(Duration(milliseconds: 900));
  await window.animationFrame;

  feedback.classes.remove('visible');
  feedback.classes.remove('fadeout');
}

void _copyToClipboard(String text) {
  final ta = TextAreaElement();
  ta.value = text;
  document.body!.append(ta);
  ta.select();
  document.execCommand('copy');
  ta.remove();
}

void _setEventForPreCodeCopyToClipboard() {
  document.querySelectorAll('.markdown-body pre').forEach((pre) {
    final container = DivElement()..classes.add('-pub-pre-copy-container');
    pre.replaceWith(container);
    container.append(pre);

    final button = DivElement()
      ..classes.add('-pub-pre-copy-button')
      ..setAttribute('title', 'copy to clipboard');
    container.append(button);

    final feedback = DivElement()
      ..classes.add('-pub-pre-copy-feedback')
      ..text = 'copied to clipboard';
    container.append(feedback);

    button.onClick.listen((_) async {
      final text = pre.dataset['textToCopy']?.trim() ?? pre.text!.trim();
      _copyToClipboard(text);
      await _animateCopyFeedback(feedback);
    });
  });
}

// Update x-ago labels periodically, and also at load time in case the page was stale in the cache.
void _setUpdateForXAgo() {
  void update() {
    document.querySelectorAll('a.-x-ago').forEach((e) {
      final timestampMillisAttr = e.getAttribute('data-timestamp');
      final timestampMillisValue = timestampMillisAttr == null
          ? null
          : int.tryParse(timestampMillisAttr);
      if (timestampMillisValue == null) {
        return;
      }
      final timestamp =
          DateTime.fromMillisecondsSinceEpoch(timestampMillisValue);
      final newLabel = formatXAgo(DateTime.now().difference(timestamp));
      final isToggled = e.dataset['toggled'] == '1';
      if (isToggled) {
        final oldLabel = e.getAttribute('title');
        if (oldLabel != newLabel) {
          e.setAttribute('title', newLabel);
        }
      } else {
        final oldLabel = e.text;
        if (oldLabel != newLabel) {
          e.text = newLabel;
        }
      }
    });
  }

  // Ever-increasing sleep during updates.
  var sleepDuration = Duration(minutes: 5);
  void schedule() {
    Timer(sleepDuration, () {
      update();
      sleepDuration += Duration(minutes: 5);
      schedule();
    });
  }

  update();
  schedule();
}

// Bind click events to switch between the title and the label on x-ago blocks.
void _setEventForXAgo() {
  document.querySelectorAll('a.-x-ago').forEach((e) {
    e.onClick.listen((event) {
      event.preventDefault();
      event.stopPropagation();
      final text = e.text;
      e.text = e.getAttribute('title');
      e.setAttribute('title', text!);
      e.dataset['toggled'] = (e.dataset['toggled'] == '1') ? '0' : '1';
    });
  });
}
