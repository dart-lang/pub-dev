// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisories_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAdvisoriesResponse _$ListAdvisoriesResponseFromJson(
        Map<String, dynamic> json) =>
    ListAdvisoriesResponse(
      advisories: (json['advisories'] as List<dynamic>)
          .map((e) => OSV.fromJson(e as Map<String, dynamic>))
          .toList(),
      advisoriesUpdated: json['advisoriesUpdated'] == null
          ? null
          : DateTime.parse(json['advisoriesUpdated'] as String),
    );

Map<String, dynamic> _$ListAdvisoriesResponseToJson(
        ListAdvisoriesResponse instance) =>
    <String, dynamic>{
      'advisories': instance.advisories,
      'advisoriesUpdated': instance.advisoriesUpdated?.toIso8601String(),
    };

OSV _$OSVFromJson(Map<String, dynamic> json) => OSV(
      schemaVersion: json['schema_version'] as String?,
      id: json['id'] as String,
      modified: json['modified'] as String,
      published: json['published'] as String?,
      withdrawn: json['withdrawn'] as String?,
      aliases: (json['aliases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      related:
          (json['related'] as List<dynamic>?)?.map((e) => e as String).toList(),
      summary: json['summary'] as String?,
      details: json['details'] as String?,
      severity: (json['severity'] as List<dynamic>?)
          ?.map((e) => Severity.fromJson(e as Map<String, dynamic>))
          .toList(),
      affected: (json['affected'] as List<dynamic>?)
          ?.map((e) => Affected.fromJson(e as Map<String, dynamic>))
          .toList(),
      references: (json['references'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      credits: (json['credits'] as List<dynamic>?)
          ?.map((e) => Credit.fromJson(e as Map<String, dynamic>))
          .toList(),
      databaseSpecific: json['database_specific'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OSVToJson(OSV instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('schema_version', instance.schemaVersion);
  val['id'] = instance.id;
  val['modified'] = instance.modified;
  writeNotNull('published', instance.published);
  writeNotNull('withdrawn', instance.withdrawn);
  val['aliases'] = instance.aliases;
  writeNotNull('related', instance.related);
  writeNotNull('summary', instance.summary);
  writeNotNull('details', instance.details);
  writeNotNull('severity', instance.severity);
  writeNotNull('affected', instance.affected);
  writeNotNull('references', instance.references);
  writeNotNull('credits', instance.credits);
  writeNotNull('database_specific', instance.databaseSpecific);
  return val;
}

Severity _$SeverityFromJson(Map<String, dynamic> json) => Severity(
      type: json['type'] as String,
      score: json['score'] as String,
    );

Map<String, dynamic> _$SeverityToJson(Severity instance) => <String, dynamic>{
      'type': instance.type,
      'score': instance.score,
    };

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      ecosystem: json['ecosystem'] as String,
      name: json['name'] as String,
      purl: json['purl'] as String?,
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'ecosystem': instance.ecosystem,
      'name': instance.name,
      'purl': instance.purl,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      introduced: json['introduced'] as String?,
      fixed: json['fixed'] as String?,
      lastAffected: json['last_affected'] as String?,
      limit: json['limit'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'introduced': instance.introduced,
      'fixed': instance.fixed,
      'last_affected': instance.lastAffected,
      'limit': instance.limit,
    };

Range _$RangeFromJson(Map<String, dynamic> json) => Range(
      type: json['type'] as String,
      repo: json['repo'] as String?,
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      databaseSpecific: json['database_specific'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RangeToJson(Range instance) => <String, dynamic>{
      'type': instance.type,
      'repo': instance.repo,
      'events': instance.events,
      'database_specific': instance.databaseSpecific,
    };

Affected _$AffectedFromJson(Map<String, dynamic> json) => Affected(
      package: Package.fromJson(json['package'] as Map<String, dynamic>),
      ranges: (json['ranges'] as List<dynamic>?)
          ?.map((e) => Range.fromJson(e as Map<String, dynamic>))
          .toList(),
      versions: (json['versions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      databaseSpecific: json['database_specific'] as Map<String, dynamic>?,
      ecosystemSpecific: json['ecosystem_specific'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AffectedToJson(Affected instance) => <String, dynamic>{
      'package': instance.package,
      'ranges': instance.ranges,
      'versions': instance.versions,
      'database_specific': instance.databaseSpecific,
      'ecosystem_specific': instance.ecosystemSpecific,
    };

Credit _$CreditFromJson(Map<String, dynamic> json) => Credit(
      name: json['name'] as String,
      contact:
          (json['contact'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreditToJson(Credit instance) => <String, dynamic>{
      'name': instance.name,
      'contact': instance.contact,
    };

Reference _$ReferenceFromJson(Map<String, dynamic> json) => Reference(
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ReferenceToJson(Reference instance) => <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };
