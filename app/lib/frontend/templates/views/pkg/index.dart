// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../search/search_form.dart';
import '../../../../shared/tags.dart';
import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;
import '../../../request_context.dart';
import '../../../static_files.dart';
import '../../layout.dart';

/// Renders the package listing.
d.Node packageListingNode({
  required SearchForm searchForm,
  required d.Node? subSdkButtons,
  required d.Node listingInfo,
  required d.Node packageList,
  required d.Node? pagination,
  required Set<String>? openSections,
}) {
  final innerContent = d.fragment([
    listingInfo,
    packageList,
    if (pagination != null) pagination,
    d.markdown('Check our help page for details on '
        '[search expressions](/help/search#query-expressions) and '
        '[result ranking](/help/search#ranking).'),
  ]);
  if (requestContext.showNewSearchUI) {
    return _searchFormContainer(
      searchForm: searchForm,
      innerContent: innerContent,
      openSections: openSections ?? const <String>{},
    );
  } else {
    return d.fragment([
      _searchControls(searchForm, subSdkButtons),
      d.div(classes: ['container'], child: innerContent),
    ]);
  }
}

d.Node _searchFormContainer({
  required SearchForm searchForm,
  required d.Node innerContent,
  required Set<String> openSections,
}) {
  return d.div(
    classes: [
      'container',
      'search-form-container',
      'experimental',
      if (searchForm.hasActiveNonQuery) '-active-on-mobile',
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
                platform: FlutterSdkPlatform.android,
                label: 'Android',
                searchForm: searchForm,
              ),
              _platformCheckbox(
                platform: FlutterSdkPlatform.ios,
                label: 'iOS',
                searchForm: searchForm,
              ),
              _platformCheckbox(
                platform: FlutterSdkPlatform.linux,
                label: 'Linux',
                searchForm: searchForm,
              ),
              _platformCheckbox(
                platform: FlutterSdkPlatform.macos,
                label: 'macOS',
                searchForm: searchForm,
              ),
              _platformCheckbox(
                platform: FlutterSdkPlatform.web,
                label: 'Web',
                searchForm: searchForm,
              ),
              _platformCheckbox(
                platform: FlutterSdkPlatform.windows,
                label: 'Windows',
                searchForm: searchForm,
              ),
            ],
          ),
          _filterSection(
            sectionTag: 'sdks',
            label: 'SDKs',
            isActive: openSections.contains('sdks') ||
                searchForm.parsedQuery.tagsPredicate
                    .anyTag((t) => t.startsWith('sdk:')),
            children: [
              _sdkCheckbox(
                sdk: SdkTagValue.dart,
                label: 'Dart',
                searchForm: searchForm,
              ),
              _sdkCheckbox(
                sdk: SdkTagValue.flutter,
                label: 'Flutter',
                searchForm: searchForm,
              ),
            ],
          ),
          _filterSection(
            sectionTag: 'advanced',
            label: 'Advanced',
            isActive: openSections.contains('advanced') ||
                searchForm.hasActiveAdvanced ||
                searchForm.parsedQuery.tagsPredicate
                    .hasTag(PackageTags.isFlutterFavorite) ||
                searchForm.parsedQuery.tagsPredicate
                    .hasTag(PackageTags.showHidden) ||
                searchForm.parsedQuery.tagsPredicate
                    .hasTag(PackageVersionTags.isNullSafe),
            children: [
              _tagBasedCheckbox(
                tagPrefix: 'is',
                tagValue: 'flutter-favorite',
                label: 'Flutter Favorite',
                searchForm: searchForm,
                title: 'Show only Flutter Favorite packages.',
              ),
              _tagBasedCheckbox(
                tagPrefix: 'show',
                tagValue: 'hidden',
                label: 'Include hidden',
                searchForm: searchForm,
                title:
                    'Show discontinued, unlisted and legacy Dart 1.x packages.',
              ),
              _tagBasedCheckbox(
                tagPrefix: 'is',
                tagValue: 'null-safe',
                label: 'Supports null safety',
                searchForm: searchForm,
                title: 'Show only null-safe packages.',
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
}) {
  return _tagBasedCheckbox(
    tagPrefix: 'platform',
    tagValue: platform,
    label: label,
    searchForm: searchForm,
    title: 'Show only packages that support the $label platform.',
  );
}

d.Node _sdkCheckbox({
  required String sdk,
  required String label,
  required SearchForm searchForm,
}) {
  return _tagBasedCheckbox(
    tagPrefix: 'sdk',
    tagValue: sdk,
    label: label,
    searchForm: searchForm,
    title: 'Show only packages that support the $label SDK.',
  );
}

d.Node _tagBasedCheckbox({
  required String tagPrefix,
  required String tagValue,
  required String label,
  required SearchForm searchForm,
  required String title,
}) {
  final tag = '$tagPrefix:$tagValue';
  final toggledSearchForm = searchForm.toggleRequiredTag(tag);
  return _formLinkedCheckbox(
    id: 'search-form-checkbox-$tagPrefix-$tagValue',
    label: label,
    toggledSearchForm: toggledSearchForm,
    isChecked: searchForm.parsedQuery.tagsPredicate.isRequiredTag(tag),
    isIndeterminate: searchForm.parsedQuery.tagsPredicate.isProhibitedTag(tag),
    tag: tag,
    action: 'filter-$tagPrefix-$tagValue',
    title: title,
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
}) {
  return d.div(
    classes: ['search-form-linked-checkbox'],
    attributes: {
      if (title != null) 'title': title,
    },
    child: material.checkbox(
      id: id,
      label: label,
      labelNodeContent: (label) => d.a(
        href: toggledSearchForm.toSearchLink(),
        text: label,
        attributes: {
          if (action != null) 'data-action': action,
          if (tag != null) 'data-tag': isIndeterminate ? '-$tag' : tag,
        },
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
              alt: 'fold toggle icon (up/down arrow)',
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

d.Node _searchControls(SearchForm searchForm, d.Node? subSdkButtons) {
  final includeDiscontinued = searchForm.includeDiscontinued;
  final includeUnlisted = searchForm.includeUnlisted;
  final nullSafe = searchForm.nullSafe;
  return d.div(
    classes: [
      'search-controls',
      if (searchForm.hasActiveAdvanced) '-active',
    ],
    children: [
      d.div(
        classes: ['container'],
        child: d.div(
          classes: ['search-controls-primary'],
          children: [
            d.div(
              classes: ['search-controls-sdk', 'search-controls-tabs'],
              child: sdkTabsNode(searchForm: searchForm),
            ),
            d.div(
              classes: ['search-controls-sdk', 'search-controls-buttons'],
              children: [
                d.span(classes: ['search-controls-label'], text: 'SDK'),
                sdkTabsNode(searchForm: searchForm),
              ],
            ),
            d.div(
              classes: [
                'search-filters-btn',
                'search-filters-btn-wrapper',
                'search-controls-more',
              ],
              attributes: {'data-ga-click-event': 'toggle-advanced-search'},
              children: [
                d.text('Advanced '),
                d.img(
                  classes: ['search-controls-more-carot'],
                  image: d.Image(
                    src: staticUrls.getAssetUrl('/static/img/carot-up.svg'),
                    alt: 'toggle button for advanced search (carot up)',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      if (subSdkButtons != null)
        d.div(
          classes: ['search-controls-subsdk'],
          child: d.div(
            classes: ['container'],
            children: [
              d.span(
                classes: ['search-controls-label'],
                text: _subSdkLabel(searchForm),
              ),
              d.div(
                classes: ['search-controls-buttons'],
                child: subSdkButtons,
              ),
            ],
          ),
        ),
      d.div(
        classes: ['search-controls-advanced'],
        child: d.div(
          classes: ['container'],
          child: d.div(
            classes: ['search-controls-advanced-block'],
            children: [
              _checkbox(
                id: '-search-unlisted-checkbox',
                label: 'Include unlisted packages',
                name: 'unlisted',
                checked: includeUnlisted,
              ),
              _checkbox(
                id: '-search-discontinued-checkbox',
                label: 'Include discontinued packages',
                name: 'discontinued',
                checked: includeDiscontinued,
              ),
              _checkbox(
                id: '-search-null-safe-checkbox',
                label: 'Supports null safety',
                name: 'null-safe',
                checked: nullSafe,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

d.Node _checkbox({
  required String id,
  required String label,
  required String name,
  required bool checked,
}) {
  return d.div(
    classes: ['search-controls-checkbox'],
    children: [
      d.input(
        type: 'checkbox',
        id: id,
        name: name,
        attributes: checked ? {'checked': 'checked'} : null,
      ),
      d.label(attributes: {'for': id}, text: label),
    ],
  );
}

String? _subSdkLabel(SearchForm sq) {
  if (sq.context.sdk == SdkTagValue.dart) {
    return 'Runtime';
  } else if (sq.context.sdk == SdkTagValue.flutter) {
    return 'Platform';
  } else {
    return null;
  }
}
