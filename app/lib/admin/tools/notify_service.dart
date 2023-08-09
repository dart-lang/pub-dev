// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/job/backend.dart';
import 'package:pub_dev/task/backend.dart';

String _printHelp() {
  return 'Notifies the auxilliary services about a new package or version.\n'
      'Syntax:\n'
      '  <tool-command> analyzer [package] [version]\n'
      '  <tool-command> dartdoc [package] [version]\n'
      '  <tool-command> task [package]\n';
}

/// Notifies the analyzer or the search service.
Future<String> executeNotifyService(List<String> args) async {
  if (args.isEmpty) {
    return _printHelp();
  }

  final String service = args[0];
  if (service == 'analyzer' && args.length == 3) {
    await jobBackend.triggerAnalysis(args[1], args[2], isHighPriority: true);
  } else if (service == 'dartdoc' && args.length == 3) {
    await jobBackend.triggerDartdoc(args[1], args[2], isHighPriority: true);
  } else if (service == 'task' && args.length == 2) {
    await taskBackend.adminBumpPriority(args[1]);
  } else {
    return _printHelp();
  }
  return 'Done.';
}
