// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' as io;

import 'package:meta/meta.dart';

import 'package:path/path.dart' as p;
import '../../package/models.dart';
import '../../shared/markdown.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;
import '../static_files.dart' as static_files;

import '_cache.dart';
import 'layout.dart';

/// The content of `/doc/policy.md`
final _policyMarkdown = _readDocContent('policy.md');

/// The content of `/doc/help.md`
final _helpMarkdown = _readDocContent('help.md');

/// The content of `/doc/help-*.md`
final _helpScoringMarkdown = _readDocContent('help-scoring.md');
final _helpSearchMarkdown = _readDocContent('help-search.md');
final _helpPublishingMarkdown = _readDocContent('help-publishing.md');

/// Renders the `views/account/unauthenticated.mustache` template for the pages
/// where the real content is only provided for logged-in users.
String renderUnauthenticatedPage({String messageMarkdown}) {
  messageMarkdown ??= 'You need to be logged in to view this page.';
  final content = templateCache.renderTemplate('account/unauthenticated', {
    'message_html': markdownToHtml(messageMarkdown),
  });
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Authentication required',
    noIndex: true,
  );
}

/// Renders the `views/account/unauthorized.mustache` template for the pages
/// where the real content is only provided for authorized users.
String renderUnauthorizedPage({String messageMarkdown}) {
  messageMarkdown ??= 'You have insufficient permissions to view this page.';
  final content = templateCache.renderTemplate('account/unauthorized', {
    'message_html': markdownToHtml(messageMarkdown),
  });
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Authorization required',
    noIndex: true,
  );
}

/// Renders the `doc/help.md`.
String renderHelpPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Help | Dart packages',
  );
}

/// Renders the `doc/help-scoring.md`.
String renderHelpScoringPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpScoringMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Scoring | Dart packages',
  );
}

/// Renders the `doc/help-search.md`.
String renderHelpSearchPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpSearchMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Search | Dart packages',
  );
}

/// Renders the `doc/help-publishing.md`.
String renderHelpPublishingPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpPublishingMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Publishing | Dart packages',
  );
}

/// Loads the markdown content from `/doc`.
String _readDocContent(String path) {
  final fullPath = p.join(static_files.resolveDocDirPath(), path);
  return io.File(fullPath).readAsStringSync();
}

/// Renders the `/doc/policy.md` document.
String renderPolicyPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(contentMarkdown: _policyMarkdown),
    title: 'Policy | Pub site',
  );
}

/// Renders the `views/page/security.mustache` template.
String renderSecurityPage() {
  final String content = templateCache.renderTemplate('page/security', {});
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(contentHtml: content),
    title: 'Security | Pub site',
  );
}

/// Renders the `views/page/standalone.mustache` template.
String _renderStandalonePageContent({
  String contentHtml,
  String contentMarkdown,
  String sideImageUrl,
}) {
  ArgumentError.checkNotNull(contentHtml ?? contentMarkdown);
  if (contentHtml != null && contentMarkdown != null) {
    throw ArgumentError(
        'Only one of `contentHtml` and `contentMarkdown` must be specified.');
  }

  contentHtml ??= markdownToHtml(contentMarkdown);
  return templateCache.renderTemplate('page/standalone', {
    'content_html': contentHtml,
    'has_side_image': sideImageUrl != null,
    'side_image_url': sideImageUrl,
  });
}

/// Renders the `views/page/error.mustache` template.
String renderErrorPage(String title, String message) {
  final values = {
    'title': title,
    'message_html': markdownToHtml(message),
  };
  final String content = templateCache.renderTemplate('page/error', values);
  return renderLayoutPage(
    PageType.error,
    content,
    title: title,
  );
}

/// Renders the `views/pkg/mini_list.mustache` template.
String renderMiniList(List<PackageView> packages) {
  final values = {
    'packages': packages.map((package) {
      return {
        'name': package.name,
        'publisher_id': package.publisherId,
        'package_url': urls.pkgPageUrl(package.name),
        'ellipsized_description': package.ellipsizedDescription,
      };
    }).toList(),
  };
  return templateCache.renderTemplate('pkg/mini_list', values);
}

/// Renders the tags using the pkg/tags template.
String renderTags({@required PackageView package}) {
  final tags = package.tags;
  final sdkTags = tags.where((s) => s.startsWith('sdk:')).toSet().toList();
  final tagValues = <Map>[];
  final tagBadges = <Map>[];
  if (package.isDiscontinued) {
    tagValues.add({
      'status': 'discontinued',
      'text': 'discontinued',
      'has_href': false,
      'title': 'Package was discontinued.',
    });
  }
  // Display unlisted tag only for packages that are not discontinued.
  if (!package.isDiscontinued &&
      package.tags.contains(PackageTags.isUnlisted)) {
    tagValues.add({
      'status': 'unlisted',
      'text': 'unlisted',
      'has_href': false,
      'title': 'Package is unlisted, this means that while the package is still '
          'publicly available the author has decided that it should not appear '
          'in search results with default search filters. This is typically '
          'done because this package is meant to support another package, '
          'rather than being consumed directly.',
    });
  }
  if (package.isObsolete) {
    tagValues.add({
      'status': 'missing',
      'text': 'outdated',
      'has_href': false,
      'title': 'Package version too old, check latest stable.',
    });
  }
  if (package.isLegacy) {
    tagValues.add({
      'status': 'legacy',
      'text': 'Dart 2 incompatible',
      'has_href': false,
      'title': 'Package does not support Dart 2.',
    });
  }
  // We only display first-class platform/runtimes
  if (sdkTags.contains(SdkTag.sdkDart)) {
    tagBadges.add({
      'sdk': 'Dart',
      'title': 'Packages compatible with Dart SDK',
      'sub_tags': [
        if (tags.contains(DartSdkTag.runtimeNativeJit))
          {
            'text': 'native',
            'title':
                'Packages compatible with Dart running on a native platform (JIT/AOT)',
          },
        if (tags.contains(DartSdkTag.runtimeWeb))
          {
            'text': 'js',
            'title': 'Packages compatible with Dart compiled for the web',
          },
      ],
    });
  }
  if (sdkTags.contains(SdkTag.sdkFlutter)) {
    tagBadges.add({
      'sdk': 'Flutter',
      'title': 'Packages compatible with Flutter SDK',
      'sub_tags': [
        if (tags.contains(FlutterSdkTag.platformAndroid))
          {
            'text': 'Android',
            'title': 'Packages compatible with Flutter on the Android platform',
          },
        if (tags.contains(FlutterSdkTag.platformIos))
          {
            'text': 'iOS',
            'title': 'Packages compatible with Flutter on the iOS platform'
          },
        if (tags.contains(FlutterSdkTag.platformWeb))
          {
            'text': 'web',
            'title': 'Packages compatible with Flutter on the Web platform',
          },
      ],
    });
  }
  if (tagBadges.isEmpty && package.isAwaiting) {
    tagValues.add({
      'status': 'missing',
      'text': '[awaiting]',
      'has_href': false,
      'title': 'Analysis should be ready soon.',
    });
  }
  if (!package.isExternal && tagValues.isEmpty && tagBadges.isEmpty) {
    tagValues.add({
      'status': 'unidentified',
      'text': '[unidentified]',
      'title': 'Check the analysis tab for further details.',
      'has_href': true,
      'href': urls.pkgScoreUrl(package.name),
    });
  }
  return templateCache.renderTemplate('pkg/tags', {
    'tags': tagValues,
    'tag_badges': tagBadges,
  });
}

/// Renders the `views/pkg/labeled_scores.mustache` template.
String renderLabeledScores(PackageView view) {
  return templateCache.renderTemplate('pkg/labeled_scores', {
    'pkg_score_url': urls.pkgScoreUrl(view.name),
    'like_score_html': _renderLabeledScore('likes', view.likes, ''),
    'pub_points_html':
        _renderLabeledScore('pub points', view.grantedPubPoints, ''),
    'popularity_score_html':
        _renderLabeledScore('popularity', view.popularity, '%'),
  });
}

/// Renders the `views/pkg/labeled_score.mustache` template.
String _renderLabeledScore(String label, int value, String sign) {
  return templateCache.renderTemplate('pkg/labeled_score', {
    'label': label,
    'has_value': value != null,
    'value': value ?? '--',
    'sign': sign,
  });
}

/// Formats the score from [0.0 - 1.0] range to [0 - 100] or '--'.
String formatScore(double value) {
  if (value == null) return '--';
  if (value <= 0.0) return '0';
  if (value >= 1.0) return '100';
  return (value * 100.0).round().toString();
}
