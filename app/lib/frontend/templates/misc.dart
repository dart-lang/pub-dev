// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' show pi;

import 'package:meta/meta.dart';

import 'package:path/path.dart' as p;
import '../../package/models.dart';
import '../../search/search_service.dart' show SearchQuery;
import '../../shared/markdown.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;
import '../request_context.dart';
import '../static_files.dart' as static_files;

import '_cache.dart';
import '_utils.dart';
import 'layout.dart';

/// Renders the `views/account/unauthenticated.mustache` template for the pages
/// where the real content is only provided for logged-in users.
String renderUnauthenticatedPage({String messageMarkdown}) {
  messageMarkdown ??= 'You need to be logged in to view this page.';
  final content = templateCache.renderTemplate('account/unauthenticated', {
    'message_html': markdownToHtml(messageMarkdown, null),
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
    'message_html': markdownToHtml(messageMarkdown, null),
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

/// Loads the markdown content from `/doc`.
String _readDocContent(String path) {
  final fullPath = p.join(static_files.resolveDocDirPath(), path);
  return io.File(fullPath).readAsStringSync();
}

/// The content of `/doc/policy.md`
final _policyMarkdown = _readDocContent('policy.md');

/// The content of `/doc/help.md`
final _helpMarkdown = _readDocContent('help.md');

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

  contentHtml ??= markdownToHtml(contentMarkdown, null);
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
    'message_html': markdownToHtml(message, null),
  };
  final String content = templateCache.renderTemplate('page/error', values);
  return renderLayoutPage(
    PageType.error,
    content,
    title: title,
    includeSurvey: false,
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
        'has_tags': false,
        'tags_html': renderTags(
          package: package,
          searchQuery: null,
        ),
      };
    }).toList(),
  };
  return templateCache.renderTemplate('pkg/mini_list', values);
}

/// Renders the tags using the pkg/tags template.
String renderTags({
  @required PackageView package,
  @required SearchQuery searchQuery,
  bool showTagBadges = false,
}) {
  final tags = package.tags;
  final sdkTags = tags.where((s) => s.startsWith('sdk:')).toSet().toList();
  final List<Map> tagValues = <Map>[];
  final tagBadges = <Map>[];
  if (package.isExternal) {
    // no tags added
  } else if (package.isAwaiting) {
    tagValues.add({
      'status': 'missing',
      'text': '[awaiting]',
      'has_href': false,
      'title': 'Analysis should be ready soon.',
    });
  } else if (package.isDiscontinued) {
    tagValues.add({
      'status': 'discontinued',
      'text': '[discontinued]',
      'has_href': false,
      'title': 'Package was discontinued.',
    });
  } else if (package.isObsolete) {
    tagValues.add({
      'status': 'missing',
      'text': '[outdated]',
      'has_href': false,
      'title': 'Package version too old, check latest stable.',
    });
  } else if (package.isLegacy) {
    tagValues.add({
      'status': 'legacy',
      'text': 'Dart 2 incompatible',
      'has_href': false,
      'title': 'Package does not support Dart 2.',
    });
  } else if (sdkTags.isEmpty) {
    tagValues.add({
      'status': 'unidentified',
      'text': '[unidentified]',
      'title': 'Check the analysis tab for further details.',
      'has_href': true,
      'href': urls.pkgScoreUrl(package.name),
    });
  } else if (showTagBadges) {
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
              'title':
                  'Packages compatible with Flutter on the Android platform',
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
  } else if (searchQuery?.sdk == SdkTagValue.dart) {
    if (tags.contains(DartSdkTag.runtimeNativeJit)) {
      tagValues.add({
        'status': null,
        'text': 'native',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Dart on Native',
        'has_href': false,
      });
    }
    if (tags.contains(DartSdkTag.runtimeWeb)) {
      tagValues.add({
        'status': null,
        'text': 'js',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Dart on Web',
        'has_href': false,
      });
    }
  } else if (searchQuery?.sdk == SdkTagValue.flutter) {
    if (tags.contains(FlutterSdkTag.platformAndroid)) {
      tagValues.add({
        'status': null,
        'text': 'android',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Flutter on Android',
        'has_href': false,
      });
    }
    if (tags.contains(FlutterSdkTag.platformIos)) {
      tagValues.add({
        'status': null,
        'text': 'ios',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Flutter on iOS',
        'has_href': false,
      });
    }
    if (tags.contains(FlutterSdkTag.platformWeb)) {
      tagValues.add({
        'status': null,
        'text': 'web',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Flutter on Web',
        'has_href': false,
      });
    }
  } else {
    sdkTags.sort(); // Show SDK tags (in sorted order)
    tagValues.addAll(
      sdkTags.map(
        (tag) {
          final value = tag.split(':').last;
          return {
            'status': null,
            'text': value,
            'has_href': true,
            'href': urls.searchUrl(sdk: value),
            'title': tag,
          };
        },
      ),
    );
  }
  return templateCache.renderTemplate('pkg/tags', {
    'tags': tagValues,
    'tag_badges': tagBadges,
  });
}

/// Renders the `views/shared/score_circle.mustache` template.
String renderScoreCircle({
  @required String label,
  @required int percent,
  String link,
  String title,
  String secondaryLabel,
}) {
  if (percent < 0) percent = 0;
  if (percent > 100) percent = 100;

  // Circle arc is rendered via SVG circle's dash-array, with the length on
  // the circle's circumference as the arc's active part, and then a longer
  // transparent pattern.
  final radius = 20;
  return templateCache.renderTemplate('shared/score_circle', {
    'radius': radius,
    'diameter': radius * 2,
    'active': (percent * radius * 2 * pi) ~/ 100,
    'inactive': radius * 7, // longer than the circumference (r * 2 * pi)
    'primary_label': label,
    'has_secondary_label': secondaryLabel != null,
    'secondary_label': secondaryLabel,
    'percent': percent,
    'link': link,
    'title': title,
  });
}

/// Renders the simplified version of the circle with 'sdk' text content instead
/// of the score.
String renderSdkScoreBox() {
  if (requestContext.isExperimental) {
    return renderScoreCircle(label: 'sdk', percent: 100);
  }
  // TODO(3246): Remove after migrating to the new UI.
  return '<div class="score-box"><span class="number -solid">sdk</span></div>';
}

/// Renders the circle with the overall score.
String renderScoreBox(
  PackageView view, {
  bool isTabHeader = false,
}) {
  final overallScore = view.overallScore;
  final String formattedScore = formatScore(overallScore);
  String title;
  if (!view.isSkipped && overallScore == null) {
    title = 'Awaiting analysis to complete.';
  } else {
    title = 'Analysis and more details.';
  }
  if (requestContext.isExperimental) {
    if (isTabHeader) {
      return 'Score: <span class="score-value">'
          '${htmlEscape.convert(formattedScore)}</span>';
    }
    return renderScoreCircle(
      label: formattedScore,
      percent: overallScore == null ? 0 : (100 * overallScore).round(),
      title: title,
      link: urls.pkgScoreUrl(view.name),
    );
  }

  // TODO(3246): Remove the rest of the method after migrating to the new UI.
  final String scoreClass = _classifyScore(overallScore);
  final String escapedTitle = htmlAttrEscape.convert(title);
  final newIndicator = view.isNewPackage
      ? '<span class="new" title="Created in the last 30 days">new</span>'
      : '';
  final String boxHtml = '<div class="score-box">'
      '$newIndicator'
      '<span class="number -$scoreClass" title="$escapedTitle">$formattedScore</span>'
      '</div>';
  if (!isTabHeader) {
    return '<a href="${urls.pkgScoreUrl(view.name)}">$boxHtml</a>';
  } else {
    return boxHtml;
  }
}

/// Formats the score from [0.0 - 1.0] range to [0 - 100] or '--'.
String formatScore(double value) {
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
