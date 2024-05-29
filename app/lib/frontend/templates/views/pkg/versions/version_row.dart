// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/package_api.dart';
import 'package:pub_dev/task/models.dart';

import '../../../../../package/model_properties.dart';
import '../../../../../shared/urls.dart' as urls;
import '../../../../dom/dom.dart' as d;
import '../../../../static_files.dart';
import '../../../package_misc.dart';

d.Node versionRowNode(
  String package,
  VersionInfo version,
  Pubspec pubspec, {
  PackageVersionStateInfo? versionStatus,
}) {
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
          title: 'Visit $package ${version.version} page',
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
                '${sdk.major}.${sdk.minor}${sdk.channel != null ? ' (${sdk.channel})' : ''}')
            : null,
      ),
      d.td(
        classes: ['uploaded'],
        child: d.xAgoTimestamp(version.published!),
      ),
      d.td(
        classes: ['documentation'],
        child: _documentationCell(package, version, versionStatus),
      ),
      d.td(
        classes: ['archive'],
        child: d.a(
          href: urls.pkgArchiveDownloadUrl(package, version.version),
          rel: 'nofollow',
          title: 'Download $package ${version.version} archive',
          child: d.img(
            classes: ['version-table-icon'],
            image: d.Image(
              src: staticUrls.downloadIcon,
              alt: 'Download $package ${version.version} archive',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    ],
  );
}

d.Node _documentationCell(
  String package,
  VersionInfo version,
  PackageVersionStateInfo? status,
) {
  if (status == null) {
    return d.text('');
  }
  final taskStatus = status.status;
  if (taskStatus == PackageVersionStatus.pending) {
    return d.text('pending');
  } else if (status.docs) {
    return d.a(
      href: urls.pkgDocUrl(package, version: version.version),
      rel: 'nofollow',
      title: 'Go to the documentation of $package ${version.version}',
      child: d.img(
        classes: ['version-table-icon'],
        image: d.Image(
          src: staticUrls.documentationIcon,
          alt: 'Go to the documentation of $package ${version.version}',
          width: 24,
          height: 24,
        ),
      ),
    );
  } else {
    return d.a(
      href: urls.pkgScoreLogTxtUrl(package, version: version.version),
      rel: 'nofollow',
      title: 'Check the analysis logs for $package ${version.version}',
      child: d.img(
        classes: ['version-table-icon'],
        image: d.Image(
          src: staticUrls.documentationFailedIcon,
          alt: 'Check the analysis logs for $package ${version.version}',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
