// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pana.health;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;

import 'code_problem.dart';
import 'platform.dart';
import 'pubspec.dart';
import 'summary.dart';

part 'fitness.g.dart';

/// Describes a health metric that takes size and complexity into account.
@JsonSerializable()
class Fitness extends Object with _$FitnessSerializerMixin {
  /// Represents the size and complexity of the library.
  final double magnitude;

  /// The faults, penalties and failures to meet the standards.
  final double shortcoming;

  Fitness(this.magnitude, this.shortcoming);

  factory Fitness.fromJson(Map json) => _$FitnessFromJson(json);

  String toSimpleText() =>
      '${(magnitude - shortcoming).toStringAsFixed(2)} out of ${magnitude.toStringAsFixed(2)}';
}

Future<Fitness> calcFitness(
    String pkgDir,
    String dartFile,
    bool isFormatted,
    List<CodeProblem> fileAnalyzerItems,
    List<String> directLibs,
    DartPlatform platform) async {
  // statement count estimated by:
  // - counting the non-comment ';' characters
  // - counting the non-empty lines
  // - assumed average line length
  var content = await new File(p.join(pkgDir, dartFile)).readAsString();
  content = content
      .replaceAll(_blockCommentRegExp, '')
      .replaceAll(_lineCommentRegExp, '');
  final semiColonCount = content.replaceAll(_antiSemiColonRegExp, '').length;
  final nonEmptyLineCount =
      content.split('\n').where((line) => line.trim().isNotEmpty).length;
  final statementEstimate = content.length ~/ 40;
  final statementCount =
      (semiColonCount + nonEmptyLineCount + statementEstimate) ~/ 3;

  // code magnitude is estimated by the imported lib count and statement count
  final magnitude =
      max(1.0, ((directLibs?.length ?? 0) + statementCount).toDouble());

  // major issues are penalized in the percent of the total
  // minor issues are penalized in a fixed amount
  final errorPoints = max(10.0, magnitude * 0.20); // 20%
  final warnPoints = max(4.0, magnitude * 0.05); // 5%
  final hintPoints = 1.0;

  var shortcoming = 0.0;

  if (platform != null && platform.hasConflict) {
    shortcoming += errorPoints;
  }

  if (isFormatted == null || !isFormatted) {
    shortcoming += hintPoints;
  }

  if (fileAnalyzerItems != null) {
    for (var item in fileAnalyzerItems) {
      if (item.severity == 'INFO') {
        shortcoming += hintPoints;
      } else if (item.severity == 'WARNING') {
        shortcoming += warnPoints;
      } else {
        shortcoming += errorPoints;
      }
    }
  }

  return new Fitness(magnitude, min(shortcoming, magnitude));
}

Fitness calcPkgFitness(Pubspec pubspec, DartPlatform pkgPlatform,
    Iterable<DartFileSummary> files, List<ToolProblem> toolIssues) {
  var magnitude = 0.0;
  var shortcoming = 0.0;
  for (var dfs in files) {
    if (dfs.isInLib && dfs.fitness != null) {
      magnitude += dfs.fitness.magnitude;
      shortcoming += dfs.fitness.shortcoming;
    }
  }
  magnitude = max(1.0, magnitude);

  // platform conflict means it is unlikely it can run in any environment
  if (pkgPlatform.hasConflict) {
    final platformError = max(20.0, magnitude * 0.20); // 20 %
    shortcoming += platformError;
  }

  // major tool errors are penalized in the percent of the total
  final toolErrorPoints = max(20.0, magnitude * 0.20); // 20%
  shortcoming += toolIssues.length * toolErrorPoints;

  // unconstrained dependencies are penalized in the percent of the total
  final unconstrainedErrorPoints = max(5.0, magnitude * 0.05); // 5%
  shortcoming +=
      pubspec.unconstrainedDependencies.length * unconstrainedErrorPoints;

  return new Fitness(magnitude, min(shortcoming, magnitude));
}

final _blockCommentRegExp = new RegExp(r'\/\*.*\*\/', multiLine: true);
final _lineCommentRegExp = new RegExp(r'\/\/.*$');
final _antiSemiColonRegExp = new RegExp(r'[^\;]');
