// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const String analysisOptions = '''
analyzer:
  strong-mode: true

# Source of linter options:
# http://dart-lang.github.io/linter/lints/options/options.html

linter:
  rules:
    - camel_case_types
    - hash_and_equals
    - iterable_contains_unrelated_type
    - list_remove_unrelated_type
    - unrelated_type_equality_checks
    - valid_regexps
''';
