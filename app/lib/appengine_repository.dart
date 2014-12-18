// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_package_repo;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pubserver/repository.dart';

import 'models.dart' as models;

/// A read-only implementation of [PackageRepository] using the Cloud Datastore
/// for metadata and Cloud Storage for tarball storage.
class AppEnginePackageRepo extends PackageRepository {
  final DatastoreDB db;
  _TarballCloudStorage _tarballStorage;

  AppEnginePackageRepo(this.db, Storage storage, String bucket) {
    _tarballStorage = new _TarballCloudStorage(storage, bucket, '');
  }

  Stream<PackageVersion> versions(String package) {
    var controller;
    var subscription;

    controller = new StreamController(
        onListen: () {
          var packageKey = db.emptyKey.append(models.Package, id: package);
          var query = db.query(models.PackageVersion, ancestorKey: packageKey);
          subscription = query.run().listen((models.PackageVersion model) {
            var packageVersion = new PackageVersion(
                package, model.version, model.pubspec.yamlString);
            controller.add(packageVersion);
          }, onError: (error, stack) => controller.addError(error, stack),
             onDone: () => controller.close());
        },
        onPause: () => subscription.pause(),
        onResume: () => subscription.resume(),
        onCancel: () => subscription.cancel());
    return controller.stream;
  }

  Future<PackageVersion> lookupVersion(String package, String version) async {
    var packageVersionKey = db
        .emptyKey
        .append(models.Package, id: package)
        .append(models.PackageVersion, id: version);

    models.PackageVersion pv = (await db.lookup([packageVersionKey])).first;
    if (pv == null) return null;
    return new PackageVersion(package, version, pv.pubspec.yamlString);
  }

  Future<Stream<List<int>>> download(String package, String version) {
    return new Future.value(_tarballStorage.download(package, version));
  }

  bool get supportsDownloadUrl => true;

  Future<Uri> downloadUrl(String package, String version) {
    return _tarballStorage.downloadUrl(package, version);
  }
}

/// Helper utility class for interfacing with Cloud Storage for storing
/// tarballs.
class _TarballCloudStorage {
  final String bucket;
  final String prefix;
  final Storage storage;

  _TarballCloudStorage(this.storage, this.bucket, this.prefix);

  Stream<List<int>> download(String package, String version) {
    var object = _tarballObject(package, version);
    return storage.bucket(bucket).read(object);
  }

  Future<Uri> downloadUrl(String package, String version) {
    var object = _tarballObject(package, version);
    var uri = Uri.parse('https://storage.googleapis.com/$bucket$object');
    return new Future.value(uri);
    //return storage.bucket(bucket).info(object)
    //    .then((info) => info.downloadLink);
  }

  // TODO: Do we need some kind of escaping here?
  String _tarballObject(String package, String version)
      => '$prefix/packages/$package-$version.tar.gz';
}
