// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/frontend/templates/package_misc.dart';

import '../../../../../package/models.dart';
import '../../../../../shared/urls.dart' as urls;
import '../../../../dom/dom.dart' as d;
import '../../../../static_files.dart';

d.Node versionRowNode({
  required PackageVersion version,
  required String downloadUrl,
}) {
  final sdk = version.pubspec!.minSdkVersion;
  return d.tr(
    attributes: {
      'data-version': version.version!,
    },
    children: [
      d.td(
        classes: ['version'],
        child: d.a(
          href: urls.pkgPageUrl(version.package, version: version.version),
          text: version.version!,
        ),
      ),
      d.td(
        classes: ['badge'],
        child: version.pubspec!.hasOptedIntoNullSafety
            ? nullSafeBadgeNode(
                title: 'Package version is opted into null safety.')
            : null,
      ),
      d.td(
        classes: ['sdk'],
        child: sdk != null
            ? d.text(
                '${sdk.major}.${sdk.minor}${sdk.channel != null ? '(${sdk.channel})' : ''}')
            : null,
      ),
      d.td(classes: ['uploaded'], text: version.shortCreated),
      d.td(
        classes: ['documentation'],
        child: d.a(
          href: urls.pkgDocUrl(version.package, version: version.version),
          rel: 'nofollow',
          title:
              'Go to the documentation of ${version.package} ${version.version}',
          child: d.img(
            classes: ['version-table-icon'],
            src: staticUrls.versionsTableIcons['documentation'] as String,
            alt:
                'Go to the documentation of ${version.package} ${version.version}',
            attributes: {
              'data-failed-icon':
                  staticUrls.versionsTableIcons['documentationFailed'] as String
            },
          ),
        ),
      ),
      d.td(
        classes: ['archive'],
        child: d.a(
          href: downloadUrl,
          rel: 'nofollow',
          title: 'Download ${version.package} ${version.version} archive',
          child: d.img(
            classes: ['version-table-icon'],
            src: staticUrls.versionsTableIcons['download'] as String,
            alt: 'Download ${version.package} ${version.version} archive',
          ),
        ),
      ),
    ],
  );
}
