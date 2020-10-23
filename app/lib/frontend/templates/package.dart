// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/page_data.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart' show getRepositoryUrl;
import 'package:pub_dev/shared/handlers.dart';

import '../../analyzer/analyzer_client.dart';
import '../../package/models.dart';
import '../../package/overrides.dart' show devDependencyPackages;
import '../../scorecard/models.dart';
import '../../search/search_form.dart';
import '../../shared/email.dart' show EmailAddress;
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../request_context.dart';
import '../static_files.dart';

import '_cache.dart';
import '_utils.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'misc.dart';
import 'package_analysis.dart';
import 'package_misc.dart';

String _renderLicense(String baseUrl, LicenseFile license) {
  if (license == null) return null;
  final String escapedName = htmlEscape.convert(license.shortFormatted);
  String html = escapedName;

  if (license.url != null && license.path != null) {
    final String escapedLink = htmlAttrEscape.convert(license.url);
    final String escapedPath = htmlEscape.convert(license.path);
    html += ' (<a href="$escapedLink">$escapedPath</a>)';
  } else if (license.path != null) {
    final String escapedPath = htmlEscape.convert(license.path);
    html += ' ($escapedPath)';
  }
  return html;
}

String _renderDependencyList(AnalysisView analysis) {
  if (analysis == null ||
      !analysis.hasPanaSummary ||
      analysis.directDependencies == null) return null;
  final List<String> packages =
      analysis.directDependencies.map((pd) => pd.package).toList()..sort();
  if (packages.isEmpty) return null;
  return packages
      .map((p) => '<a href="${urls.pkgPageUrl(p)}">$p</a>')
      .join(', ');
}

String _renderInstallTab(PackageVersion selectedVersion, List<String> tags) {
  final packageName = selectedVersion.package;
  final isFlutterPackage = selectedVersion.pubspec.usesFlutter;
  List importExamples;
  if (selectedVersion.libraries.contains('$packageName.dart')) {
    importExamples = [
      {
        'package': packageName,
        'library': '$packageName.dart',
      },
    ];
  } else {
    importExamples = selectedVersion.libraries.map((library) {
      return {
        'package': selectedVersion.packageKey.id,
        'library': library,
      };
    }).toList();
  }

  final executables = selectedVersion.pubspec.executables?.keys?.toList();
  executables?.sort();
  final hasExecutables = executables != null && executables.isNotEmpty;

  final exampleVersionConstraint = '^${selectedVersion.version}';

  final bool usePubGet = !isFlutterPackage ||
      tags == null ||
      tags.isEmpty ||
      tags.contains(SdkTag.sdkDart);

  final bool useFlutterPackagesGet =
      isFlutterPackage || (tags != null && tags.contains(SdkTag.sdkFlutter));

  String editorSupportedToolHtml;
  if (usePubGet && useFlutterPackagesGet) {
    editorSupportedToolHtml =
        '<code>pub get</code> or <code>flutter pub get</code>';
  } else if (useFlutterPackagesGet) {
    editorSupportedToolHtml = '<code>flutter pub get</code>';
  } else {
    editorSupportedToolHtml = '<code>pub get</code>';
  }

  return templateCache.renderTemplate('pkg/install_tab', {
    'dependencies_key': devDependencyPackages.contains(packageName)
        ? 'dev_dependencies'
        : 'dependencies',
    'use_as_an_executable': hasExecutables,
    'use_as_a_library': !hasExecutables || importExamples.isNotEmpty,
    'package': packageName,
    'example_version_constraint': exampleVersionConstraint,
    'has_libraries': importExamples.isNotEmpty,
    'import_examples': importExamples,
    'use_pub_get': usePubGet,
    'use_flutter_packages_get': useFlutterPackagesGet,
    'show_editor_support': usePubGet || useFlutterPackagesGet,
    'editor_supported_tool_html': editorSupportedToolHtml,
    'executables': executables,
  });
}

/// Renders the right-side info box (quick summary of the package, mostly coming
/// from pubspec.yaml).
String renderPkgInfoBox(PackagePageData data) {
  final package = data.package;
  final packageLinks = data.version.packageLinks;

  String documentationUrl = packageLinks.documentationUrl;
  if (urls.hideUserProvidedDocUrl(documentationUrl)) {
    documentationUrl = null;
  }
  final dartdocsUrl = urls.pkgDocUrl(
    package.name,
    version: data.version.version,
    isLatest: data.isLatestStable,
  );

  final metaLinks = <Map<String, dynamic>>[];
  final docLinks = <Map<String, dynamic>>[];
  void addLink(
    String href,
    String label, {
    bool detectServiceProvider = false,
    bool documentation = false,
  }) {
    final uri = urls.parseValidUrl(href);
    if (uri == null) return;

    if (detectServiceProvider) {
      final providerName = urls.inferServiceProviderName(href);
      if (providerName != null) {
        label += ' ($providerName)';
      }
    }
    final linkData = <String, dynamic>{
      'href': href,
      'label': label,
      'rel': uri.shouldIndicateUgc ? 'ugc' : null,
    };
    if (documentation) {
      docLinks.add(linkData);
    } else {
      metaLinks.add(linkData);
    }
  }

  if (packageLinks.repositoryUrl != packageLinks.homepageUrl) {
    addLink(packageLinks.homepageUrl, 'Homepage');
  }
  addLink(packageLinks.repositoryUrl, 'Repository',
      detectServiceProvider: true);
  addLink(packageLinks.issueTrackerUrl, 'View/report issues');
  addLink(documentationUrl, 'Documentation', documentation: true);
  if (data.analysis.hasApiDocs) {
    addLink(dartdocsUrl, 'API reference', documentation: true);
  }

  return templateCache.renderTemplate('pkg/info_box', {
    'name': package.name,
    'description': data.version.pubspec.description,
    'meta_links': metaLinks,
    'has_doc_links': docLinks.isNotEmpty,
    'doc_links': docLinks,
    'replaced_by': package.replacedBy,
    'replaced_by_link':
        package.replacedBy == null ? null : urls.pkgPageUrl(package.replacedBy),
    'publisher_id': package.publisherId,
    'publisher_link': package.publisherId == null
        ? null
        : urls.publisherUrl(package.publisherId),
    'uploaders_title':
        data.uploaderEmails.length > 1 ? 'Uploaders' : 'Uploader',
    'uploaders_html': data.uploaderEmails.isEmpty
        ? null
        : _getAuthorsHtml(data.uploaderEmails),
    'license_html':
        _renderLicense(packageLinks.baseUrl, data.analysis?.licenseFile),
    'dependencies_html': _renderDependencyList(data.analysis),
    'search_deps_link': urls.searchUrl(q: 'dependency:${package.name}'),
    'labeled_scores_html': renderLabeledScores(data.toPackageView()),
  });
}

/// Renders the `views/pkg/header.mustache` template for header metadata and
/// wraps it with content-header.
String renderPkgHeader(PackagePageData data) {
  final package = data.package;
  final bool showPrereleaseVersion = package.showPrereleaseVersion;
  final bool showUpdated = !data.isLatestStable || showPrereleaseVersion;

  final isNullSafe = requestContext.isNullSafetyDisplayed &&
      data.toPackageView().tags.contains(PackageVersionTags.isNullSafe);
  final nullSafeBadgeHtml = isNullSafe ? renderNullSafeBadge() : null;

  final metadataHtml = templateCache.renderTemplate('pkg/header', {
    'publisher_id': package.publisherId,
    'publisher_url': package.publisherId == null
        ? null
        : urls.publisherUrl(package.publisherId),
    'null_safe_badge_html': nullSafeBadgeHtml,
    'latest': {
      'show_updated': showUpdated,
      'show_prerelease_version': showPrereleaseVersion,
      'stable_url': urls.pkgPageUrl(package.name),
      'stable_version': package.latestVersion,
      'prerelease_url': urls.pkgPageUrl(package.name,
          version: package.latestPrereleaseVersion),
      'prerelease_version': package.latestPrereleaseVersion,
    },
    'short_created': data.version.shortCreated,
  });
  final pkgView = data.toPackageView();
  return renderDetailHeader(
    title: '${package.name} ${data.version.version}',
    packageLikes: package.likes,
    isLiked: data.isLiked,
    isFlutterFavorite:
        (package.assignedTags ?? []).contains(PackageTags.isFlutterFavorite),
    metadataHtml: metadataHtml,
    tagsHtml: renderTags(package: pkgView),
    isLoose: true,
  );
}

/// Renders the package detail page.
String renderPkgShowPage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      data: data,
      readmeTab: _readmeTab(data),
    ),
    pkgPageTab: urls.PkgPageTab.readme,
  );
}

/// Renders the package changelog page.
String renderPkgChangelogPage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      data: data,
      changelogTab: _changelogTab(data),
    ),
    pkgPageTab: urls.PkgPageTab.changelog,
  );
}

/// Renders the package example page.
String renderPkgExamplePage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      data: data,
      exampleTab: _exampleTab(data),
    ),
    pkgPageTab: urls.PkgPageTab.example,
  );
}

/// Renders the package install page.
String renderPkgInstallPage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      data: data,
      installingTab: _installTab(data),
    ),
    pkgPageTab: urls.PkgPageTab.install,
  );
}

/// Renders the package score page.
String renderPkgScorePage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      data: data,
      scoreTab: _scoreTab(data),
    ),
    pkgPageTab: urls.PkgPageTab.score,
  );
}

String _renderPkgPage({
  @required PackagePageData data,
  @required List<Tab> tabs,
  @required urls.PkgPageTab pkgPageTab,
}) {
  final card = data.analysis?.card;

  final content = renderDetailPage(
    headerHtml: renderPkgHeader(data),
    tabs: tabs,
    infoBoxLead: data.version.ellipsizedDescription,
    infoBoxHtml: renderPkgInfoBox(data),
    footerHtml: renderPackageSchemaOrgHtml(data),
  );

  final isFlutterPackage = data.version.pubspec.usesFlutter;
  final packageAndVersion = data.isLatestStable
      ? data.package.name
      : '${data.package.name} ${data.version.version}';
  final pageTitle =
      '$packageAndVersion | ${isFlutterPackage ? 'Flutter' : 'Dart'} Package';
  final canonicalUrl = urls.pkgPageUrl(
    data.package.name,
    version: data.isLatestStable ? null : data.version.version,
    includeHost: true,
    pkgPageTab: pkgPageTab,
  );
  final noIndex = (card?.isSkipped ?? false) ||
      (card?.grantedPubPoints == 0) ||
      data.package.isExcludedInRobots;
  return renderLayoutPage(
    PageType.package,
    content,
    title: pageTitle,
    pageDescription: data.version.ellipsizedDescription,
    faviconUrl: isFlutterPackage ? staticUrls.flutterLogo32x32 : null,
    canonicalUrl: canonicalUrl,
    shareUrl: canonicalUrl,
    noIndex: noIndex,
    pageData: pkgPageData(data.package, data.version),
  );
}

PageData pkgPageData(Package package, PackageVersion selectedVersion) {
  return PageData(
    pkgData: PkgData(
        package: package.name,
        version: selectedVersion.version,
        publisherId: package.publisherId,
        isDiscontinued: package.isDiscontinued,
        likes: package.likes),
  );
}

Tab _readmeTab(PackagePageData data) {
  final baseUrl = data.version.packageLinks.baseUrl;
  final content =
      data.hasReadme ? renderFile(data.version.readme, baseUrl) : '';
  return Tab.withContent(
    id: 'readme',
    title: 'Readme',
    contentHtml: content,
    isMarkdown: true,
  );
}

Tab _changelogTab(PackagePageData data) {
  if (!data.hasChangelog) return null;
  final baseUrl = data.version.packageLinks.baseUrl;
  final content = renderFile(
    data.version.changelog,
    baseUrl,
    isChangelog: true,
  );
  return Tab.withContent(
    id: 'changelog',
    title: 'Changelog',
    contentHtml: content,
    isMarkdown: true,
  );
}

Tab _exampleTab(PackagePageData data) {
  if (!data.hasExample) return null;
  final baseUrl = data.version.packageLinks.baseUrl;

  String renderedExample;
  final exampleFilename = data.version.example.filename;
  renderedExample = renderFile(data.version.example, baseUrl);
  if (renderedExample != null) {
    final url = getRepositoryUrl(baseUrl, exampleFilename);
    final escapedName = htmlEscape.convert(exampleFilename);
    final link = url == null
        ? escapedName
        : '<a href="$url" target="_blank" rel="noopener noreferrer nofollow">$escapedName</a>';
    renderedExample = '<p style="font-family: monospace"><b>$link</b></p>\n'
        '$renderedExample';
  }

  return Tab.withContent(
    id: 'example',
    title: 'Example',
    contentHtml: renderedExample,
    isMarkdown: true,
  );
}

Tab _installTab(PackagePageData data) {
  return Tab.withContent(
    id: 'installing',
    title: 'Installing',
    contentHtml: _renderInstallTab(data.version, data.analysis?.derivedTags),
  );
}

Tab _scoreTab(PackagePageData data) {
  return Tab.withContent(
    id: 'analysis',
    title: 'Scores',
    contentHtml: renderAnalysisTab(
      data.package.name,
      data.version.pubspec.sdkConstraint,
      data.analysis?.card,
      data.analysis,
      likeCount: data.package.likes,
    ),
  );
}

String _getAuthorsHtml(List<String> authors) {
  return (authors ?? const []).map((String value) {
    final EmailAddress author = EmailAddress.parse(value);
    final escapedName = htmlEscape.convert(author.name ?? author.email);
    if (author.email != null) {
      final escapedEmail = htmlAttrEscape.convert(author.email);
      final emailSearchUrl = htmlAttrEscape.convert(
          SearchForm.parse(query: 'email:${author.email}').toSearchLink());
      final text =
          '<a href="$emailSearchUrl" title="Search packages from $escapedName" rel="nofollow">'
          '$escapedEmail'
          '</a>';
      return '<span class="author">$text</span>';
    } else {
      return '<span class="author">$escapedName</span>';
    }
  }).join('<br/>');
}

String renderPackageSchemaOrgHtml(PackagePageData data) {
  final p = data.package;
  final pv = data.version;
  final Map map = {
    '@context': 'http://schema.org',
    '@type': 'SoftwareSourceCode',
    'name': p.name,
    'version': pv.version,
    'description': '${p.name} - ${pv.pubspec.description}',
    'url': urls.pkgPageUrl(p.name, includeHost: true),
    'dateCreated': p.created.toIso8601String(),
    'dateModified': pv.created.toIso8601String(),
    'programmingLanguage': 'Dart',
    'image':
        '${urls.siteRoot}${staticUrls.staticPath}/img/pub-dev-icon-cover-image.png'
  };
  final licenseFileUrl = data.analysis?.licenseFile?.url;
  if (licenseFileUrl != null) {
    map['license'] = licenseFileUrl;
  }
  // TODO: add http://schema.org/codeRepository for github and gitlab links
  return '<script type="application/ld+json">\n${json.encode(map)}\n</script>\n';
}

/// Build package tabs.
///
/// Unspecified tab content will be filled with links to the corresponding page.
List<Tab> buildPackageTabs({
  @required PackagePageData data,
  Tab readmeTab,
  Tab changelogTab,
  Tab exampleTab,
  Tab installingTab,
  Tab versionsTab,
  Tab scoreTab,
  Tab adminTab,
}) {
  final package = data.package;
  final linkVersion = data.isLatestStable ? null : data.version.version;
  readmeTab ??= Tab.withLink(
    id: 'readme',
    title: 'Readme',
    href: urls.pkgReadmeUrl(package.name, version: linkVersion),
  );
  changelogTab ??= Tab.withLink(
    id: 'changelog',
    title: 'Changelog',
    href: urls.pkgChangelogUrl(package.name, version: linkVersion),
  );
  exampleTab ??= Tab.withLink(
    id: 'example',
    title: 'Example',
    href: urls.pkgExampleUrl(package.name, version: linkVersion),
  );
  installingTab ??= Tab.withLink(
    id: 'installing',
    title: 'Installing',
    href: urls.pkgInstallUrl(package.name, version: linkVersion),
  );
  versionsTab ??= Tab.withLink(
    id: 'versions',
    title: 'Versions',
    href: urls.pkgVersionsUrl(package.name),
  );
  scoreTab ??= Tab.withLink(
    id: 'analysis',
    title: 'Scores',
    href: urls.pkgScoreUrl(package.name, version: linkVersion),
  );
  adminTab ??= Tab.withLink(
    id: 'admin',
    title: 'Admin',
    href: urls.pkgAdminUrl(package.name),
  );
  return <Tab>[
    readmeTab,
    if (data.hasChangelog) changelogTab,
    if (data.hasExample) exampleTab,
    installingTab,
    versionsTab,
    scoreTab,
    if (data.isAdmin) adminTab,
  ];
}

/// Renders the package page when the package has been moderated.
String renderModeratedPackagePage(String packageName) {
  final message = 'The package `$packageName` has been removed.';
  return renderErrorPage(default404NotFound, message);
}
