// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/models.dart' show LicenseFile;
import 'package:pubspec_parse/pubspec_parse.dart' as pubspek;

import '../../../../package/overrides.dart' show redirectPackageUrls;
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;

d.Node? licenseNode({
  required LicenseFile? licenseFile,
  required String? licenseUrl,
}) {
  if (licenseUrl == null) return null;
  licenseFile ??= LicenseFile('LICENSE', 'unknown');
  return d.fragment([
    d.text('${licenseFile.shortFormatted} ('),
    d.a(href: licenseUrl, text: licenseFile.path),
    d.text(')'),
  ]);
}

d.Node? dependencyListNode(Map<String, pubspek.Dependency>? dependencies) {
  if (dependencies == null) return null;
  final packages = dependencies.keys.toList()..sort();
  if (packages.isEmpty) return null;
  return d.fragment(
    packages.expand((p) {
      final dep = dependencies[p];
      var href = redirectPackageUrls[p];
      String? constraint;
      if (href == null && dep is pubspek.HostedDependency) {
        href = urls.pkgPageUrl(p);
        constraint = dep.version.toString();
      }
      return <d.Node>[
        d.text(', '),
        href == null ? d.text(p) : d.a(href: href, title: constraint, text: p),
      ];
    }).skip(1), // skips the first comma (', ').
  );
}
