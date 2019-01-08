// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.templates;

import 'dart:convert';
import 'dart:math';

import 'package:meta/meta.dart';
import 'package:pana/models.dart' show SuggestionLevel;

import '../scorecard/models.dart';
import '../shared/analyzer_client.dart';
import '../shared/email.dart' show EmailAddress;
import '../shared/markdown.dart';
import '../shared/platform.dart';
import '../shared/search_service.dart';
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';

import 'color.dart';
import 'models.dart';
import 'static_files.dart';
import 'template_consts.dart';
import 'templates/_cache.dart';
import 'templates/layout.dart';

String _escapeAngleBrackets(String msg) =>
    const HtmlEscape(HtmlEscapeMode.element).convert(msg);

const HtmlEscape _htmlEscaper = const HtmlEscape();
const HtmlEscape _attrEscaper = const HtmlEscape(HtmlEscapeMode.attribute);

/// [TemplateService] singleton instance.
/// TODO: remove after https://github.com/dart-lang/pub-dartlang-dart/issues/1907 gets fixed
final templateService = new TemplateService();

/// Used for rendering HTML pages for pub.dartlang.org.
class TemplateService {
  /// Renders the `views/pkg/versions/index` template.
  String renderPkgVersionsPage(String package, List<PackageVersion> versions,
      List<Uri> versionDownloadUrls) {
    assert(versions.length == versionDownloadUrls.length);

    final stableVersionRows = [];
    final devVersionRows = [];
    PackageVersion latestDevVersion;
    for (int i = 0; i < versions.length; i++) {
      final PackageVersion version = versions[i];
      final String url = versionDownloadUrls[i].toString();
      final rowHtml = _renderVersionTableRow(version, url);
      if (version.semanticVersion.isPreRelease) {
        latestDevVersion ??= version;
        devVersionRows.add(rowHtml);
      } else {
        stableVersionRows.add(rowHtml);
      }
    }

    final htmlBlocks = <String>[];
    if (stableVersionRows.isNotEmpty && devVersionRows.isNotEmpty) {
      htmlBlocks.add(
          '<p>The latest dev release was <a href="#dev">${latestDevVersion.version}</a> '
          'on ${latestDevVersion.shortCreated}.</p>');
    }
    if (stableVersionRows.isNotEmpty) {
      htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
        'id': 'stable',
        'kind': 'Stable',
        'package': {'name': package},
        'version_table_rows': stableVersionRows,
      }));
    }
    if (devVersionRows.isNotEmpty) {
      htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
        'id': 'dev',
        'kind': 'Dev',
        'package': {'name': package},
        'version_table_rows': devVersionRows,
      }));
    }
    return renderLayoutPage(PageType.package, htmlBlocks.join(),
        title: '$package package - All Versions',
        canonicalUrl: urls.pkgPageUrl(package, includeHost: true));
  }

  String _renderVersionTableRow(PackageVersion version, String downloadUrl) {
    final versionData = {
      'package': version.package,
      'version': version.version,
      'version_url': urls.pkgPageUrl(version.package, version: version.version),
      'short_created': version.shortCreated,
      'dartdocs_url':
          _attr(urls.pkgDocUrl(version.package, version: version.version)),
      'download_url': _attr(downloadUrl),
      'icons': staticUrls.versionsTableIcons,
    };
    return templateCache.renderTemplate(
        'pkg/versions/version_row', versionData);
  }

  /// Renders the `views/pkg/index.mustache` template.
  String renderPkgIndexPage(
      List<PackageView> packages, PageLinks links, String currentPlatform,
      {SearchQuery searchQuery, int totalCount}) {
    final packagesJson = [];
    for (int i = 0; i < packages.length; i++) {
      final view = packages[i];
      final overallScore = view.overallScore;
      String externalType;
      bool isSdk = false;
      if (view.isExternal && view.url.startsWith('https://api.dartlang.org/')) {
        externalType = 'Dart core library';
        isSdk = true;
      }
      String scoreBoxHtml;
      if (isSdk) {
        scoreBoxHtml = _renderSdkScoreBox();
      } else if (!view.isExternal) {
        scoreBoxHtml = _renderScoreBox(overallScore,
            isSkipped: view.isSkipped,
            isNewPackage: view.isNewPackage,
            package: view.name);
      }
      packagesJson.add({
        'url': view.url ?? urls.pkgPageUrl(view.name),
        'name': view.name,
        'is_external': view.isExternal,
        'external_type': externalType,
        'show_metadata': !view.isExternal,
        'version': view.version,
        'show_dev_version': view.devVersion != null,
        'dev_version': view.devVersion,
        'dev_version_url': urls.pkgPageUrl(view.name, version: view.devVersion),
        'last_uploaded': view.shortUpdated,
        'desc': view.ellipsizedDescription,
        'tags_html': _renderTags(
          view.platforms,
          isAwaiting: view.isAwaiting,
          isDiscontinued: view.isDiscontinued,
          isLegacy: view.isLegacy,
          isObsolete: view.isObsolete,
          packageName: view.name,
        ),
        'score_box_html': scoreBoxHtml,
        'has_api_pages': view.apiPages != null && view.apiPages.isNotEmpty,
        'api_pages': view.apiPages
            ?.map((page) => {
                  'title': page.title ?? page.path,
                  'href': page.url ??
                      urls.pkgDocUrl(view.name,
                          isLatest: true, relativePath: page.path),
                })
            ?.toList(),
      });
    }

    final PlatformDict platformDict = getPlatformDict(currentPlatform);
    final isSearch = searchQuery != null && searchQuery.hasQuery;
    final unsupportedQualifier =
        isSearch && (searchQuery.parsedQuery.text?.contains(':') ?? false);
    final String sortValue = serializeSearchOrder(searchQuery?.order) ??
        (isSearch ? 'search_relevance' : 'listing_relevance');
    final SortDict sortDict = getSortDict(sortValue);
    final values = {
      'sort_value': sortValue,
      'sort_name': sortDict.label,
      'ranking_tooltip_html': sortDict.tooltip,
      'is_search': isSearch,
      'unsupported_qualifier': unsupportedQualifier,
      'title': platformDict.topPlatformPackages,
      'packages': packagesJson,
      'has_packages': packages.isNotEmpty,
      'pagination': renderPagination(links),
      'search_query': searchQuery?.query,
      'total_count': totalCount,
    };
    final content = templateCache.renderTemplate('pkg/index', values);

    String pageTitle = platformDict.topPlatformPackages;
    if (isSearch) {
      pageTitle = 'Search results for ${searchQuery.query}.';
    } else {
      if (links.rightmostPage > 1) {
        pageTitle = 'Page ${links.currentPage} | $pageTitle';
      }
    }
    return renderLayoutPage(
      PageType.listing,
      content,
      title: pageTitle,
      platform: currentPlatform,
      searchQuery: searchQuery,
      noIndex: true,
    );
  }

  String _renderAnalysisDepRow(PkgDependency pd) {
    return templateCache.renderTemplate('pkg/analysis_dep_row', {
      'is_hosted': pd.isHosted,
      'package': pd.package,
      'package_url': urls.pkgPageUrl(pd.package),
      'constraint': pd.constraint?.toString(),
      'resolved': pd.resolved?.toString(),
      'available': pd.available?.toString(),
    });
  }

  /// Renders the `views/pkg/analysis_tab.mustache` template.
  String renderAnalysisTab(String package, String sdkConstraint,
      ScoreCardData card, AnalysisView analysis) {
    if (card == null || analysis == null || !analysis.hasAnalysisData) {
      return null;
    }

    String statusText;
    switch (analysis.panaReportStatus) {
      case ReportStatus.aborted:
        statusText = 'aborted';
        break;
      case ReportStatus.failed:
        statusText = 'tool failures';
        break;
      case ReportStatus.success:
        statusText = 'completed';
        break;
      default:
        break;
    }

    List<Map> prepareDependencies(List<PkgDependency> list) {
      if (list == null || list.isEmpty) return const [];
      return list.map((pd) => {'row_html': _renderAnalysisDepRow(pd)}).toList();
    }

    final hasSdkConstraint = sdkConstraint != null && sdkConstraint.isNotEmpty;
    final directDeps = prepareDependencies(analysis.directDependencies);
    final transitiveDeps = prepareDependencies(analysis.transitiveDependencies);
    final devDeps = prepareDependencies(analysis.devDependencies);
    final hasDependency = hasSdkConstraint ||
        directDeps.isNotEmpty ||
        transitiveDeps.isNotEmpty ||
        devDeps.isNotEmpty;

    final Map<String, dynamic> data = {
      'package': package,
      'show_discontinued': card.isDiscontinued,
      'show_outdated': card.isObsolete,
      'show_legacy': card.isLegacy,
      'show_analysis': !card.isSkipped,
      'analysis_tab_url': urls.analysisTabUrl(package),
      'date_completed': analysis.timestamp == null
          ? null
          : shortDateFormat.format(analysis.timestamp),
      'analysis_status': statusText,
      'dart_sdk_version': analysis.dartSdkVersion,
      'pana_version': analysis.panaVersion,
      'flutter_version': analysis.flutterVersion,
      'platforms_html': analysis.platforms
              ?.map((p) => getPlatformDict(p, nullIfMissing: true)?.name ?? p)
              ?.join(', ') ??
          '<i>unsure</i>',
      'platforms_reason_html': markdownToHtml(analysis.platformsReason, null),
      'analysis_suggestions_html':
          _renderSuggestionBlockHtml('Analysis', analysis.panaSuggestions),
      'health_suggestions_html':
          _renderSuggestionBlockHtml('Health', analysis.healthSuggestions),
      'maintenance_suggestions_html': _renderSuggestionBlockHtml(
          'Maintenance', analysis.maintenanceSuggestions),
      'has_dependency': hasDependency,
      'dependencies': {
        'has_sdk': hasSdkConstraint,
        'sdk': sdkConstraint,
        'has_direct': hasSdkConstraint || directDeps.isNotEmpty,
        'direct': directDeps,
        'has_transitive': transitiveDeps.isNotEmpty,
        'transitive': transitiveDeps,
        'has_dev': devDeps.isNotEmpty,
        'dev': devDeps,
      },
      'score_bars': _renderScoreBars(card),
    };

    return templateCache.renderTemplate('pkg/analysis_tab', data);
  }

  String _renderSuggestionBlockHtml(
      String header, List<Suggestion> suggestions) {
    if (suggestions == null || suggestions.isEmpty) {
      return null;
    }

    final hasIssues = suggestions.any((s) => s.isError || s.isWarning);
    final label =
        hasIssues ? '$header issues and suggestions' : '$header suggestions';

    final mappedValues = suggestions.map((suggestion) {
      return {
        'icon_class': _suggestionIconClass(suggestion.level),
        'title_html':
            _renderSuggestionTitle(suggestion.title, suggestion.score),
        'description_html': markdownToHtml(suggestion.description, null),
        'suggestion_help_html': getSuggestionHelpMessage(suggestion.code),
      };
    }).toList();

    final data = <String, dynamic>{
      'label': label,
      'suggestions': mappedValues,
    };
    return templateCache.renderTemplate('pkg/analysis_suggestion_block', data);
  }

  Map<String, Object> _pkgShowPageValues(
      Package package,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
      ScoreCardData card,
      AnalysisView analysis,
      bool isFlutterPackage) {
    String readmeFilename;
    String renderedReadme;
    final homepageUrl = selectedVersion.homepage;
    if (selectedVersion.readme != null) {
      readmeFilename = selectedVersion.readme.filename;
      renderedReadme = _renderFile(selectedVersion.readme, homepageUrl);
    }

    String changelogFilename;
    String renderedChangelog;
    if (selectedVersion.changelog != null) {
      changelogFilename = selectedVersion.changelog.filename;
      renderedChangelog = _renderFile(selectedVersion.changelog, homepageUrl);
    }

    String exampleFilename;
    String renderedExample;
    if (selectedVersion.example != null) {
      exampleFilename = selectedVersion.example.filename;
      renderedExample = _renderFile(selectedVersion.example, homepageUrl);
      if (renderedExample != null) {
        renderedExample = '<p style="font-family: monospace">'
            '<b>${_htmlEscaper.convert(exampleFilename)}</b>'
            '</p>\n'
            '$renderedExample';
      }
    }

    final versionTableRows = [];
    for (int i = 0; i < versions.length; i++) {
      final PackageVersion version = versions[i];
      final String url = versionDownloadUrls[i].toString();
      versionTableRows.add(_renderVersionTableRow(version, url));
    }

    final bool shouldShowDev =
        latestStableVersion.semanticVersion < latestDevVersion.semanticVersion;
    final bool shouldShow =
        selectedVersion != latestStableVersion || shouldShowDev;

    final List<Map<String, String>> tabs = <Map<String, String>>[];
    void addFileTab(String id, String title, String content) {
      if (content != null) {
        tabs.add({
          'id': id,
          'title': title,
          'content': content,
        });
      }
    }

    addFileTab('readme', readmeFilename, renderedReadme);
    addFileTab('changelog', changelogFilename, renderedChangelog);
    addFileTab('example', 'Example', renderedExample);
    if (tabs.isNotEmpty) {
      tabs.first['active'] = '-active';
    }
    final isAwaiting = card == null ||
        analysis == null ||
        (!card.isSkipped && !analysis.hasPanaSummary);
    String documentationUrl = selectedVersion.documentation;
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
    final packageLinks = selectedVersion.packageLinks;

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
      addLink(homepageUrl, 'Homepage');
    }
    addLink(packageLinks.repositoryUrl, 'Repository',
        detectServiceProvider: true);
    addLink(packageLinks.issueTrackerUrl, 'View/report issues');
    addLink(packageLinks.documentationUrl, 'Documentation');
    addLink(dartdocsUrl, 'API reference');

    final values = {
      'package': {
        'name': package.name,
        'selected_version': {
          'version': selectedVersion.id,
        },
        'latest': {
          'should_show': shouldShow,
          'should_show_dev': shouldShowDev,
          'stable_url': urls.pkgPageUrl(package.name),
          'stable_name': latestStableVersion.version,
          'dev_url':
              urls.pkgPageUrl(package.name, version: latestDevVersion.version),
          'dev_name': latestDevVersion.version,
        },
        'tags_html': _renderTags(
          analysis?.platforms,
          isAwaiting: isAwaiting,
          isDiscontinued: card?.isDiscontinued ?? false,
          isLegacy: card?.isLegacy ?? false,
          isObsolete: card?.isObsolete ?? false,
        ),
        'description': selectedVersion.pubspec.description,
        // TODO: make this 'Authors' if PackageVersion.authors is a list?!
        'authors_title': 'Author',
        'authors_html': _getAuthorsHtml(selectedVersion.pubspec.authors),
        'links': links,
        // TODO: make this 'Uploaders' if Package.uploaders is > 1?!
        'uploaders_title': 'Uploader',
        'uploaders_html': _getAuthorsHtml(package.uploaderEmails),
        'short_created': selectedVersion.shortCreated,
        'license_html': _renderLicenses(homepageUrl, analysis?.licenses),
        'score_box_html': _renderScoreBox(card?.overallScore,
            isSkipped: card?.isSkipped ?? false,
            isNewPackage: package.isNewPackage()),
        'dependencies_html': _renderDependencyList(analysis),
        'analysis_html': renderAnalysisTab(package.name,
            selectedVersion.pubspec.sdkConstraint, card, analysis),
        'schema_org_pkgmeta_json':
            json.encode(_schemaOrgPkgMeta(package, selectedVersion, analysis)),
      },
      'version_table_rows': versionTableRows,
      'show_versions_link': totalNumberOfVersions > versions.length,
      'versions_url': urls.pkgVersionsUrl(package.name),
      'tabs': tabs,
      'has_no_file_tab': tabs.isEmpty,
      'version_count': '$totalNumberOfVersions',
      'icons': staticUrls.versionsTableIcons,
    };
    return values;
  }

  Map<String, dynamic> _renderScoreBars(ScoreCardData card) {
    String renderScoreBar(double score, Brush brush) {
      return templateCache.renderTemplate('pkg/score_bar', {
        'percent': _formatScore(score ?? 0.0),
        'score': _formatScore(score),
        'background': brush.background.toString(),
        'color': brush.color.toString(),
        'shadow': brush.shadow.toString(),
      });
    }

    final isSkipped = card?.isSkipped ?? false;
    final healthScore = isSkipped ? null : card?.healthScore;
    final maintenanceScore = isSkipped ? null : card?.maintenanceScore;
    final popularityScore = card?.popularityScore;
    final overallScore = card?.overallScore ?? 0.0;
    return {
      'health_html':
          renderScoreBar(healthScore, genericScoreBrush(healthScore)),
      'maintenance_html':
          renderScoreBar(maintenanceScore, genericScoreBrush(maintenanceScore)),
      'popularity_html':
          renderScoreBar(popularityScore, genericScoreBrush(popularityScore)),
      'overall_html':
          renderScoreBar(overallScore, overallScoreBrush(overallScore)),
    };
  }

  String _renderLicenses(String baseUrl, List<LicenseFile> licenses) {
    if (licenses == null || licenses.isEmpty) return null;
    return licenses.map((license) {
      final String escapedName = _htmlEscaper.convert(license.shortFormatted);
      String html = escapedName;

      if (license.url != null && license.path != null) {
        final String escapedLink = _attrEscaper.convert(license.url);
        final String escapedPath = _htmlEscaper.convert(license.path);
        html += ' (<a href="$escapedLink">$escapedPath</a>)';
      } else if (license.path != null) {
        final String escapedPath = _htmlEscaper.convert(license.path);
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

  String _renderInstallTab(Package package, PackageVersion selectedVersion,
      bool isFlutterPackage, List<String> platforms) {
    List importExamples;
    if (selectedVersion.libraries.contains('${package.id}.dart')) {
      importExamples = [
        {
          'package': package.id,
          'library': '${package.id}.dart',
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
      'package': package.name,
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

  /// Renders the `views/pkg/show.mustache` template.
  String renderPkgShowPage(
      Package package,
      bool isVersionPage,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
      ScoreCardData card,
      AnalysisView analysis) {
    assert(versions.length == versionDownloadUrls.length);
    final int platformCount = card?.platformTags?.length ?? 0;
    final String singlePlatform =
        platformCount == 1 ? card.platformTags.single : null;
    final bool hasPlatformSearch =
        singlePlatform != null && singlePlatform != KnownPlatforms.other;
    final bool hasOnlyFlutterPlatform =
        singlePlatform == KnownPlatforms.flutter;
    final bool isFlutterPackage = hasOnlyFlutterPlatform ||
        latestStableVersion.pubspec.dependsOnFlutterSdk ||
        latestStableVersion.pubspec.hasFlutterPlugin;

    final Map<String, Object> values = _pkgShowPageValues(
      package,
      versions,
      versionDownloadUrls,
      selectedVersion,
      latestStableVersion,
      latestDevVersion,
      totalNumberOfVersions,
      card,
      analysis,
      isFlutterPackage,
    );
    values['search_deps_link'] =
        urls.searchUrl(q: 'dependency:${package.name}');
    values['install_tab_html'] = _renderInstallTab(
        package, selectedVersion, isFlutterPackage, analysis?.platforms);
    final content = templateCache.renderTemplate('pkg/show', values);
    final packageAndVersion = isVersionPage
        ? '${selectedVersion.package} ${selectedVersion.version}'
        : selectedVersion.package;
    var pageDescription = packageAndVersion;
    if (isFlutterPackage) {
      pageDescription += ' Flutter and Dart package';
    } else {
      pageDescription += ' Dart package';
    }
    final pageTitle =
        '$packageAndVersion | ${isFlutterPackage ? 'Flutter' : 'Dart'} Package';
    pageDescription += ' - ${selectedVersion.ellipsizedDescription}';
    final canonicalUrl =
        isVersionPage ? urls.pkgPageUrl(package.name, includeHost: true) : null;
    return renderLayoutPage(
      PageType.package,
      content,
      title: pageTitle,
      pageDescription: pageDescription,
      faviconUrl: isFlutterPackage ? staticUrls.flutterLogo32x32 : null,
      canonicalUrl: canonicalUrl,
      platform: hasPlatformSearch ? singlePlatform : null,
      noIndex: package.isDiscontinued == true, // isDiscontinued may be null
    );
  }

  /// Renders the `views/uploader_confirmed.mustache` template.
  String renderUploaderConfirmedPage(String package, String uploaderEmail) {
    final String content = templateCache.renderTemplate('uploader_confirmed', {
      'package': package,
      'uploader_email': uploaderEmail,
    });
    return renderLayoutPage(PageType.package, content,
        title: 'Uploader confirmed', includeSurvey: false);
  }

  /// Renders the `views/authorized.mustache` template.
  String renderAuthorizedPage() {
    final String content = templateCache.renderTemplate('authorized', {});
    return renderLayoutPage(PageType.package, content,
        title: 'Pub Authorized Successfully', includeSurvey: false);
  }

  /// Renders the `views/index.mustache` template.
  String renderErrorPage(
      String title, String message, List<PackageView> topPackages) {
    final hasTopPackages = topPackages != null && topPackages.isNotEmpty;
    final topPackagesHtml = hasTopPackages ? renderMiniList(topPackages) : null;
    final values = {
      'title': title,
      'message_html': markdownToHtml(message, null),
      'has_top_packages': hasTopPackages,
      'top_packages_html': topPackagesHtml,
    };
    final String content = templateCache.renderTemplate('error', values);
    return renderLayoutPage(PageType.package, content,
        title: title, includeSurvey: false);
  }

  /// Renders the `views/help.mustache` template.
  String renderHelpPage() {
    final String content = templateCache.renderTemplate('help', {});
    return renderLayoutPage(PageType.package, content,
        title: 'Help | Dart Packages');
  }

  /// Renders the `views/index.mustache` template.
  String renderIndexPage(
    String topHtml,
    String platform,
  ) {
    final platformDict = getPlatformDict(platform);
    final packagesUrl = urls.searchUrl(platform: platform);
    final links = <String>[
      '<a href="$packagesUrl">${_htmlEscaper.convert(platformDict.morePlatformPackagesLabel)}</a>'
    ];
    if (platformDict.onlyPlatformPackagesUrl != null) {
      links.add('<a href="${platformDict.onlyPlatformPackagesUrl}">'
          '${_htmlEscaper.convert(platformDict.onlyPlatformPackagesLabel)}</a>');
    }
    final values = {
      'more_links_html': links.join(' '),
      'top_header': platformDict.topPlatformPackages,
      'ranking_tooltip_html': getSortDict('top').tooltip,
      'top_html': topHtml,
    };
    final String content = templateCache.renderTemplate('index', values);
    return renderLayoutPage(
      PageType.landing,
      content,
      title: platformDict.landingPageTitle,
      platform: platform,
    );
  }

  /// Renders the `views/mini_list.mustache` template.
  String renderMiniList(List<PackageView> packages) {
    final values = {
      'packages': packages.map((package) {
        return {
          'name': package.name,
          'package_url': urls.pkgPageUrl(package.name),
          'ellipsized_description': package.ellipsizedDescription,
          'tags_html': _renderTags(
            package.platforms,
            isAwaiting: package.isAwaiting,
            isDiscontinued: package.isDiscontinued,
            isLegacy: package.isLegacy,
            isObsolete: package.isObsolete,
            packageName: package.name,
          ),
        };
      }).toList(),
    };
    return templateCache.renderTemplate('mini_list', values);
  }

  /// Renders the `views/pagination.mustache` template.
  String renderPagination(PageLinks pageLinks) {
    final values = {
      'page_links': pageLinks.hrefPatterns(),
    };
    return templateCache.renderTemplate('pagination', values,
        escapeValues: false);
  }

  /// Renders the tags using the pkg/tags template.
  String _renderTags(
    List<String> platforms, {
    @required bool isAwaiting,
    @required bool isDiscontinued,
    @required bool isLegacy,
    @required bool isObsolete,
    String packageName,
  }) {
    final List<Map> tags = <Map>[];
    if (isAwaiting) {
      tags.add({
        'status': 'missing',
        'text': '[awaiting]',
        'title': 'Analysis should be ready soon.',
      });
    } else if (isDiscontinued) {
      tags.add({
        'status': 'discontinued',
        'text': '[discontinued]',
        'title': 'Package was discontinued.',
      });
    } else if (isObsolete) {
      tags.add({
        'status': 'missing',
        'text': '[outdated]',
        'title': 'Package version too old, check latest stable.',
      });
    } else if (isLegacy) {
      tags.add({
        'status': 'legacy',
        'text': 'Dart 2 incompatible',
        'title': 'Package does not support Dart 2.',
      });
    } else if (platforms != null && platforms.isNotEmpty) {
      tags.addAll(platforms.map((platform) {
        final platformDict = getPlatformDict(platform, nullIfMissing: true);
        return {
          'text': platformDict?.name ?? platform,
          'href': platformDict?.listingUrl,
          'title': platformDict?.tagTitle,
        };
      }));
    } else {
      tags.add({
        'status': 'unidentified',
        'text': '[unidentified]',
        'title': 'Check the analysis tab for further details.',
        'href': urls.analysisTabUrl(packageName),
      });
    }
    return templateCache.renderTemplate('pkg/tags', {'tags': tags});
  }
}

String _getAuthorsHtml(List<String> authors) {
  return (authors ?? const []).map((String value) {
    final EmailAddress author = new EmailAddress.parse(value);
    final escapedName = _htmlEscaper.convert(author.name ?? author.email);
    if (author.email != null) {
      final escapedEmail = _attrEscaper.convert(author.email);
      final emailSearchUrl = _attrEscaper.convert(
          new SearchQuery.parse(query: 'email:${author.email}').toSearchLink());
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

String _renderSdkScoreBox() {
  return '<div class="score-box"><span class="number -small -solid">sdk</span></div>';
}

String _renderScoreBox(
  double overallScore, {
  @required bool isSkipped,
  bool isNewPackage,
  String package,
}) {
  final String formattedScore = _formatScore(overallScore);
  final String scoreClass = _classifyScore(overallScore);
  String title;
  if (!isSkipped && overallScore == null) {
    title = 'Awaiting analysis to complete.';
  } else {
    title = 'Analysis and more details.';
  }
  final String escapedTitle = _attrEscaper.convert(title);
  final newIndicator = (isNewPackage ?? false)
      ? '<span class="new" title="Created in the last 30 days">new</span>'
      : '';
  final String boxHtml = '<div class="score-box">'
      '$newIndicator'
      '<span class="number -$scoreClass" title="$escapedTitle">$formattedScore</span>'
      // TODO: decide on label - {{! <span class="text">?????</span> }}
      '</div>';
  if (package != null) {
    return '<a href="${urls.analysisTabUrl(package)}">$boxHtml</a>';
  } else {
    return boxHtml;
  }
}

String _formatScore(double value) {
  if (value == null) return '--';
  if (value <= 0.0) return '0';
  if (value >= 1.0) return '100';
  return (value * 100.0).round().toString();
}

String _classifyScore(double value) {
  if (value == null) return 'missing';
  if (value <= 0.5) return 'rotten';
  if (value <= 0.7) return 'good';
  return 'solid';
}

class PageLinks {
  final int offset;
  final int count;
  final SearchQuery _searchQuery;

  PageLinks(this.offset, this.count, {SearchQuery searchQuery})
      : _searchQuery = searchQuery;

  PageLinks.empty()
      : offset = 1,
        count = 1,
        _searchQuery = null;

  int get leftmostPage => max(currentPage - maxPages ~/ 2, 1);

  int get currentPage => 1 + offset ~/ resultsPerPage;

  int get rightmostPage {
    final int fromSymmetry = currentPage + maxPages ~/ 2;
    final int fromCount = 1 + ((count - 1) ~/ resultsPerPage);
    return min(fromSymmetry, max(currentPage, fromCount));
  }

  List<Map> hrefPatterns() {
    final List<Map> results = [];

    final bool hasPrevious = currentPage > 1;
    results.add({
      'disabled': !hasPrevious,
      'render_link': hasPrevious,
      'href': _attrEscaper.convert(formatHref(currentPage - 1)),
      'text': '&laquo;',
    });

    for (int page = leftmostPage; page <= rightmostPage; page++) {
      final bool isCurrent = page == currentPage;
      results.add({
        'active': isCurrent,
        'render_link': !isCurrent,
        'href': _attrEscaper.convert(formatHref(page)),
        'text': '$page',
        'rel_prev': currentPage == page + 1,
        'rel_next': currentPage == page - 1,
      });
    }

    final bool hasNext = currentPage < rightmostPage;
    results.add({
      'disabled': !hasNext,
      'render_link': hasNext,
      'href': _attrEscaper.convert(formatHref(currentPage + 1)),
      'text': '&raquo;',
    });

    // should not happen
    assert(!results
        .any((map) => map['disabled'] == true && map['active'] == true));
    return results;
  }

  String formatHref(int page) {
    if (_searchQuery == null) {
      return urls.searchUrl(page: page);
    } else {
      return _searchQuery.toSearchLink(page: page);
    }
  }
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

String _renderFile(FileObject file, String baseUrl) {
  final filename = file.filename;
  final content = file.text;
  if (content != null) {
    if (_isMarkdownFile(filename)) {
      return markdownToHtml(content, baseUrl);
    } else if (_isDartFile(filename)) {
      return _renderDartCode(content);
    } else {
      return _renderPlainText(content);
    }
  }
  return null;
}

bool _isMarkdownFile(String filename) => filename.toLowerCase().endsWith('.md');

bool _isDartFile(String filename) => filename.toLowerCase().endsWith('.dart');

String _renderDartCode(String text) =>
    markdownToHtml('````dart\n${text.trim()}\n````\n', null);

String _renderPlainText(String text) =>
    '<div class="highlight"><pre>${_escapeAngleBrackets(text)}</pre></div>';

String _attr(String value) {
  if (value == null) return null;
  return _attrEscaper.convert(value);
}

String _suggestionIconClass(String level) {
  if (level == null) return 'suggestion-icon-info';
  switch (level) {
    case SuggestionLevel.error:
      return 'suggestion-icon-danger';
    case SuggestionLevel.warning:
      return 'suggestion-icon-warning';
    default:
      return 'suggestion-icon-info';
  }
}

String _renderSuggestionTitle(String title, double score) {
  final formattedScore = _formatSuggestionScore(score);
  if (formattedScore != null) {
    title = '$title ($formattedScore)';
  }
  return markdownToHtml(title, null);
}

String _formatSuggestionScore(double score) {
  if (score == null || score == 0.0) {
    return null;
  }
  final intValue = score.round();
  final isInt = intValue.toDouble() == score;
  final formatted = isInt ? intValue.toString() : score.toStringAsFixed(2);
  return '-$formatted points';
}
