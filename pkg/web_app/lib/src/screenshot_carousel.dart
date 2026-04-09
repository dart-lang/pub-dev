// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:js_interop';

import 'package:web/web.dart';
import 'package:web_app/src/web_util.dart';

import '_focusability.dart';

void setupScreenshotCarousel() {
  _setEventForScreenshot();
}

void _setEventForScreenshot() {
  final carousel =
      document.getElementById('-screenshot-carousel') as HTMLElement?;
  if (carousel == null) {
    return;
  }
  final thumbnails = document.querySelectorAll('div[data-thumbnail]');
  final imageContainer = document.getElementById('-image-container')!;
  final prev = document.getElementById('-carousel-prev') as HTMLElement;
  final next = document.getElementById('-carousel-next') as HTMLElement;
  final description =
      document.getElementById('-screenshot-description') as HTMLElement;
  final existingImageElement =
      document.getElementById('-carousel-image') as HTMLElement?;
  final HTMLElement imageElement;
  if (existingImageElement != null) {
    imageElement = existingImageElement;
  } else {
    imageElement = document.createElement('img') as HTMLElement;
    imageElement.id = '-carousel-image';
    imageContainer.append(imageElement);
    imageElement.className = 'carousel-image';
  }

  HTMLElement? focusedTriggerSourceElement;
  void Function()? restoreFocusabilityFn;
  var images = <String>[];
  var descriptions = <String>[];

  void hideElement(HTMLElement element) {
    element.style.display = 'none';
  }

  void showElement(HTMLElement element) {
    element.style.display = 'flex';
  }

  void showImage(int index) {
    hideElement(description);
    hideElement(imageElement);
    imageElement.setAttribute('src', images[index]);
    description.innerText = descriptions[index];

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
      showElement(imageElement);
      showElement(description);
    });
  }

  var screenshotIndex = 0;
  for (final thumbnail in thumbnails.toElementList()) {
    void setup() {
      restoreFocusabilityFn = disableAllFocusability(
        allowedComponents: [prev, next],
      );
      focusedTriggerSourceElement = thumbnail as HTMLElement;
      showElement(carousel);
      document.body!.classList
        ..remove('overflow-auto')
        ..add('overflow-hidden');
      images = thumbnail.getAttribute('data-thumbnail')!.split(',');
      final raw = jsonDecode(
        thumbnail.getAttribute('data-thumbnail-descriptions-json')!,
      );
      descriptions = (raw as List).cast<String>();
      showImage(screenshotIndex);
    }

    thumbnail.parentElement!.onClick.listen((event) {
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
    document.body!.classList
      ..remove('overflow-hidden')
      ..add('overflow-auto');
    screenshotIndex = 0;
    images.clear();
    descriptions.clear();
    focusedTriggerSourceElement?.focus();
    focusedTriggerSourceElement = null;
    restoreFocusabilityFn?.call();
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

  document.addEventListener(
    'keydown',
    (KeyboardEvent event) {
      if (carousel.style.display == 'none') {
        return;
      }

      if (event.key == 'Escape') {
        event.stopPropagation();
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
    }.toJS,
  );
}
