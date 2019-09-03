// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/command_runner.dart';

import 'package:pub_dartlang_org/shared/configuration.dart';

import 'package:pub_dartlang_org/service/entrypoint/analyzer.dart';
import 'package:pub_dartlang_org/service/entrypoint/dartdoc.dart';
import 'package:pub_dartlang_org/service/entrypoint/frontend.dart';
import 'package:pub_dartlang_org/service/entrypoint/search.dart';

void main(List<String> originalArgs) async {
  // Insert GAE_SERVICE as the primary command (only applied on appengine)
  final args = <String>[
    if (envConfig.gaeService != null) envConfig.gaeService,
    ...originalArgs
  ];
  final runner = CommandRunner('pub_dev', 'pub.dev services')
    ..addCommand(AnalyzerCommand())
    ..addCommand(DartdocCommand())
    ..addCommand(DefaultCommand())
    ..addCommand(SearchCommand());
  await runner.run(args);
}
