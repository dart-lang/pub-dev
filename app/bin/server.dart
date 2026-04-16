// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/command_runner.dart';

import 'package:pub_dev/service/entrypoint/analyzer.dart';
import 'package:pub_dev/service/entrypoint/frontend.dart';
import 'package:pub_dev/service/entrypoint/search.dart';
import 'package:pub_dev/shared/env_config.dart';

void main(List<String> args) async {
  final runner = CommandRunner('pub_dev', 'pub.dev services')
    ..addCommand(AnalyzerCommand())
    ..addCommand(DefaultCommand())
    ..addCommand(SearchCommand());

  if (args.isEmpty && envConfig.isRunningInAppengine) {
    final service = envConfig.gaeService;
    if (service != null && service.isNotEmpty) {
      args = [service];
    }
  }

  await runner.run(args);
}
