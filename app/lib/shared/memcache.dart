// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const Duration indexUiPageExpiration = const Duration(minutes: 10);
const Duration packageJsonExpiration = const Duration(minutes: 10);
const Duration packageUiPageExpiration = const Duration(minutes: 10);
const Duration analyzerDataExpiration = const Duration(minutes: 60);
const Duration searchUiPageExpiration = const Duration(minutes: 10);

const String indexUiPageKey = 'pub_index';
const String packageJsonPrefix = 'package_json_';
const String packageUiPagePrefix = 'package_ui_';
const String analyzerDataPrefix = 'dart_analyzer_api_';
const String searchUiPagePrefix = 'dart_search_ui_';
