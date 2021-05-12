// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:pool/pool.dart';
import 'package:http/http.dart' as http;
import 'package:iso/iso.dart';
import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:retry/retry.dart';

late final http.Client _client;

/// Checks all the pub.dev archives with both tar reader implementation and
/// compares the output.
Future<void> main(List<String> args) async {
  final concurrency = int.tryParse(Platform.environment['CONCURRENCY'] ?? '') ??
      Platform.numberOfProcessors;
  print('concurrency: $concurrency');

  final dataDir =
      Directory('${Platform.environment['HOME']}/data/pub.dev/reader');
  await dataDir.create(recursive: true);
  final trackFile = File('${dataDir.path}/package.txt');

  _client = http.Client();
  try {
    final packages = await _listPackages();
    packages.shuffle();
    print('Found: ${packages.length} packages.');

    for (final package in packages) {
      final statusFile =
          File('${dataDir.path}/${package.substring(0, 1)}/$package.json');
      if (await statusFile.exists()) continue;
      await statusFile.parent.create();

      // maps status codes to list of package-version(s)
      final statuses = <String, List<String>>{};
      final diffs = <Map<String, dynamic>>[];

      try {
        final versions = await _listVersions(package);
        final pool = Pool(concurrency);
        final futures = <Future>[];
        for (final version in versions) {
          futures.add(pool.withResource(() async {
            final iso = await _createIso();
            try {
              iso.send({'package': package, 'version': version});
              final reply = (await iso.dataOut.first) as Map<String, dynamic>;
              final status = reply['status'] as String;
              statuses
                  .putIfAbsent(status, () => <String>[])
                  .add('$package/$version');
              if (status != 'ok') {
                diffs.add(reply);
              }
            } finally {
              iso.dispose();
            }
          }));
        }
        await Future.wait(futures);
        await pool.close();

        final counts =
            statuses.map((key, value) => MapEntry(key, value.length));
        print('$package $counts');
        await trackFile.writeAsString('$package $counts\n',
            mode: FileMode.writeOnlyAppend);
        await statusFile.writeAsString(JsonEncoder.withIndent('  ').convert({
          'statuses': statuses,
          'diffs': diffs,
        }));
      } catch (e, st) {
        print(e);
        print(st);
      }
    }
  } finally {
    _client.close();
  }
  exit(0);
}

void run(IsoRunner iso) async {
  iso.receive();
  // listen to the data coming in
  iso.dataIn!.listen((dynamic data) async {
    final map = data as Map<String, dynamic>;
    iso.send(
        await checkPackage(map['package'] as String, map['version'] as String));
  });
}

Future<Map<String, dynamic>> checkPackage(
    String package, String version) async {
  [package, version];
  final archiveFile =
      File('${Directory.systemTemp.path}/$package-$version.tar.gz');
  try {
    await retry(() async {
      final rs = await http.get(Uri.parse(
          'https://storage.googleapis.com/pub-packages/packages/${Uri.encodeComponent(package)}-${Uri.encodeComponent(version)}.tar.gz'));
      if (rs.statusCode != 200) {
        throw Exception('Unable to access archive of $package-$version.');
      }
      await archiveFile.writeAsBytes(rs.bodyBytes);
    });

    final s1 =
        await summarizePackageArchive(archiveFile.path, useNative: false);
    final s2 = await summarizePackageArchive(archiveFile.path, useNative: true);

    final m1 = s1.toJson();
    final m2 = s2.toJson();
    if (json.encode(m1) == json.encode(m2)) {
      return {'status': 'ok'};
    }

    final status = json.encode(s1.issues) != json.encode(s2.issues)
        ? 'diff-issues'
        : 'diff-content';

    return {
      'package': package,
      'version': version,
      'status': status,
      'old': _diffTo(m1, m2),
      'new': _diffTo(m2, m1),
    };
  } finally {
    if (archiveFile.existsSync()) {
      await archiveFile.delete();
    }
  }
}

Map<String, dynamic> _diffTo(Map<String, dynamic> v1, Map<String, dynamic> v2) {
  final map = <String, dynamic>{};
  for (final key in v1.keys) {
    if (v2.containsKey(key) && json.encode(v1[key]) == json.encode(v2[key])) {
      continue;
    }
    map[key] = v1[key];
  }
  return map;
}

Future<List<String>> _listPackages() async {
  return await retry(() async {
    final rs = await _client.get(
      Uri.parse('https://pub.dev/api/packages?compact=1'),
      headers: {
        'accept': 'application/json',
      },
    );
    if (rs.statusCode != 200) {
      throw AssertionError('Unexpected status code: ${rs.statusCode}');
    }
    final data = json.decode(rs.body) as Map<String, dynamic>;
    final packages = (data['packages'] as List<dynamic>).cast<String>();
    packages.sort();
    return packages;
  });
}

Future<List<String>> _listVersions(String package) async {
  return await retry(() async {
    final rs = await _client.get(
      Uri.parse('https://pub.dev/api/packages/$package'),
      headers: {
        'accept': 'application/json',
      },
    );
    if (rs.statusCode != 200) {
      throw AssertionError(
          'Unexpected status code ($package): ${rs.statusCode}');
    }
    final data = json.decode(rs.body) as Map<String, dynamic>;
    final versions =
        (data['versions'] as List<dynamic>).cast<Map<String, dynamic>>();
    return versions.map((v) => v['version'] as String).toList();
  });
}

class _IsoStarting {
  final Iso iso;
  final Future started;

  _IsoStarting._(this.iso, this.started);

  factory _IsoStarting() {
    final iso = Iso(run);
    final f = iso.run();
    return _IsoStarting._(iso, f);
  }
}

final _isoPool = <_IsoStarting>[];
Future<Iso> _createIso() async {
  while (_isoPool.isEmpty) {
    _isoPool.addAll(List.generate(8, (_) => _IsoStarting()).reversed);
  }
  final last = _isoPool.removeLast();
  await last.started;
  return last.iso;
}
