// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:args/args.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

/// Sets the private key value.
Future main(List<String> args) async {
  final argv = _argParser.parse(args);

  if (argv['help'] as bool == true) {
    print('List packages that are with-held.');
    print(_argParser.usage);
    return;
  }

  await withToolRuntime(() async {
    print('Scanning packages...');
    final query = dbService.query<Package>()..filter('isWithheld =', true);
    await for (final p in query.run()) {
      assert(p.isWithheld == true);
      print(p.name);
    }
  });
}
