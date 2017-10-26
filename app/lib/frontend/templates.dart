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
import '../shared/search_service.dart' show SearchQuery;
import '../shared/utils.dart';

import 'models.dart';
import 'search_service.dart' show SearchResultPage;

String _escapeAngleBrackets(String msg) =>
    const HtmlEscape(HtmlEscapeMode.ELEMENT).convert(msg);

const HtmlEscape _htmlEscaper = const HtmlEscape();
const HtmlEscape _attrEscaper = const HtmlEscape(HtmlEscapeMode.ATTRIBUTE);

final _AuthorsRegExp = new RegExp(r'^\s*(.+)\s+<(.+)>\s*$');

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

    final Map<String, Object> values =
        _pkgVersionsValues(package, versions, versionDownloadUrls);
    return _renderPage('pkg/versions/index', values);
  }

  Map<String, Object> _pkgVersionsValues(String package,
      List<PackageVersion> versions, List<Uri> versionDownloadUrls) {
    final versionsJson = [];
    for (int i = 0; i < versions.length; i++) {
      final PackageVersion version = versions[i];
      final String url = versionDownloadUrls[i].toString();
      versionsJson.add({
        'version': version.id,
        'short_created': version.shortCreated,
        'documentation': version.documentation,
        'download_url': url,
      });
    }

    final values = {
      'package': {
        'name': package,
      },
      'versions': versionsJson,
      'icons': LogoUrls.versionsTableIcons, // used in v2 only
    };
    return values;
  }

  /// Renders the `views/v2/pkg/versions/index` template.
  String renderPkgVersionsPageV2(String package, List<PackageVersion> versions,
      List<Uri> versionDownloadUrls) {
    assert(versions.length == versionDownloadUrls.length);

    final Map<String, Object> values =
        _pkgVersionsValues(package, versions, versionDownloadUrls);
    final content = _renderTemplate('v2/pkg/versions/index', values);
    return renderLayoutPageV2(content);
  }

  /// Renders the `views/pkg/index.mustache` template.
  String renderPkgIndexPage(List<PackageView> packages, PageLinks links,
      {String title, String faviconUrl, String descriptionHtml}) {
    final packagesJson = [];
    for (int i = 0; i < packages.length; i++) {
      final view = packages[i];
      packagesJson.add({
        'icons': _renderIconsColumnHtml(view.platforms),
        'name': view.name,
        'description': {
          'ellipsized_description': view.ellipsizedDescription,
        },
        'authors_html': _getAuthorsHtml(view.authors),
        'short_updated': view.shortUpdated,
      });
    }
    final values = {
      'title': title ?? 'Packages',
      'description_html': descriptionHtml,
      'packages': packagesJson,
      'pagination': renderPagination(links),
    };

    String pageTitle = title ?? 'All Packages';
    if (links.rightmostPage > 1) {
      pageTitle = 'Page ${links.currentPage} | $pageTitle';
    }

    return _renderPage('pkg/index', values,
        title: pageTitle, faviconUrl: faviconUrl);
  }

  /// Renders the `views/v2/pkg/index.mustache` template.
  String renderPkgIndexPageV2(
      List<PackageView> packages, PageLinks links, String currentPlatform) {
    final packagesJson = [];
    for (int i = 0; i < packages.length; i++) {
      final view = packages[i];
      packagesJson.add({
        'url': '/packages/${view.name}',
        'name': view.name,
        'version': HTML_ESCAPE.convert(view.version),
        'show_dev_version': view.devVersion != null,
        'dev_version': HTML_ESCAPE.convert(view.devVersion ?? ''),
        'dev_version_href': Uri.encodeComponent(view.devVersion ?? ''),
        'last_uploaded': view.shortUpdated,
        'desc': view.ellipsizedDescription,
        'tags_html': _renderTags(view.platforms), // used in v2 only
        // TODO: add authors (?) - old version had it, new design may not have the space for it
      });
    }

    String title = 'Packages';
    String descriptionHtml = '';
    if (currentPlatform == KnownPlatforms.flutter) {
      title = 'Flutter Packages';
      descriptionHtml = flutterPackagesDescriptionHtml;
    }

    final values = {
      'platform_tabs_html': renderPlatformTabs(platform: currentPlatform),
      'title': title ?? 'Packages',
      'description_html': descriptionHtml,
      'packages': packagesJson,
      'has_packages': packages.isNotEmpty,
      'pagination': renderPaginationV2(links),
    };
    final content = _renderTemplate('v2/pkg/index', values);

    String pageTitle = title ?? 'All Packages';
    if (links.rightmostPage > 1) {
      pageTitle = 'Page ${links.currentPage} | $pageTitle';
    }
    return renderLayoutPageV2(
      content,
      title: pageTitle,
      platform: currentPlatform,
    );
  }

  /// Renders the `views/v2/pkg/analysis_tab.mustache` template.
  String renderAnalysisTabV2(AnalysisView analysis) {
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

    final List<String> toolProblems = analysis.toolProblems;

    final List<Map> dependencies = analysis
        .getTransitiveDependencies()
        .map((String pkg) => {
              'name': pkg,
              'text': pkg,
              'sep': ',',
            })
        .toList();
    if (dependencies.isNotEmpty) {
      dependencies.last['sep'] = '';
    }

    final Map<String, dynamic> data = {
      'date_completed': analysis.timestamp == null
          ? null
          : shortDateFormat.format(analysis.timestamp),
      'analysis_status': statusText,
      'tool_problems': toolProblems,
      "has_tool_problems": toolProblems != null && toolProblems.isNotEmpty,
      'has_dependency': dependencies.isNotEmpty,
      'dependencies': dependencies,
      'health': analysis.health,
    };

    return _renderTemplate('v2/pkg/analysis_tab', data);
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
      analysis,
      isFlutterPlugin,
    );
    return _renderPage(
      'pkg/show',
      values,
      title: '${package.name} ${selectedVersion.id} | Dart Package',
      packageVersion: selectedVersion,
      faviconUrl: isFlutterPlugin ? LogoUrls.flutterLogo32x32 : null,
    );
  }

  Map<String, Object> _pkgShowPageValues(
      Package package,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
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

    final versionsJson = [];
    for (int i = 0; i < versions.length; i++) {
      final PackageVersion version = versions[i];
      final String url = versionDownloadUrls[i].toString();
      versionsJson.add({
        'version': version.id,
        'short_created': version.shortCreated,
        'documentation': version.documentation,
        'download_url': url,
      });
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
      tabs.first['class'] = 'active'; // used in old design only
      tabs.first['active'] = '-active'; // used in v2 only
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
        'icons': _renderIconsBlockHtml(
            analysis?.platforms), // used in old design only
        'tags_html': _renderTags(analysis?.platforms,
            wrapperDiv: true), // used in v2 only
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
        'uploaders_html': _getUploadersHtml(package),
        'short_created': selectedVersion.shortCreated,
        'install_command': isFlutterPlugin ? 'flutter packages get' : 'pub get',
        'install_tool': isFlutterPlugin ? '\'packages get\'' : '\'pub get\'',
        'license': analysis?.licenseText,
        'analysis_html': renderAnalysisTabV2(analysis),
      },
      'versions': versionsJson,
      'show_versions_link': totalNumberOfVersions > versions.length,
      'tabs': tabs,
      'has_no_file_tab': tabs.isEmpty,
      'version_count': '$totalNumberOfVersions',
      'icons': LogoUrls.versionsTableIcons, // used in v2 only
    };
    return values;
  }

  /// Renders the `views/v2/pkg/show.mustache` template.
  String renderPkgShowPageV2(
      Package package,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
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
      analysis,
      isFlutterPlugin,
    );
    final content = _renderTemplate('v2/pkg/show', values);
    return renderLayoutPageV2(
      content,
      title: '${package.name} ${selectedVersion.id} | Dart Package',
      packageName: selectedVersion.package,
      packageDescription: selectedVersion.ellipsizedDescription,
      faviconUrl: isFlutterPlugin ? LogoUrls.flutterLogo32x32 : null,
    );
  }

  /// Renders the `views/authorized.mustache` template.
  String renderAuthorizedPage() {
    return _renderPage('authorized', {},
        title: 'Pub Authorized Successfully', includeSurvey: false);
  }

  /// Renders the `views/index.mustache` template.
  String renderErrorPage(String status, String message, String traceback) {
    final values = {
      'status': status,
      'message': message,
      'traceback': traceback
    };
    return _renderPage('error', values,
        title: 'Error $status', includeSurvey: false);
  }

  /// Renders the `views/index.mustache` template.
  String renderIndexPage(
      List<PackageVersion> recentPackages, List<AnalysisView> analysisViews) {
    final values = {
      'recent_packages': new List.generate(recentPackages.length, (index) {
        final PackageVersion version = recentPackages[index];
        final AnalysisView analysis = analysisViews[index];
        final description = version.ellipsizedDescription;
        return {
          'icons': _renderIconsColumnHtml(analysis.platforms),
          'name': version.packageKey.id,
          'short_updated': version.shortCreated,
          'latest_version': {'version': version.id},
          'description': description != null,
          'ellipsized_description': description,
        };
      }).toList(),
    };
    return _renderPage('index', values, title: 'Pub: Dart Package Manager');
  }

  /// Renders the `views/v2/index.mustache` template.
  String renderIndexPageV2(
    String topHtml,
    String updatedHtml,
    String newestHtml,
    String platform,
  ) {
    final values = {
      'platform_tabs_html':
          renderPlatformTabs(platform: platform, isLanding: true),
      'top_html': topHtml,
      'updated_html': updatedHtml,
      'newest_html': newestHtml,
    };
    final String content = _renderTemplate('v2/index', values);
    return renderLayoutPageV2(
      content,
      title: 'Pub: Dart Package Manager',
      homeBanner: true,
      platform: platform,
    );
  }

  /// Renders the `views/v2/mini_list.mustache` template.
  String renderMiniList(List<PackageView> packages) {
    final values = {
      'packages': packages.map((package) {
        return {
          'name': package.name,
          'ellipsized_description': package.ellipsizedDescription,
          'tags_html': _renderTags(package.platforms),
        };
      }).toList(),
    };
    return _renderTemplate('v2/mini_list', values);
  }

  /// Renders the `views/v2/layout.mustache` template.
  String renderLayoutPageV2(
    String contentHtml, {
    String title: 'pub.dartlang.org',
    String packageName,
    String packageDescription,
    String faviconUrl,
    String platform,
    String searchQuery,
    bool homeBanner: false,
    bool includeSurvey: true,
  }) {
    final String escapedSearchQuery =
        searchQuery == null ? null : HTML_ESCAPE.convert(searchQuery);
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
      // This is not escaped as it is already escaped by the caller.
      'content_html': contentHtml,
      'include_survey': includeSurvey,
      'home_banner': homeBanner,
      'default_banner': !homeBanner,
    };
    return _renderTemplate('v2/layout', values, escapeValues: false);
  }

  /// Renders the `views/layout.mustache` template.
  String renderLayoutPage(String title, String contentString,
      {PackageVersion packageVersion,
      String faviconUrl,
      String searchQuery,
      bool includeSurvey: true}) {
    final String escapedSearchQuery =
        searchQuery == null ? null : HTML_ESCAPE.convert(searchQuery);
    final values = {
      'favicon': faviconUrl ?? LogoUrls.smallDartFavicon,
      'package': packageVersion == null
          ? false
          : {
              'name': HTML_ESCAPE.convert(packageVersion.packageKey.id),
              'description':
                  HTML_ESCAPE.convert(packageVersion.ellipsizedDescription),
            },
      'title': HTML_ESCAPE.convert(title),
      'search_query': escapedSearchQuery,
      // This is not escaped as it is already escaped by the caller.
      'content': contentString,
      // TODO: The python implementation used
      'message': false,
      'include_survey': includeSurvey
    };
    return _renderTemplate('layout', values, escapeValues: false);
  }

  /// Renders the `views/v2/pagination.mustache` template.
  String renderPaginationV2(PageLinks pageLinks) {
    final values = {
      'page_links': pageLinks.hrefPatterns(),
    };
    return _renderTemplate('v2/pagination', values, escapeValues: false);
  }

  /// Renders the `views/pagination.mustache` template.
  String renderPagination(PageLinks pageLinks) {
    final values = {
      'page_links': pageLinks.hrefPatterns(),
    };
    return _renderTemplate('pagination', values, escapeValues: false);
  }

  /// Renders the `views/search.mustache` template.
  String renderSearchPage(SearchResultPage resultPage, PageLinks pageLinks) {
    final String queryText = resultPage.query.text;
    final Map<String, Object> values =
        _searchPage(resultPage, renderPagination(pageLinks));
    return _renderPage('search', values,
        title: 'Search results for $queryText.', searchQuery: queryText);
  }

  /// Renders the `views/v2/search.mustache` template.
  String renderSearchPageV2(SearchResultPage resultPage, PageLinks pageLinks) {
    final String queryText = resultPage.query.text;
    final Map<String, Object> values =
        _searchPage(resultPage, renderPaginationV2(pageLinks));
    final content = _renderTemplate('v2/search', values);
    return renderLayoutPageV2(content,
        title: 'Search results for $queryText.',
        platform: resultPage.query.platformPredicate?.toQueryParamValue(),
        searchQuery: queryText);
  }

  Map<String, Object> _searchPage(
      SearchResultPage resultPage, String paginationHtml) {
    final List results = [];
    for (int i = 0; i < resultPage.packages.length; i++) {
      final PackageView view = resultPage.packages[i];
      results.add({
        'url': '/packages/${view.name}',
        'name': view.name,
        'version': HTML_ESCAPE.convert(view.version),
        'show_dev_version': view.devVersion != null,
        'dev_version': HTML_ESCAPE.convert(view.devVersion ?? ''),
        'dev_version_href': Uri.encodeComponent(view.devVersion ?? ''),
        'icons':
            _renderIconsColumnHtml(view.platforms), // used in old design only
        'last_uploaded': view.shortUpdated,
        'desc': view.ellipsizedDescription,
        'tags_html': _renderTags(view.platforms), // used in v2 only
      });
    }
    final values = {
      'platform_tabs_html': renderPlatformTabs(searchQuery: resultPage.query),
      'query': resultPage.query.text,
      'results': results,
      'total_count': resultPage.totalCount, // used in v2 only
      'pagination': paginationHtml,
      'hasResults': results.length > 0,
      'search_service': 'service',
    };
    return values;
  }

  /// Renders a whole HTML page using the `views/layout.mustache` template and
  /// the provided [template] for the content.
  String _renderPage(String template, values,
      {String title: 'pub.dartlang.org',
      PackageVersion packageVersion,
      String faviconUrl,
      String searchQuery,
      bool includeSurvey: true}) {
    final renderedContent = _renderTemplate(template, values);
    return renderLayoutPage(title, renderedContent,
        packageVersion: packageVersion,
        faviconUrl: faviconUrl,
        searchQuery: searchQuery,
        includeSurvey: includeSurvey);
  }

  /// Renders the icons and related text using the pkg/icons_block template.
  String _renderIconsBlockHtml(List<String> platforms) {
    final List icons = _mapIconsDataFromPlatforms(platforms);
    return _renderTemplate('pkg/icons_block', {
      'has_icons': icons.isNotEmpty,
      'icons': icons,
    });
  }

  /// Renders the icons and related text using the pkg/icons_column template.
  String _renderIconsColumnHtml(List<String> platforms) {
    final List icons = _mapIconsDataFromPlatforms(platforms);
    return _renderTemplate('pkg/icons_column', {
      'has_icons': icons.isNotEmpty,
      'icons': icons,
      'min_width_px': icons.length * 25,
    });
  }

  List _mapIconsDataFromPlatforms(List<String> platforms) {
    final List icons = [];
    platforms?.forEach((String platform) {
      final Map iconData = _logoData[platform];
      if (iconData == null) {
        // TODO: log missing
      } else {
        icons.add(iconData);
      }
    });
    return icons;
  }

  /// Renders the tags using the pkg/tags template.
  String _renderTags(List<String> platforms, {bool wrapperDiv: false}) {
    final List tags = platforms?.map((platform) {
      final Map tagData = _logoData[platform];
      return tagData ?? {'text': platform};
    })?.toList();
    return _renderTemplate('v2/pkg/tags', {
      'has_tags': tags != null && tags.isNotEmpty,
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
    return _renderTemplate('v2/platform_tabs', values);
  }
}

String _getAuthorsHtml(List<String> authors) {
  return (authors ?? const []).map((String value) {
    var name = value;
    var email = value;

    final match = _AuthorsRegExp.matchAsPrefix(value);
    if (match != null) {
      name = match.group(1);
      email = match.group(2);
    }

    // TODO: Properly escape this.
    return '<span class="author"><a href="mailto:$email" title="Email $email">'
        '<i class="icon-envelope">Email $email</i></a> $name</span>';
  }).join('<br/>');
}

String _getUploadersHtml(Package package) {
  // TODO: HTML escape email addresses.
  return package.uploaderEmails.join('<br/>');
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

class SearchLinks extends PageLinks {
  final SearchQuery query;

  SearchLinks(this.query, int count) : super(query.offset, count);

  SearchLinks.empty(this.query) : super.empty();

  @override
  String formatHref(int page) => query.toSearchLink(page: page);
}

class PackageLinks extends PageLinks {
  static const int resultsPerPage = 10;
  static const int maxPages = 15;
  final String _basePath;
  final String _platform;

  PackageLinks(int offset, int count, {String basePath, String platform})
      : _basePath = basePath,
        _platform = platform,
        super(offset, count);

  PackageLinks.empty({String basePath, String platform})
      : _basePath = basePath,
        _platform = platform,
        super.empty();

  @override
  String formatHref(int page) {
    final String basePath = _basePath ?? '/packages';
    String url = '$basePath?';
    if (_platform != null) {
      url = '${url}platform=$_platform&';
    }
    return '${url}page=$page';
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
  static const String html5Logo32x32 = '/static/img/html5-logo-32x32.png';
  // Original source: https://pixabay.com/en/bash-command-line-linux-shell-148836/
  static const String shellLogo32x32 = '/static/img/shell-logo-32x32.png';

  static const versionsTableIcons = const {
    'documentation': LogoUrls.documentationIcon,
    'download': LogoUrls.downloadIcon,
  };
}

// 'text': used in v2 only
// 'label', 'src': used in old design only
final Map<String, Map> _logoData = const {
  KnownPlatforms.flutter: const {
    'src': LogoUrls.flutterLogo32x32,
    'label': 'Flutter package',
    'href': '/flutter/packages',
    'text': 'Flutter',
  },
  KnownPlatforms.server: const {
    'src': LogoUrls.shellLogo32x32,
    'label': 'Server',
    'text': 'Server',
  },
  KnownPlatforms.web: const {
    'src': LogoUrls.html5Logo32x32,
    'label': 'Web',
    'text': 'Web',
  },
};

const String flutterPackagesDescriptionHtml =
    '<p><a href="https://flutter.io/using-packages/">Learn more about using packages with Flutter.</a></p>';
