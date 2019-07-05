// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'package:pub_integration/pub_integration.dart';

/// Runs integration test against prod or staging server.
Future main(List<String> args) async {
  final _argParser = ArgParser()
    ..addFlag('help', defaultsTo: false, abbr: 'h')
    ..addOption('pub-hosted-url', help: 'The PUB_HOSTED_URL to use.')
    ..addOption('invited-email', help: 'The e-mail of the invited account.')
    ..addOption('credentials-json',
        help: 'The credentials.json to use for uploads and other actions.');
  final argv = _argParser.parse(args);
  if (argv['help'] as bool) {
    print(_argParser.usage);
    exit(0);
  }

  bool verifyParameters = false;

  String pubHostedUrl = (argv['pub-hosted-url'] as String);
  if (pubHostedUrl == null) {
    pubHostedUrl = Platform.environment['PUB_HOSTED_URL'];
    verifyParameters = true;
  }
  if (pubHostedUrl == null) {
    print('--pub-hosted-url or PUB_HOSTED_URL must be set');
    exit(1);
  }
  if (pubHostedUrl.endsWith('/')) {
    pubHostedUrl = pubHostedUrl.substring(0, pubHostedUrl.length - 1);
  }

  final invitedEmail = argv['invited-email'] as String;
  if (invitedEmail == null || invitedEmail.isEmpty) {
    print('--invited-email must be set');
    exit(1);
  }

  String credentialsFile = argv['credentials-json'] as String;
  if (credentialsFile == null && Platform.environment['PUB_CACHE'] != null) {
    credentialsFile =
        p.join(Platform.environment['PUB_CACHE'], 'credentials.json');
    verifyParameters = true;
  }
  if (credentialsFile == null && Platform.environment['HOME'] != null) {
    credentialsFile =
        p.join(Platform.environment['HOME'], '.pub-cache', 'credentials.json');
    verifyParameters = true;
  }
  if (credentialsFile == null) {
    print('--credentials-json must be set');
    exit(1);
  }
  final credentialsExist = await File(credentialsFile).exists();
  if (!credentialsExist) {
    print('credentials.json must exist');
    exit(1);
  }
  final credentialsFileContent = await File(credentialsFile).readAsString();

  print('');
  print('PUB_HOSTED_URL:   $pubHostedUrl');
  print('invited e-mail:   $invitedEmail');
  print('credentials.json: $credentialsFile');
  print('');

  if (verifyParameters) {
    print('******');
    print('Please accept the autodetected values, hit ENTER or CTRL+C.');
    stdin.readByteSync();
  }

  await verifyPub(
    pubHostedUrl: pubHostedUrl,
    credentialsFileContent: credentialsFileContent,
    invitedEmail: invitedEmail,
    inviteCompleterFn: () async {
      print('******');
      print('Please accept invite sent to $invitedEmail, hit ENTER when done.');
      stdin.readLineSync();
    },
  );

  print('');
  print('LGTM');
  print('');
}
