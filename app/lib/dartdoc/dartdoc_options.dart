// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Returns a new, pub-specific dartdoc options based on [original].
///
/// dartdoc_options.yaml allows to change how doc content is generated.
/// To provide uniform experience across the pub site, and to reduce the
/// potential attack surface (HTML-, and code-injections, code executions),
/// we do not support every option.
///
/// https://github.com/dart-lang/dartdoc#dartdoc_optionsyaml
///
/// Discussion on the enabled options:
/// https://github.com/dart-lang/pub-dev/issues/4521#issuecomment-779821098
Map<String, dynamic> customizeDartdocOptions(Map<String, dynamic> original) {
  final passThroughOptions = <String, dynamic>{};
  if (original != null &&
      original.containsKey('dartdoc') &&
      original['dartdoc'] is Map<String, dynamic>) {
    final dartdoc = original['dartdoc'] as Map<String, dynamic>;
    for (final key in _passThroughKeys) {
      if (dartdoc.containsKey(key)) {
        passThroughOptions[key] = dartdoc[key];
      }
    }
  }
  return <String, dynamic>{
    'dartdoc': <String, dynamic>{
      ...passThroughOptions,
      'showUndocumentedCategories': true,
    },
  };
}

final _passThroughKeys = <String>[
  'categories',
  'categoryOrder',
  // TODO: enable after checking that the relative path doesn't escape the package folder
  // 'examplePathPrefix',
  'exclude',
  'include',
  'nodoc',
];
