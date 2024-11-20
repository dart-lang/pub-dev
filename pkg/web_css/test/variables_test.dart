// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('all sass variables are used', () async {
    final variables = (await File('lib/src/_variables.scss').readAsLines())
        .where((l) => l.startsWith(r'$') && l.contains(':'))
        .map((l) => l.substring(1).split(':').first.trim())
        .where((v) => v.isNotEmpty)
        .toSet();
    expect(variables, isNotEmpty);

    final files = await Directory('lib')
        .list(recursive: true)
        .where((f) => f is File && f.path.endsWith('.scss'))
        .cast<File>()
        .toList();

    for (final file in files) {
      if (variables.isEmpty) break;
      if (file.path.contains('_variables.scss')) continue;
      final content = await file.readAsString();
      final matched = variables.where((v) => content.contains('\$$v')).toList();
      variables.removeAll(matched);
    }

    expect(variables, isEmpty);
  });

  group('CSS variables', () {
    final dashVariables = <String>{};
    late Set<String> variables;

    Iterable<String> extractVariables(List<String> lines) {
      return lines
          .map((l) => l.trim())
          .where((l) => l.startsWith('--') && l.contains(':'))
          .map((l) => l.split(':').first.trim())
          .where((v) => v.isNotEmpty)
          .toSet();
    }

    setUpAll(() async {
      variables =
          extractVariables(await File('lib/src/_variables.scss').readAsLines())
              .toSet();

      // remove Material design variables
      variables.removeWhere((v) => v.startsWith('--mdc-'));

      for (final f
          in Directory('../../third_party/site-shared/dash_design/lib/')
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('.scss'))) {
        dashVariables.addAll(extractVariables(f.readAsLinesSync()));
      }
    });

    test('variables are present', () {
      expect(variables, isNotEmpty);
    });

    test('a variable does not share another as prefix', () {
      for (final v in variables) {
        final shared =
            variables.where((x) => x != v && x.startsWith(v)).toList();
        expect(shared, isEmpty, reason: v);
      }
    });

    test('all CSS variables are used', () async {
      final files = await Directory('lib')
          .list(recursive: true)
          .where((f) => f is File && f.path.endsWith('.scss'))
          .cast<File>()
          .toList();

      final unused = <String>{...variables};
      for (final file in files) {
        if (unused.isEmpty) break;
        final content = await file.readAsString();
        unused.removeWhere((v) => content.contains('var($v)'));
      }

      expect(unused, isEmpty);
    });

    test('all variables used have definition', () async {
      final files = await Directory('lib')
          .list(recursive: true)
          .where((f) => f is File && f.path.endsWith('.scss'))
          .cast<File>()
          .toList();
      final varRegExp = RegExp(r'var\((.*?)\)');
      for (final file in files) {
        final content = await file.readAsString();
        for (final m in varRegExp.allMatches(content)) {
          final name = m.group(1)!.trim();
          if (!variables.contains(name)) {
            // exempt Material Design variables
            if (name.startsWith('--mdc-')) {
              continue;
            }
            // exempt known dash variables
            if (name.startsWith('--dash-') && dashVariables.contains(name)) {
              continue;
            }

            fail('${file.path} references `$name` without definition.');
          }
        }
      }
    });
  });
}
