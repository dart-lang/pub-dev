// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/data/account_api.dart';
import 'package:clock/clock.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../admin/models.dart';
import '../../frontend/email_sender.dart';
import '../../frontend/handlers/cache_control.dart';
import '../../shared/datastore.dart';
import '../../shared/email.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
import '../../shared/utils.dart';
import '../request_context.dart';
import '../templates/report.dart';

/// Handles GET /report
Future<shelf.Response> reportPageHandler(shelf.Request request) async {
  if (!requestContext.experimentalFlags.isReportPageEnabled) {
    return notFoundHandler(request);
  }

  return htmlResponse(
    renderReportPage(
      sessionData: requestContext.sessionData,
    ),
    headers: CacheControl.explicitlyPrivate.headers,
  );
}

/// Handles POST /api/report
Future<String> processReportPageHandler(
    shelf.Request request, ReportForm form) async {
  if (!requestContext.experimentalFlags.isReportPageEnabled) {
    throw NotFoundException('Experimental flag is not enabled.');
  }
  final now = clock.now().toUtc();
  final caseId = '${now.toIso8601String().split('T').first}/${createUuid()}';

  final isAuthenticated = requestContext.sessionData?.isAuthenticated ?? false;
  final user = isAuthenticated ? await requireAuthenticatedWebUser() : null;
  final userEmail = user?.email ?? form.email;

  if (!isAuthenticated) {
    InvalidInputException.check(
      userEmail != null && isValidEmail(userEmail),
      'Email is invalid or missing.',
    );
  } else {
    InvalidInputException.checkNull(form.email, 'email');
  }

  InvalidInputException.checkStringLength(
    form.message,
    'message',
    minimum: 20,
    maximum: 8192,
  );

  // If the email sending fails, we may have pending [ModerationCase] entities
  // in the datastore. These would be reviewed and processed manually.
  await withRetryTransaction(dbService, (tx) async {
    final mc = ModerationCase.init(
      caseId: caseId,
      reporterEmail: userEmail!,
      source: ModerationDetectedBy.externalNotification,
      kind: ModerationKind.notification,
      status: ModerationStatus.pending,
    );
    tx.insert(mc);
  });

  final bodyText = <String>[
    'New report recieved on ${now.toIso8601String()}: $caseId',
    'Message:\n${form.message}',
  ].join('\n\n');

  await emailSender.sendMessage(createReportPageAdminEmail(
    id: caseId,
    userEmail: userEmail!,
    bodyText: bodyText,
  ));

  return 'Report submitted successfully.';
}
