// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '_cache.dart';

/// Renders the `views/shared/widget/button.mustache` template.
String renderButton({
  @required String label,
  String id,
  List<String> classes,
  Map<String, String> data,
  bool danger = false,
  bool flat = false,
}) {
  final allClasses = <String>[
    if (classes != null) ...classes,
    if (danger) 'pub-button-danger',
    'mdc-button',
    if (!flat) 'mdc-button--raised',
  ];
  return templateCache.renderTemplate('shared/widget/button', {
    'id': id,
    'classes': allClasses.join(' '),
    'data': data == null
        ? null
        : data.entries
            .map((e) => {
                  'key': e.key,
                  'value': e.value,
                })
            .toList(),
    'label': label,
  });
}
