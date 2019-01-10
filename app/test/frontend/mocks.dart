// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dartlang_org/dartdoc/models.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_service.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

class BackendMock implements Backend {
  final Function newestPackagesFun;
  final Function latestPackageVersionsFun;
  final Function latestPackagesFun;
  final Function lookupLatestVersionsFun;
  final Function lookupPackageFun;
  final Function lookupPackageVersionFun;
  final Function versionsOfPackageFun;
  final Function downloadUrlFun;
  final Function updatePackageInviteFn;

  BackendMock({
    this.newestPackagesFun,
    this.latestPackageVersionsFun,
    this.latestPackagesFun,
    this.lookupLatestVersionsFun,
    this.lookupPackageFun,
    this.lookupPackageVersionFun,
    this.versionsOfPackageFun,
    this.downloadUrlFun,
    this.updatePackageInviteFn,
  });

  @override
  // ignore: always_declare_return_types
  get db => throw new Exception('unexpected db access');

  @override
  // ignore: always_declare_return_types
  get repository => throw new Exception('unexpected repository access');

  @override
  // ignore: always_declare_return_types
  get uiPackageCache => null;

  @override
  Future<List<Package>> newestPackages({int offset, int limit}) async {
    if (newestPackagesFun == null) {
      throw new Exception('no newestPackagesFun');
    }
    return ((await newestPackagesFun(offset: offset, limit: limit)) as List)
        .cast<Package>();
  }

  @override
  Stream<String> allPackageNames(
      {DateTime updatedSince, bool excludeDiscontinued = false}) {
    throw new UnsupportedError('sorry!');
  }

  @override
  Future<List<PackageVersion>> latestPackageVersions(
      {int offset, int limit, bool devVersions = false}) async {
    if (latestPackageVersionsFun == null) {
      throw new Exception('no latestPackageVersionsFun');
    }
    return ((await latestPackageVersionsFun(offset: offset, limit: limit))
            as List)
        .cast<PackageVersion>();
  }

  @override
  Future<List<Package>> latestPackages(
      {int offset, int limit, String detectedType}) async {
    if (latestPackagesFun == null) {
      throw new Exception('no latestPackagesFun');
    }
    return ((await latestPackagesFun(
            offset: offset, limit: limit, detectedType: detectedType)) as List)
        .cast<Package>();
  }

  @override
  Future<List<PackageVersion>> lookupLatestVersions(List<Package> packages,
      {bool devVersions = false}) async {
    if (lookupLatestVersionsFun == null) {
      throw new Exception('no lookupLatestVersionsFun');
    }
    return ((await lookupLatestVersionsFun(packages)) as List)
        .cast<PackageVersion>();
  }

  @override
  Future<Package> lookupPackage(String packageName) async {
    if (lookupPackageFun == null) {
      throw new Exception('no lookupPackageFun');
    }
    return (await lookupPackageFun(packageName)) as Package;
  }

  @override
  Future<List<Package>> lookupPackages(Iterable<String> packageNames) {
    return Future.wait(packageNames.map(lookupPackage));
  }

  @override
  Future<PackageVersion> lookupPackageVersion(
      String package, String version) async {
    if (lookupPackageVersionFun == null) {
      throw new Exception('no lookupPackageVersionFun');
    }
    return (await lookupPackageVersionFun(package, version)) as PackageVersion;
  }

  @override
  Future<List<PackageVersion>> versionsOfPackage(String packageName) async {
    if (versionsOfPackageFun == null) {
      throw new Exception('no versionsOfPackageFun');
    }
    return ((await versionsOfPackageFun(packageName)) as List)
        .cast<PackageVersion>();
  }

  @override
  Future<Uri> downloadUrl(String package, String version) async {
    if (downloadUrlFun == null) {
      throw new Exception('no downloadUrlFun');
    }
    return (await downloadUrlFun(package, version)) as Uri;
  }

  @override
  Future<PackageInvite> confirmPackageInvite({
    String packageName,
    String type,
    String recipientEmail,
    String urlNonce,
  }) {
    throw new UnimplementedError();
  }

  @override
  Future<InviteStatus> updatePackageInvite({
    String packageName,
    String type,
    String recipientEmail,
    String fromEmail,
  }) async {
    if (updatePackageInviteFn == null) {
      throw new Exception('no downloadUrlFun');
    }
    return (await updatePackageInviteFn(
      packageName: packageName,
      type: type,
      recipientEmail: recipientEmail,
      fromEmail: fromEmail,
    )) as InviteStatus;
  }

  @override
  Future deleteObsoleteInvites() {
    throw new UnimplementedError();
  }
}

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

class AnalyzerClientMock implements AnalyzerClient {
  AnalysisView mockAnalysisView;

  @override
  Future close() async => null;

  @override
  Future<AnalysisView> getAnalysisView(AnalysisKey key) async =>
      mockAnalysisView;

  @override
  Future<List<AnalysisView>> getAnalysisViews(Iterable<AnalysisKey> keys) =>
      Future.wait(keys.map(getAnalysisView));

  @override
  Future triggerAnalysis(
      String package, String version, Set<String> dependentPackages) async {}
}

class DartdocClientMock implements DartdocClient {
  @override
  Future<DartdocEntry> getEntry(String package, String version) async {
    return null;
  }

  @override
  Future<List<DartdocEntry>> getEntries(
      String package, List<String> versions) async {
    return versions.map((s) => null).toList();
  }

  @override
  Future triggerDartdoc(
      String package, String version, Set<String> dependentPackages) async {}

  @override
  Future close() async {}

  @override
  Future<String> getTextContent(
      String package, String version, String relativePath,
      {Duration timeout}) async {
    return null;
  }
}

class SearchClientMock implements SearchClient {
  final Function searchFun;
  SearchClientMock({this.searchFun});

  @override
  Future<PackageSearchResult> search(SearchQuery query) async {
    if (searchFun == null) {
      throw new Exception('no searchFun');
    }
    return (await searchFun(query)) as PackageSearchResult;
  }

  @override
  Future triggerReindex(String package, String version) async {}

  @override
  Future close() async {}
}

class SearchServiceMock implements SearchService {
  final Function searchFun;

  SearchServiceMock(this.searchFun);

  @override
  Future<SearchResultPage> search(SearchQuery query) async {
    return (await searchFun(query)) as SearchResultPage;
  }

  @override
  Future close() async => null;
}
