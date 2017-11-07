// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:pana/src/mini_sum.dart';
import 'package:pana/src/platform.dart';
import 'package:pana/src/utils.dart';
import 'package:path/path.dart' as p;

main() async {
  var dir = new Directory("results");

  var items = dir
      .listSync()
      .where((fse) => fse is File && p.extension(fse.path) == '.json')
      .toList();

  var summaries = items
      .map((fse) {
        try {
          return new MiniSum.fromFileContent((fse as File).readAsStringSync());
        } catch (e) {
          stderr.writeln(e);
          return null;
        }
      })
      .where((sum) => sum != null && sum.pubClean)
      .toList();

  summaries.sort((a, b) => a.packageName.compareTo(b.packageName));

  _updateResults(summaries);
}

void _updateResults(List<MiniSum> summaries) {
  var toolDir = new Directory('tool');
  if (!toolDir.existsSync()) {
    toolDir.createSync();
  }

  var file = new File(p.join('tool', 'summaries.tjson'));
  try {
    file.writeAsStringSync(
        summaries.map((m) => m.toJson()).map(JSON.encode).join('\n'));
  } on JsonUnsupportedObjectError catch (e) {
    print([e, e.unsupportedObject, e.cause, e.stackTrace]);
    rethrow;
  }

  var types = new SplayTreeMap<String, int>();

  var descriptions = <String, DartPlatform>{};

  for (var miniSum in summaries) {
    print(miniSum.summary.packageName);
    var platformSummary = miniSum.summary.platform;

    print('\t${platformSummary.descriptionAndReason}');

    types[platformSummary.description] =
        (types[platformSummary.description] ?? 0) + 1;
  }

  var pcts = new Map<String, String>.fromIterables(
      types.keys,
      types.values
          .map((i) => (100 * i / summaries.length).toStringAsFixed(0) + '%'));

  types['_total'] = summaries.length;

  print(prettyJson({'items': descriptions, 'summary': types, 'pcts': pcts}));
}
