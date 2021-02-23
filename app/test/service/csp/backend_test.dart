// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/secret/backend.dart';
import 'package:test/test.dart';

import 'package:pub_dev/service/csp/backend.dart';

import '../../shared/test_services.dart';

void main() {
  Map<String, List<String>> getCspValues() {
    final result = <String, List<String>>{};
    for (final part in cspBackend.cspValue.split(';')) {
      final list = part.split(' ');
      result[list.first] = list.sublist(1).toList();
    }
    return result;
  }

  testWithProfile('default keys', fn: () async {
    final keys = getCspValues().keys.toSet();
    expect(keys, <String>{
      'default-src',
      'font-src',
      'img-src',
      'manifest-src',
      'object-src',
      'script-src',
      'style-src',
    });
  });

  testWithProfile('extra script src', fn: () async {
    final defaultScriptValues = getCspValues()['script-src'];
    final defaultStyleValues = getCspValues()['style-src'];

    await secretBackend.update(
        SecretKey.cspScriptSrc, 'https://example.com/js http://example.com/');
    await cspBackend.update();

    final newScriptValues = getCspValues()['script-src'];
    final newStyleValues = getCspValues()['style-src'];
    expect(newStyleValues, defaultStyleValues);
    expect(newScriptValues, containsAll(defaultScriptValues));
    expect(newScriptValues, contains('https://example.com/js'));
    expect(newScriptValues, contains('http://example.com/'));
  });

  testWithProfile('extra style src', fn: () async {
    final defaultScriptValues = getCspValues()['script-src'];
    final defaultStyleValues = getCspValues()['style-src'];

    await secretBackend.update(
        SecretKey.cspStyleSrc, 'https://example.com/css http://example.com/');
    await cspBackend.update();

    final newScriptValues = getCspValues()['script-src'];
    final newStyleValues = getCspValues()['style-src'];
    expect(newScriptValues, defaultScriptValues);
    expect(newStyleValues, containsAll(defaultStyleValues));
    expect(newStyleValues, contains('https://example.com/css'));
    expect(newStyleValues, contains('http://example.com/'));
  });
}
