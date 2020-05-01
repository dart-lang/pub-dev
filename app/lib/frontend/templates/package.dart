// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/page_data.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart' show getRepositoryUrl;

import '../../analyzer/analyzer_client.dart';
import '../../package/models.dart';
import '../../package/overrides.dart' show devDependencyPackages;
import '../../scorecard/models.dart';
import '../../search/search_service.dart';
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
String renderPkgInfoBox(
  PackagePageData data,
) {
  final package = data.package;
  final selectedVersion = data.version;
  final packageLinks = selectedVersion.packageLinks;

  String documentationUrl = packageLinks.documentationUrl;
  if (urls.hideUserProvidedDocUrl(documentationUrl)) {
    documentationUrl = null;
  }
  final dartdocsUrl = urls.pkgDocUrl(
    package.name,
    version: selectedVersion.version,
    isLatest: selectedVersion.version == package.latestVersion,
  );

  final metaLinks = <Map<String, dynamic>>[];
  final docLinks = <Map<String, dynamic>>[];
  void addLink(
    String href,
    String label, {
    bool detectServiceProvider = false,
    bool documentation = false,
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
    final linkData = <String, dynamic>{'href': href, 'label': label};
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
    'description': selectedVersion.pubspec.description,
    'meta_links': metaLinks,
    'has_doc_links': docLinks.isNotEmpty,
    'doc_links': docLinks,
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
        _renderLicenses(packageLinks.baseUrl, data.analysis?.licenses),
    'dependencies_html': _renderDependencyList(data.analysis),
    'search_deps_link': urls.searchUrl(q: 'dependency:${package.name}'),
    // TODO: remove the below keys after we've migrated to the new UI
    'is_flutter_favorite':
        (package.assignedTags ?? []).contains(PackageTags.isFlutterFavorite),
    'all_links': [...metaLinks, ...docLinks],
  });
}

/// Renders the `views/pkg/header.mustache` template for header metadata and
/// wraps it with content-header.
String renderPkgHeader(PackagePageData data) {
  final package = data.package;
  final selectedVersion = data.version;
  final bool showDevVersion = package.latestDevVersion != null &&
      package.latestSemanticVersion < package.latestDevSemanticVersion;
  final bool showUpdated =
      selectedVersion.version != package.latestVersion || showDevVersion;

  final metadataHtml = templateCache.renderTemplate('pkg/header', {
    'publisher_id': package.publisherId,
    'publisher_url': package.publisherId == null
        ? null
        : urls.publisherUrl(package.publisherId),
    'latest': {
      'show_updated': showUpdated,
      'show_dev_version': showDevVersion,
      'stable_url': urls.pkgPageUrl(package.name),
      'stable_version': package.latestVersion,
      'dev_url':
          urls.pkgPageUrl(package.name, version: package.latestDevVersion),
      'dev_version': package.latestDevVersion,
    },
    'short_created': selectedVersion.shortCreated,
  });
  final pkgView = PackageView.fromModel(
    package: package,
    version: selectedVersion,
    scoreCard: data.analysis?.card,
  );
  return renderDetailHeader(
    title: '${package.name} ${selectedVersion.version}',
    packageLikes: package.likes,
    isLiked: data.isLiked,
    isFlutterFavorite:
        (package.assignedTags ?? []).contains(PackageTags.isFlutterFavorite),
    metadataHtml: metadataHtml,
    tagsHtml: renderTags(
      package: pkgView,
      searchQuery: null,
      showTagBadges: true,
    ),
    isLoose: true,
  );
}

/// Renders the package detail page.
String renderPkgShowPage(PackagePageData data) {
  if (requestContext.isExperimental) {
    return _renderPkgPage(
      data: data,
      tabs: buildPackageTabs(
        packagePageData: data,
        readmeTab: _readmeTab(data),
      ),
    );
  } else {
    return _renderPkgPage(
      data: data,
      tabs: buildPackageTabs(
        packagePageData: data,
        readmeTab: _readmeTab(data),
        changelogTab: _changelogTab(data),
        exampleTab: _exampleTab(data),
        installingTab: _installTab(data),
        scoreTab: _scoreTab(data),
      ),
    );
  }
}

/// Renders the package changelog page.
String renderPkgChangelogPage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      packagePageData: data,
      changelogTab: _changelogTab(data),
    ),
  );
}

/// Renders the package example page.
String renderPkgExamplePage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      packagePageData: data,
      exampleTab: _exampleTab(data),
    ),
  );
}

/// Renders the package install page.
String renderPkgInstallPage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      packagePageData: data,
      installingTab: _installTab(data),
    ),
  );
}

/// Renders the package score page.
String renderPkgScorePage(PackagePageData data) {
  return _renderPkgPage(
    data: data,
    tabs: buildPackageTabs(
      packagePageData: data,
      scoreTab: _scoreTab(data),
    ),
  );
}

String _renderPkgPage({
  @required PackagePageData data,
  @required List<Tab> tabs,
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
  final isVersionPage = data.package.latestVersion != data.version.version;
  final packageAndVersion = isVersionPage
      ? '${data.version.package} ${data.version.version}'
      : data.version.package;
  final pageTitle =
      '$packageAndVersion | ${isFlutterPackage ? 'Flutter' : 'Dart'} Package';
  final canonicalUrl = isVersionPage
      ? urls.pkgPageUrl(data.package.name, includeHost: true)
      : null;
  final shareUrl = urls.pkgPageUrl(
    data.package.name,
    version: isVersionPage ? data.version.version : null,
    includeHost: true,
  );
  final noIndex = (card?.isSkipped ?? false) ||
      (card?.overallScore == 0.0) ||
      data.package.isDiscontinued;
  return renderLayoutPage(
    PageType.package,
    content,
    title: pageTitle,
    pageDescription: data.version.ellipsizedDescription,
    faviconUrl: isFlutterPackage ? staticUrls.flutterLogo32x32 : null,
    canonicalUrl: canonicalUrl,
    shareUrl: shareUrl,
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
  final version = data.version;
  final baseUrl = version.packageLinks.baseUrl;
  final content = version.readme == null
      ? ''
      : renderFile(
          version.readme,
          baseUrl,
          isChangelog: requestContext.isExperimental,
        );
  return Tab.withContent(
    id: 'readme',
    title: 'Readme',
    contentHtml: content,
    isMarkdown: true,
  );
}

Tab _changelogTab(PackagePageData data) {
  final version = data.version;
  if (version.changelog == null) return null;
  final baseUrl = version.packageLinks.baseUrl;
  final content = renderFile(
    version.changelog,
    baseUrl,
    isChangelog: requestContext.isExperimental,
  );
  return Tab.withContent(
    id: 'changelog',
    title: 'Changelog',
    contentHtml: content,
    isMarkdown: true,
  );
}

Tab _exampleTab(PackagePageData data) {
  final version = data.version;
  if (version.example == null) return null;
  final baseUrl = version.packageLinks.baseUrl;

  String renderedExample;
  final exampleFilename = version.example.filename;
  renderedExample = renderFile(version.example, baseUrl);
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
    titleHtml: renderScoreBox(data.toPackageView(), isTabHeader: true),
    contentHtml: renderAnalysisTab(data.version.package,
        data.version.pubspec.sdkConstraint, data.analysis?.card, data.analysis),
  );
}

String _getAuthorsHtml(List<String> authors) {
  return (authors ?? const []).map((String value) {
    final EmailAddress author = EmailAddress.parse(value);
    final escapedName = htmlEscape.convert(author.name ?? author.email);
    if (author.email != null) {
      final escapedEmail = htmlAttrEscape.convert(author.email);
      final emailSearchUrl = htmlAttrEscape.convert(
          SearchQuery.parse(query: 'email:${author.email}').toSearchLink());
      final emailIcon = requestContext.isExperimental
          ? ''
          : '<a href="mailto:$escapedEmail" title="Email $escapedEmail">'
              '<i class="email-icon"></i>'
              '</a> ';
      final searchIcon = requestContext.isExperimental
          ? ''
          : '<a href="$emailSearchUrl" title="Search packages with $escapedEmail" rel="nofollow">'
              '<i class="search-icon"></i>'
              '</a> ';
      final text = requestContext.isExperimental
          ? '<a href="$emailSearchUrl" title="Search packages from $escapedName" rel="nofollow">'
              '$escapedEmail'
              '</a>'
          : escapedName;
      return '<span class="author">$emailIcon$searchIcon$text</span>';
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
    'name': pv.package,
    'version': pv.version,
    'description': '${pv.package} - ${pv.pubspec.description}',
    'url': urls.pkgPageUrl(pv.package, includeHost: true),
    'dateCreated': p.created.toIso8601String(),
    'dateModified': pv.created.toIso8601String(),
    'programmingLanguage': 'Dart',
    'image':
        '${urls.siteRoot}${staticUrls.staticPath}/img/pub-dev-icon-cover-image.png'
  };
  final licenses = data.analysis?.licenses;
  final firstUrl =
      licenses?.firstWhere((lf) => lf.url != null, orElse: () => null)?.url;
  if (firstUrl != null) {
    map['license'] = firstUrl;
  }
  // TODO: add http://schema.org/codeRepository for github and gitlab links
  return '<script type="application/ld+json">\n${json.encode(map)}\n</script>\n';
}

/// Build package tabs.
///
/// Unspecified tab content will be filled with links to the corresponding page.
List<Tab> buildPackageTabs({
  @required PackagePageData packagePageData,
  Tab readmeTab,
  Tab changelogTab,
  Tab exampleTab,
  Tab installingTab,
  Tab versionsTab,
  Tab scoreTab,
  Tab adminTab,
}) {
  final package = packagePageData.package;
  final version = packagePageData.version;
  final isVersioned = version.version != package.latestVersion;
  final linkVersion = isVersioned ? version.version : null;
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
    titleHtml:
        renderScoreBox(packagePageData.toPackageView(), isTabHeader: true),
    href: urls.pkgScoreUrl(package.name, version: linkVersion),
  );
  adminTab ??= Tab.withLink(
    id: 'admin',
    title: 'Admin',
    href: urls.pkgAdminUrl(package.name),
  );
  return <Tab>[
    if (version.readme != null) readmeTab,
    if (version.changelog != null) changelogTab,
    if (version.example != null) exampleTab,
    installingTab,
    versionsTab,
    scoreTab,
    if (packagePageData.isAdmin) adminTab,
  ];
}
