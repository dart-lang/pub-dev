// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart' as db;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../shared/utils.dart' show createUuid;

part 'models.g.dart';

abstract class HistorySource {
  static const String account = 'account';
  static const String analyzer = 'analyzer';
  static const String dartdoc = 'dartdoc';
}

@db.Kind(name: 'History', idType: db.IdType.String)
class History extends db.ExpandoModel {
  History();

  History._({
    this.publisherId,
    this.packageName,
    this.packageVersion,
    this.timestamp,
    this.source,
    HistoryEvent event,
  }) {
    id = createUuid();
    timestamp ??= DateTime.now().toUtc();
    historyEvent = event;
  }

  factory History.entry(HistoryEvent event) {
    final pkgEvent = event is PackageHistoryEvent ? event : null;
    final publisherEvent = event is PublisherHistoryEvent ? event : null;
    return History._(
      publisherId: publisherEvent?.publisherId,
      packageName: pkgEvent?.packageName,
      packageVersion:
          pkgEvent == null ? null : (pkgEvent.packageVersion ?? '*'),
      timestamp: event.timestamp,
      source: event.source,
      event: event,
    );
  }

  /// This is null if it's not publisher related (ie. package related).
  @db.StringProperty()
  String publisherId;

  /// This is null if it's not package related (ie. publisher related).
  @db.StringProperty()
  String packageName;

  /// This is null if it's not package related (ie. publisher related).
  @db.StringProperty()
  String packageVersion;

  /// The timestamp of the entry.
  @db.DateTimeProperty()
  DateTime timestamp;

  @db.StringProperty(required: true)
  String source;

  @db.StringProperty(required: true)
  String eventType;

  @db.StringProperty()
  String eventJson;

  Map<String, dynamic> get eventData =>
      json.decode(eventJson) as Map<String, dynamic>;
  set eventData(Map<String, dynamic> value) {
    eventJson = json.encode(value);
  }

  HistoryUnion get historyUnion =>
      HistoryUnion.fromJson({eventType: eventData});

  HistoryEvent get historyEvent => historyUnion.event;
  set historyEvent(HistoryEvent event) {
    final union = HistoryUnion.ofEvent(event);
    final map = union.toJson();
    eventType = map.keys.single;
    eventData = map.values.single as Map<String, dynamic>;
  }

  String formatMarkdown() => historyEvent?.formatMarkdown();
}

abstract class HistoryEvent {
  String get source;
  DateTime get timestamp;
  String formatMarkdown();
}

/// A history event specific to a package (optionally to a package version).
abstract class PackageHistoryEvent extends HistoryEvent {
  String get packageName;
  String get packageVersion;
}

/// A history event specific to a publisher.
abstract class PublisherHistoryEvent extends HistoryEvent {
  String get publisherId;
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class HistoryUnion {
  final PackageOptionsChanged packageOptionsChanged;
  final PackageTransferred packageTransferred;
  final PackageUploaded packageUploaded;
  final UploaderChanged uploaderChanged;
  final UploaderInvited uploaderInvited;
  final AnalysisCompleted analysisCompleted;
  final PublisherCreated publisherCreated;
  final MemberInvited memberInvited;
  final MemberJoined memberJoined;
  final MemberRemoved memberRemoved;

  HistoryUnion({
    this.packageOptionsChanged,
    this.packageTransferred,
    this.packageUploaded,
    this.uploaderChanged,
    this.uploaderInvited,
    this.analysisCompleted,
    this.publisherCreated,
    this.memberInvited,
    this.memberJoined,
    this.memberRemoved,
  }) {
    assert(_items.where((x) => x != null).length == 1);
  }

  factory HistoryUnion.ofEvent(HistoryEvent event) {
    if (event is PackageOptionsChanged) {
      return HistoryUnion(packageOptionsChanged: event);
    } else if (event is PackageTransferred) {
      return HistoryUnion(packageTransferred: event);
    } else if (event is PackageUploaded) {
      return HistoryUnion(packageUploaded: event);
    } else if (event is UploaderChanged) {
      return HistoryUnion(uploaderChanged: event);
    } else if (event is UploaderInvited) {
      return HistoryUnion(uploaderInvited: event);
    } else if (event is AnalysisCompleted) {
      return HistoryUnion(analysisCompleted: event);
    } else if (event is PublisherCreated) {
      return HistoryUnion(publisherCreated: event);
    } else if (event is MemberInvited) {
      return HistoryUnion(memberInvited: event);
    } else if (event is MemberJoined) {
      return HistoryUnion(memberJoined: event);
    } else if (event is MemberRemoved) {
      return HistoryUnion(memberRemoved: event);
    } else {
      throw ArgumentError('Unknown type: ${event.runtimeType}');
    }
  }

  factory HistoryUnion.fromJson(Map<String, dynamic> json) =>
      _$HistoryUnionFromJson(json);

  List<HistoryEvent> get _items {
    return <HistoryEvent>[
      packageOptionsChanged,
      packageTransferred,
      packageUploaded,
      uploaderChanged,
      uploaderInvited,
      analysisCompleted,
      publisherCreated,
      memberInvited,
      memberJoined,
      memberRemoved,
    ];
  }

  HistoryEvent get event => _items.firstWhere((x) => x != null);

  Map<String, dynamic> toJson() => _$HistoryUnionToJson(this);
}

/// An event that describes when package options has been changed.
@JsonSerializable(includeIfNull: false)
class PackageOptionsChanged implements PackageHistoryEvent {
  @override
  final String packageName;
  final String userId;
  final String userEmail;
  final bool isDiscontinued;
  @override
  final DateTime timestamp;

  PackageOptionsChanged({
    @required this.packageName,
    @required this.userId,
    @required this.userEmail,
    @required this.isDiscontinued,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory PackageOptionsChanged.fromJson(Map<String, dynamic> json) =>
      _$PackageOptionsChangedFromJson(json);

  @override
  String get packageVersion => null;

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    final flags = <String>[
      if (isDiscontinued != null) '`isDiscontinued = $isDiscontinued`',
    ];
    return '`$userEmail` changed the following flag(s): ${flags.join(', ')}.';
  }

  Map<String, dynamic> toJson() => _$PackageOptionsChangedToJson(this);
}

/// An event that describes when a package is transferred from/to publishers.
@JsonSerializable()
class PackageTransferred implements PackageHistoryEvent {
  @override
  final String packageName;
  final String fromPublisherId;
  final String toPublisherId;
  final String userId;
  final String userEmail;
  @override
  final DateTime timestamp;

  PackageTransferred({
    @required this.packageName,
    @required this.fromPublisherId,
    @required this.toPublisherId,
    @required this.userId,
    @required this.userEmail,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory PackageTransferred.fromJson(Map<String, dynamic> json) =>
      _$PackageTransferredFromJson(json);

  @override
  String get packageVersion => null;

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    final from = fromPublisherId == null ? '' : 'from `$fromPublisherId` ';
    final to = toPublisherId == null ? '' : 'to `$toPublisherId` ';
    return 'Package `$packageName` was transferred $from${to}by `$userEmail`.';
  }

  Map<String, dynamic> toJson() => _$PackageTransferredToJson(this);
}

/// An event that describes when a new package version was uploaded.
@JsonSerializable()
class PackageUploaded implements PackageHistoryEvent {
  @override
  final String packageName;
  @override
  final String packageVersion;
  final String uploaderId;
  final String uploaderEmail;
  @override
  final DateTime timestamp;

  PackageUploaded({
    @required this.packageName,
    @required this.packageVersion,
    @required this.uploaderId,
    @required this.uploaderEmail,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory PackageUploaded.fromJson(Map<String, dynamic> json) =>
      _$PackageUploadedFromJson(json);

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    return 'Version $packageVersion was uploaded by `$uploaderEmail`.';
  }

  Map<String, dynamic> toJson() => _$PackageUploadedToJson(this);
}

/// An event that describes when uploaders of the package changed.
@JsonSerializable(includeIfNull: false)
class UploaderChanged implements PackageHistoryEvent {
  @override
  final String packageName;
  final String currentUserId;
  final String currentUserEmail;
  final List<String> addedUploaderIds;
  final List<String> addedUploaderEmails;
  final List<String> removedUploaderIds;
  final List<String> removedUploaderEmails;
  @override
  final DateTime timestamp;

  UploaderChanged({
    @required this.packageName,
    @required this.currentUserId,
    @required this.currentUserEmail,
    this.addedUploaderIds,
    this.addedUploaderEmails,
    this.removedUploaderIds,
    this.removedUploaderEmails,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  @override
  String get packageVersion => null;

  factory UploaderChanged.fromJson(Map<String, dynamic> json) =>
      _$UploaderChangedFromJson(json);

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    final changes = <String>[];
    if (addedUploaderEmails != null && addedUploaderEmails.isNotEmpty) {
      final emails = addedUploaderEmails.map((e) => '`$e`').join(', ');
      changes.add('added $emails');
    }
    if (removedUploaderEmails != null && removedUploaderEmails.isNotEmpty) {
      final emails = removedUploaderEmails.map((e) => '`$e`').join(', ');
      changes.add('removed $emails');
    }
    final actor = (currentUserEmail != null && currentUserEmail.isNotEmpty)
        ? currentUserEmail
        : 'A site administrator';
    return '$actor has changed uploaders: ${changes.join(' and ')}.';
  }

  Map<String, dynamic> toJson() => _$UploaderChangedToJson(this);
}

/// An event that describes when a new uploader was invited to a package.
@JsonSerializable(includeIfNull: false)
class UploaderInvited implements PackageHistoryEvent {
  @override
  final String packageName;
  final String currentUserId;
  final String currentUserEmail;
  final String uploaderUserEmail;
  @override
  final DateTime timestamp;

  UploaderInvited({
    @required this.packageName,
    @required this.currentUserId,
    @required this.currentUserEmail,
    @required this.uploaderUserEmail,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory UploaderInvited.fromJson(Map<String, dynamic> json) =>
      _$UploaderInvitedFromJson(json);

  @override
  String get packageVersion => null;

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    return '`$currentUserEmail` invited `$uploaderUserEmail` to be an uploader.';
  }

  Map<String, dynamic> toJson() => _$UploaderInvitedToJson(this);
}

/// An event that describes when an analysis has been completed.
@JsonSerializable()
class AnalysisCompleted implements PackageHistoryEvent {
  @override
  final String packageName;
  @override
  final String packageVersion;
  final bool hasErrors;
  final bool hasPlatforms;
  @override
  final DateTime timestamp;

  AnalysisCompleted({
    @required this.packageName,
    @required this.packageVersion,
    @required this.hasErrors,
    @required this.hasPlatforms,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory AnalysisCompleted.fromJson(Map<String, dynamic> json) =>
      _$AnalysisCompletedFromJson(json);

  @override
  String get source => HistorySource.analyzer;

  @override
  String formatMarkdown() {
    if (hasErrors) {
      return 'Analysis of `package:$packageName` failed.';
    } else if (hasPlatforms) {
      return 'Analysis of `package:$packageName` completed successful.';
    } else {
      return 'Analysis of `package:$packageName` completed, but no platform has been identified.';
    }
  }

  Map<String, dynamic> toJson() => _$AnalysisCompletedToJson(this);
}

/// An event that describes when a publisher has been created.
@JsonSerializable()
class PublisherCreated implements PublisherHistoryEvent {
  @override
  final String publisherId;
  final String userId;
  final String userEmail;
  @override
  final DateTime timestamp;

  PublisherCreated({
    @required this.publisherId,
    @required this.userId,
    @required this.userEmail,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory PublisherCreated.fromJson(Map<String, dynamic> json) =>
      _$PublisherCreatedFromJson(json);

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    return 'Publisher `$publisherId` was created by `$userEmail`.';
  }

  Map<String, dynamic> toJson() => _$PublisherCreatedToJson(this);
}

/// An event that describes when a new member was invited to a publisher.
@JsonSerializable(includeIfNull: false)
class MemberInvited implements PublisherHistoryEvent {
  @override
  final String publisherId;
  final String currentUserId;
  final String currentUserEmail;
  final String invitedUserId;
  final String invitedUserEmail;
  @override
  final DateTime timestamp;

  MemberInvited({
    @required this.publisherId,
    @required this.currentUserId,
    @required this.currentUserEmail,
    @required this.invitedUserId,
    @required this.invitedUserEmail,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory MemberInvited.fromJson(Map<String, dynamic> json) =>
      _$MemberInvitedFromJson(json);

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    return '`$currentUserEmail` invited `$invitedUserEmail` to be a member.';
  }

  Map<String, dynamic> toJson() => _$MemberInvitedToJson(this);
}

/// An event that describes when a new member joined to a publisher.
@JsonSerializable(includeIfNull: false)
class MemberJoined implements PublisherHistoryEvent {
  @override
  final String publisherId;
  final String userId;
  final String userEmail;
  final String role;
  @override
  final DateTime timestamp;

  MemberJoined({
    @required this.publisherId,
    @required this.userId,
    @required this.userEmail,
    @required this.role,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory MemberJoined.fromJson(Map<String, dynamic> json) =>
      _$MemberJoinedFromJson(json);

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    return '`$userEmail` joined as member in role `$role`.';
  }

  Map<String, dynamic> toJson() => _$MemberJoinedToJson(this);
}

/// An event that describes when a member was removed from a publisher.
@JsonSerializable(includeIfNull: false)
class MemberRemoved implements PublisherHistoryEvent {
  @override
  final String publisherId;
  final String currentUserId;
  final String currentUserEmail;
  final String removedUserId;
  final String removedUserEmail;
  @override
  final DateTime timestamp;

  MemberRemoved({
    @required this.publisherId,
    @required this.currentUserId,
    @required this.currentUserEmail,
    @required this.removedUserId,
    @required this.removedUserEmail,
    DateTime timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory MemberRemoved.fromJson(Map<String, dynamic> json) =>
      _$MemberRemovedFromJson(json);

  @override
  String get source => HistorySource.account;

  @override
  String formatMarkdown() {
    return '`$currentUserEmail` removed member `$removedUserEmail`.';
  }

  Map<String, dynamic> toJson() => _$MemberRemovedToJson(this);
}
