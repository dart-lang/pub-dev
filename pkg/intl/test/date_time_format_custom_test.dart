// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Test date formatting and parsing using custom locale data, which we get
/// from the local copy.

import 'dart:async';
import 'date_time_format_test_stub.dart';
import 'package:intl/date_symbol_data_local.dart' as localSymbols;
import 'package:intl/date_time_patterns.dart' as localPatterns;
import 'package:intl/date_symbol_data_custom.dart';

main() {
  var symbols = localSymbols.dateTimeSymbolMap();
  var patterns = localPatterns.dateTimePatternMap();
  List<String> locales = symbols.keys.toList().take(10).toList();
  // Force inclusion of locales that are hard-coded in tests.
  var requiredLocales = ["en_US", "de", "fr", "ja", "el", "de_AT"];
  locales.addAll(requiredLocales);
  for (var locale in locales) {
    print("initializing $locale");
    initializeDateFormattingCustom(
        locale: locale, symbols: symbols[locale], patterns: patterns[locale]);
  }
  runWith(() => locales, null, nullInitialization);
}

Future nullInitialization(String a, String b) => new Future.value(null);
