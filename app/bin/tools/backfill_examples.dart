// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/datastore.dart' as ds;
import 'package:http/http.dart' as http;

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/utils.dart';

http.Client _httpClient;

Future main(List<String> args) async {
  String pkg;
  if (args.isNotEmpty) {
    pkg = args.single;
  }

  int updated = 0;
  _httpClient = http.Client();
  await withProdServices(() async {
    final query = dbService.query<PackageVersion>()..order('-created');
    if (pkg != null) {
      query.filter('package =', ds.Key([ds.KeyElement('Package', pkg)]));
    }
    await for (PackageVersion pv in query.run()) {
      if (pv.exampleFilename == null && pv.exampleContent == null) {
        try {
          print('Updating: ${pv.package} ${pv.version}');
          await _backfill(pv);
          updated++;
        } catch (e, st) {
          print('Failed to update ${pv.package} ${pv.version}, error: $e $st');
          rethrow;
        }
      }
    }
  });
  _httpClient.close();
  print('Updated: $updated package versions.');
}

Future _backfill(PackageVersion pv) async {
  final String uri =
      'https://storage.googleapis.com/pub-packages/packages/${pv.package}-${pv.version}.tar.gz';
  final http.Response rs = await _httpClient.get(uri);
  if (rs.statusCode != 200) {
    print('Unable to download: $uri');
    return;
  }

  final Archive archive = TarDecoder()
      .decodeBytes(GZipDecoder().decodeBytes(rs.bodyBytes, verify: true));
  ArchiveFile archiveFile;
  for (String candidate in exampleFileCandidates(pv.package)) {
    archiveFile = archive.findFile(candidate);
    if (archiveFile != null) break;
  }
  if (archiveFile == null) return;

  final String archiveFilename = archiveFile.name;
  final String content =
      utf8.decode(archiveFile.content as List<int>, allowMalformed: true);
  if (content.trim().isEmpty) return;

  if (pv.exampleFilename == archiveFilename && pv.exampleContent == content) {
    return;
  }

  await dbService.withTransaction((Transaction t) async {
    final packageVersion = (await t.lookup([pv.key])).first as PackageVersion;
    packageVersion.exampleFilename = archiveFilename;
    packageVersion.exampleContent = content;
    t.queueMutations(inserts: [packageVersion]);
    await t.commit();
  });
}
