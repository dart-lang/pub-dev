// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.templates;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:mustache/mustache.dart' as mustache;

import '../shared/analyzer_client.dart';
import '../shared/markdown.dart';
import '../shared/platform.dart';
import '../shared/search_service.dart' show SearchQuery;

import 'models.dart';
import 'search_service.dart' show SearchResultPage;

final Logger _logger = new Logger('pub.templates');

String _escapeAngleBrackets(String msg) =>
    const HtmlEscape(HtmlEscapeMode.ELEMENT).convert(msg);

const HtmlEscape _HtmlEscaper = const HtmlEscape();

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
    };
    return _renderPage('pkg/versions/index', values);
  }

  /// Renders the `views/pkg/index.mustache` template.
  String renderPkgIndexPage(
      List<Package> packages,
      List<PackageVersion> versions,
      List<AnalysisView> analysisViews,
      PageLinks links,
      {String title,
      String faviconUrl,
      String descriptionHtml}) {
    final packagesJson = [];
    for (int i = 0; i < packages.length; i++) {
      final package = packages[i];
      final version = versions[i];
      final analysis = analysisViews[i];
      packagesJson.add({
        'icons': _renderIconsColumnHtml(analysis.platforms),
        'name': package.name,
        'description': {
          'ellipsized_description': version.ellipsizedDescription,
        },
        'authors_html': _getAuthorsHtml(version),
        'short_updated': package.shortUpdated,
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

  /// Renders the `views/pkg/analysis_tab.mustache` template.
  String renderAnalysisTab(AnalysisView analysis) {
    if (analysis == null || !analysis.hasAnalysisData) return null;

    String statusText;
    switch (analysis.analysisStatus) {
      case AnalysisStatus.aborted:
        statusText = 'Could not analyze package.';
        break;
      case AnalysisStatus.failure:
        statusText = 'Analyzer had some errors.';
        break;
      case AnalysisStatus.success:
        statusText = 'Analyzer completed successfully.';
        break;
    }

    final List<Map> dependencies = analysis
        .getTransitiveDependencies()
        .map((String pkg) => {
              'text': pkg,
              'href': 'https://pub.dartlang.org/packages/$pkg',
              'sep': ',',
            })
        .toList();
    if (dependencies.isNotEmpty) {
      dependencies.last['sep'] = '';
    }

    final Map<String, dynamic> data = {
      'timestamp': analysis.timestamp.toString(),
      'status': statusText,
      'has_dependency': dependencies.isNotEmpty,
      'dependencies': dependencies,
    };

    return _renderTemplate('pkg/analysis_tab', data);
  }

  /// Renders the `views/private_keys/show.mustache` template.
  String renderPkgShowPage(
      Package package,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
      AnalysisView analysis,
      String analysisTabContent) {
    assert(versions.length == versionDownloadUrls.length);

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
            '<b>${_HtmlEscaper.convert(exampleFilename)}</b>'
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

    final bool isFlutterPlugin =
        latestStableVersion.pubspec.dependsOnFlutterSdk ||
            latestStableVersion.pubspec.hasFlutterPlugin;

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
    if (analysisTabContent != null) {
      addFileTab('analysis', 'Analysis', analysisTabContent);
    }
    if (tabs.isNotEmpty) tabs.first['class'] = 'active';

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
        'icons': _renderIconsBlockHtml(analysis?.platforms),
        'description': selectedVersion.pubspec.description,
        // TODO: make this 'Authors' if PackageVersion.authors is a list?!
        'authors_title': 'Author',
        'authors_html': _getAuthorsHtml(selectedVersion),
        'homepage': selectedVersion.homepage,
        'nice_homepage': selectedVersion.homepageNice,
        'documentation': selectedVersion.documentation,
        'nice_documentation': selectedVersion.documentationNice,
        'crossdart': selectedVersion.crossdart,
        'nice_crossdart': selectedVersion.crossdartNice,
        // TODO: make this 'Uploaders' if Package.uploaders is > 1?!
        'uploaders_title': 'Uploader',
        'uploaders_html': _getUploadersHtml(package),
        'short_created': selectedVersion.shortCreated,
        'install_command': isFlutterPlugin ? 'flutter packages get' : 'pub get',
        'install_tool': isFlutterPlugin ? '\'packages get\'' : '\'pub get\'',
        'license': analysis?.licenseText,
      },
      'versions': versionsJson,
      'show_versions_link': totalNumberOfVersions > versions.length,
      'tabs': tabs,
      'has_no_file_tab': tabs.isEmpty,
      'version_count': '$totalNumberOfVersions',
    };
    return _renderPage(
      'pkg/show',
      values,
      title: '${package.name} ${selectedVersion.id} | Dart Package',
      packageVersion: selectedVersion,
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

  /// Renders the `views/pagination.mustache` template.
  String renderPagination(PageLinks pageLinks) {
    final values = {
      'page_links': pageLinks.hrefPatterns(),
    };
    return _renderTemplate('pagination', values, escapeValues: false);
  }

  /// Renders the `views/search.mustache` template.
  String renderSearchPage(SearchResultPage resultPage, PageLinks pageLinks) {
    final List results = [];
    for (int i = 0; i < resultPage.packages.length; i++) {
      final resultPkg = resultPage.packages[i];
      final PackageVersion stable = resultPkg.version;
      final showDevVersion = resultPkg.devVersion != null;

      results.add({
        'url': '/packages/${stable.packageKey.id}',
        'name': stable.packageKey.id,
        'version': HTML_ESCAPE.convert(stable.id),
        'show_dev_version': showDevVersion,
        'dev_version': HTML_ESCAPE.convert(resultPkg.devVersion ?? ''),
        'dev_version_href': Uri.encodeComponent(resultPkg.devVersion ?? ''),
        'icons': _renderIconsColumnHtml(resultPkg.analysis.platforms),
        'last_uploaded': stable.shortCreated,
        'desc': stable.ellipsizedDescription,
      });
    }
    final String queryText = resultPage.query.text;
    final values = {
      'query': queryText,
      'results': results,
      'pagination': renderPagination(pageLinks),
      'hasResults': results.length > 0,
      'search_service': 'service',
    };
    return _renderPage('search', values,
        title: 'Search results for $queryText.', searchQuery: queryText);
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
}

String _getAuthorsHtml(PackageVersion version) {
  final author = version.pubspec.author;
  var authors = version.pubspec.authors;

  if (authors == null && author != null) authors = [author];
  if (authors == null) authors = const [];

  return authors.map((String value) {
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
  static const int RESULTS_PER_PAGE = 10;
  static const int MAX_PAGES = 10;

  final int offset;
  final int count;

  PageLinks(this.offset, this.count);

  PageLinks.empty()
      : offset = 1,
        count = 1;

  int get leftmostPage => max(currentPage - MAX_PAGES ~/ 2, 1);

  int get currentPage => 1 + offset ~/ RESULTS_PER_PAGE;

  int get rightmostPage {
    final int fromSymmetry = currentPage + MAX_PAGES ~/ 2;
    final int fromCount = 1 + ((count - 1) ~/ RESULTS_PER_PAGE);
    return min(fromSymmetry, max(currentPage, fromCount));
  }

  List<Map> hrefPatterns() {
    final List<Map> results = [];

    final bool hasPrevious = currentPage > 1;
    results.add({
      'state': {'state': hasPrevious ? null : 'disabled'},
      'href': hasPrevious ? {'href': formatHref(currentPage - 1)} : null,
      'text': '&laquo;',
    });

    for (int page = leftmostPage; page <= rightmostPage; page++) {
      final bool isCurrent = page == currentPage;
      final String state = isCurrent ? 'active' : null;

      results.add({
        'state': {'state': state},
        'href': isCurrent ? null : {'href': formatHref(page)},
        'text': '$page',
      });
    }

    final bool hasNext = currentPage < rightmostPage;
    results.add({
      'state': {'state': hasNext ? null : 'disabled'},
      'href': hasNext ? {'href': formatHref(currentPage + 1)} : null,
      'text': '&raquo;',
    });
    return results;
  }

  String formatHref(int page);
}

class SearchLinks extends PageLinks {
  final SearchQuery query;

  SearchLinks(this.query, int count) : super(query.offset, count);

  SearchLinks.empty(this.query) : super.empty();

  @override
  String formatHref(int page) {
    final Map<String, String> params = {
      'q': query.text,
      'page': page.toString(),
    };
    if (query.platformPredicate != null && query.platformPredicate.isNotEmpty) {
      params['platforms'] = query.platformPredicate.toQueryParamValue();
    }
    if (query.packagePrefix != null && query.packagePrefix.isNotEmpty) {
      params['pkg-prefix'] = query.packagePrefix;
    }
    return new Uri(path: '/search', queryParameters: params).toString();
  }
}

class PackageLinks extends PageLinks {
  static const int RESULTS_PER_PAGE = 10;
  static const int MAX_PAGES = 15;
  final String _basePath;

  PackageLinks(int offset, int count, {String basePath})
      : _basePath = basePath,
        super(offset, count);

  PackageLinks.empty({String basePath})
      : _basePath = basePath,
        super.empty();

  @override
  String formatHref(int page) => '${_basePath ?? '/packages'}?page=$page';
}

abstract class LogoUrls {
  static const String smallDartFavicon = '/static/favicon.ico';
  static const String flutterLogo32x32 = '/static/img/flutter-logo-32x32.png';
  static const String html5Logo32x32 = '/static/img/html5-logo-32x32.png';
  // Original source: https://pixabay.com/en/bash-command-line-linux-shell-148836/
  static const String shellLogo32x32 = '/static/img/shell-logo-32x32.png';
}

final Map<String, Map> _logoData = const {
  KnownPlatforms.flutter: const {
    'src': LogoUrls.flutterLogo32x32,
    'label': 'Flutter package',
    'href': '/flutter/packages',
  },
  KnownPlatforms.server: const {
    'src': LogoUrls.shellLogo32x32,
    'label': 'Server',
  },
  KnownPlatforms.web: const {
    'src': LogoUrls.html5Logo32x32,
    'label': 'Web',
  },
};

const String flutterPackagesDescriptionHtml =
    '<p><a href="https://flutter.io/using-packages/">Learn more about using packages with Flutter.</a></p>';
