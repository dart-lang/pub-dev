// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';

import '../../shared/datastore.dart' as db;
import '../../shared/utils.dart';

/// A record of an outgoing email to a single recipient.
@db.Kind(name: 'OutgoingEmail', idType: db.IdType.String)
class OutgoingEmail extends db.Model {
  String get uuid => id as String;

  @db.DateTimeProperty(required: true)
  DateTime? created;

  /// The total number of attempts.
  @db.IntProperty(required: true, indexed: false)
  int attempts = 0;

  /// The timestamp of the last attempt.
  @db.DateTimeProperty()
  DateTime? lastAttempted;

  /// A random identifier to mark that the message is under processing.
  /// After a successful attempt, the [claimId] will be `null`, however,
  /// if the sending process is aborted (e.g. the instance dies), the
  /// [claimId] will be kept.
  @db.StringProperty()
  String? claimId;

  /// The timestamp of the next attempt.
  @db.DateTimeProperty(required: true)
  DateTime? pendingAt;

  /// The email address of the sender.
  @db.StringProperty(required: true)
  String? fromEmail;

  @db.StringListProperty()
  List<String>? recipientEmails;

  /// The subject of the email.
  @db.StringProperty(required: true, indexed: false)
  String? subject;

  /// The body text (in plain text format) of the email.
  @db.StringProperty(required: true, indexed: false)
  String? bodyText;

  OutgoingEmail();
  OutgoingEmail.init({
    required this.fromEmail,
    required this.recipientEmails,
    required this.subject,
    required this.bodyText,
  }) {
    id = createUuid();
    created = clock.now().toUtc();
    // adding an extra
    pendingAt = clock.now().toUtc().add(Duration(minutes: 1));
  }

  /// Whether a new attempt can be made to deliver the email.
  bool get mayAttemptNow => isAlive && clock.now().isAfter(pendingAt!);

  /// Whether we consider the outgoing email alive and try sending.
  bool get isAlive => attempts < 2;
  bool get isNotAlive => !isAlive;

  bool get hasExpiredClaim =>
      claimId != null &&
      clock.now().difference((lastAttempted ?? created)!) > Duration(hours: 8);
}
