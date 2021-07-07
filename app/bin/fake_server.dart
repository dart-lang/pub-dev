// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/command_runner.dart';

import 'package:pub_dev/fake/server/fake_server_entrypoint.dart';
import 'package:pub_dev/fake/tool/init_data_file.dart';

void main(List<String> args) async {
  final runner = CommandRunner('fake_server', 'Fake pub server')
    ..addCommand(FakeServerCommand())
    ..addCommand(FakeInitDataFileCommand());
  await runner.run(args);
}
