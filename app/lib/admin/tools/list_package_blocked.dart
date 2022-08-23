// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';

import '../../package/models.dart';
import '../../shared/datastore.dart';

final _argParser = ArgParser()
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future<String> executeListPackageBlocked(List<String> args) async {
  final argv = _argParser.parse(args);

  if (argv['help'] as bool) {
    return 'List packages that are blocked.\n'
        '${_argParser.usage}';
  }

  final query = dbService.query<Package>()..filter('isBlocked =', true);
  final output = StringBuffer();
  await for (final p in query.run()) {
    output.writeln(p.name!);
  }
  return output.toString();
}
