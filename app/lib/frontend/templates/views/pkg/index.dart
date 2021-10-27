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
}) {
  return d.div(
    classes: ['container', 'search-form-container', 'experimental'],
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
            label: 'SDKs',
            isActive: searchForm.sdks.isNotEmpty,
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
            label: 'Advanced',
            isActive: searchForm.hasActiveAdvanced,
            children: [
              _formLinkedCheckbox(
                id: 'search-form-checbox-discontinued',
                label: 'Include discontinued',
                toggledSearchForm: searchForm.toggleDiscontinued(),
                isChecked: searchForm.includeDiscontinued,
              ),
              _formLinkedCheckbox(
                id: 'search-form-checbox-unlisted',
                label: 'Include unlisted',
                toggledSearchForm: searchForm.toggleUnlisted(),
                isChecked: searchForm.includeUnlisted,
              ),
              _formLinkedCheckbox(
                id: 'search-form-checbox-null-safe',
                label: 'Supports null safety',
                toggledSearchForm: searchForm.toggleNullSafe(),
                isChecked: searchForm.nullSafe,
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
  return _formLinkedCheckbox(
    id: 'search-form-checkbox-platform-$platform',
    label: label,
    toggledSearchForm: searchForm.togglePlatform(platform),
    isChecked: searchForm.platforms.contains(platform),
  );
}

d.Node _sdkCheckbox({
  required String sdk,
  required String label,
  required SearchForm searchForm,
}) {
  return _formLinkedCheckbox(
    id: 'search-form-checkbox-sdk-$sdk',
    label: label,
    toggledSearchForm: searchForm.toggleSdk(sdk),
    isChecked: searchForm.sdks.contains(sdk),
  );
}

d.Node _formLinkedCheckbox({
  required String id,
  required String label,
  required SearchForm toggledSearchForm,
  required bool isChecked,
}) {
  return d.div(
    classes: ['search-form-linked-checkbox'],
    child: material.checkbox(
      id: id,
      label: label,
      labelNodeContent: (label) => d.a(
        classes: ['search-link'],
        href: toggledSearchForm.toSearchLink(),
        text: label,
      ),
      checked: isChecked,
    ),
  );
}

d.Node _filterSection({
  required String label,
  required Iterable<d.Node> children,
  bool isActive = false,
}) {
  return d.div(
    classes: ['search-form-section', 'foldable', if (isActive) '-active'],
    children: [
      d.h3(
        classes: ['search-form-section-header foldable-button'],
        children: [
          d.span(classes: ['search-form-section-header-label'], text: label),
          d.img(
            classes: ['foldable-icon'],
            src: staticUrls
                .getAssetUrl('/static/img/search-form-foldable-icon.svg'),
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
                  src: staticUrls.getAssetUrl('/static/img/carot-up.svg'),
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
