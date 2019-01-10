// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/models.dart';

class ScoreCardBackendMock implements ScoreCardBackend {
  @override
  Future<ScoreCardData> getScoreCardData(
      String packageName, String packageVersion,
      {bool onlyCurrent}) {
    return null;
  }

  @override
  Future<PackageStatus> getPackageStatus(String package, String version) {
    throw new UnimplementedError();
  }

  @override
  Future deleteOldEntries() {
    throw new UnimplementedError();
  }

  @override
  Future<Map<String, ReportData>> loadReports(
      String packageName, String packageVersion,
      {List<String> reportTypes, String runtimeVersion}) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> shouldUpdateReport(
      String packageName, String packageVersion, String reportType,
      {bool includeDiscontinued = false,
        bool includeObsolete = false,
        Duration successThreshold = const Duration(days: 30),
        Duration failureThreshold = const Duration(days: 1),
        DateTime updatedAfter}) {
    throw new UnimplementedError();
  }

  @override
  Future updateReport(
      String packageName, String packageVersion, ReportData data) {
    throw new UnimplementedError();
  }

  @override
  Future updateScoreCard(String packageName, String packageVersion) {
    throw new UnimplementedError();
  }
}
