// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../frontend/static_files.dart';
import '../shared/urls.dart';

import 'customization.dart';

/// Returns the customizer config, extended with the current runtime's data.
DartdocCustomizerConfig customizerConfig({
  required String packageName,
  required String packageVersion,
  required bool isLatestStable,
}) {
  return DartdocCustomizerConfig(
    packageName: packageName,
    packageVersion: packageVersion,
    isLatestStable: isLatestStable,
    docRootUrl: isLatestStable
        ? pkgDocUrl(packageName, isLatest: true)
        : pkgDocUrl(packageName, version: packageVersion),
    latestStableDocumentationUrl: pkgDocUrl(packageName, isLatest: true),
    pubPackagePageUrl: pkgPageUrl(packageName,
        version: isLatestStable ? null : packageVersion),
    dartLogoSvgUrl: staticUrls.dartLogoSvg,
    githubMarkdownCssUrl: staticUrls.githubMarkdownCss,
    gtmJsUrl: staticUrls.gtmJs,
    trustedTargetHosts: trustedTargetHost,
    trustedUrlSchemes: trustedUrlSchemes,
  );
}
