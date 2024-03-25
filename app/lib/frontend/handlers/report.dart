// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/data/account_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/frontend/email_sender.dart';
import 'package:pub_dev/frontend/handlers/account.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../shared/email.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
import '../../shared/utils.dart';
import '../request_context.dart';
import '../templates/report.dart';
import 'headers.dart';

/// Handles GET /report
Future<shelf.Response> reportPageHandler(shelf.Request request) async {
  if (!requestContext.experimentalFlags.isReportPageEnabled) {
    return notFoundHandler(request);
  }
  // TODO: Final report page cannot require authentication!
  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }

  return htmlResponse(
    renderReportPage(
      sessionData: requestContext.sessionData,
    ),
    headers: {
      ...CacheHeaders.privateZero(),
    },
  );
}

/// Handles POST /api/report
Future<String> processReportPageHandler(
    shelf.Request request, ReportForm form) async {
  if (!requestContext.experimentalFlags.isReportPageEnabled) {
    throw NotFoundException('Experimental flag is not enabled.');
  }
  final user = await requireAuthenticatedWebUser();

  final now = clock.now().toUtc();
  final id = '${now.toIso8601String().split('T').first}/${createUuid()}';

  InvalidInputException.checkStringLength(
    form.description,
    'description',
    minimum: 20,
    maximum: 8192,
  );

  final bodyText = <String>[
    'New report recieved on ${now.toIso8601String()}: $id',
    'Description:\n${form.description}',
  ].join('\n\n');

  await emailSender.sendMessage(createReportPageAdminEmail(
    id: id,
    userEmail: user.email!,
    bodyText: bodyText,
  ));

  return 'Report submitted successfully.';
}
