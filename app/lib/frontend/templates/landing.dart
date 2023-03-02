// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/models.dart';
import '../../package/models.dart' show PackageView;
import '../../service/youtube/backend.dart' show PkgOfWeekVideo;

import 'layout.dart';
import 'views/landing/page.dart';

/// Renders the landing page template.
String renderLandingPage({
  List<PackageView>? ffPackages,
  List<PackageView>? mostPopularPackages,
  List<PackageView>? topFlutterPackages,
  List<PackageView>? topDartPackages,
  List<PkgOfWeekVideo>? topPoWVideos,
  required SessionData? sessionData,
}) {
  final content = landingPageNode(
    ffPackages: ffPackages,
    mostPopularPackages: mostPopularPackages,
    topFlutterPackages: topFlutterPackages,
    topDartPackages: topDartPackages,
    topPoWVideos: topPoWVideos,
  );
  return renderLayoutPage(
    PageType.landing,
    content,
    title: 'Dart packages',
    canonicalUrl: '/',
    mainClasses: ['landing-main'],
    sessionData: sessionData,
  );
}
