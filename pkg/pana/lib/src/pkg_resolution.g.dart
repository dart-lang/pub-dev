// GENERATED CODE - DO NOT MODIFY BY HAND

part of pana.pkg_resolution;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

PkgResolution _$PkgResolutionFromJson(Map<String, dynamic> json) =>
    new PkgResolution((json['dependencies'] as List)
        ?.map((e) => e == null
            ? null
            : new PkgDependency.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$PkgResolutionSerializerMixin {
  List<PkgDependency> get dependencies;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'dependencies': dependencies};
}

PkgDependency _$PkgDependencyFromJson(Map<String, dynamic> json) =>
    new PkgDependency(
        json['package'] as String,
        json['dependencyType'] as String,
        json['constraintType'] as String,
        json['constraint'] == null
            ? null
            : new VersionConstraint.parse(json['constraint']),
        json['resolved'] == null ? null : new Version.parse(json['resolved']),
        json['available'] == null ? null : new Version.parse(json['available']),
        (json['errors'] as List)?.map((e) => e as String)?.toList());

abstract class _$PkgDependencySerializerMixin {
  String get package;
  String get dependencyType;
  String get constraintType;
  VersionConstraint get constraint;
  Version get resolved;
  Version get available;
  List<String> get errors;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'package': package,
      'dependencyType': dependencyType,
      'constraintType': constraintType,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('constraint', constraint?.toString());
    writeNotNull('resolved', resolved?.toString());
    writeNotNull('available', available?.toString());
    writeNotNull('errors', errors);
    return val;
  }
}
