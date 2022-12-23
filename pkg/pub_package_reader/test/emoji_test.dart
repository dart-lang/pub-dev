// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_package_reader/src/emoji_ranges.dart';
import 'package:test/test.dart';

void main() {
  group('hasEmojiCharacter', () {
    test('simple text', () {
      expect(hasEmojiCharacter('abc def 0123'), isFalse);
    });

    test('emoji in string', () async {
      expect(hasEmojiCharacter('📁 a 📁 b 📁'), isTrue);
    });

    test('CJK characters', () async {
      final text = '文字 Chinese (Hanzi), 漢字 Japanese (Kanji), 漢字 Korean (Hanja)';
      expect(hasEmojiCharacter(text), isFalse);
    });
  });

  group(
    'generator',
    () {
      final sequences = _UnicodeEmojiSequences();

      setUpAll(() async {
        await sequences.fetchAndParse();
      });

      test('basic values', () {
        // Uncomment the following line to print basic ranges:
        // print(sequences.getBasicRanges(mergeThreshold: 4).map((e) => '$e,\n').join());
        for (final v in sequences.basicValues) {
          expect(hasEmojiCharacter(String.fromCharCode(v)), isTrue,
              reason: '$v is not detected.');
        }
      });
    },
    tags: ['sanity'],
  );
}

class _UnicodeEmojiSequences {
  late List<int> basicValues;

  Future<void> fetchAndParse() async {
    final rs = await http.get(
        Uri.parse('https://unicode.org/Public/emoji/14.0/emoji-sequences.txt'));
    if (rs.statusCode != 200) {
      throw Exception('Unable to fetch sequences data.');
    }
    final lines = rs.body.split('\n');
    final basicLines = lines
        .where((l) => !l.startsWith('#') && l.contains('Basic_Emoji'))
        .toList();
    if (basicLines.length < 10) {
      throw Exception('Unable to detect basic sections.');
    }

    basicValues = basicLines
        .map((l) => l.split(';').first.trim())
        .where((l) => !l.contains(' '))
        .expand(
      (v) {
        final parts =
            v.split('..').map((e) => int.parse(e, radix: 16)).toList();
        if (parts.length == 1) return parts;
        return List.generate(parts[1] - parts[0] + 1, (i) => parts[0] + i);
      },
    ).toList();
    basicValues.sort();
  }

  List<CodeUnitRange> getBasicRanges({int mergeThreshold = 0}) {
    final ranges = <CodeUnitRange>[];
    for (final v in basicValues) {
      if (ranges.isEmpty || ranges.last.end + mergeThreshold < v) {
        ranges.add(CodeUnitRange(v, v + 1));
      } else {
        final old = ranges.removeLast();
        ranges.add(CodeUnitRange(old.start, v + 1));
      }
    }
    return ranges;
  }
}
