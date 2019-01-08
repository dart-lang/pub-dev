// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../../shared/markdown.dart';
import '../../shared/urls.dart' as urls;

import '../models.dart';
import '../template_consts.dart';

import '_cache.dart';
import 'layout.dart';

/// Renders the `views/help.mustache` template.
String renderHelpPage() {
  final String content = templateCache.renderTemplate('help', {});
  return renderLayoutPage(PageType.package, content,
      title: 'Help | Dart Packages');
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

/// Renders the `views/mini_list.mustache` template.
String renderMiniList(List<PackageView> packages) {
  final values = {
    'packages': packages.map((package) {
      return {
        'name': package.name,
        'package_url': urls.pkgPageUrl(package.name),
        'ellipsized_description': package.ellipsizedDescription,
        'tags_html': renderTags(
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

/// Renders the tags using the pkg/tags template.
String renderTags(
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
