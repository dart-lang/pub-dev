// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:pana/pana.dart' show Summary;

part 'pana_report.g.dart';

/// JSON report pana reported stored by `pub_worker.dart`.
@JsonSerializable()
class PanaReport {
  /// Identifier for the log file matching this pana report.
  final String logId;

  /// Pana summary (output from pana)
  ///
  /// This may be `null` if analysis failed, in this case `logId` should still
  /// point to a log with some information about why the analysis failed.
  final Summary? summary;

  // json_serializable boiler-plate
  PanaReport({
    required this.logId,
    required this.summary,
  });
  factory PanaReport.fromJson(Map<String, dynamic> json) =>
      _$PanaReportFromJson(json);
  Map<String, dynamic> toJson() => _$PanaReportToJson(this);
}
