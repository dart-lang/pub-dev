// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.templates;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:mustache/mustache.dart' as mustache;

import '../shared/analyzer_client.dart';
import '../shared/markdown.dart';
import '../shared/platform.dart';
import '../shared/search_service.dart' show SearchQuery, serializeSearchOrder;
import '../shared/utils.dart';

import 'model_properties.dart' show Author;
import 'models.dart';
import 'template_consts.dart';

String _escapeAngleBrackets(String msg) =>
    const HtmlEscape(HtmlEscapeMode.ELEMENT).convert(msg);

const HtmlEscape _htmlEscaper = const HtmlEscape();
const HtmlEscape _attrEscaper = const HtmlEscape(HtmlEscapeMode.ATTRIBUTE);

void registerTemplateService(TemplateService service) =>
    ss.register(#_templates, service);

TemplateService get templateService => ss.lookup(#_templates);

/// Used for rendering HTML pages for pub.dartlang.org.
class TemplateService {
  /// The path to the directory which contains mustache templates.
  ///
  /// The path should not contain a trailing slash (e.g. "/tmp/views").
  final String templateDirectory;

  /// A cache which keeps all used mustach templates parsed in memory.
  final Map<String, mustache.Template> _CachedMustacheTemplates = {};

  TemplateService({this.templateDirectory: '/project/app/views'});

  /// Renders the `views/pkg/versions/index` template.
  String renderPkgVersionsPage(String package, List<PackageVersion> versions,
      List<Uri> versionDownloadUrls) {
    assert(versions.length == versionDownloadUrls.length);

    final versionTableRows = [];
    for (int i = 0; i < versions.length; i++) {
      final PackageVersion version = versions[i];
      final String url = versionDownloadUrls[i].toString();
      versionTableRows.add(_renderVersionTableRow(version, url));
    }

    final values = {
      'package': {
        'name': package,
      },
      'version_table_rows': versionTableRows,
    };
    final content = _renderTemplate('pkg/versions/index', values);
    return renderLayoutPage(PageType.package, content);
  }

  String _renderVersionTableRow(PackageVersion version, String downloadUrl) {
    final versionData = {
      'package': version.package,
      'version': version.id,
      'short_created': version.shortCreated,
      'documentation': version.documentation,
      'download_url': downloadUrl,
      'icons': LogoUrls.versionsTableIcons,
    };
    return _renderTemplate('pkg/versions/version_row', versionData);
  }

  /// Renders the `views/pkg/index.mustache` template.
  String renderPkgIndexPage(
      List<PackageView> packages, PageLinks links, String currentPlatform,
      {SearchQuery searchQuery, int totalCount}) {
    final packagesJson = [];
    for (int i = 0; i < packages.length; i++) {
      final view = packages[i];
      final overallScore = view.overallScore;
      packagesJson.add({
        'url': '/packages/${view.name}',
        'name': view.name,
        'version': HTML_ESCAPE.convert(view.version),
        'show_dev_version': view.devVersion != null,
        'dev_version': HTML_ESCAPE.convert(view.devVersion ?? ''),
        'dev_version_href': Uri.encodeComponent(view.devVersion ?? ''),
        'last_uploaded': view.shortUpdated,
        'desc': view.ellipsizedDescription,
        'tags_html': _renderTags(view.platforms, package: view.name),
        'score_box_html': _renderScoreBox(overallScore,
            isNewPackage: view.isNewPackage, package: view.name),
      });
    }

    final PlatformDict platformDict = getPlatformDict(currentPlatform);
    final isSearch = searchQuery != null && searchQuery.hasQuery;
    final String sortValue = serializeSearchOrder(searchQuery?.order) ??
        (isSearch ? 'search_relevance' : 'listing_relevance');
    final SortDict sortDict = getSortDict(sortValue);
    final values = {
      'sort_value': sortValue,
      'sort_name': sortDict.label,
      'ranking_tooltip_html': sortDict.tooltip,
      'is_search': isSearch,
      'title': platformDict.pageTitle,
      'packages': packagesJson,
      'has_packages': packages.isNotEmpty,
      'pagination': renderPagination(links),
      'search_query': searchQuery?.query,
      'total_count': totalCount,
    };
    final content = _renderTemplate('pkg/index', values);

    String pageTitle = platformDict.pageTitle;
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
    );
  }

  /// Renders the `views/pkg/analysis_tab.mustache` template.
  String renderAnalysisTab(AnalysisExtract extract, AnalysisView analysis) {
    if (analysis == null || !analysis.hasAnalysisData) return null;

    String statusText;
    switch (analysis.analysisStatus) {
      case AnalysisStatus.aborted:
        statusText = 'aborted';
        break;
      case AnalysisStatus.failure:
        statusText = 'tool failures';
        break;
      case AnalysisStatus.success:
        statusText = 'completed';
        break;
    }

    final List suggestions = analysis.suggestions?.map((suggestion) {
      return {
        'title': markdownToHtml(suggestion.title, null),
        'description': markdownToHtml(suggestion.description, null),
      };
    })?.toList();

    List<Map> prepareDependencies(List<PkgDependency> list) {
      if (list == null || list.isEmpty) return const [];
      return list
          .map((pd) => {
                'package': pd.package,
                'constraint': pd.constraint?.toString(),
                'resolved': pd.resolved?.toString(),
                'available': pd.available?.toString(),
              })
          .toList();
    }

    final directDeps = prepareDependencies(analysis.directDependencies);
    final transitiveDeps = prepareDependencies(analysis.transitiveDependencies);
    final devDeps = prepareDependencies(analysis.devDependencies);
    final hasDependency = directDeps.isNotEmpty ||
        transitiveDeps.isNotEmpty ||
        devDeps.isNotEmpty;

    final Map<String, dynamic> data = {
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
      'hasSuggestions': suggestions != null && suggestions.isNotEmpty,
      'suggestions': suggestions,
      'has_dependency': hasDependency,
      'dependencies': {
        'has_direct': directDeps.isNotEmpty,
        'direct': directDeps,
        'has_transitive': transitiveDeps.isNotEmpty,
        'transitive': transitiveDeps,
        'has_dev': devDeps.isNotEmpty,
        'dev': devDeps,
      },
      'health': _formatScore(extract?.health),
      'maintenance': _formatScore(extract?.maintenance),
      'popularity': _formatScore(extract?.popularity),
      'score_box_html': _renderScoreBox(extract?.overallScore),
    };

    return _renderTemplate('pkg/analysis_tab', data);
  }

  Map<String, Object> _pkgShowPageValues(
      Package package,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
      AnalysisExtract extract,
      AnalysisView analysis,
      isFlutterPlugin) {
    List importExamples;
    if (selectedVersion.libraries.contains('${package.id}.dart')) {
      importExamples = [
        {
          'package': package.id,
          'library': '${package.id}.dart',
        }
      ];
    } else {
      importExamples = selectedVersion.libraries.map((library) {
        return {
          'package': selectedVersion.packageKey.id,
          'library': library,
        };
      }).toList();
    }

    // TODO(nweiz): Once the 1.11 SDK is out and pub supports ">=1.2.3-pre
    // <1.2.3", suggest that as the version constraint for prerelease versions.
    final exampleVersionConstraint = '"^${selectedVersion.version}"';

    bool isMarkdownFile(String filename) {
      return filename.toLowerCase().endsWith('.md');
    }

    bool isDartFile(String filename) {
      return filename.toLowerCase().endsWith('.dart');
    }

    String renderPlainText(String text) {
      return '<div class="highlight"><pre>${_escapeAngleBrackets(text)}'
          '</pre></div>';
    }

    String renderDartCode(String text) {
      return markdownToHtml('````dart\n${text.trim()}\n````\n', null);
    }

    String renderFile(FileObject file, String baseUrl) {
      final filename = file.filename;
      final content = file.text;
      if (content != null) {
        if (isMarkdownFile(filename)) {
          return markdownToHtml(content, baseUrl);
        } else if (isDartFile(filename)) {
          return renderDartCode(content);
        } else {
          return renderPlainText(content);
        }
      }
      return null;
    }

    String readmeFilename;
    String renderedReadme;
    if (selectedVersion.readme != null) {
      readmeFilename = selectedVersion.readme.filename;
      renderedReadme =
          renderFile(selectedVersion.readme, selectedVersion.homepage);
    }

    String changelogFilename;
    String renderedChangelog;
    if (selectedVersion.changelog != null) {
      changelogFilename = selectedVersion.changelog.filename;
      renderedChangelog =
          renderFile(selectedVersion.changelog, selectedVersion.homepage);
    }

    String exampleFilename;
    String renderedExample;
    if (selectedVersion.example != null) {
      exampleFilename = selectedVersion.example.filename;
      renderedExample =
          renderFile(selectedVersion.example, selectedVersion.homepage);
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

    final bool should_show_dev =
        latestStableVersion.semanticVersion < latestDevVersion.semanticVersion;
    final bool should_show =
        selectedVersion != latestStableVersion || should_show_dev;

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

    final values = {
      'package': {
        'name': package.name,
        'selected_version': {
          'version': selectedVersion.id,
          'example_version_constraint': exampleVersionConstraint,
          'has_libraries': importExamples.length > 0,
          'import_examples': importExamples,
        },
        'latest': {
          'should_show': should_show,
          'should_show_dev': should_show_dev,
          'stable_href': Uri.encodeComponent(latestStableVersion.id),
          'stable_name': HTML_ESCAPE.convert(latestStableVersion.id),
          'dev_href': Uri.encodeComponent(latestDevVersion.id),
          'dev_name': HTML_ESCAPE.convert(latestDevVersion.id),
        },
        'tags_html': _renderTags(analysis?.platforms, wrapperDiv: true),
        'description': selectedVersion.pubspec.description,
        // TODO: make this 'Authors' if PackageVersion.authors is a list?!
        'authors_title': 'Author',
        'authors_html':
            _getAuthorsHtml(selectedVersion.pubspec.getAllAuthors()),
        'homepage': selectedVersion.homepage,
        'nice_homepage': selectedVersion.homepageNice,
        'documentation': selectedVersion.documentation,
        'nice_documentation': selectedVersion.documentationNice,
        // TODO: make this 'Uploaders' if Package.uploaders is > 1?!
        'uploaders_title': 'Uploader',
        'uploaders_html': _getAuthorsHtml(package.uploaderEmails),
        'short_created': selectedVersion.shortCreated,
        'install_html': _renderInstall(isFlutterPlugin, analysis?.platforms),
        'license_html':
            _renderLicenses(selectedVersion.homepage, analysis?.licenses),
        'score_box_html': _renderScoreBox(extract?.overallScore,
            isNewPackage: package.isNewPackage()),
        'dependencies_html': _renderDependencyList(analysis),
        'analysis_html': renderAnalysisTab(extract, analysis),
      },
      'version_table_rows': versionTableRows,
      'show_versions_link': totalNumberOfVersions > versions.length,
      'tabs': tabs,
      'has_no_file_tab': tabs.isEmpty,
      'version_count': '$totalNumberOfVersions',
      'icons': LogoUrls.versionsTableIcons,
    };
    return values;
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
    return packages.map((p) => '<a href="/packages/$p">$p</a>').join(', ');
  }

  String _renderInstall(bool isFlutter, List<String> platforms) {
    final bool renderGeneric = !isFlutter ||
        platforms == null ||
        platforms.isEmpty ||
        platforms.length > 1 ||
        platforms.first != KnownPlatforms.flutter;
    final bool renderFlutter = isFlutter ||
        (platforms != null && platforms.contains(KnownPlatforms.flutter));
    String toolHtml;
    if (renderGeneric && renderFlutter) {
      toolHtml = '<code>pub get</code> or <code>packages get</code>';
    } else if (renderFlutter) {
      toolHtml = '<code>packages get</code>';
    } else {
      toolHtml = '<code>pub get</code>';
    }

    final values = {
      'generic': renderGeneric,
      'flutter': renderFlutter,
      'tool_html': toolHtml,
    };
    return _renderTemplate('pkg/install_block', values);
  }

  /// Renders the `views/pkg/show.mustache` template.
  String renderPkgShowPage(
      Package package,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
      AnalysisExtract extract,
      AnalysisView analysis) {
    assert(versions.length == versionDownloadUrls.length);
    final bool isFlutterPlugin =
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
      extract,
      analysis,
      isFlutterPlugin,
    );
    values['search_deps_link'] = _attrEscaper.convert(
      new Uri(
        path: '/packages',
        queryParameters: {'q': 'dependency:${package.name}'},
      ).toString(),
    );
    final content = _renderTemplate('pkg/show', values);
    return renderLayoutPage(
      PageType.package,
      content,
      title: '${package.name} ${selectedVersion.id} | Dart Package',
      packageName: selectedVersion.package,
      packageDescription: selectedVersion.ellipsizedDescription,
      faviconUrl: isFlutterPlugin ? LogoUrls.flutterLogo32x32 : null,
    );
  }

  /// Renders the `views/authorized.mustache` template.
  String renderAuthorizedPage() {
    final String content = _renderTemplate('authorized', {});
    return renderLayoutPage(PageType.package, content,
        title: 'Pub Authorized Successfully', includeSurvey: false);
  }

  /// Renders the `views/index.mustache` template.
  String renderErrorPage(String status, String message, String traceback) {
    final values = {
      'status': status,
      'message': message,
      'traceback': traceback
    };
    final String content = _renderTemplate('error', values);
    return renderLayoutPage(PageType.package, content,
        title: 'Error $status', includeSurvey: false);
  }

  /// Renders the `views/help.mustache` template.
  String renderHelpPage() {
    final String content = _renderTemplate('help', {});
    return renderLayoutPage(PageType.package, content);
  }

  /// Renders the `views/index.mustache` template.
  String renderIndexPage(
    String topHtml,
    String platform,
  ) {
    final platformDict = getPlatformDict(platform);
    final values = {
      'packages_url': platform == null ? '/packages' : '/$platform/packages',
      'more_packages': 'More ${platformDict.name} packages...',
      'top_header': platformDict.pageTitle,
      'ranking_tooltip_html': getSortDict('top').tooltip,
      'top_html': topHtml,
    };
    final String content = _renderTemplate('index', values);
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
          'ellipsized_description': package.ellipsizedDescription,
          'tags_html': _renderTags(package.platforms, package: package.name),
        };
      }).toList(),
    };
    return _renderTemplate('mini_list', values);
  }

  /// Renders the `views/layout.mustache` template.
  String renderLayoutPage(
    PageType type,
    String contentHtml, {
    String title: 'pub.dartlang.org',
    String packageName,
    String packageDescription,
    String faviconUrl,
    String platform,
    SearchQuery searchQuery,
    bool includeSurvey: true,
  }) {
    final queryText = searchQuery?.query;
    final String escapedSearchQuery =
        queryText == null ? null : HTML_ESCAPE.convert(queryText);
    String platformTabs;
    if (type == PageType.landing) {
      platformTabs = renderPlatformTabs(platform: platform, isLanding: true);
    } else if (type == PageType.listing) {
      platformTabs =
          renderPlatformTabs(platform: platform, searchQuery: searchQuery);
    }
    final searchSort = searchQuery?.order == null
        ? null
        : serializeSearchOrder(searchQuery.order);
    final platformDict = getPlatformDict(platform);
    final values = {
      'static_assets_dir': LogoUrls.newDesignAssetsDir,
      'favicon': faviconUrl ?? LogoUrls.smallDartFavicon,
      'package': packageName == null
          ? false
          : {
              'name': HTML_ESCAPE.convert(packageName),
              'description': HTML_ESCAPE.convert(packageDescription ?? ''),
            },
      'title': HTML_ESCAPE.convert(title),
      'search_platform': platform,
      'search_query': escapedSearchQuery,
      'search_query_placeholder': 'Search ${platformDict.name} packages',
      'search_sort_param': searchSort,
      'platform_tabs_html': platformTabs,
      'landing_blurb_html': platformDict.landingBlurb,
      // This is not escaped as it is already escaped by the caller.
      'content_html': contentHtml,
      'include_survey': includeSurvey,
      'landing_banner': type == PageType.landing,
      'landing_banner_image':
          platform == 'flutter' ? 'flutter-packages.png' : 'dart-packages.png',
      'landing_banner_alt':
          platform == 'flutter' ? 'Flutter packages' : 'Dart packages',
      'listing_banner': type == PageType.listing,
      'package_banner': type == PageType.package,
      'schema_org_searchaction_json': JSON.encode(_schemaOrgSearchAction),
    };
    return _renderTemplate('layout', values, escapeValues: false);
  }

  /// Renders the `views/pagination.mustache` template.
  String renderPagination(PageLinks pageLinks) {
    final values = {
      'page_links': pageLinks.hrefPatterns(),
    };
    return _renderTemplate('pagination', values, escapeValues: false);
  }

  /// Renders the tags using the pkg/tags template.
  String _renderTags(List<String> platforms,
      {String package, bool wrapperDiv: false}) {
    final List<Map> tags = <Map>[];
    if (platforms == null) {
      tags.add({
        'status': 'missing',
        'text': '[awaiting]',
        'title': 'Analysis should be ready soon.',
      });
    } else if (platforms.isEmpty) {
      final String hash = '#-analysis-tab-';
      final String href = package == null ? hash : '/packages/$package$hash';
      tags.add({
        'status': 'unidentified',
        'text': '[unidentified]',
        'title': 'Check the analysis tab for further details.',
        'href': href,
      });
    } else {
      tags.addAll(platforms.map((platform) {
        final platformDict = getPlatformDict(platform, nullIfMissing: true);
        return {
          'text': platformDict.name ?? platform,
          'href': platformDict?.listingUrl,
        };
      }));
    }
    return _renderTemplate('pkg/tags', {
      'has_tags': tags.isNotEmpty,
      'wrapper_div': wrapperDiv,
      'tags': tags,
    });
  }

  /// Renders [template] with given [values].
  ///
  /// If [escapeValues] is `false`, values in `values` will not be escaped.
  String _renderTemplate(String template, values, {bool escapeValues: true}) {
    final mustache.Template parsedTemplate =
        _CachedMustacheTemplates.putIfAbsent(template, () {
      final file = new File('$templateDirectory/$template.mustache');
      return new mustache.Template(file.readAsStringSync(),
          htmlEscapeValues: escapeValues, lenient: true);
    });
    return parsedTemplate.renderString(values);
  }

  String renderPlatformTabs({
    String platform,
    SearchQuery searchQuery,
    bool isLanding: false,
  }) {
    final String currentPlatform =
        platform ?? searchQuery?.platformPredicate?.single;
    Map platformTabData(String tabText, String tabPlatform) {
      String url;
      if (searchQuery != null) {
        final newQuery = searchQuery.change(
            platformPredicate: tabPlatform == null
                ? new PlatformPredicate()
                : new PlatformPredicate(required: [tabPlatform]));
        url = newQuery.toSearchLink();
      } else {
        final List<String> pathParts = [''];
        if (tabPlatform != null) pathParts.add(tabPlatform);
        if (!isLanding) pathParts.add('packages');
        url = pathParts.join('/');
        if (url.isEmpty) {
          url = '/';
        }
      }
      return {
        'text': tabText,
        'href': _attrEscaper.convert(url),
        'active': tabPlatform == currentPlatform
      };
    }

    final values = {
      'tabs': [
        platformTabData('Flutter', KnownPlatforms.flutter),
        platformTabData('Web', KnownPlatforms.web),
        platformTabData('Server', KnownPlatforms.server),
        platformTabData('All', null),
      ]
    };
    return _renderTemplate('platform_tabs', values);
  }
}

String _getAuthorsHtml(List<String> authors) {
  return (authors ?? const []).map((String value) {
    final Author author = new Author.parse(value);
    final escapedName = _htmlEscaper.convert(author.name);
    if (author.email != null) {
      final escapedEmail = _attrEscaper.convert(author.email);
      final emailSearchUrl = _attrEscaper.convert(
          new SearchQuery.parse(query: 'email:${author.email}').toSearchLink());
      return '<span class="author">'
          '<a href="mailto:$escapedEmail" title="Email $escapedEmail">'
          '<i class="email-icon"></i></a> '
          '<a href="$emailSearchUrl" title="Search packages with $escapedEmail">'
          '<i class="search-icon"></i></a> '
          '$escapedName'
          '</span>';
    } else {
      return '<span class="author">$escapedName</span>';
    }
  }).join('<br/>');
}

String _renderScoreBox(double overallScore,
    {bool isNewPackage, String package}) {
  final String formattedScore = _formatScore(overallScore);
  final String scoreClass = _classifyScore(overallScore);
  final String title = overallScore == null
      ? 'Awaiting analysis to complete.'
      : 'Analysis and more details.';
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
    return '<a href="/packages/$package#-analysis-tab-">$boxHtml</a>';
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
  if (value <= 0.4) return 'rotten';
  if (value <= 0.7) return 'good';
  return 'solid';
}

abstract class PageLinks {
  static const int resultsPerPage = 10;
  static const int maxPages = 10;

  final int offset;
  final int count;

  PageLinks(this.offset, this.count);

  PageLinks.empty()
      : offset = 1,
        count = 1;

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

  String formatHref(int page);
}

class PackageLinks extends PageLinks {
  static const int resultsPerPage = 10;
  static const int maxPages = 15;
  final String _basePath;
  final SearchQuery _searchQuery;

  PackageLinks(int offset, int count,
      {String basePath, SearchQuery searchQuery})
      : _basePath = basePath,
        _searchQuery = searchQuery,
        super(offset, count);

  PackageLinks.empty({String basePath})
      : _basePath = basePath,
        _searchQuery = null,
        super.empty();

  @override
  String formatHref(int page) {
    final String basePath = _basePath ?? '/packages';
    if (_searchQuery == null) {
      return '$basePath?page=$page';
    } else {
      return _searchQuery.toSearchLink(page: page);
    }
  }
}

abstract class LogoUrls {
  static const String newDesignAssetsDir = '/static/v2';
  static const String documentationIcon =
      '$newDesignAssetsDir/img/ic_drive_document_black_24dp.svg';
  static const String downloadIcon =
      '$newDesignAssetsDir/img/ic_get_app_black_24dp.svg';

  static const String smallDartFavicon = '/static/favicon.ico';
  static const String flutterLogo32x32 = '/static/img/flutter-logo-32x32.png';

  static const versionsTableIcons = const {
    'documentation': LogoUrls.documentationIcon,
    'download': LogoUrls.downloadIcon,
  };
}

enum PageType {
  landing,
  listing,
  package,
}

const _schemaOrgSearchAction = const {
  '@context': 'http://schema.org',
  '@type': 'WebSite',
  'url': 'https://pub.dartlang.org/',
  'potentialAction': const {
    '@type': 'SearchAction',
    'target': 'https://pub.dartlang.org/packages?q={query}',
    'query-input': 'required',
  },
};
