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

  /// The timestamp of the next attempt.
  @db.DateTimeProperty(required: true)
  DateTime? pendingAt;

  /// The error message of the last failure.
  @db.StringProperty(indexed: false)
  String? lastError;

  /// The email address of the sender.
  @db.StringProperty(required: true)
  String? fromEmail;

  /// The email address of the recipient.
  @db.StringProperty(required: true)
  String? recipientEmail;

  /// The subject of the email.
  @db.StringProperty(required: true, indexed: false)
  String? subject;

  /// The body text (in plain text format) of the email.
  @db.StringProperty(required: true, indexed: false)
  String? bodyText;

  OutgoingEmail();
  OutgoingEmail.init({
    required this.fromEmail,
    required this.recipientEmail,
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
}
