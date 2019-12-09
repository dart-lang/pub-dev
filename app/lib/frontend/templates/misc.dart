// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../../package/models.dart';
import '../../search/search_service.dart' show SearchQuery;
import '../../shared/markdown.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

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

/// Renders the `views/help.mustache` template.
String renderHelpPage() {
  final String content = templateCache.renderTemplate('help', {
    'dart_site_root': urls.dartSiteRoot,
    'pana_url': urls.panaUrl(),
    'pana_maintenance_url': urls.panaMaintenanceUrl(),
  });
  return renderLayoutPage(PageType.standalone, content,
      title: 'Help | Dart packages');
}

/// Renders the `views/security.mustache` template.
String renderSecurityPage() {
  final String content = templateCache.renderTemplate('security', {});
  return renderLayoutPage(PageType.standalone, content,
      title: 'Security | Pub site');
}

/// Renders the `views/show.mustache` template.
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
  return renderLayoutPage(
    PageType.error,
    content,
    title: title,
    includeSurvey: false,
  );
}

/// Renders the `views/mini_list.mustache` template.
String renderMiniList(List<PackageView> packages) {
  final values = {
    'packages': packages.map((package) {
      return {
        'name': package.name,
        'publisher_id': package.publisherId,
        'package_url': urls.pkgPageUrl(package.name),
        'ellipsized_description': package.ellipsizedDescription,
        'tags_html': renderTags(
          searchQuery: null,
          tags: package.tags,
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

/// Renders the tags using the pkg/tags template.
String renderTags({
  @required SearchQuery searchQuery,
  @required List<String> tags,
  @required bool isAwaiting,
  @required bool isDiscontinued,
  @required bool isLegacy,
  @required bool isObsolete,
  bool showTagBadges = false,
  String packageName,
}) {
  final sdkTags = tags.where((s) => s.startsWith('sdk:')).toSet().toList();
  final List<Map> tagValues = <Map>[];
  final tagBadges = <Map>[];
  if (isAwaiting) {
    tagValues.add({
      'status': 'missing',
      'text': '[awaiting]',
      'title': 'Analysis should be ready soon.',
    });
  } else if (isDiscontinued) {
    tagValues.add({
      'status': 'discontinued',
      'text': '[discontinued]',
      'title': 'Package was discontinued.',
    });
  } else if (isObsolete) {
    tagValues.add({
      'status': 'missing',
      'text': '[outdated]',
      'title': 'Package version too old, check latest stable.',
    });
  } else if (isLegacy) {
    tagValues.add({
      'status': 'legacy',
      'text': 'Dart 2 incompatible',
      'title': 'Package does not support Dart 2.',
    });
  } else if (sdkTags.isEmpty) {
    tagValues.add({
      'status': 'unidentified',
      'text': '[unidentified]',
      'title': 'Check the analysis tab for further details.',
      'href': urls.analysisTabUrl(packageName),
    });
  } else if (showTagBadges) {
    // We only display first-class platform/runtimes
    if (sdkTags.contains(SdkTag.sdkDart)) {
      tagBadges.add({
        'sdk': 'dart',
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
        'sdk': 'flutter',
        'title': 'Packages compatible with Flutter SDK',
        'sub_tags': [
          if (tags.contains(FlutterSdkTag.platformAndroid))
            {
              'text': 'android',
              'title':
                  'Packages compatible with Flutter on the Android platform',
            },
          if (tags.contains(FlutterSdkTag.platformIos))
            {
              'text': 'ios',
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
        'text': 'native',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Dart on Native',
      });
    }
    if (tags.contains(DartSdkTag.runtimeWeb)) {
      tagValues.add({
        'text': 'js',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Dart on Web',
      });
    }
  } else if (searchQuery?.sdk == SdkTagValue.flutter) {
    if (tags.contains(FlutterSdkTag.platformAndroid)) {
      tagValues.add({
        'text': 'android',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Flutter on Android',
      });
    }
    if (tags.contains(FlutterSdkTag.platformIos)) {
      tagValues.add({
        'text': 'ios',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Flutter on iOS',
      });
    }
    if (tags.contains(FlutterSdkTag.platformWeb)) {
      tagValues.add({
        'text': 'web',
        // TODO: link to platform/runtime-based search
        'title': 'Works with Flutter on Web',
      });
    }
  } else {
    sdkTags.sort(); // Show SDK tags (in sorted order)
    tagValues.addAll(
      sdkTags.map(
        (tag) {
          final value = tag.split(':').last;
          return {
            'text': value,
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

/// Renders the simplified version of the circle with 'sdk' text content instead
/// of the score.
String renderSdkScoreBox() {
  return '<div class="score-box"><span class="number -solid">sdk</span></div>';
}

/// Renders the circle with the overall score.
String renderScoreBox(
  double overallScore, {
  @required bool isSkipped,
  bool isNewPackage,
  String package,
}) {
  final String formattedScore = formatScore(overallScore);
  final String scoreClass = _classifyScore(overallScore);
  String title;
  if (!isSkipped && overallScore == null) {
    title = 'Awaiting analysis to complete.';
  } else {
    title = 'Analysis and more details.';
  }
  final String escapedTitle = htmlAttrEscape.convert(title);
  final newIndicator = (isNewPackage ?? false)
      ? '<span class="new" title="Created in the last 30 days">new</span>'
      : '';
  final String boxHtml = '<div class="score-box">'
      '$newIndicator'
      '<span class="number -$scoreClass" title="$escapedTitle">$formattedScore</span>'
      '</div>';
  if (package != null) {
    return '<a href="${urls.analysisTabUrl(package)}">$boxHtml</a>';
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
