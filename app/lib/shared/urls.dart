// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart'
    show SearchForm, SearchOrder;
import 'package:path/path.dart' as p;

const primaryHost = 'pub.dev';
const legacyHost = 'pub.dartlang.org';
const fullSiteUrl = 'https://$primaryHost/';
const siteRoot = 'https://$primaryHost';
const dartSiteRoot = 'https://dart.dev';
const httpsApiDartDev = 'https://api.dart.dev/';

/// URI schemes that are trusted and can be rendered. Other URI schemes must be
/// rejected and the URL mustn't be displayed.
const trustedUrlSchemes = <String>['http', 'https', 'mailto'];

/// Hostnames that are trusted in user-generated content (and don't get rel="ugc").
const trustedTargetHost = [
  'api.dart.dev',
  'api.flutter.dev',
  'dart.dev',
  'flutter.dev',
  'pub.dev',
];

final _siteRootUri = Uri.parse('$siteRoot/');
final _pathRootUri = Uri(path: '/');

/// The list of available tabs on the package page.
enum PkgPageTab {
  readme,
  changelog,
  example,
  install,
  license,
  pubspec,
  versions,
  score,
  admin,
  activityLog,
}

const _pkgPageTabSegments = <PkgPageTab, String>{
  PkgPageTab.readme: '',
  PkgPageTab.changelog: 'changelog',
  PkgPageTab.example: 'example',
  PkgPageTab.install: 'install',
  PkgPageTab.license: 'license',
  PkgPageTab.pubspec: 'pubspec',
  PkgPageTab.versions: 'versions',
  PkgPageTab.score: 'score',
  PkgPageTab.admin: 'admin',
  PkgPageTab.activityLog: 'activity-log',
};

String pkgPageUrl(
  String package, {
  String? version,
  bool includeHost = false,
  PkgPageTab? pkgPageTab,
}) {
  final subPageSegment = _pkgPageTabSegments[pkgPageTab ?? PkgPageTab.readme];
  final segments = <String>[
    'packages',
    package,
    if (version != null) ...['versions', version],
    if (subPageSegment != null && subPageSegment.isNotEmpty) subPageSegment,
  ];
  final baseUri = includeHost ? _siteRootUri : _pathRootUri;
  return baseUri.resolveUri(Uri(pathSegments: segments)).toString();
}

String pkgReadmeUrl(String package, {String? version}) =>
    pkgPageUrl(package, version: version);

String pkgChangelogUrl(String package, {String? version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.changelog);

String pkgExampleUrl(String package, {String? version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.example);

String pkgLicenseUrl(
  String package, {
  String? version,
  bool? includeHost,
}) =>
    pkgPageUrl(
      package,
      version: version,
      pkgPageTab: PkgPageTab.license,
      includeHost: includeHost ?? false,
    );

String pkgInstallUrl(String package, {String? version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.install);

String pkgVersionsUrl(String package) =>
    pkgPageUrl(package, pkgPageTab: PkgPageTab.versions);

String pkgScoreUrl(String package, {String? version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.score);

String pkgAdminUrl(
  String package, {
  bool? includeHost,
}) =>
    pkgPageUrl(
      package,
      pkgPageTab: PkgPageTab.admin,
      includeHost: includeHost ?? false,
    );

String pkgActivityLogUrl(String package) =>
    pkgPageUrl(package, pkgPageTab: PkgPageTab.activityLog);

String pkgArchiveDownloadUrl(String package, String version, {Uri? baseUri}) {
  final path =
      '/packages/${Uri.encodeComponent(package)}/versions/${Uri.encodeComponent(version)}.tar.gz';
  if (baseUri == null) {
    return path;
  } else {
    return baseUri.resolve(path).toString();
  }
}

String pkgDocUrl(
  String package, {
  String? version,
  bool includeHost = false,
  String? relativePath,
  bool omitTrailingSlash = false,
  bool isLatest = false,
}) {
  if (isLatest || version == null) {
    version = 'latest';
  }
  final segments = <String>[
    'documentation',
    package,
    version,
  ];
  final baseUri = includeHost ? _siteRootUri : _pathRootUri;
  String url = baseUri.resolveUri(Uri(pathSegments: segments)).toString();

  if (relativePath != null) {
    url = p.join(url, relativePath);
  } else if (!omitTrailingSlash) {
    url = '$url/';
  }
  if (url.endsWith('/index.html')) {
    url = url.substring(0, url.length - 'index.html'.length);
  }
  if (omitTrailingSlash && url.endsWith('/')) {
    url = url.substring(0, url.length - 1);
  }
  return url;
}

String publisherUrl(String publisherId) => '/publishers/$publisherId';
String publisherPackagesUrl(String publisherId) =>
    '/publishers/$publisherId/packages';
String publisherUnlistedPackagesUrl(String publisherId) =>
    '/publishers/$publisherId/unlisted-packages';

String publisherAdminUrl(String publisherId) =>
    publisherUrl(publisherId) + '/admin';

String publisherActivityLogUrl(String publisherId) =>
    publisherUrl(publisherId) + '/activity-log';

String searchUrl({
  String? q,
  int? page,
}) {
  return SearchForm(query: q).toSearchLink(page: page);
}

String listingByPopularity() =>
    SearchForm(order: SearchOrder.popularity).toSearchLink();

String dartSdkMainUrl(String version) {
  final isDev = version.contains('dev');
  final channel = isDev ? 'dev' : 'stable';
  final url = p.join(httpsApiDartDev, channel, version);
  return '$url/';
}

/// Returns the consent URL that will be sent to the invited user.
String consentUrl(String consentId) => '$siteRoot/consent?id=$consentId';

/// Return true if the user-provided `documentation` URL should not be shown.
bool hideUserProvidedDocUrl(String? url) {
  if (url == null || url.isEmpty) return true;
  final uri = Uri.tryParse(url);
  if (uri == null) return true;
  if (uri.scheme != 'http' && uri.scheme != 'https') return true;
  final host = uri.host.toLowerCase();
  return host == 'dartdocs.org' ||
      host == 'www.dartdocs.org' ||
      host == 'pub.dartlang.org' ||
      host == 'pub.dev';
}

/// Returns the [url] in a format that will be displayed on the user-facing
/// website.
/// - https:// prefixes are stripped down
/// - TODO: consider stripping long URLs
String? displayableUrl(String? url) {
  if (url == null) {
    return null;
  }
  if (url.startsWith('https://')) {
    url = url.substring('https://'.length);
  }
  return url;
}

String myPackagesUrl({String? next}) => Uri(
      path: '/my-packages',
      queryParameters: next == null ? null : {'next': next},
    ).toString();
String myLikedPackagesUrl() => '/my-liked-packages';
String myPublishersUrl() => '/my-publishers';
String myActivityLogUrl() => '/my-activity-log';
String createPublisherUrl() => '/create-publisher';

/// Parses [url] and returns the [Uri] object only if the result Uri is valid
/// (e.g. is relative or has recognized scheme).
Uri? parseValidUrl(String? url) {
  if (url == null || url.isEmpty) return null;
  final uri = Uri.tryParse(url);
  if (uri == null || uri.isInvalid) return null;
  return uri;
}

extension UriExt on Uri {
  /// The [scheme] of the [Uri] is trusted, it may be displayed.
  bool get isTrustedScheme => trustedUrlSchemes.contains(scheme);

  /// Whether the [Uri] has an untrusted or incompatible structure.
  bool get isInvalid => hasScheme && !isTrustedScheme;

  /// The host of the link is trusted, it is unlikely to be a spam.
  bool get isTrustedHost => trustedTargetHost.contains(host);

  /// Whether on rendering we should emit rel="ugc".
  bool get shouldIndicateUgc => host.isNotEmpty && !isTrustedHost;
}

/// Whether the [value] is accepted as a valid local redirection URL.
bool isValidLocalRedirectUrl(String value) {
  value = value.trim();
  if (value.isEmpty) {
    return false;
  }
  if (!value.startsWith('/')) {
    return false;
  }
  final uri = Uri.tryParse(value);
  if (uri == null || uri.hasScheme || uri.hasAuthority || uri.hasFragment) {
    return false;
  }
  final normalized = p.normalize(value);
  if (normalized != value) {
    return false;
  }
  return true;
}
