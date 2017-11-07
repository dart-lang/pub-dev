// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine_pub.http_proxy_repository;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pub_server/repository.dart';

final Logger _logger = new Logger('pub_server.http_proxy_repository');

/// Implements the [PackageRepository] by talking to a remote HTTP server via
/// the pub HTTP API.
///
/// This [PackageRepository] does not support uploading so far.
class HttpProxyRepository extends PackageRepository {
  final http.Client client;
  final Uri baseUrl;

  HttpProxyRepository(this.client, this.baseUrl);

  Stream<PackageVersion> versions(String package) {
    Future<List<PackageVersion>> fetch() async {
      Uri versionUrl =
          baseUrl.resolve('/api/packages/${Uri.encodeComponent(package)}');

      http.Response response = await client.get(versionUrl);
      var json = JSON.decode(response.body);
      var versions = json['versions'];
      if (versions != null) {
        return versions.map((Map item) {
          var pubspec = item['pubspec'];
          var pubspecString = JSON.encode(pubspec);
          return new PackageVersion(
              pubspec['name'], pubspec['version'], pubspecString);
        }).toList();
      }
      return const [];
    }

    var controller = new StreamController();

    fetch()
        .then((List<PackageVersion> packageVersions) {
          for (var packageVersion in packageVersions) {
            controller.add(packageVersion);
          }
        })
        .catchError(controller.addError)
        .whenComplete(controller.close);

    return controller.stream;
  }

  // TODO: Could be optimized, since we don't need to list all versions and can
  // just talk to the HTTP endpoint which gives us a specific package/version
  // combination.
  Future<PackageVersion> lookupVersion(String package, String version) {
    return versions(package)
        .where((v) => v.packageName == package && v.versionString == version)
        .toList()
        .then((List<PackageVersion> versions) {
      if (versions.length >= 1) return versions.first;
      return null;
    });
  }

  bool get supportsUpload => false;

  bool get supportsAsyncUpload => false;

  bool get supportsDownloadUrl => true;

  Future<Uri> downloadUrl(String package, String version) async {
    package = Uri.encodeComponent(package);
    version = Uri.encodeComponent(version);
    return baseUrl.resolve('/packages/$package/versions/$version.tar.gz');
  }

  Future<Stream> download(String package, String version) async {
    _logger.info('Downloading package $package/$version.');

    var url = await downloadUrl(package, version);
    var response = await client.send(new http.Request('GET', url));
    return response.stream;
  }
}
