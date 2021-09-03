// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../dom/dom.dart' as d;
import '_cache.dart';
import 'views/shared/detail/header.dart';

final wideHeaderDetailPageClassName = '-wide-header-detail-page';

/// Renders the detail page's header template.
///
/// The like button in the header will not be displayed when [isLiked] is null.
String renderDetailHeader({
  String? title,
  d.Node? titleNode,
  String? imageUrl,
  int? packageLikes,
  bool? isLiked,
  bool isFlutterFavorite = false,
  d.Node? metadataNode,
  d.Node? tagsNode,

  /// Set true for more whitespace in the header.
  bool isLoose = false,
}) {
  if ((title == null && titleNode == null) ||
      (title != null && titleNode != null)) {
    throw ArgumentError(
        'Exactly one of `title` and `titleNode` must be specified.');
  }

  return detailHeaderNode(
    titleNode: titleNode ?? d.text(title!),
    metadataNode: metadataNode,
    tagsNode: tagsNode,
    imageUrl: imageUrl,
    isLoose: isLoose,
    isLiked: isLiked == true,
    likeCount: packageLikes,
    isFlutterFavorite: isFlutterFavorite,
  ).toString();
}

/// Renders the `shared/detail/page.mustache` template
String renderDetailPage({
  required String headerHtml,
  required List<Tab> tabs,
  required String? infoBoxHtml,
  String? infoBoxLead,
  String? footerHtml,
}) {
  return templateCache.renderTemplate('shared/detail/page', {
    'header_html': headerHtml,
    'tabs_html': renderDetailTabs(tabs),
    'info_box_lead': infoBoxLead,
    'has_info_box': infoBoxHtml != null,
    'info_box_html': infoBoxHtml,
    'footer_html': footerHtml,
  });
}

/// Renders the `views/shared/detail/tabs.mustache` template.
String renderDetailTabs(List<Tab> tabs) {
  // active: the first one with content
  for (Tab tab in tabs) {
    if (tab.contentHtml != null) {
      tab.isActive = true;
      break;
    }
  }
  final values = {'tabs': tabs.map((t) => t._toMustacheData()).toList()};
  return templateCache.renderTemplate('shared/detail/tabs', values);
}

/// Defines the header and content part of a tab.
class Tab {
  final String id;
  final String title;
  final String? href;
  final String? contentHtml;
  final bool isMarkdown;
  bool isActive = false;

  Tab.withContent({
    required this.id,
    required this.title,
    required this.contentHtml,
    this.isMarkdown = false,
  }) : href = null;

  Tab.withLink({
    required this.id,
    required this.title,
    required this.href,
  })  : contentHtml = null,
        isMarkdown = false;

  Map _toMustacheData() {
    final isPrivate =
        id == 'admin' || id == 'activity-log' || id.startsWith('my-');
    final titleClasses = <String>[
      'detail-tab',
      contentHtml == null ? 'tab-link' : 'tab-button',
      'detail-tab-$id-title',
      if (isActive) '-active',
      if (isPrivate) '-private',
    ];
    final contentClasses = <String>[
      'tab-content',
      'detail-tab-$id-content',
      if (isActive) '-active',
      if (isMarkdown) 'markdown-body',
    ];
    final titleNode =
        href == null ? d.text(title) : d.a(href: href, text: title);
    return <String, dynamic>{
      'title_classes': titleClasses.join(' '),
      'title_html': titleNode.toString(),
      'content_classes': contentClasses.join(' '),
      'content_html': contentHtml,
      'has_content': contentHtml != null,
    };
  }
}
