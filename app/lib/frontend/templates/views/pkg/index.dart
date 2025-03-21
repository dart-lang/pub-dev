// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';

import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;
import '../../../static_files.dart';

/// Renders the package listing.
d.Node packageListingNode({
  required SearchForm searchForm,
  required d.Node listingInfo,
  required d.Node? nameMatches,
  required d.Node? topicMatches,
  required d.Node packageList,
  required d.Node? pagination,
  required Set<String>? openSections,

  /// Whether the search form input fields (on the left side) that would create
  /// a more restrictive search expression (by adding extra filtering conditions),
  /// should have a HTML link displayed. As such links are crawled by both human and
  /// bot traffic, we may not want to expose them when their usefulness is zero.
  /// We still keep the checkbox and the clickability of the label for human users.
  required bool mayDisplayRestrictiveHtmlLink,
}) {
  final matchHighlights = [
    if (nameMatches != null) nameMatches,
    if (topicMatches != null) topicMatches,
  ];
  final innerContent = d.fragment([
    listingInfo,
    if (matchHighlights.isNotEmpty)
      d.div(
        classes: ['listing-highlight-block'],
        children: matchHighlights,
      ),
    packageList,
    if (pagination != null) pagination,
    d.markdown('Check our help page for details on '
        '[search expressions](/help/search#query-expressions) and '
        '[result ranking](/help/search#ranking).'),
  ]);
  return _searchFormContainer(
    searchForm: searchForm,
    innerContent: innerContent,
    openSections: openSections ?? const <String>{},
    mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
  );
}

d.Node _searchFormContainer({
  required SearchForm searchForm,
  required d.Node innerContent,
  required Set<String> openSections,
  required bool mayDisplayRestrictiveHtmlLink,
}) {
  return d.div(
    classes: [
      'container',
      'search-form-container',
      if (openSections.isNotEmpty || searchForm.hasActiveNonQuery)
        '-active-on-mobile',
    ],
    children: [
      d.div(
        classes: ['search-form'],
        children: [
          _filterSection(
            label: 'Platforms',
            isActive: true,
            children: [
              _platformCheckbox(
                platform: PlatformTagValue.android,
                label: 'Android',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _platformCheckbox(
                platform: PlatformTagValue.ios,
                label: 'iOS',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _platformCheckbox(
                platform: PlatformTagValue.linux,
                label: 'Linux',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _platformCheckbox(
                platform: PlatformTagValue.macos,
                label: 'macOS',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _platformCheckbox(
                platform: PlatformTagValue.web,
                label: 'Web',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _platformCheckbox(
                platform: PlatformTagValue.windows,
                label: 'Windows',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
            ],
          ),
          _filterSection(
            sectionTag: 'sdks',
            label: 'SDKs',
            isActive: openSections.contains('sdks') ||
                searchForm.parsedQuery.tagsPredicate.hasTagPrefix('sdk:'),
            children: [
              _sdkCheckbox(
                sdk: SdkTagValue.dart,
                label: 'Dart',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _sdkCheckbox(
                sdk: SdkTagValue.flutter,
                label: 'Flutter',
                searchForm: searchForm,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
            ],
          ),
          _filterSection(
            sectionTag: 'license',
            label: 'License',
            isActive:
                openSections.contains('license') || searchForm.hasActiveLicense,
            children: [
              _tagBasedCheckbox(
                tagPrefix: 'license',
                tagValue: 'osi-approved',
                label: 'OSI approved',
                searchForm: searchForm,
                title: 'Show only packages with OSI approved license.',
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
            ],
          ),
          _filterSection(
            sectionTag: 'advanced',
            label: 'Advanced',
            isActive: openSections.contains('advanced') ||
                searchForm.hasActiveAdvanced,
            children: [
              _tagBasedCheckbox(
                tagPrefix: 'is',
                tagValue: 'flutter-favorite',
                label: 'Flutter Favorite',
                searchForm: searchForm,
                title: 'Show only Flutter Favorite packages.',
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _tagBasedCheckbox(
                tagPrefix: 'show',
                tagValue: 'unlisted',
                label: 'Include unlisted',
                searchForm: searchForm,
                title:
                    'Show unlisted, discontinued and legacy Dart 1.x packages.',
                isPermissiveWhenChecked: true,
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _tagBasedCheckbox(
                tagPrefix: 'has',
                tagValue: 'screenshot',
                label: 'Has screenshot',
                searchForm: searchForm,
                title: 'Show only packages with screenshots.',
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _tagBasedCheckbox(
                tagPrefix: 'is',
                tagValue: 'dart3-compatible',
                label: 'Dart 3 compatible',
                searchForm: searchForm,
                title: 'Show only packages compatible with Dart 3.',
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _tagBasedCheckbox(
                tagPrefix: 'is',
                tagValue: 'plugin',
                label: 'Flutter plugin',
                searchForm: searchForm,
                title: 'Show only Flutter plugins.',
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
              _tagBasedCheckbox(
                tagPrefix: 'is',
                tagValue: 'wasm-ready',
                label: 'WASM ready',
                searchForm: searchForm,
                title: 'Show only WASM ready packages.',
                mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
              ),
            ],
          ),
        ],
      ),
      d.div(
        classes: ['search-results'],
        child: innerContent,
      ),
    ],
  );
}

d.Node _platformCheckbox({
  required String platform,
  required String label,
  required SearchForm searchForm,
  required bool mayDisplayRestrictiveHtmlLink,
}) {
  return _tagBasedCheckbox(
    tagPrefix: 'platform',
    tagValue: platform,
    label: label,
    searchForm: searchForm,
    title: 'Show only packages that support the $label platform.',
    mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
  );
}

d.Node _sdkCheckbox({
  required String sdk,
  required String label,
  required SearchForm searchForm,
  required bool mayDisplayRestrictiveHtmlLink,
}) {
  return _tagBasedCheckbox(
    tagPrefix: 'sdk',
    tagValue: sdk,
    label: label,
    searchForm: searchForm,
    title: 'Show only packages that support the $label SDK.',
    mayDisplayRestrictiveHtmlLink: mayDisplayRestrictiveHtmlLink,
  );
}

d.Node _tagBasedCheckbox({
  required String tagPrefix,
  required String tagValue,
  required String label,
  required SearchForm searchForm,
  required String title,
  bool isPermissiveWhenChecked = false,
  required bool mayDisplayRestrictiveHtmlLink,
}) {
  final tag = '$tagPrefix:$tagValue';
  final toggledSearchForm = searchForm.toggleRequiredTag(tag);
  final isChecked = searchForm.parsedQuery.tagsPredicate.isRequiredTag(tag);
  final isRestrictiveOnAction = (!isPermissiveWhenChecked) ^ isChecked;
  return _formLinkedCheckbox(
    id: 'search-form-checkbox-$tagPrefix-$tagValue',
    label: label,
    toggledSearchForm: toggledSearchForm,
    isChecked: searchForm.parsedQuery.tagsPredicate.isRequiredTag(tag),
    isIndeterminate: searchForm.parsedQuery.tagsPredicate.isProhibitedTag(tag),
    tag: tag,
    action: 'filter-$tagPrefix-$tagValue',
    title: title,
    displayLabelAsLink: !isRestrictiveOnAction || mayDisplayRestrictiveHtmlLink,
  );
}

d.Node _formLinkedCheckbox({
  required String id,
  required String label,
  required SearchForm toggledSearchForm,
  required bool isChecked,
  bool isIndeterminate = false,
  String? tag,
  required String? action,
  String? title,
  required bool displayLabelAsLink,
}) {
  final dataAttributes = {
    if (action != null) 'data-action': action,
    if (tag != null) 'data-tag': tag,
  };
  return d.div(
    classes: ['search-form-linked-checkbox'],
    attributes: {
      if (title != null) 'title': title,
    },
    child: material.checkbox(
      id: id,
      label: label,
      labelNodeContent: (label) => displayLabelAsLink
          ? d.a(
              href: toggledSearchForm.toSearchLink(),
              text: label,
              attributes: dataAttributes,
              rel: 'nofollow',
            )
          : d.span(
              text: label,
              attributes: dataAttributes,
            ),
      checked: isChecked,
      indeterminate: isIndeterminate,
    ),
  );
}

d.Node _filterSection({
  String? sectionTag,
  required String label,
  required Iterable<d.Node> children,
  bool isActive = false,
}) {
  return d.div(
    classes: ['search-form-section', 'foldable', if (isActive) '-active'],
    attributes: {if (sectionTag != null) 'data-section-tag': sectionTag},
    children: [
      d.h3(
        classes: ['search-form-section-header foldable-button'],
        children: [
          d.span(classes: ['search-form-section-header-label'], text: label),
          d.img(
            classes: ['foldable-icon'],
            image: d.Image(
              src: staticUrls
                  .getAssetUrl('/static/img/search-form-foldable-icon.svg'),
              alt: 'fold toggle (up/down arrow)',
              width: 13,
              height: 6,
            ),
          ),
        ],
      ),
      d.div(
        classes: ['foldable-content'],
        children: children,
      ),
    ],
  );
}
