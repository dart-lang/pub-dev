// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Creates a report about recent uploaders.
library;

import 'dart:async';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:clock/clock.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/account/backend.dart';

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:typed_sql/typed_sql.dart';

Future<String> executeRecentUploaders(List<String> args) async {
  final parser = ArgParser()
    ..addOption(
      'max-age',
      defaultsTo: '7',
      help: 'The maximum age of the package in days.',
    )
    ..addOption('output', help: 'The report output file (or stdout otherwise)');
  final argv = parser.parse(args);
  final maxAgeDays = int.parse(argv['max-age'] as String);

  final byUploaders = <String, List<String>>{};
  final byPublishers = <String, List<String>>{};

  final pool = Pool(10);

  final updatedAfter = clock.now().subtract(Duration(days: maxAgeDays));
  final packages = await primaryDatabase.withRetry(
    (db) => db.packages
        .where((p) => p.updatedAt >= toExpr(updatedAfter))
        .select((p) => (p.name, p.publisherId))
        .fetch(),
  );
  final futures = <Future>[];
  for (final (name, publisherId) in packages) {
    Future<void> process() async {
      if (publisherId != null) {
        byPublishers.putIfAbsent(publisherId, () => <String>[]).add(name);
      } else {
        final uploaderEmails = await accountBackend.getEmailsOfUserIds(
          await packageBackend.lookupPackageUploaders(name),
        );
        uploaderEmails.forEach((email) {
          byUploaders.putIfAbsent(email ?? '', () => <String>[]).add(name);
        });
      }
    }

    futures.add(pool.withResource(process));
  }
  await Future.wait(futures);
  await pool.close();

  Map<String, List<String>> sortByCountAndTrim(Map<String, List<String>> map) {
    final keys = map.keys.toList();
    keys.sort((a, b) => -map[a]!.length.compareTo(map[b]!.length));
    final mapped = <String, List<String>>{};
    for (final key in keys) {
      mapped[key] = map[key]!.take(3).toList();
    }
    return mapped;
  }

  return JsonEncoder.withIndent('  ').convert({
    'byUploaders': sortByCountAndTrim(byUploaders),
    'byPublishers': sortByCountAndTrim(byPublishers),
  });
}
