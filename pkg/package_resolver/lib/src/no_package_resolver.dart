// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'async_package_resolver.dart';
import 'package_resolver.dart';
import 'sync_package_resolver.dart';
import 'utils.dart';

/// A package resolution strategy that is unable to resolve any `package:` URIs.
class NoPackageResolver implements SyncPackageResolver {
  Map<String, Uri> get packageConfigMap => null;
  Uri get packageConfigUri => null;
  Uri get packageRoot => null;
  String get processArgument => null;

  PackageResolver get asAsync => new AsyncPackageResolver(this);

  Uri resolveUri(packageUri) {
    // Verify that the URI is valid.
    asPackageUri(packageUri, "packageUri");
    return null;
  }

  Uri urlFor(String package, [String path]) => null;

  Uri packageUriFor(url) {
    // Verify that the URI is a valid type.
    asUri(url, "url");
    return null;
  }

  String packagePath(String package) => null;
}
