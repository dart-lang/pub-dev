// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:path/path.dart' as p;

import 'package:fake_pub_server/local_server_state.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_dev/tool/test_profile/normalizer.dart';

final _argParser = ArgParser()
  ..addOption('test-profile', help: 'The file to read the test profile from.')
  ..addOption('cache-dir', help: 'The directory to cache the downloaded files.')
  ..addOption('data-file', help: 'The file to store the local state.');

Future<void> main(List<String> args) async {
  final argv = _argParser.parse(args);
  final profile = normalize(TestProfile.fromYaml(
    await File(argv['test-profile'] as String).readAsString(),
  ));

  final cacheDirArg = argv['cache-dir'] as String;
  final cacheDir = cacheDirArg ?? Directory.systemTemp.createTempSync().path;
  await Directory(cacheDir).create(recursive: true);

  final state = LocalServerState(path: argv['data-file'] as String);

  await fork(() async {
    registerDbService(DatastoreDB(state.datastore));
    registerStorageService(state.storage);
    registerActiveConfiguration(Configuration.test());
    await withPubServices(() async {
      // ignore: invalid_use_of_visible_for_testing_member
      await importProfile(
          profile: profile, archiveCachePath: p.join(cacheDir, 'archives'));
    });
  });
  await state.save();

  if (cacheDirArg == null) {
    await Directory(cacheDir).delete(recursive: true);
  }
}
