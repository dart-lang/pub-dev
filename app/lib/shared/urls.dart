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

/// Extensions that are considered to be images.
final _imageExtensions = <String>{
  '.apng',
  '.avif',
  '.gif',
  '.jpg',
  '.jpeg',
  '.png',
  '.svg',
  '.webp',
};

/// Common repository URL replacement patterns.
const _repositoryReplacePrefixes = {
  'http://github.com': 'https://github.com',
  'https://www.github.com': 'https://github.com',
  'https://www.gitlab.com': 'https://gitlab.com',
};

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

String pkgScoreLogTxtUrl(String package, {String? version}) {
  return p.join(pkgScoreUrl(package, version: version), 'log.txt');
}

String pkgPubspecUrl(String package, {String? version}) =>
    pkgPageUrl(package, version: version, pkgPageTab: PkgPageTab.pubspec);

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
  final p = Uri.encodeComponent(package);
  final v = Uri.encodeComponent(version);
  final path = '/api/archives/$p-$v.tar.gz';
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
  bool isLatest = false,
}) {
  final relativePathSegments = relativePath == null
      ? const <String>[]
      : Uri.parse(relativePath)
          .pathSegments
          .where((e) => e.isNotEmpty)
          .toList();

  var forceEndingSlash = relativePathSegments.isEmpty;
  if (relativePathSegments.isNotEmpty &&
      relativePathSegments.last == 'index.html') {
    relativePathSegments.removeLast();
    forceEndingSlash = true;
  }

  if (isLatest || version == null) {
    version = 'latest';
  }
  final segments = <String>[
    'documentation',
    package,
    version,
    ...relativePathSegments,
    if (forceEndingSlash) '',
  ];
  final baseUri = includeHost ? _siteRootUri : _pathRootUri;
  return baseUri.resolveUri(Uri(pathSegments: segments)).toString();
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

String reportPage({
  required String subject,
  required String? url,
}) {
  return Uri(path: '/report', queryParameters: {
    'subject': subject,
    if (url != null) 'url': url,
  }).toString();
}

/// Parses GitHub and GitLab urls, and returns the root of the repository.
String? inferRepositoryUrl(String? baseUrl) {
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
String? inferIssueTrackerUrl(String? baseUrl) {
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
    return Uri(
      scheme: 'https',
      host: uri.host,
      pathSegments: segments,
    ).toString();
  }
  return null;
}

/// Infer base URL that can be used to link files from.
String? inferBaseUrl({String? homepageUrl, String? repositoryUrl}) {
  var baseUrl = repositoryUrl ?? homepageUrl;
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
    if (baseUrl!.startsWith(prefix)) {
      baseUrl = baseUrl.replaceFirst(prefix, prefixReplacements[prefix]!);
    }
  }
  if ((baseUrl!.startsWith('https://github.com/') ||
          baseUrl.startsWith('https://gitlab.com/')) &&
      baseUrl.endsWith('.git')) {
    baseUrl = baseUrl.substring(0, baseUrl.length - 4);
  }

  return baseUrl;
}

/// Infer the hosting/service provider for a given URL.
String? inferServiceProviderName(String? url) {
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

/// Returns an URL that is likely the downloadable URL of the given path.
String? getRepositoryUrl(
  String? repository,
  String relativePath, {
  String branch = 'master',
}) {
  if (repository == null || repository.isEmpty) return null;
  for (var key in _repositoryReplacePrefixes.keys) {
    if (repository!.startsWith(key)) {
      repository =
          repository.replaceFirst(key, _repositoryReplacePrefixes[key]!);
    }
  }
  try {
    final uri = Uri.parse(repository!);
    final segments = List<String>.from(uri.pathSegments);
    while (segments.isNotEmpty && segments.last.isEmpty) {
      segments.removeLast();
    }

    if (repository.startsWith('https://github.com/') ||
        repository.startsWith('https://gitlab.com/')) {
      if (segments.length >= 2 &&
          segments[1].endsWith('.git') &&
          segments[1].length > 4) {
        segments[1] = segments[1].substring(0, segments[1].length - 4);
      }

      final extension = p.extension(relativePath).toLowerCase();
      final isRaw = _imageExtensions.contains(extension);
      final typeSegment = isRaw ? 'raw' : 'blob';

      if (segments.length < 2) {
        return null;
      } else if (segments.length == 2) {
        final newUrl = uri.replace(pathSegments: segments).toString();
        return p.url.join(newUrl, typeSegment, branch, relativePath);
      } else if (segments[2] == 'tree' || segments[2] == 'blob') {
        segments[2] = typeSegment;
        final newUrl = uri.replace(pathSegments: segments).toString();
        return p.url.join(newUrl, relativePath);
      } else {
        return null;
      }
    }
  } catch (_) {
    return null;
  }
  return null;
}

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
