// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pana.summary;

import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import 'code_problem.dart';
import 'fitness.dart';
import 'license.dart';
import 'pkg_resolution.dart';
import 'platform.dart';
import 'pubspec.dart';
import 'utils.dart' show toRelativePath;

part 'summary.g.dart';

@JsonSerializable()
class DartFileSummary extends Object with _$DartFileSummarySerializerMixin {
  final String uri;
  final int size;

  /// If this file is formatted with `dartfmt`.
  ///
  /// `true` if it is.
  /// `false` if it is not.
  /// `null` if `dartfmt` failed while running.
  final bool isFormatted;
  final List<CodeProblem> codeProblems;

  @JsonKey(includeIfNull: false)
  final List<String> directLibs;
  @JsonKey(includeIfNull: false)
  final List<String> transitiveLibs;
  @JsonKey(includeIfNull: false)
  final DartPlatform platform;
  @JsonKey(includeIfNull: false)
  final Fitness fitness;

  DartFileSummary(
    this.uri,
    this.size,
    this.isFormatted,
    this.codeProblems,
    this.directLibs,
    this.transitiveLibs,
    this.platform,
    this.fitness,
  );

  factory DartFileSummary.fromJson(Map<String, dynamic> json) =>
      _$DartFileSummaryFromJson(json);

  /// The relative path in the package archive.
  String get path => toRelativePath(uri);
  bool get isInBin => path.startsWith('bin/');
  bool get isInLib => path.startsWith('lib/');
  bool get isInLibSrc => path.startsWith('lib/src/');

  /// Whether the file provides a public API for the package users.
  bool get isPublicApi => isInLib && !isInLibSrc;

  /// Whether the file has any local import that point outside of the lib/
  bool get hasOutsideLibDependency =>
      directLibs != null &&
      directLibs.any((String lib) => lib.startsWith('asset:'));

  bool get hasCodeError =>
      (codeProblems?.any((cp) => cp.isError) ?? false) ||
      hasOutsideLibDependency;

  CodeProblem get firstCodeError =>
      codeProblems?.firstWhere((cp) => cp.isError, orElse: () => null);
}

@JsonSerializable()
class Summary extends Object with _$SummarySerializerMixin {
  @JsonKey(nullable: false)
  final Version panaVersion;

  final String sdkVersion;

  @JsonKey(includeIfNull: false)
  final Map<String, Object> flutterVersion;
  final String packageName;

  @JsonKey(includeIfNull: false)
  final Version packageVersion;

  final Pubspec pubspec;

  final PkgResolution pkgResolution;
  final Map<String, DartFileSummary> dartFiles;
  final DartPlatform platform;
  final List<LicenseFile> licenses;

  @JsonKey(includeIfNull: false)
  final List<ToolProblem> toolProblems;

  final Fitness fitness;

  Summary(
      this.panaVersion,
      this.sdkVersion,
      this.packageName,
      this.packageVersion,
      this.pubspec,
      this.pkgResolution,
      this.dartFiles,
      List<ToolProblem> toolProblems,
      this.platform,
      this.licenses,
      this.fitness,
      {this.flutterVersion})
      : this.toolProblems = (toolProblems == null || toolProblems.isEmpty)
            ? null
            : new List<ToolProblem>.unmodifiable(toolProblems);

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  Iterable<CodeProblem> get codeProblems => dartFiles.values
      .map((dfs) => dfs.codeProblems)
      .where((l) => l != null)
      .expand((list) => list);
}

@JsonSerializable()
class ToolProblem extends Object with _$ToolProblemSerializerMixin {
  final String tool;
  final String message;
  @JsonKey(includeIfNull: false)
  final dynamic code;

  ToolProblem(this.tool, this.message, [this.code]);

  factory ToolProblem.fromJson(Map<String, dynamic> json) =>
      _$ToolProblemFromJson(json);
}

abstract class ToolNames {
  static const String pubspec = 'pubspec';
  static const String dartAnalyzer = 'dart-analyzer';
  static const String libraryScanner = 'library-scanner';
  static const String pubUpgrade = 'pub-upgrade';
  static const String dartfmt = 'dartfmt';
}
