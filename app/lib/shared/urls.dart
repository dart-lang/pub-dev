// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;

import '../package/overrides.dart';
import '../search/search_form.dart' show SearchForm;

const primaryHost = 'pub.dev';
const legacyHost = 'pub.dartlang.org';
const fullSiteUrl = 'https://$primaryHost/';
const siteRoot = 'https://$primaryHost';
const dartSiteRoot = 'https://dart.dev';
const httpsApiDartDev = 'https://api.dart.dev/';

/// URI schemes that are trusted and can be rendered. Other URI schemes must be
/// rejected and the URL mustn't be displayed.
const _trustedSchemes = <String>['http', 'https', 'mailto'];

/// Hostnames that are trusted in user-generated content (and don't get rel="ugc").
const _trustedTargetHost = [
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
};

String pkgPageUrl(
  String package, {
  String version,
  bool includeHost = false,
  PkgPageTab pkgPageTab,
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

String pkgReadmeUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version);

String pkgChangelogUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.changelog);

String pkgExampleUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.example);

String pkgLicenseUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.license);

String pkgInstallUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.install);

String pkgVersionsUrl(String package) =>
    pkgPageUrl(package, pkgPageTab: PkgPageTab.versions);

String pkgScoreUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.score);

String pkgAdminUrl(String package) =>
    pkgPageUrl(package, pkgPageTab: PkgPageTab.admin);

String pkgArchiveDownloadUrl(String package, String version, {Uri baseUri}) {
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
  String version,
  bool includeHost = false,
  String relativePath,
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
    SearchForm.parse(publisherId: publisherId).toSearchLink();

String publisherAdminUrl(String publisherId) =>
    publisherUrl(publisherId) + '/admin';

String searchUrl({
  String sdk,
  List<String> runtimes,
  List<String> platforms,
  String q,
  int page,
}) {
  final query = SearchForm.parse(
    sdk: sdk,
    runtimes: runtimes,
    platforms: platforms,
    query: q,
  );
  return query.toSearchLink(page: page);
}

String dartSdkMainUrl(String version) {
  final isDev = version.contains('dev');
  final channel = isDev ? 'dev' : 'stable';
  final url = p.join(httpsApiDartDev, channel, version);
  return '$url/';
}

/// Parses GitHub and GitLab urls, and returns the root of the repository.
String inferRepositoryUrl(String baseUrl) {
  if (baseUrl == null) {
    return null;
  }
  final uri = Uri.tryParse(baseUrl);
  if (uri == null) {
    return null;
  }
  if (uri.scheme != 'http' && uri.scheme != 'https') {
    return null;
  }
  if (uri.hasPort) {
    return null;
  }
  if (uri.host == 'github.com' || uri.host == 'gitlab.com') {
    final segments = uri.pathSegments.take(2).toList();
    if (segments.length != 2) {
      return null;
    }
    return Uri(scheme: uri.scheme, host: uri.host, pathSegments: segments)
        .toString();
  }
  return null;
}

/// Parses GitHub and GitLab urls, and returns the issue tracker of the repository.
String inferIssueTrackerUrl(String baseUrl) {
  if (baseUrl == null) {
    return null;
  }
  final uri = Uri.tryParse(baseUrl);
  if (uri == null) {
    return null;
  }
  if (uri.scheme != 'http' && uri.scheme != 'https') {
    return null;
  }
  if (uri.hasPort) {
    return null;
  }
  if (uri.host == 'github.com' || uri.host == 'gitlab.com') {
    final segments = uri.pathSegments.take(2).toList();
    if (segments.length != 2) {
      return null;
    }
    segments.add('issues');
    final url = Uri(
      scheme: 'https',
      host: uri.host,
      pathSegments: segments,
    ).toString();
    return overrideIssueTrackerUrl(url);
  }
  return null;
}

/// Infer base URL that can be used to link files from.
String inferBaseUrl({String homepageUrl, String repositoryUrl}) {
  String baseUrl = repositoryUrl ?? homepageUrl;
  if (baseUrl == null) return null;

  // In a few cases people specify only a deep repository URL for their
  // package (e.g. a monorepo for multiple packages). While we default the
  // base URL to be the repository URL, this check allows us to use the deep
  // URL for linking.
  if (homepageUrl != null && homepageUrl.startsWith(baseUrl)) {
    baseUrl = homepageUrl;
  }

  // URL cleanup
  final prefixReplacements = const <String, String>{
    'http://github.com/': 'https://github.com/',
    'http://www.github.com/': 'https://github.com/',
    'https://www.github.com/': 'https://github.com/',
    'http://gitlab.com/': 'https://gitlab.com/',
    'http://www.gitlab.com/': 'https://gitlab.com/',
    'https://www.gitlab.com/': 'https://gitlab.com/',
  };
  for (final prefix in prefixReplacements.keys) {
    if (baseUrl.startsWith(prefix)) {
      baseUrl = baseUrl.replaceFirst(prefix, prefixReplacements[prefix]);
    }
  }
  if ((baseUrl.startsWith('https://github.com/') ||
          baseUrl.startsWith('https://gitlab.com/')) &&
      baseUrl.endsWith('.git')) {
    baseUrl = baseUrl.substring(0, baseUrl.length - 4);
  }

  return baseUrl;
}

/// Infer the hosting/service provider for a given URL.
String inferServiceProviderName(String url) {
  if (url == null) {
    return null;
  }
  if (url.startsWith('https://github.com/')) {
    return 'GitHub';
  }
  if (url.startsWith('https://gitlab.com/')) {
    return 'GitLab';
  }
  return null;
}

/// Returns the consent URL that will be sent to the invited user.
String consentUrl(String consentId) => '$siteRoot/consent?id=$consentId';

/// Return true if the user-provided `documentation` URL should not be shown.
bool hideUserProvidedDocUrl(String url) {
  if (url == null || url.isEmpty) return true;
  final uri = Uri.parse(url);
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
String displayableUrl(String url) {
  if (url == null) {
    return null;
  }
  if (url.startsWith('https://')) {
    url = url.substring('https://'.length);
  }
  return url;
}

String myPackagesUrl() => '/my-packages';
String myLikedPackagesUrl() => '/my-liked-packages';
String myPublishersUrl() => '/my-publishers';
String createPublisherUrl() => '/create-publisher';

/// Parses [url] and returns the [Uri] object only if the result Uri is valid
/// (e.g. is relative or has recognized scheme).
Uri parseValidUrl(String url) {
  if (url == null || url.isEmpty) return null;
  final uri = Uri.tryParse(url);
  if (uri == null || uri.isInvalid) return null;
  return uri;
}

extension UriExt on Uri {
  /// The [scheme] of the [Uri] is trusted, it may be displayed.
  bool get isTrustedScheme => _trustedSchemes.contains(scheme);

  /// Whether the [Uri] has an untrusted or incompatible structure.
  bool get isInvalid => hasScheme && !isTrustedScheme;

  /// The host of the link is trusted, it is unlikely to be a spam.
  bool get isTrustedHost => _trustedTargetHost.contains(host);

  /// Whether on rendering we should emit rel="ugc".
  bool get shouldIndicateUgc => host.isNotEmpty && !isTrustedHost;
}
