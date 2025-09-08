// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart' as g;
import 'src/api_router_generator.dart' show ApiRouterGenerator;
import 'src/client_library_generator.dart' show ClientLibraryGenerator;

Builder apiRouterPartBuilder(BuilderOptions _) =>
    g.SharedPartBuilder([ApiRouterGenerator()], 'api_router');

Builder clientLibraryBuilder(BuilderOptions options) => g.LibraryBuilder(
  ClientLibraryGenerator(),
  generatedExtension: '.client.dart',
);
