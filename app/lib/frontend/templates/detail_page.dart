// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../dom/dom.dart' as d;
import 'views/shared/detail/header.dart';
import 'views/shared/detail/page.dart';
import 'views/shared/detail/tabs.dart';

final wideHeaderDetailPageClassName = '-wide-header-detail-page';

/// Renders the detail page's header template.
///
/// The like button in the header will not be displayed when [isLiked] is null.
d.Node renderDetailHeader({
  required d.Node titleNode,
  d.Image? image,
  int? packageLikes,
  bool? isLiked,
  bool isFlutterFavorite = false,
  d.Node? metadataNode,
  d.Node? tagsNode,

  /// Set true for more whitespace in the header.
  bool isLoose = false,
}) {
  return detailHeaderNode(
    titleNode: titleNode,
    metadataNode: metadataNode,
    tagsNode: tagsNode,
    image: image,
    isLoose: isLoose,
    isLiked: isLiked == true,
    likeCount: packageLikes,
    isFlutterFavorite: isFlutterFavorite,
  );
}

/// Renders the detail page template
d.Node renderDetailPage({
  required d.Node headerNode,
  required List<Tab> tabs,
  required d.Node? infoBoxNode,
  String? infoBoxLead,
  d.Node? footerNode,
}) {
  // active: the first one with content
  for (Tab tab in tabs) {
    if (tab.contentNode != null) {
      tab.isActive = true;
      break;
    }
  }
  final tabsNode = detailTabsNode(tabs: tabs);
  return detailPageNode(
    headerNode: headerNode,
    tabsNode: tabsNode,
    infoBoxNode: infoBoxNode,
    infoBoxLead: infoBoxLead,
    footerNode: footerNode,
  );
}

/// Defines the header and content part of a tab.
class Tab {
  final String id;
  final String title;
  final String? href;
  final d.Node? contentNode;
  final bool isMarkdown;
  bool isActive = false;

  Tab.withContent({
    required this.id,
    required this.title,
    required this.contentNode,
    this.isMarkdown = false,
  }) : href = null;

  Tab.withLink({
    required this.id,
    required this.title,
    required this.href,
  })  : contentNode = null,
        isMarkdown = false;

  bool get isPrivate =>
      id == 'admin' || id == 'activity-log' || id.startsWith('my-');

  List<String> get titleClasses => <String>[
        'detail-tab',
        contentNode == null ? 'tab-link' : 'tab-button',
        'detail-tab-$id-title',
        if (isActive) '-active',
        if (isPrivate) '-private',
      ];

  d.Node get titleNode =>
      href == null ? d.text(title) : d.a(href: href, text: title);

  bool get hasContent => contentNode != null;

  List<String> get contentClasses => <String>[
        'tab-content',
        'detail-tab-$id-content',
        if (isActive) '-active',
        if (isMarkdown) 'markdown-body',
      ];
}
