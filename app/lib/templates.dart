// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.templates;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'colored_markdown.dart' as cmd;
import 'package:mustache/mustache.dart' as mustache;
import 'package:gcloud/service_scope.dart' as ss;

import 'models.dart';

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

  /// Renders the `views/private_keys/new.mustache` template.
  String renderPrivateKeysNewPage(bool wasAlreadySet, bool isProduction) {
    final values = {
      'already_set': wasAlreadySet,
      'production': isProduction,
    };
    return _renderPage('private_keys/new', values);
  }

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
      List<Package> packages, List<PackageVersion> versions, PageLinks links) {
    final packagesJson = [];
    for (int i = 0; i < packages.length; i++) {
      final package = packages[i];
      final version = versions[i];
      packagesJson.add({
        'name': package.name,
        'description': {
          'ellipsized_description': version.ellipsizedDescription,
        },
        'authors_html': _getAuthorsHtml(version),
        'short_updated': version.shortCreated,
      });
    }
    final values = {
      'packages': packagesJson,
      'pagination': renderPagination(links),
    };

    var title = 'All Packages';
    if (links.rightmostPage > 1) {
      title = 'Page ${links.currentPage} | $title';
    }

    return _renderPage('pkg/index', values, title: title);
  }

  /// Renders the `views/private_keys/show.mustache` template.
  String renderPkgShowPage(
      Package package,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions) {
    assert(versions.length == versionDownloadUrls.length);

    var importExamples;
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

    String renderPlainText(String text) {
      return '<div class="highlight"><pre>${cmd.escapeAngleBrackets(text)}'
          '</pre></div>';
    }

    String renderFile(FileObject file) {
      final filename = file.filename;
      final content = file.text;
      if (content != null) {
        if (isMarkdownFile(filename)) {
          try {
            return cmd.markdownToHtmlWithSyntax(content);
          } catch (e) {
            return cmd.markdownToHtmlWithoutSyntax(content);
          }
        } else {
          return renderPlainText(content);
        }
      }
      return null;
    }

    var readmeFilename;
    var renderedReadme;
    if (selectedVersion.readme != null) {
      readmeFilename = selectedVersion.readme.filename;
      renderedReadme = renderFile(selectedVersion.readme);
    }

    var changelogFilename;
    var renderedChangelog;
    if (selectedVersion.changelog != null) {
      changelogFilename = selectedVersion.changelog.filename;
      renderedChangelog = renderFile(selectedVersion.changelog);
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

    // TODO: use the value stored in [Package] once that PR is merged.
    List<String> detectedTypes;
    if (latestStableVersion.pubspec.asJson['flutter'] is Map &&
        latestStableVersion.pubspec.asJson['flutter'].containsKey('plugin')) {
      detectedTypes = ['flutter_plugin'];
    }

    final Map<String, String> pageMapAttributes = {};
    detectedTypes?.forEach((String type) {
      pageMapAttributes['dt_$type'] = '1';
    });

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
      },
      'versions': versionsJson,
      'show_versions_link': totalNumberOfVersions > versions.length,
      'readme': renderedReadme,
      'readme_filename': readmeFilename,
      'changelog': renderedChangelog,
      'changelog_filename': changelogFilename,
      'version_count': '$totalNumberOfVersions',
    };
    return _renderPage(
      'pkg/show',
      values,
      title: '${package.name} ${selectedVersion.id} | Dart Package',
      packageVersion: selectedVersion,
      pageMapAttributes: pageMapAttributes,
    );
  }

  /// Renders the `views/authorized.mustache` template.
  String renderAuthorizedPage() {
    return _renderPage('authorized', {}, title: 'Pub Authorized Successfully');
  }

  /// Renders the `views/index.mustache` template.
  String renderErrorPage(String status, String message, String traceback) {
    final values = {
      'status': status,
      'message': message,
      'traceback': traceback,
    };
    return _renderPage('error', values, title: 'Error $status');
  }

  /// Renders the `views/index.mustache` template.
  String renderIndexPage(List<PackageVersion> recentPackages) {
    final values = {
      'recent_packages': recentPackages.map((PackageVersion version) {
        final description = version.ellipsizedDescription;
        return {
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
      {PackageVersion packageVersion, Map<String, String> pageMapAttributes}) {
    final List<Map<String, String>> pageMapAttrList = [];
    pageMapAttributes?.forEach((String attr, String value) {
      pageMapAttrList.add({
        'attr': HTML_ESCAPE.convert(attr),
        'value': HTML_ESCAPE.convert(value),
      });
    });
    final values = {
      'package': packageVersion == null
          ? false
          : {
              'name': HTML_ESCAPE.convert(packageVersion.packageKey.id),
              'description':
                  HTML_ESCAPE.convert(packageVersion.ellipsizedDescription),
            },
      'title': HTML_ESCAPE.convert(title),
      // This is not escaped as it is already escaped by the caller.
      'content': contentString,
      'has_pagemap': pageMapAttrList.isNotEmpty,
      'pagemap_attributes': pageMapAttrList,

      // TODO: The python implementation used
      'message': false,
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
  String renderSearchPage(String query, List<PackageVersion> stableVersions,
      List<PackageVersion> devVersions, PageLinks pageLinks) {
    final List results = [];
    for (int i = 0; i < stableVersions.length; i++) {
      final PackageVersion stable = stableVersions[i];
      final PackageVersion dev =
          devVersions.length > i ? devVersions[i] : stable;
      results.add({
        'url': '/packages/${stable.packageKey.id}',
        'name': stable.packageKey.id,
        'version': HTML_ESCAPE.convert(stable.id),
        'show_dev_version': stable.id != dev.id,
        'dev_version': HTML_ESCAPE.convert(dev.id),
        'dev_version_href': Uri.encodeComponent(dev.id),
        'last_uploaded': stable.shortCreated,
        'desc': stable.ellipsizedDescription,
      });
    }

    final values = {
      'query': query,
      'results': results,
      'pagination': renderPagination(pageLinks),
      'hasResults': results.length > 0,
    };
    return _renderPage('search', values, title: 'Search results for $query.');
  }

  /// Renders the `views/site_map.mustache` template.
  String renderSitemapPage() {
    return _renderPage('site_map', {}, title: 'Site Map');
  }

  /// Renders a whole HTML page using the `views/layout.mustache` template and
  /// the provided [template] for the content.
  String _renderPage(
    String template,
    values, {
    String title: 'pub.dartlang.org',
    PackageVersion packageVersion,
    Map<String, String> pageMapAttributes,
  }) {
    final renderedContent = _renderTemplate(template, values);
    return renderLayoutPage(
      title,
      renderedContent,
      packageVersion: packageVersion,
      pageMapAttributes: pageMapAttributes,
    );
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

  int get leftmostPage =>
      max(1 + offset ~/ RESULTS_PER_PAGE - MAX_PAGES ~/ 2, 1);

  int get currentPage => 1 + offset ~/ RESULTS_PER_PAGE;

  int get rightmostPage {
    final extension = max(MAX_PAGES ~/ 2 - leftmostPage, 1);
    return 1 +
        min(offset ~/ RESULTS_PER_PAGE + MAX_PAGES ~/ 2 + extension,
            count ~/ RESULTS_PER_PAGE);
  }

  List<Map> hrefPatterns() {
    final List<Map> results = [];

    results.add({
      'state': {'state': currentPage <= 1 ? 'disabled' : null},
      'href': {'href': formatHref(currentPage - 1)},
      'text': '&laquo',
    });

    for (int page = leftmostPage; page <= rightmostPage; page++) {
      final String state = (page == currentPage) ? 'active' : null;

      results.add({
        'state': {'state': state},
        'href': {'href': formatHref(page)},
        'text': '$page',
      });
    }

    results.add({
      'state': {'state': currentPage >= rightmostPage ? 'disabled' : null},
      'href': {'href': formatHref(currentPage + 1)},
      'text': '&raquo',
    });
    return results;
  }

  String formatHref(int page);
}

class SearchLinks extends PageLinks {
  final String query;

  SearchLinks(this.query, int offset, int count) : super(offset, count);

  SearchLinks.empty(this.query) : super.empty();

  @override
  String formatHref(int page) =>
      '/search?q=${Uri.encodeQueryComponent(query)}&page=$page';
}

class PackageLinks extends PageLinks {
  static const int RESULTS_PER_PAGE = 10;
  static const int MAX_PAGES = 15;

  PackageLinks(int offset, int count) : super(offset, count);

  PackageLinks.empty() : super.empty();

  @override
  String formatHref(int page) => '/packages?page=$page';
}
