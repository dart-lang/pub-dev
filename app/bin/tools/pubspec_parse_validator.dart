// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

final _argParser = new ArgParser()
  ..addOption('package', abbr: 'p', help: 'The package to test.')
  ..addOption('version', abbr: 'v', help: 'The version to test.')
  ..addFlag('continue', help: 'Whether to go on when an error is found.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final package = argv['package'] as String;
  final version = argv['version'] as String;
  final doContinue = argv['continue'] as bool;

  useLoggingPackageAdaptor();
  await withProdServices(() async {
    if (package != null && version != null) {
      final list = await dbService.lookup([
        dbService.emptyKey
            .append(Package, id: package)
            .append(PackageVersion, id: version)
      ]);
      final pv = list.first as PackageVersion;
      print('Parsing ${pv.package} ${pv.version}...');
      new Pubspec.parse(pv.pubspec.jsonString);
    } else {
      final query = package == null
          ? dbService.query<PackageVersion>()
          : dbService.query<PackageVersion>(
              ancestorKey:
                  dbService.emptyKey.append(PackageVersion, id: package));
      await for (PackageVersion pv in query.run()) {
        print('Parsing ${pv.package} ${pv.version}...');
        if (doContinue) {
          try {
            new Pubspec.parse(pv.pubspec.jsonString);
          } catch (e, st) {
            stderr.writeln('Error parsing ${pv.package} ${pv.version}:');
            stderr.writeln(e);
            stderr.writeln(st.toString());
          }
        } else {
          new Pubspec.parse(pv.pubspec.jsonString);
        }
      }
    }
  });
}
