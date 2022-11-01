// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_package_reader/src/names.dart';
import 'package:test/test.dart';

void main() {
  group('Reserved words', () {
    test('matching grammar file', () async {
      final rs = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/dart-lang/sdk/main/tools/spec_parser/Dart.g'));
      if (rs.statusCode != 200) {
        throw Exception('Unexpected status code: ${rs.statusCode}.');
      }
      final lines = rs.body.split('\n');
      final keywords = <String>[];
      for (var i = 0; i < lines.length - 3; i++) {
        // match the following pattern:
        // HIDE
        //     :    'hide'
        //     ;
        if (lines[i] != lines[i].toUpperCase()) continue;
        final candidate = lines[i].toLowerCase().trim();
        if (lines[i + 1] != "    :    '$candidate'") continue;
        if (lines[i + 2] != '    ;') continue;
        keywords.add(candidate);
      }
      expect(keywords, containsAll(['as', 'assert', 'async', 'for']));
      // reserved, but allowed because package:async already exists.
      keywords.remove('async');
      keywords.remove('when');
      for (final keyword in keywords) {
        expect(reservedWords, contains(keyword));
      }
    });
  });
}
