// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import 'src/pub_tool_script.dart';
import 'src/public_pages_script.dart';

/// Runs the integration tests on the [pubHostedUrl].
Future verifyPub({
  @required String pubHostedUrl,
  @required String credentialsFile,
  @required String invitedEmail,
  @required InviteCompleterFn inviteCompleterFn,
}) async {
  final pubToolScript = PubToolScript(
    pubHostedUrl,
    credentialsFile,
    invitedEmail,
    inviteCompleterFn,
  );
  await pubToolScript.verify();

  final publicPagesScript = PublicPagesScript(pubHostedUrl);
  await publicPagesScript.verify();
}
