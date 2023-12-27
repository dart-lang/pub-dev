// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';

import 'package:web_app/src/_dom_helper.dart';

void setupScreenshotCarousel() {
  _setEventForScreenshot();
}

void _setEventForScreenshot() {
  final carousel = document.getElementById('-screenshot-carousel');
  if (carousel == null) {
    return;
  }
  final thumbnails = document.querySelectorAll('div[data-thumbnail]');
  final imageContainer = document.getElementById('-image-container')!;
  final prev = document.getElementById('-carousel-prev')!;
  final next = document.getElementById('-carousel-next')!;
  final description =
      document.getElementById('-screenshot-description') as ParagraphElement;
  ImageElement? imageElement =
      document.getElementById('-carousel-image') as ImageElement?;
  if (imageElement == null) {
    imageElement = ImageElement();
    imageElement.id = '-carousel-image';
    imageContainer.children.add(imageElement);
    imageElement.className = 'carousel-image';
  }

  Element? focusedTriggerSourceElement;
  Function? restoreFocusabilityFn;
  List<String> images = [];
  List<String> descriptions = [];

  void hideElement(Element element) {
    element.style.display = 'none';
  }

  void showElement(Element element) {
    element.style.display = 'flex';
  }

  void showImage(int index) {
    hideElement(description);
    hideElement(imageElement!);
    imageElement.src = images[index];
    description.text = descriptions[index];

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

    imageElement.onLoad.listen((_) {
      showElement(imageElement!);
      showElement(description);
    });
  }

  int screenshotIndex = 0;
  for (final thumbnail in thumbnails) {
    void setup() {
      restoreFocusabilityFn = disableAllFocusability(
        allowedComponents: [
          prev,
          next,
        ],
      );
      focusedTriggerSourceElement = thumbnail;
      showElement(carousel);
      document.body!.classes.remove('overflow-auto');
      document.body!.classes.add('overflow-hidden');
      images = thumbnail.dataset['thumbnail']!.split(',');
      final raw = jsonDecode(thumbnail.dataset['thumbnail-descriptions-json']!);
      descriptions = (raw as List).cast<String>();
      showImage(screenshotIndex);
    }

    thumbnail.parent!.onClick.listen((event) {
      event.stopPropagation();
      setup();
    });
    thumbnail.onKeyDown.listen((event) {
      if (event.key == 'Enter') {
        event.stopPropagation();
        setup();
      }
    });
  }

  void closeCarousel() {
    hideElement(carousel);
    hideElement(next);
    hideElement(prev);
    hideElement(description);
    document.body!.classes.remove('overflow-hidden');
    document.body!.classes.add('overflow-auto');
    screenshotIndex = 0;
    images.clear();
    descriptions.clear();
    focusedTriggerSourceElement?.focus();
    focusedTriggerSourceElement = null;
    if (restoreFocusabilityFn != null) {
      restoreFocusabilityFn!();
    }
  }

  void gotoPrev() {
    showImage(--screenshotIndex);
    prev.focus();
  }

  void gotoNext() {
    showImage(++screenshotIndex);
    next.focus();
  }

  prev.onClick.listen((event) {
    event.stopPropagation();
    gotoPrev();
  });
  prev.onKeyDown.listen((event) {
    if (event.key == 'Enter') {
      event.stopPropagation();
      gotoPrev();
    }
  });

  next.onClick.listen((event) {
    event.stopPropagation();
    gotoNext();
  });
  next.onKeyDown.listen((event) {
    if (event.key == 'Enter') {
      event.stopPropagation();
      gotoNext();
    }
  });

  imageElement.onClick.listen((event) => event.stopPropagation());

  carousel.onClick.listen((event) {
    event.stopPropagation();
    closeCarousel();
  });

  document.onKeyDown.listen((event) {
    if (carousel.style.display == 'none') {
      return;
    }

    if (event.key == 'Escape') {
      event.stopPropagation;
      closeCarousel();
    }
    if (event.key == 'ArrowLeft') {
      if (screenshotIndex > 0) {
        event.stopPropagation();
        gotoPrev();
      }
    }
    if (event.key == 'ArrowRight') {
      if (screenshotIndex < images.length - 1) {
        event.stopPropagation();
        gotoNext();
      }
    }
  });
}
