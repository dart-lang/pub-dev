// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/package_api.dart';

import '../../../../../package/model_properties.dart';
import '../../../../../shared/urls.dart' as urls;
import '../../../../dom/dom.dart' as d;
import '../../../../static_files.dart';
import '../../../package_misc.dart';

d.Node versionRowNode(String package, VersionInfo version, Pubspec pubspec) {
  final sdk = pubspec.minSdkVersion;
  return d.tr(
    attributes: {
      'data-version': version.version,
    },
    children: [
      d.td(
        classes: ['version'],
        child: d.a(
          href: urls.pkgPageUrl(package, version: version.version),
          text: version.version,
        ),
      ),
      d.td(
        classes: ['badge'],
        child: pubspec.hasOptedIntoNullSafety
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
      d.td(
        classes: ['uploaded'],
        child: d.shortTimestamp(version.published!),
      ),
      d.td(
        classes: ['documentation'],
        child: d.a(
          href: urls.pkgDocUrl(package, version: version.version),
          rel: 'nofollow',
          title: 'Go to the documentation of $package ${version.version}',
          child: d.img(
            classes: ['version-table-icon'],
            src: staticUrls.documentationIcon,
            alt: 'Go to the documentation of $package ${version.version}',
            attributes: {
              'data-failed-icon': staticUrls.documentationFailedIcon,
            },
          ),
        ),
      ),
      d.td(
        classes: ['archive'],
        child: d.a(
          href: urls.pkgArchiveDownloadUrl(package, version.version),
          rel: 'nofollow',
          title: 'Download $package ${version.version} archive',
          child: d.img(
            classes: ['version-table-icon'],
            src: staticUrls.downloadIcon,
            alt: 'Download $package ${version.version} archive',
          ),
        ),
      ),
    ],
  );
}
