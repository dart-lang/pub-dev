// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pana.code_problem;

import 'package:path/path.dart' as p;
import 'package:quiver/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'code_problem.g.dart';

@JsonSerializable()
class CodeProblem extends Object
    with _$CodeProblemSerializerMixin
    implements Comparable<CodeProblem> {
  static final _regexp = new RegExp('^' + // beginning of line
          '([\\w_\\.]+)\\|' * 3 + // first three error notes
          '([^\\|]+)\\|' + // file path
          '([\\w_\\.]+)\\|' * 3 + // line, column, length
          '(.*?)' + // rest is the error message
          '\$' // end of line
      );

  final String severity;
  final String errorType;
  final String errorCode;

  final String file;
  final int line;
  final int col;
  final String description;

  CodeProblem(this.severity, this.errorType, this.errorCode, this.description,
      this.file, this.line, this.col);

  static CodeProblem parse(String content, {String projectDir}) {
    if (content.isEmpty) {
      throw new ArgumentError('Provided content is empty.');
    }
    var matches = _regexp.allMatches(content).toList();

    if (matches.isEmpty) {
      if (content.endsWith(" is a part and cannot be analyzed.")) {
        var filePath = content.split(' ').first;

        content = content.replaceAll(filePath, '').trim();

        if (projectDir != null) {
          assert(p.isWithin(projectDir, filePath));
          filePath = p.relative(filePath, from: projectDir);
        }

        return new CodeProblem(
            'WEIRD', 'UNKNOWN', 'UNKNOWN', content, filePath, 0, 0);
      }

      if (content == "Please pass in a library that contains this part.") {
        return null;
      }

      throw new ArgumentError(
          'Provided content does not align with expectations.\n`$content`');
    }

    var match = matches.single;

    var severity = match[1];
    var errorType = match[2];
    var errorCode = match[3];

    var filePath = match[4];
    var line = match[5];
    var column = match[6];
    // length = 7
    var description = match[8];

    if (projectDir != null) {
      assert(p.isWithin(projectDir, filePath));
      filePath = p.relative(filePath, from: projectDir);
    }

    return new CodeProblem(severity, errorType, errorCode, description,
        filePath, int.parse(line), int.parse(column));
  }

  factory CodeProblem.fromJson(Map<String, dynamic> json) =>
      _$CodeProblemFromJson(json);

  bool get isError => severity?.toUpperCase() == 'ERROR';

  @override
  int compareTo(CodeProblem other) {
    var myVals = _values;
    var otherVals = other._values;
    for (var i = 0; i < myVals.length; i++) {
      var compare = (_values[i] as Comparable).compareTo(otherVals[i]);

      if (compare != 0) {
        return compare;
      }
    }

    assert(this == other);

    return 0;
  }

  @override
  int get hashCode => hashObjects(_values);

  @override
  bool operator ==(Object other) {
    if (other is CodeProblem) {
      var myVals = _values;
      var otherVals = other._values;
      for (var i = 0; i < myVals.length; i++) {
        if (myVals[i] != otherVals[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  List<Object> get _values =>
      [file, line, col, severity, errorType, errorCode, description];
}
