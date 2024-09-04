// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/frontend/request_context.dart';

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart' show staticUrls;

d.Node searchBannerNode({
  required String formUrl,
  required String placeholder,
  required String? queryText,
  required bool autofocus,
  required bool showSearchFiltersButton,
  required String? sortParam,
  required bool hasActive,
}) {
  return d.form(
    classes: ['search-bar', 'banner-item'],
    attributes: {
      'autocomplete': 'off',
    },
    action: formUrl,
    children: [
      d.input(
        classes: ['input'],
        type: 'search',
        name: 'q',
        placeholder: placeholder,
        autocomplete: 'off',
        autofocus: autofocus,
        value: queryText,
        attributes: {
          'title': 'Search',
          if (requestContext.experimentalFlags.isSearchCompletionEnabled)
            'data-widget': 'completion',
          'data-completion-src': '/api/search-input-completion-data',
          'data-completion-class': 'search-completion',
        },
      ),
      d.span(classes: ['icon']),
      if (showSearchFiltersButton)
        d.div(
          classes: [
            'search-filters-btn-wrapper',
            if (hasActive) '-active',
          ],
          children: [
            d.img(
              classes: ['search-filters-btn', 'search-filters-btn-inactive'],
              image: d.Image(
                src: staticUrls
                    .getAssetUrl('/static/img/search-filters-inactive.svg'),
                alt: 'toggle the display of search filters (inactive)',
                width: 42,
                height: 42,
              ),
            ),
            d.img(
              classes: ['search-filters-btn', 'search-filters-btn-active'],
              image: d.Image(
                src: staticUrls
                    .getAssetUrl('/static/img/search-filters-active.svg'),
                alt: 'toggle the display of search filters (active)',
                width: 42,
                height: 42,
              ),
            ),
          ],
        ),
      if (sortParam != null && sortParam.isNotEmpty)
        d.input(type: 'hidden', name: 'sort', value: sortParam),
    ],
  );
}

/// Create completion data for search input.
///
/// Format is dictacted by `pkg/web_app/lib/src/completion.dart`.
///
/// If values in `match` is a prefix of what is being typed completion
/// will automatically start. It'll always try to use the longest match.
/// If not specified options available are assumed to be `terminal`, that is
/// they will be followed by whitespace.
/// If `forcedOnly` is specified, completion can only be initiated with
/// Ctrl+Space.
///
/// This can generate completion data of different sizes given [topics] and
/// [licenses].
String completionDataJson({
  List<String> topics = const [],
  List<String> licenses = const [],
}) =>
    json.encode({
      // TODO: Write a shared type for this in `pkg/_pub_shared/lib/data/`
      'completions': [
        {
          'match': ['', '-'],
          'terminal': false,
          'forcedOnly': true,
          'options': [
            'has:',
            'is:',
            'license:',
            'platform:',
            'sdk:',
            'show:',
            'topic:',
            'runtime:',
            'dependency:',
            'dependency*:',
            'publisher:',
          ],
        },
        // TODO: Consider completion support for dependency:, dependency*: and publisher:
        {
          'match': ['is:', '-is:'],
          'options': [
            'dart3-compatible',
            'flutter-favorite',
            'legacy',
            'null-safe',
            'plugin',
            'unlisted',
            'wasm-ready',
          ],
        },
        {
          'match': ['has:', '-has:'],
          'options': [
            'executable',
            'screenshot',
          ],
        },
        {
          'match': ['license:', '-license:'],
          'options': [
            'osi-approved',
            ...licenses,
          ],
        },
        {
          'match': ['show:', '-show:'],
          'options': [
            'unlisted',
          ],
        },
        {
          'match': ['sdk:', '-sdk:'],
          'options': [
            'dart',
            'flutter',
          ],
        },
        {
          'match': ['platform:', '-platform:'],
          'options': [
            'android',
            'ios',
            'linux',
            'macos',
            'web',
            'windows',
          ],
        },
        {
          'match': ['runtime:', '-runtime:'],
          'options': [
            'native-aot',
            'native-jit',
            'web',
          ],
        },
        {
          'match': ['topic:', '-topic:'],
          'options': [
            ...topics,
          ],
        },
      ],
    });
