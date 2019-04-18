// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:meta/meta.dart';

import '../../scorecard/models.dart';
import '../../shared/analyzer_client.dart';
import '../../shared/email.dart' show EmailAddress;
import '../../shared/platform.dart';
import '../../shared/search_service.dart';
import '../../shared/urls.dart' as urls;

import '../models.dart';
import '../static_files.dart';

import '_cache.dart';
import '_utils.dart';
import 'layout.dart';
import 'misc.dart';
import 'package_analysis.dart';
import 'package_versions.dart';

String _renderLicenses(String baseUrl, List<LicenseFile> licenses) {
  if (licenses == null || licenses.isEmpty) return null;
  return licenses.map((license) {
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
  }).join('<br/>');
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

String _renderInstallTab(PackageVersion selectedVersion, bool isFlutterPackage,
    List<String> platforms) {
  final packageName = selectedVersion.package;
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
      platforms == null ||
      platforms.isEmpty ||
      platforms.length > 1 ||
      platforms.first != KnownPlatforms.flutter;

  final bool useFlutterPackagesGet = isFlutterPackage ||
      (platforms != null && platforms.contains(KnownPlatforms.flutter));

  String editorSupportedToolHtml;
  if (usePubGet && useFlutterPackagesGet) {
    editorSupportedToolHtml =
        '<code>pub get</code> or <code>flutter packages get</code>';
  } else if (useFlutterPackagesGet) {
    editorSupportedToolHtml = '<code>flutter packages get</code>';
  } else {
    editorSupportedToolHtml = '<code>pub get</code>';
  }

  return templateCache.renderTemplate('pkg/install_tab', {
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

String _renderVersionsTab(
  PackageVersion selectedVersion,
  List<PackageVersion> versions,
  List<Uri> versionDownloadUrls,
  int totalNumberOfVersions,
) {
  final versionTableRows = [];
  for (int i = 0; i < versions.length; i++) {
    final PackageVersion version = versions[i];
    final String url = versionDownloadUrls[i].toString();
    versionTableRows.add(renderVersionTableRow(version, url));
  }
  return templateCache.renderTemplate('pkg/versions_tab', {
    'package_name': selectedVersion.package,
    'version_table_rows': versionTableRows,
    'show_versions_link': totalNumberOfVersions > versions.length,
    'versions_url': urls.pkgVersionsUrl(selectedVersion.package),
    'version_count': '$totalNumberOfVersions',
  });
}

/// Renders the right-side info box (quick summary of the package, mostly coming
/// from pubspec.yaml).
String _renderSidebar(
  Package package,
  PackageVersion selectedVersion,
  List<String> uploaderEmails,
  AnalysisView analysis,
) {
  final packageLinks = selectedVersion.packageLinks;
  final baseUrl = packageLinks.repositoryUrl ?? packageLinks.homepageUrl;

  String documentationUrl = packageLinks.documentationUrl;
  if (documentationUrl != null &&
      (documentationUrl.startsWith('https://www.dartdocs.org/') ||
          documentationUrl.startsWith('http://www.dartdocs.org/') ||
          documentationUrl.startsWith('https://pub.dartlang.org/') ||
          documentationUrl.startsWith('http://pub.dartlang.org/'))) {
    documentationUrl = null;
  }
  final dartdocsUrl = urls.pkgDocUrl(
    package.name,
    version: selectedVersion.version,
    isLatest: selectedVersion.version == package.latestVersion,
  );

  final links = <Map<String, dynamic>>[];
  void addLink(
    String href,
    String label, {
    bool detectServiceProvider = false,
  }) {
    if (href == null || href.isEmpty) {
      return;
    }
    if (detectServiceProvider) {
      final providerName = urls.inferServiceProviderName(href);
      if (providerName != null) {
        label += ' ($providerName)';
      }
    }
    links.add(<String, dynamic>{'href': href, 'label': label});
  }

  if (packageLinks.repositoryUrl != packageLinks.homepageUrl) {
    addLink(packageLinks.homepageUrl, 'Homepage');
  }
  addLink(packageLinks.repositoryUrl, 'Repository',
      detectServiceProvider: true);
  addLink(packageLinks.issueTrackerUrl, 'View/report issues');
  addLink(packageLinks.documentationUrl, 'Documentation');
  addLink(dartdocsUrl, 'API reference');

  return templateCache.renderTemplate('pkg/sidebar', {
    'name': package.name,
    'description': selectedVersion.pubspec.description,
    'links': links,
    // TODO: make this 'Authors' if PackageVersion.authors is a list?!
    'authors_title': 'Author',
    'authors_html': _getAuthorsHtml(selectedVersion.pubspec.authors),
    // TODO: make this 'Uploaders' if Package.uploaders is > 1?!
    'uploaders_title': 'Uploader',
    'uploaders_html': _getAuthorsHtml(uploaderEmails),
    'license_html': _renderLicenses(baseUrl, analysis?.licenses),
    'dependencies_html': _renderDependencyList(analysis),
    'search_deps_link': urls.searchUrl(q: 'dependency:${package.name}'),
  });
}

/// Renders the `views/pkg/show.mustache` template.
String renderPkgShowPage(
    Package package,
    List<String> uploaderEmails,
    bool isVersionPage,
    List<PackageVersion> versions,
    List<Uri> versionDownloadUrls,
    PackageVersion selectedVersion,
    PackageVersion latestStableVersion,
    PackageVersion latestDevVersion,
    int totalNumberOfVersions,
    AnalysisView analysis) {
  assert(versions.length == versionDownloadUrls.length);
  final card = analysis?.card;
  final int platformCount = card?.platformTags?.length ?? 0;
  final String singlePlatform =
      platformCount == 1 ? card.platformTags.single : null;
  final bool hasPlatformSearch =
      singlePlatform != null && singlePlatform != KnownPlatforms.other;
  final bool hasOnlyFlutterPlatform = singlePlatform == KnownPlatforms.flutter;
  final bool isFlutterPackage =
      hasOnlyFlutterPlatform || latestStableVersion.pubspec.usesFlutter;

  final bool shouldShowDev =
      latestStableVersion.semanticVersion < latestDevVersion.semanticVersion;
  final bool shouldShow =
      selectedVersion != latestStableVersion || shouldShowDev;

  final isAwaiting = card == null ||
      analysis == null ||
      (!card.isSkipped && !analysis.hasPanaSummary);

  final tabsData = _tabsData(
    selectedVersion,
    isFlutterPackage,
    analysis,
    versions,
    versionDownloadUrls,
    totalNumberOfVersions,
    isNewPackage: package.isNewPackage(),
  );

  final values = {
    'package': {
      'name': package.name,
      'version': selectedVersion.id,
      'latest': {
        'should_show': shouldShow,
        'should_show_dev': shouldShowDev,
        'stable_url': urls.pkgPageUrl(package.name),
        'stable_name': latestStableVersion.version,
        'dev_url':
            urls.pkgPageUrl(package.name, version: latestDevVersion.version),
        'dev_name': latestDevVersion.version,
      },
      'tags_html': renderTags(
        analysis?.platforms,
        isAwaiting: isAwaiting,
        isDiscontinued: card?.isDiscontinued ?? false,
        isLegacy: card?.isLegacy ?? false,
        isObsolete: card?.isObsolete ?? false,
      ),
      'short_created': selectedVersion.shortCreated,
      'schema_org_pkgmeta_json':
          json.encode(_schemaOrgPkgMeta(package, selectedVersion, analysis)),
    },
    'tabs': tabsData,
    'icons': staticUrls.versionsTableIcons,
    'sidebar_html':
        _renderSidebar(package, selectedVersion, uploaderEmails, analysis),
  };
  final content = templateCache.renderTemplate('pkg/show', values);
  final packageAndVersion = isVersionPage
      ? '${selectedVersion.package} ${selectedVersion.version}'
      : selectedVersion.package;
  final pageTitle =
      '$packageAndVersion | ${isFlutterPackage ? 'Flutter' : 'Dart'} Package';
  final canonicalUrl =
      isVersionPage ? urls.pkgPageUrl(package.name, includeHost: true) : null;
  final noIndex = (card?.isSkipped ?? false) ||
      (card?.overallScore == 0.0) ||
      (package.isDiscontinued ?? false);
  return renderLayoutPage(
    PageType.package,
    content,
    title: pageTitle,
    pageDescription: selectedVersion.ellipsizedDescription,
    faviconUrl: isFlutterPackage ? staticUrls.flutterLogo32x32 : null,
    canonicalUrl: canonicalUrl,
    platform: hasPlatformSearch ? singlePlatform : null,
    noIndex: noIndex,
  );
}

List<Map<String, String>> _tabsData(
  PackageVersion selectedVersion,
  bool isFlutterPackage,
  AnalysisView analysis,
  List<PackageVersion> versions,
  List<Uri> versionDownloadUrls,
  int totalNumberOfVersions, {
  @required bool isNewPackage,
}) {
  final card = analysis?.card;

  String readmeFilename;
  String renderedReadme;
  final packageLinks = selectedVersion.packageLinks;
  final baseUrl = packageLinks.repositoryUrl ?? packageLinks.homepageUrl;
  if (selectedVersion.readme != null) {
    readmeFilename = selectedVersion.readme.filename;
    renderedReadme = renderFile(selectedVersion.readme, baseUrl);
  }

  String changelogFilename;
  String renderedChangelog;
  if (selectedVersion.changelog != null) {
    changelogFilename = selectedVersion.changelog.filename;
    renderedChangelog = renderFile(selectedVersion.changelog, baseUrl);
  }

  String exampleFilename;
  String renderedExample;
  if (selectedVersion.example != null) {
    exampleFilename = selectedVersion.example.filename;
    renderedExample = renderFile(selectedVersion.example, baseUrl);
    if (renderedExample != null) {
      renderedExample = '<p style="font-family: monospace">'
          '<b>${htmlEscape.convert(exampleFilename)}</b>'
          '</p>\n'
          '$renderedExample';
    }
  }

  final tabs = <Map<String, String>>[];
  void addTab(
    String id, {
    String title,
    String titleHtml,
    String content,
    bool markdown = false,
  }) {
    tabs.add({
      'id': id,
      'title_html': titleHtml ?? htmlEscape.convert(title),
      'content_html': content,
      'markdown-body': markdown ? 'markdown-body' : null,
    });
  }

  void addFileTab(String id, String title, String content) {
    if (content == null) return;
    addTab(id, title: title, content: content, markdown: true);
  }

  addFileTab('readme', readmeFilename, renderedReadme);
  addFileTab('changelog', changelogFilename, renderedChangelog);
  addFileTab('example', 'Example', renderedExample);

  addTab('installing',
      title: 'Installing',
      content: _renderInstallTab(
          selectedVersion, isFlutterPackage, analysis?.platforms));
  addTab('versions',
      title: 'Versions',
      content: _renderVersionsTab(selectedVersion, versions,
          versionDownloadUrls, totalNumberOfVersions));
  addTab(
    'analysis',
    titleHtml: renderScoreBox(card?.overallScore,
        isSkipped: card?.isSkipped ?? false, isNewPackage: isNewPackage),
    content: renderAnalysisTab(selectedVersion.package,
        selectedVersion.pubspec.sdkConstraint, card, analysis),
  );
  if (tabs.isNotEmpty) {
    tabs.first['active'] = '-active';
  }
  return tabs;
}

String _getAuthorsHtml(List<String> authors) {
  return (authors ?? const []).map((String value) {
    final EmailAddress author = EmailAddress.parse(value);
    final escapedName = htmlEscape.convert(author.name ?? author.email);
    if (author.email != null) {
      final escapedEmail = htmlAttrEscape.convert(author.email);
      final emailSearchUrl = htmlAttrEscape.convert(
          SearchQuery.parse(query: 'email:${author.email}').toSearchLink());
      return '<span class="author">'
          '<a href="mailto:$escapedEmail" title="Email $escapedEmail">'
          '<i class="email-icon"></i></a> '
          '<a href="$emailSearchUrl" title="Search packages with $escapedEmail" rel="nofollow">'
          '<i class="search-icon"></i></a> '
          '$escapedName'
          '</span>';
    } else {
      return '<span class="author">$escapedName</span>';
    }
  }).join('<br/>');
}

Map _schemaOrgPkgMeta(Package p, PackageVersion pv, AnalysisView analysis) {
  final Map map = {
    '@context': 'http://schema.org',
    '@type': 'SoftwareSourceCode',
    'name': pv.package,
    'version': pv.version,
    'description': '${pv.package} - ${pv.pubspec.description}',
    'url': urls.pkgPageUrl(pv.package, includeHost: true),
    'dateCreated': p.created.toIso8601String(),
    'dateModified': pv.created.toIso8601String(),
    'programmingLanguage': 'Dart',
    'image':
        '${urls.siteRoot}${staticUrls.staticPath}/img/dart-logo-400x400.png'
  };
  final licenses = analysis?.licenses;
  final firstUrl =
      licenses?.firstWhere((lf) => lf.url != null, orElse: () => null)?.url;
  if (firstUrl != null) {
    map['license'] = firstUrl;
  }
  // TODO: add http://schema.org/codeRepository for github and gitlab links
  return map;
}
