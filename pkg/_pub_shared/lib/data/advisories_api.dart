// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'advisories_api.g.dart';

/// Response for listing all security advisories affecting a given package.
@JsonSerializable()
class ListAdvisoriesResponse {
  /// List of advisories
  final List<OSV> advisories;

  /// The latest point in time at which the content of this response was modified.
  DateTime advisoriesUpdated;

  // json_serializable boiler-plate
  ListAdvisoriesResponse(
      {required this.advisories, required this.advisoriesUpdated});
  factory ListAdvisoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListAdvisoriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListAdvisoriesResponseToJson(this);
}

/// Representation of an advisory in [Open Source Vulnerability format][1] version 1.5
///
/// [1]: https://ossf.github.io/osv-schema/
@JsonSerializable(includeIfNull: false)
class OSV {
  /// The version number of the OSV schema that this particular vulnerability
  /// was exported with.
  @JsonKey(name: 'schema_version')
  final String? schemaVersion;

  /// The unique identifier for this particular vulnerability.
  ///
  /// It is a string of the format <DB>-<ENTRYID>, where DB names the database
  /// and ENTRYID is in the format used by the database.
  /// For example: “OSV-2020-111”, “CVE-2021-3114”, or “GHSA-vp9c-fpxx-744v”.
  String id;

  /// The time this entry was last modified, as an RFC3339-formatted timestamp
  /// in UTC (ending in “Z”).
  String modified;

  /// The time this entry was published, as an RFC3339-formatted time stamp in
  /// UTC (ending in “Z”).
  String? published;

  /// The time the entry should be considered to have been withdrawn, as an
  /// RFC3339-formatted timestamp in UTC (ending in “Z”).
  String? withdrawn;

  /// A list of IDs of the same vulnerability in other databases, in the form of
  /// the [id] field.
  @JsonKey(defaultValue: <String>[])
  List<String> aliases;

  /// A list of IDs of closely related vulnerabilities, such as the same problem
  /// in alternate ecosystems.
  List<String>? related;

  /// A one-line, English textual summary of the vulnerability.
  String? summary;

  /// Additional English textual details about the vulnerability.
  String? details;

  /// A list of [Severity] items describing the severity of a vulnerability
  /// using one or more quantitative scoring methods.
  List<Severity>? severity;

  /// A list of [Affected] items describing the affected package versions.
  List<Affected>? affected;

  /// A list of [Reference] items describing references.
  List<Reference>? references;

  /// A of [Credit] items providing a way to give credit for the discovery,
  /// confirmation, patch, or other events in the life cycle of a vulnerability.
  List<Credit>? credits;

  /// A map holding additional information about the vulnerability as defined by
  /// the database from which the record was obtained. The meaning of the values
  ///  within the object is entirely defined by the database.
  @JsonKey(name: 'database_specific')
  Map<String, dynamic>? databaseSpecific;

  OSV({
    this.schemaVersion,
    required this.id,
    required this.modified,
    this.published,
    this.withdrawn,
    this.aliases = const <String>[],
    this.related,
    this.summary,
    this.details,
    this.severity,
    this.affected,
    this.references,
    this.credits,
    this.databaseSpecific,
  });

  factory OSV.fromJson(Map<String, dynamic> json) => _$OSVFromJson(json);
  Map<String, dynamic> toJson() => _$OSVToJson(this);
}

@JsonSerializable()
class Severity {
  /// Either 'CVSS_V2' or 'CVSS_V3'.
  String type;

  /// A CVSS vector string representing the unique characteristics and severity
  /// of the vulnerability using the Common Vulnerability Scoring System
  /// notation, either V2 or V3 depending on the value of [type].
  String score;

  Severity({
    required this.type,
    required this.score,
  });

  factory Severity.fromJson(Map<String, dynamic> json) =>
      _$SeverityFromJson(json);

  Map<String, dynamic> toJson() => _$SeverityToJson(this);
}

@JsonSerializable()
class Package {
  String ecosystem;
  String name;
  String? purl;

  Package({
    required this.ecosystem,
    required this.name,
    this.purl,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
  Map<String, dynamic> toJson() => _$PackageToJson(this);
}

@JsonSerializable()
class Event {
  String? introduced;
  String? fixed;
  @JsonKey(name: 'last_affected')
  String? lastAffected;
  String? limit;

  Event({
    this.introduced,
    this.fixed,
    this.lastAffected,
    this.limit,
  });
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class Range {
  String type;
  String? repo;
  List<Event>? events;
  @JsonKey(name: 'database_specific')
  Map<String, dynamic>? databaseSpecific;

  Range({
    required this.type,
    this.repo,
    this.events,
    this.databaseSpecific,
  });
  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);
  Map<String, dynamic> toJson() => _$RangeToJson(this);
}

@JsonSerializable()
class Affected {
  Package package;
  List<Range>? ranges;
  List<String>? versions;
  @JsonKey(name: 'database_specific')
  Map<String, dynamic>? databaseSpecific;
  @JsonKey(name: 'ecosystem_specific')
  Map<String, dynamic>? ecosystemSpecific;

  Affected(
      {required this.package,
      this.ranges,
      this.versions,
      this.databaseSpecific,
      this.ecosystemSpecific});

  factory Affected.fromJson(Map<String, dynamic> json) =>
      _$AffectedFromJson(json);
  Map<String, dynamic> toJson() => _$AffectedToJson(this);
}

@JsonSerializable()
class Credit {
  String name;
  List<String>? contact;

  Credit({
    required this.name,
    this.contact,
  });

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);
  Map<String, dynamic> toJson() => _$CreditToJson(this);
}

@JsonSerializable()
class Reference {
  String? type;
  String? url;

  Reference({
    this.type,
    this.url,
  });

  factory Reference.fromJson(Map<String, dynamic> json) =>
      _$ReferenceFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceToJson(this);
}
