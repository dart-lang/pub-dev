// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/package_api.dart' as package_api;
import 'package:basics/basics.dart';
import 'package:http/http.dart' as http;
import 'package:pana/pana.dart' show ToolEnvironment;
import 'package:path/path.dart' as p;

import '../../shared/configuration.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';
import 'models.dart';

/// Utility method to resolve package:version pairs that are:
/// - latest versions of the packages that are without specific versions
/// - direct or transitive dependencies of the packages
///
/// The resulting list contains all the resolved versions (may be more packages
/// than the profile originally specified).
Future<List<ResolvedVersion>> resolveVersions(
    http.Client client, TestProfile profile) async {
  return await withTempDirectory((temp) async {
    final pubCacheDir = Directory(p.join(temp.path, 'pub-cache'));
    await pubCacheDir.create();

    final toolEnv = await ToolEnvironment.create(
      dartSdkDir: activeConfiguration.tools?.previewDartSdkPath ??
          activeConfiguration.tools?.stableDartSdkPath,
      flutterSdkDir: activeConfiguration.tools?.previewFlutterSdkPath ??
          activeConfiguration.tools?.stableFlutterSdkPath,
      pubCacheDir: pubCacheDir.path,
    );

    for (final package in profile.packages) {
      final versions = package.versions == null || package.versions!.isEmpty
          ? <TestVersion>[TestVersion(version: 'any', created: null)]
          : package.versions;
      for (final version in versions!) {
        final dummyDir = Directory(p.join(temp.path, 'dummy'));
        await dummyDir.create();

        final pubspecFile = File(p.join(dummyDir.path, 'pubspec.yaml'));
        await pubspecFile.writeAsString(_generateDummyPubspec(
          package.name,
          version.version,
          minSdkVersion: toolEnv.runtimeInfo.sdkVersion,
        ));

        final pr = await toolEnv.runUpgrade(dummyDir.path, false);
        if (pr.exitCode != 0) {
          throw Exception(
              'dart pub get on `${package.name} $version` exited with ${pr.exitCode}.\n${pr.stderr}');
        }

        await dummyDir.delete(recursive: true);
      }
    }
    final pubHostedDir =
        Directory(p.join(pubCacheDir.path, 'hosted', 'pub.dev'));
    final dirs = await pubHostedDir.list().toList();
    final versions = <ResolvedVersion>[];
    for (final dir in dirs.whereType<Directory>()) {
      final basename = p.basename(dir.path);
      if (!basename.contains('-')) continue;
      final parts = basename.partition('-');
      final package = parts.first;
      final version = parts.last;

      final rs = await client.get(Uri.parse(
          '${urls.siteRoot}/api/packages/$package/versions/$version'));
      final map = json.decode(rs.body) as Map<String, dynamic>;
      final info = package_api.VersionInfo.fromJson(map);

      versions.add(ResolvedVersion(
        package: package,
        version: version,
        created: info.published,
      ));
    }
    return versions;
  });
}

String _generateDummyPubspec(
  String package,
  String version, {
  String? minSdkVersion,
}) {
  minSdkVersion ??= Platform.version.split(' ').first;
  return json.encode(
    {
      'name': '____dummy____',
      'environment': {
        'sdk': '>=$minSdkVersion <3.0.0',
      },
      'dependencies': {
        package: version,
      },
    },
  );
}
