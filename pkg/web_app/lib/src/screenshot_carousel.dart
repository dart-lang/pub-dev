// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

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

  List<String> images = [];
  List<String> descriptions = [];

  void hideElement(Element element) {
    element.style.display = 'none';
  }

  void showElement(Element element) {
    element.style.display = 'flex';
  }

  void showImage(int index, UIEvent event) {
    event.stopPropagation();
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

    imageElement.onLoad.listen((event) {
      showElement(imageElement!);
      showElement(description);
    });
  }

  int screenshotIndex = 0;
  for (final thumbnail in thumbnails) {
    thumbnail.parent!.onClick.listen((event) {
      showElement(carousel);
      document.body!.classes.remove('overflow-auto');
      document.body!.classes.add('overflow-hidden');
      images = thumbnail.dataset['thumbnail']!.split(',');
      descriptions = thumbnail.dataset['thumbnail-descriptions']!.split(',');
      showImage(screenshotIndex, event);
    });
  }

  void closeCarousel(UIEvent event) {
    event.stopPropagation;
    hideElement(carousel);
    hideElement(next);
    hideElement(prev);
    hideElement(description);
    document.body!.classes.remove('overflow-hidden');
    document.body!.classes.add('overflow-auto');
    screenshotIndex = 0;
  }

  prev.onClick.listen((event) => showImage(--screenshotIndex, event));

  next.onClick.listen((event) => showImage(++screenshotIndex, event));

  imageElement.onClick.listen((event) => event.stopPropagation());

  carousel.onClick.listen((event) => closeCarousel(event));

  document.onKeyDown.listen((event) {
    if (carousel.style.display == 'none') {
      return;
    }

    if (event.key == 'Escape') {
      closeCarousel(event);
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
  });
}
