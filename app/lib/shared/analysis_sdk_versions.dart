// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final String toolStableDartSdkVersion = '3.0.0';
final String toolStableFlutterSdkVersion = '3.10.0';
final String toolPreviewDartSdkVersion = '3.1.0-63.1.beta';
final String toolPreviewFlutterSdkVersion = '3.11.0-0.0.pre';

/// Prints the commands needed to setup analysis SDKs in the containerized environment.
void main(List<String> args) {
  late final List<String> commands;
  if (args.length == 1 && args.single == 'app') {
    commands = [
      '/project/tool/setup-dart.sh /tool/stable $toolStableDartSdkVersion',
      '/project/tool/setup-dart.sh /tool/preview $toolPreviewDartSdkVersion',
      '/project/tool/setup-flutter.sh /tool/stable $toolStableFlutterSdkVersion',
      '/project/tool/setup-flutter.sh /tool/preview $toolPreviewFlutterSdkVersion',
    ];
  } else if (args.length == 1 && args.single == 'worker') {
    commands = [
      'tool/setup-dart.sh /home/worker/dart $toolStableDartSdkVersion',
      'mv /home/worker/dart/dart-sdk /home/worker/dart/stable',
      'tool/setup-dart.sh /home/worker/dart $toolPreviewDartSdkVersion',
      'mv /home/worker/dart/dart-sdk /home/worker/dart/preview',
      'tool/setup-flutter.sh /home/worker/flutter $toolStableFlutterSdkVersion',
      'mv /home/worker/flutter/flutter /home/worker/flutter/stable',
      'tool/setup-flutter.sh /home/worker/flutter $toolPreviewFlutterSdkVersion',
      'mv /home/worker/flutter/flutter /home/worker/flutter/preview',
    ];
  } else {
    throw ArgumentError('Must get a parameter of "app" or "worker".');
  }

  for (final cmd in commands) {
    print('echo "Running $cmd ..."');
    print(cmd);
  }
}
