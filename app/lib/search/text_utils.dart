// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final RegExp _separators =
    new RegExp(r'[_\.,;=\(\)\>\<\[\]\{\}\|\?\!\/\+\-\*]|\s');
final RegExp _nonCharacterRegExp = new RegExp('[^a-z0-9]');
final RegExp _multiWhitespaceRegExp = new RegExp('\\s+');

const _descriptionExtensions = const <String, String>{
  'angular': 'angulardart',
};

String compactText(String text, {int maxLength: -1}) {
  if (text == null) return '';
  String t = text.replaceAll(_multiWhitespaceRegExp, ' ').trim();
  if (maxLength > 0 && t.length > maxLength) {
    t = t.substring(0, maxLength);
  }
  return t;
}

String compactDescription(String text) => compactText(text, maxLength: 500);
String compactReadme(String text) => compactText(text, maxLength: 1000);

String extendDescription(String package, String text) {
  final String extension = _descriptionExtensions[package];
  if (extension == null) return text;
  if (text == null) return extension;
  return '$text $extension';
}

String normalizeBeforeIndexing(String text) {
  if (text == null) return '';
  final String t = text
      .toLowerCase()
      .replaceAll(_nonCharacterRegExp, ' ')
      .replaceAll(_multiWhitespaceRegExp, ' ')
      .trim();
  return t;
}

Iterable<String> splitForIndexing(String text) {
  if (text == null || text.isEmpty) return new Iterable.empty();
  return text.split(_separators).where((s) => s.isNotEmpty);
}
