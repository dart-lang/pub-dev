// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

/// Client interface for accessing some of pub's public APIs.
class PubClient {
  final http.Client _httpClient;
  final String _siteRoot;

  PubClient(this._httpClient, {String siteRoot = 'https://pub.dartlang.org'})
      : _siteRoot = siteRoot;

  /// List the name of packages.
  Future<List<String>> listPackages() async {
    final content = await _httpClient.read('$_siteRoot/api/packages?compact=1');
    final map = convert.json.decode(content) as Map<String, dynamic>;
    final packages = (map['packages'] as List).cast<String>();
    return packages;
  }

  /// Fetch the base package data (versions and uploaders).
  Future<PackageData> getPackageData(String package) async {
    final content = await _httpClient.read('$_siteRoot/packages/$package.json');
    final map = convert.json.decode(content) as Map<String, dynamic>;
    final uploaders = (map['uploaders'] as List)?.cast<String>();
    final versions = (map['versions'] as List)?.cast<String>();
    return PackageData(uploaders: uploaders, versions: versions);
  }

  /// Fetch the package version data (created, pubspec).
  Future<PackageVersionData> getPackageVersionData(
      String package, String version) async {
    final pageContent = await _httpClient
        .read('$_siteRoot/packages/$package/versions/$version');
    final searchJson = pageContent
        .split('\n')
        .firstWhere((s) => s.contains('"@type":"SoftwareSourceCode"'));
    final searchMap = convert.json.decode(searchJson) as Map<String, dynamic>;
    final created = DateTime.parse(searchMap['dateModified'] as String);
    return PackageVersionData(
      created: created,
      pubspec: await _getPubspec(package, version),
    );
  }

  Future<Map<String, dynamic>> _getPubspec(
      String package, String version) async {
    final content = await _httpClient
        .read('$_siteRoot/api/packages/$package/versions/$version');
    final map = convert.json.decode(content) as Map<String, dynamic>;
    return map['pubspec'] as Map<String, dynamic>;
  }

  /// Closes the http client.
  ///
  /// (kept-it Future-based in case we may need to close streams).
  Future close() async {
    _httpClient.close();
  }
}

class PackageData {
  final List<String> uploaders;
  final List<String> versions;

  PackageData({this.uploaders, this.versions});
}

class PackageVersionData {
  final DateTime created;
  final Map<String, dynamic> pubspec;

  PackageVersionData({this.created, this.pubspec});
}
