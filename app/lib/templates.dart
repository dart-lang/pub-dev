// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.templates;

import 'dart:io';
import 'dart:math';

import 'package:markdown/markdown.dart' as md;
import 'package:mustache/mustache.dart' as mustache;
import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:gcloud/service_scope.dart' as ss;

import 'models.dart';

final _AuthorsRegExp = new RegExp(r'^\s*(.+)\s+<(.+)>\s*$');

void registerTemplateService(TemplateService service)
    => ss.register(#_templates, service);

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
    var values = {
        'already_set': wasAlreadySet,
        'production' : isProduction,
    };
    return _renderPage('private_keys/new', values);
  }

  /// Renders the `views/pkg/versions/index` template.
  String renderPkgVersionsPage(Package package, List<PackageVersion> versions) {
    var values = {
        'package': {
          'name' : package.name,
        },
        'versions' : versions.map((PackageVersion version) {
          return {
            'version' : version.id,
            'short_created' : version.shortCreated,
            'documentation' : version.documentat,
            'download_url' : version.downloadUrl,
          };
        }).toList(),
    };
    return _renderPage('pkg/versions/index', values);
  }

  /// Renders the `views/pkg/index.mustache` template.
  String renderPkgIndexPage(List<Package> packages,
                            List<PackageVersion> versions,
                            PageLinks links) {
    var packagesJson = [];
    for (int i = 0; i < packages.length; i++) {
      var package = packages[i];
      var version = versions[i];
      packagesJson.add({
          'name' : package.name,
          'description' : {
            'ellipsized_description' : version.ellipsizedDescription,
          },
          'authors_html' : _getAuthorsHtml(version),
          'short_updated' : version.shortCreated,
      });
    }
    var values = {
        'packages': packagesJson,
        'pagination' : renderPagination(links),
    };

    var title = 'All Packages';
    if (links.rightmostPage > 1) {
      title = 'Page ${links.currentPage} | $title';
    }

    return _renderPage('pkg/index', values, title: title);
  }

  /// Renders the `views/private_keys/show.mustache` template.
  String renderPkgShowPage(Package package,
                           List<PackageVersion> versions,
                           PackageVersion latestVersion,
                           int totalNumberOfVersions) {
    var importExamples;
    if (latestVersion.libraries.contains('${package.id}.dart')) {
      importExamples = [{
        'package' : package.id,
        'library' : '${package.id}.dart',
      }];
    } else {
      importExamples = latestVersion.libraries.map((library) {
        return {
          'package' : latestVersion.packageKey.id,
          'library' : library,
        };
      }).toList();
    }

    String exampleVersionConstraint;
    var version = new semver.Version.parse(latestVersion.key.id);
    if (version.major == 0) {
      exampleVersionConstraint =
          '">=${version} <${version.major}.${version.minor+1}.0"';
    } else {
      exampleVersionConstraint = '">=${version} <${version.major + 1}.0.0"';
    }

    var readmeFilename;
    var readme;
    if (latestVersion.readme != null) {
      readmeFilename = latestVersion.readme.filename;
      readme = latestVersion.readme.text;
      if (readmeFilename.endsWith('.md')) {
        readme = md.markdownToHtml(readme);
      }
    }

    var changelogFilename;
    var changelog;
    if (latestVersion.changelog != null) {
      changelogFilename = latestVersion.changelog.filename;
      changelog = latestVersion.changelog.text;
      if (changelogFilename.endsWith('.md')) {
        changelog = md.markdownToHtml(changelog);
      }
    }

    var values = {
        'package': {
          'name' : package.name,
          'latest_version' : {
            'version' : latestVersion.id,
            'example_version_constraint' : exampleVersionConstraint,
            'has_libraries' : importExamples.length > 0,
            'import_examples' : importExamples,
          },
          'description' : latestVersion.pubspec.description,
          // TODO: make this 'Authors' if PackageVersion.authors is a list?!
          'authors_title' : 'Author',
          'authors_html' : _getAuthorsHtml(latestVersion),
          'homepage' : latestVersion.homepage,
          'nice_homepage' : latestVersion.homepageNice,
          'documentation' : latestVersion.documentation,
          'nice_documentation' : latestVersion.documentationNice,
          // TODO: make this 'Uploaders' if Package.uploaders is > 1?!
          'uploaders_title' : 'Uploader',
          'uploaders_html' : _getUploadersHtml(package),
        },
        'versions' : versions.map((PackageVersion version) {
          return {
            'version': version.id,
            'short_created': version.shortCreated,
            'documentation': version.documentation,
            'download_url': version.downloadUrl,
          };
        }).toList(),
        'show_versions_link' : totalNumberOfVersions > versions.length,
        'readme' : readme,
        'readme_filename' : readmeFilename,
        'changelog' : changelog,
        'changelog_filename': changelogFilename,
        'version_count' : '$totalNumberOfVersions',
    };
    return _renderPage(
        'pkg/show', values, title: '$package ${latestVersion.id}');
  }

  /// Renders the `views/admin.mustache` template.
  String renderAdminPage(bool privateKeysSet, bool isProduction,
                         {ReloadStatus reloadStatus}) {
    var reload_status = reloadStatus == null ? {} : {
      'count' : reloadStatus.count,
      'total' : reloadStatus.total,
      'percentage' : reloadStatus.percentage,
    };

    var values = {
        'reload_status': reload_status,
        'private_keys_set':
            privateKeysSet && isProduction ? {'production' : true} : false,
    };
    return _renderPage('admin', values, title: 'Admin Console');
  }

  /// Renders the `views/authorized.mustache` template.
  String renderAuthorizedPage() {
    return _renderPage('authorized', {}, title: 'Pub Authorized Successfully');
  }

  /// Renders the `views/index.mustache` template.
  String renderErrorPage(String status, String message, String traceback) {
    var values = {
        'status' : status,
        'message' : message,
        'traceback' : traceback,
    };
    return _renderPage('error', values, title: 'Error $status');
  }

  /// Renders the `views/index.mustache` template.
  String renderIndexPage(List<PackageVersion> recentPackages) {
    var values = {
        'recent_packages': recentPackages.map((PackageVersion version) {
          var description = version.ellipsizedDescription;
          return {
            'name' : version.packageKey.id,
            'short_updated' : version.shortCreated,
            'latest_version' : {
                'version' : version.id
            },
            'description' : description != null,
            'ellipsized_description': description,
          };
        }).toList(),
    };
    return _renderPage('index', values, title: 'Pub Package Manager');
  }

  /// Renders the `views/layout.mustache` template.
  String renderLayoutPage(String title,
                          String contentString,
                          {PackageVersion packageVersion}) {
    var values = {
      'package': packageVersion == null ? false : {
        'name' : packageVersion.packageKey.id,
        'description' : packageVersion.ellipsizedDescription,
      },
      'title': title,
      'content': contentString,

      // TODO: The python implementation used
      'message': false,

      // TODO: Fill logged_in/login_url/logout_url in.
      // NOTE: It seems very wasteful to make an API call in order to create a
      // login URL 99.999% visitors on pub.dartlang.org will not use.
      'logged_in': false,
      'login_url': 'invalid',
      'logout_url': 'invalid',
    };
    return _renderTemplate('layout', values, escapeValues: false);
  }

  /// Renders the `views/pagination.mustache` template.
  String renderPagination(PageLinks pageLinks) {
    var values = {
      'page_links' : pageLinks.hrefPatterns(),
    };
    return _renderTemplate('pagination', values, escapeValues: false);
  }

  /// Renders the `views/search.mustache` template.
  String renderSearchPage(String query,
                          List<PackageVersion> latestVersions,
                          PageLinks pageLinks) {
    var values = {
        'query' : query,
        'results' : latestVersions.map((PackageVersion version) {
           return {
             'url' : '/packages/${version.packageKey.id}',
             'name' : version.packageKey.id,
             'version' : version.id,
             'last_uploaded': version.shortCreated,
             'desc' : version.ellipsizedDescription,
           };
          }).toList(),
        'pagination' : renderPagination(pageLinks),
        'hasResults' : true
    };
    return _renderPage('search', values, title: 'Search results for $query.');
  }

  /// Renders the `views/site_map.mustache` template.
  String renderSitemapPage() {
    return _renderPage('site_map', {}, title: 'Site Map');
  }

  /// Renders a whole HTML page using the `views/layout.mustache` template and
  /// the provided [template] for the content.
  String _renderPage(String template,
                     values,
                     {String title: 'pub.dartlang.org'}) {
    var renderedContent = _renderTemplate(template, values);
    return renderLayoutPage(title, renderedContent);
  }

  /// Renders [template] with given [values].
  ///
  /// If [escapeValues] is `false`, values in `values` will not be escaped.
  String _renderTemplate(String template, values, {bool escapeValues: true}) {
    mustache.Template parsedTemplate =
        _CachedMustacheTemplates.putIfAbsent(template, () {
      var file = new File('$templateDirectory/$template.mustache');
      return mustache.parse(file.readAsStringSync());
    });
    return parsedTemplate.renderString(values, htmlEscapeValues: escapeValues);
  }
}

String _getAuthorsHtml(PackageVersion version) {
  var author = version.pubspec.author;
  var authors = version.pubspec.authors;

  if (authors == null && author != null) authors = [author];
  if (authors == null) authors = const [];

  return authors.map((String value) {
    var name = value;
    var email = value;

    var match = _AuthorsRegExp.matchAsPrefix(value);
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


class ReloadStatus {
  final int count;
  final int total;
  final double percentage;

  ReloadStatus(this.count, this.total, this.percentage);
}

abstract class PageLinks {
  static const int RESULTS_PER_PAGE = 10;
  static const int MAX_PAGES = 10;

  final int offset;
  final int count;

  PageLinks(this.offset, this.count);

  PageLinks.empty() : offset = 1, count = 1;

  int get leftmostPage
      => max(1 + offset ~/ RESULTS_PER_PAGE - MAX_PAGES ~/ 2, 1);

  int get currentPage => 1 + offset ~/ RESULTS_PER_PAGE;

  int get rightmostPage {
    var extension = max(MAX_PAGES ~/ 2 - leftmostPage, 1);
    return 1 + min(offset ~/ RESULTS_PER_PAGE + MAX_PAGES ~/ 2 + extension,
                   count ~/ RESULTS_PER_PAGE);
  }

  List<Map> hrefPatterns() {
    var results = [];

    results.add({
        'state' : {'state' : currentPage == 1 ? 'disabled' : null},
        'href' : {'href' : formatHref(currentPage - 1) },
        'text' : '&laquo',
    });

    for (int page = leftmostPage; page <= rightmostPage; page++) {
      String state = (page == currentPage) ? 'active' : null;

      results.add({
          'state' : {'state' : state },
          'href' : {'href' : formatHref(page) },
          'text' : '$page',
      });
    }

    results.add({
        'state' : {
          'state' : currentPage == count ~/ RESULTS_PER_PAGE ? 'disabled' : null
        },
        'href' : {'href' : formatHref(currentPage - 1) },
        'text' : '&raquo',
    });
    return results;
  }

  String formatHref(int page);
}

class SearchLinks extends PageLinks {
  final String query;

  SearchLinks(this.query, int offset, int count) : super(offset, count);

  SearchLinks.empty(this.query) : super.empty();

  String formatHref(int page)
      => '/search?q=${Uri.encodeQueryComponent(query)}&page=$page';
}

class PackageLinks extends PageLinks {
  static const int RESULTS_PER_PAGE = 10;
  static const int MAX_PAGES = 15;

  PackageLinks(int offset, int count) : super(offset, count);

  PackageLinks.empty() : super.empty();

  String formatHref(int page) => '/packages?page=$page';
}
