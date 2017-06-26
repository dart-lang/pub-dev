// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

/// These status codes mark the status of the analysis, not the result/report.
enum AnalysisStatus {
  /// Analysis was aborted without a report.
  /// Probably an issue with pana or an unhandled edge case.
  aborted,

  /// Analysis was completed but there are missing parts.
  /// One or more tools failed to produce the expected output.
  failure,

  /// Analysis was completed without issues.
  success,
}

Codec<AnalysisStatus, String> analysisStatusCodec = new _AnalysisStatusCodec();

/// The data which is served thought the HTTP interface of the analyzer service.
class AnalysisData {
  final String packageName;
  final String packageVersion;
  final int analysis;
  final DateTime timestamp;
  final String analysisVersion;
  final AnalysisStatus analysisStatus;
  final Map analysisContent;

  AnalysisData({
    this.packageName,
    this.packageVersion,
    this.analysis,
    this.timestamp,
    this.analysisVersion,
    this.analysisStatus,
    this.analysisContent,
  });

  factory AnalysisData.fromJson(Map json) {
    return new AnalysisData(
      packageName: json['packageName'],
      packageVersion: json['packageVersion'],
      analysis: json['analysis'],
      timestamp:
          json['timestamp'] == null ? null : DateTime.parse(json['timestamp']),
      analysisVersion: json['analysisVersion'],
      analysisStatus: analysisStatusCodec.decode(json['analysisStatus']),
      analysisContent: json['analysisContent'],
    );
  }

  Map toJson() => {
        'packageName': packageName,
        'packageVersion': packageVersion,
        'analysis': analysis,
        'timestamp': timestamp?.toIso8601String(),
        'analysisVersion': analysisVersion,
        'analysisStatus': analysisStatusCodec.encode(analysisStatus),
        'analysisContent': analysisContent,
      };
}

class _AnalysisStatusCodec extends Codec<AnalysisStatus, String> {
  @override
  final Converter<String, AnalysisStatus> decoder =
      new _AnalysisStatusDecoder();

  @override
  final Converter<AnalysisStatus, String> encoder =
      new _AnalysisStatusEncoder();
}

class _AnalysisStatusEncoder extends Converter<AnalysisStatus, String> {
  @override
  String convert(AnalysisStatus input) {
    if (input == null) return null;
    switch (input) {
      case AnalysisStatus.aborted:
        return 'aborted';
      case AnalysisStatus.failure:
        return 'failure';
      case AnalysisStatus.success:
        return 'success';
      default:
        throw new Exception('Unable to encode AnalysisStatus: $input');
    }
  }
}

class _AnalysisStatusDecoder extends Converter<String, AnalysisStatus> {
  @override
  AnalysisStatus convert(String input) {
    if (input == null) return null;
    switch (input) {
      case 'aborted':
        return AnalysisStatus.aborted;
      case 'failure':
        return AnalysisStatus.failure;
      case 'success':
        return AnalysisStatus.success;
      default:
        throw new Exception('Unable to decode AnalysisStatus: $input');
    }
  }
}
