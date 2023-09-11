// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/handlers.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../publisher/models.dart';
import '../../shared/handlers.dart';

import 'account.dart';
import 'atom_feed.dart';
import 'documentation.dart';
import 'landing.dart';
import 'listing.dart';
import 'misc.dart';
import 'package.dart';
import 'publisher.dart';

part 'routes.g.dart';

/// The main routes that are processed by the pub site's frontend.
class PubSiteService {
  Router get router => _$PubSiteServiceRouter(this);

  // ****
  // **** AppEngine health checks
  // ****

  @Route.get('/liveness_check')
  Future<Response> livenessCheck(Request request) async => htmlResponse('OK');

  @Route.get('/readiness_check')
  Future<Response> readinessCheck(Request request) async =>
      readinessCheckHandler(request);

  // ****
  // **** Landing pages
  // ****

  /// Site index
  @Route.get('/')
  Future<Response> index(Request request) => indexLandingHandler(request);

  @Route.get('/dart')
  Future<Response> dart(Request request) => dartLandingHandler(request);

  /// Flutter index
  @Route.get('/flutter')
  Future<Response> flutter(Request request) => flutterLandingHandler(request);

  /// Web index
  @Route.get('/web')
  Future<Response> web(Request request) => webLandingHandler(request);

  // ****
  // **** Listing pages
  // ****

  /// Default package listing page
  @Route.get('/packages')
  Future<Response> packages(Request request) => packagesHandlerHtml(request);

  @Route.get('/dart/packages')
  Future<Response> dartPackages(Request request) =>
      dartPackagesHandlerHtml(request);

  @Route.get('/flutter/packages')
  Future<Response> flutterPackages(Request request) =>
      flutterPackagesHandlerHtml(request);

  @Route.get('/flutter/favorites')
  Future<Response> flutterFavoritesPackages(Request request) =>
      flutterFavoritesPackagesHandlerHtml(request);

  @Route.get('/web/packages')
  Future<Response> webPackages(Request request) =>
      webPackagesHandlerHtml(request);

  // ****
  // **** Packages
  // ****

  @Route.get('/packages/<package>/versions/<version>/changelog')
  Future<Response> packageVersionChangelog(
          Request request, String package, String version) =>
      packageChangelogHandler(request, package, versionName: version);

  @Route.get('/packages/<package>/versions/<version>/example')
  Future<Response> packageVersionExample(
          Request request, String package, String version) =>
      packageExampleHandler(request, package, versionName: version);

  @Route.get('/packages/<package>/versions/<version>/install')
  Future<Response> packageVersionInstall(
          Request request, String package, String version) =>
      packageInstallHandler(request, package, versionName: version);

  @Route.get('/packages/<package>/versions/<version>/license')
  Future<Response> packageVersionLicense(
          Request request, String package, String version) =>
      packageLicenseHandler(request, package, versionName: version);

  @Route.get('/packages/<package>/versions/<version>/pubspec')
  Future<Response> packageVersionPubspec(
          Request request, String package, String version) =>
      packagePubspecHandler(request, package, versionName: version);

  @Route.get('/packages/<package>/versions/<version>/score')
  Future<Response> packageVersionScore(
          Request request, String package, String version) =>
      packageScoreHandler(request, package, versionName: version);

  @Route.get('/packages/<package>/versions/<version>')
  Future<Response> packageVersion(
          Request request, String package, String version) =>
      packageVersionHandlerHtml(request, package, versionName: version);

  @Route.get('/packages/<package>/admin')
  Future<Response> packageAdmin(Request request, String package) =>
      packageAdminHandler(request, package);

  @Route.get('/packages/<package>/activity-log')
  Future<Response> packageActivityLog(Request request, String package) =>
      packageActivityLogHandler(request, package);

  @Route.get('/packages/<package>/changelog')
  Future<Response> packageChangelog(Request request, String package) =>
      packageChangelogHandler(request, package);

  @Route.get('/packages/<package>/example')
  Future<Response> packageExample(Request request, String package) =>
      packageExampleHandler(request, package);

  @Route.get('/packages/<package>/install')
  Future<Response> packageInstall(Request request, String package) =>
      packageInstallHandler(request, package);

  @Route.get('/packages/<package>/license')
  Future<Response> packageLicense(Request request, String package) =>
      packageLicenseHandler(request, package);

  @Route.get('/packages/<package>/publisher')
  Future<Response> packagePublisher(Request request, String package) =>
      packagePublisherHandler(request, package);

  @Route.get('/packages/<package>/pubspec')
  Future<Response> packagePubspec(Request request, String package) =>
      packagePubspecHandler(request, package);

  @Route.get('/packages/<package>/score')
  Future<Response> packageScore(Request request, String package) =>
      packageScoreHandler(request, package);

  @Route.get('/packages/<package>/versions')
  Future<Response> packageVersions(Request request, String package) =>
      packageVersionsListHandler(request, package);

  @Route.get('/packages/<package>')
  Future<Response> package(Request request, String package) =>
      packageVersionHandlerHtml(request, package);

  @Route.get('/packages/<package>/versions/<version>/gen-res/<path|[^]*>')
  Future<Response> packageVersionGeneratedResources(
    Request request,
    String package,
    String version,
    String path,
  ) =>
      handleTaskResource(request, package, version, path);

  // ****
  // **** Documentation
  // ****

  @Route.get('/documentation/<package>/<version>/<path|[^]*>')
  Future<Response> documentation(
          Request request, String package, String version, String path) =>
      // TODO: pass in the [package] and [version] parameters, and maybe also the rest of the path.
      documentationHandler(request);

  @Route.get('/documentation/<package>/<version>')
  @Route.get('/documentation/<package>/<version>/')
  Future<Response> documentationVersion(
          Request request, String package, String version) =>
      // TODO: pass in the [package] and [version] parameters, and maybe also the rest of the path.
      documentationHandler(request);

  @Route.get('/documentation/<package>')
  @Route.get('/documentation/<package>/')
  Future<Response> documentationLatest(Request request, String package) =>
      // TODO: pass in the [package] parameter, or do redirect to /latest/ here
      documentationHandler(request);

  // ****
  // **** Publishers
  // ****

  /// Renders the page where users can start creating a publisher.
  @Route.get('/create-publisher')
  Future<Response> createPublisherPage(Request request) =>
      createPublisherPageHandler(request);

  /// Renders the list of publishers page.
  @Route.get('/publishers')
  Future<Response> publisherList(Request request) =>
      publisherListHandler(request);

  /// Renders the publisher page.
  @Route.get('/publishers/<publisherId>')
  Future<Response> publisherPage(Request request, String publisherId) =>
      publisherPageHandler(request, publisherId);

  /// Renders the publisher's packages page.
  @Route.get('/publishers/<publisherId>/packages')
  Future<Response> publisherPackagesPage(Request request, String publisherId) =>
      publisherPackagesPageHandler(request, publisherId,
          kind: PublisherPackagesPageKind.listed);

  /// Renders the publisher's packages page.
  @Route.get('/publishers/<publisherId>/unlisted-packages')
  Future<Response> publisherUnlistedPackagesPage(
          Request request, String publisherId) =>
      publisherPackagesPageHandler(request, publisherId,
          kind: PublisherPackagesPageKind.unlisted);

  /// Renders the publisher's admin page.
  @Route.get('/publishers/<publisherId>/admin')
  Future<Response> publisherAdminPage(Request request, String publisherId) =>
      publisherAdminPageHandler(request, publisherId);

  /// Renders the publisher's activity log page.
  @Route.get('/publishers/<publisherId>/activity-log')
  Future<Response> publisherActivityLogPage(
          Request request, String publisherId) =>
      publisherActivityLogPageHandler(request, publisherId);

  // ****
  // **** Site content and metadata
  // ****

  /// Renders the Atom XML feed
  @Route.get('/feed.atom')
  Future<Response> atomFeed(Request request) => atomFeedHandler(request);

  /// Renders the help page
  @Route.get('/help')
  Future<Response> helpPage(Request request) => helpPageHandler(request);

  /// Renders the help page for API
  @Route.get('/help/api')
  Future<Response> helpApiPage(Request request) => helpApiPageHandler(request);

  /// Renders the help page for scoring
  @Route.get('/help/scoring')
  Future<Response> helpPageScoring(Request request) =>
      helpPageScoringHandler(request);

  /// Renders the help page for search
  @Route.get('/help/search')
  Future<Response> helpPageSearch(Request request) =>
      helpPageSearchHandler(request);

  /// Renders the help page for publishing
  @Route.get('/help/publishing')
  Future<Response> helpPagePublishing(Request request) =>
      helpPagePublishingHandler(request);

  /// Renders the policy page
  @Route.get('/policy')
  Future<Response> policyPage(Request request) => policyPageHandler(request);

  /// Renders the /robots.txt page
  @Route.get('/robots.txt')
  Future<Response> robotsTxt(Request request) => robotsTxtHandler(request);

  /// Renders the security page
  @Route.get('/security')
  Future<Response> securityPage(Request request) =>
      securityPageHandler(request);

  /// Renders the /sitemap.txt page
  @Route.get('/sitemap.txt')
  Future<Response> sitemapTxt(Request request) => sitemapTxtHandler(request);

  /// Renders the /sitemap-2.txt page
  @Route.get('/sitemap-2.txt')
  Future<Response> sitemapPublishersTxt(Request request) =>
      sitemapPublishersTxtHandler(request);

  /// Renders the topics page
  @Route.get('/topics')
  Future<Response> topicsPage(Request request) => topicsPageHandler(request);

  /// Renders static assets
  @Route.get('/favicon.ico')
  @Route.get('/osd.xml')
  @Route.get('/static/<path|[^]*>')
  Future<Response> staticAsset(Request request) => staticsHandler(request);

  /// Controls the experimental cookie.
  @Route.get('/experimental')
  Future<Response> experimental(Request request) =>
      experimentalHandler(request);

  // ****
  // **** Account, authentication and user administration
  // ****

  /// Redirects user to the OAuth2 sign-in page.
  @Route.get('/sign-in')
  Future<Response> startSignIn(Request request) async =>
      startSignInHandler(request);

  /// Callback handler of the successful OAuth2 sign-in flow.
  @Route.get('/sign-in/complete')
  Future<Response> signInComplete(Request request) async =>
      signInCompleteHandler(request);

  /// List of the current user's packages.
  @Route.get('/my-packages')
  Future<Response> accountPackagesPage(Request request) async =>
      accountPackagesPageHandler(request);

  @Route.get('/my-liked-packages')
  Future<Response> accountMyLikedPackagesPage(Request request) async =>
      accountMyLikedPackagesPageHandler(request);

  /// List of the current user's publishers.
  @Route.get('/my-publishers')
  Future<Response> accountPublishersPage(Request request) async =>
      accountPublishersPageHandler(request);

  /// List of the current user's activity log.
  @Route.get('/my-activity-log')
  Future<Response> accountMyActivityLogPage(Request request) async =>
      accountMyActivityLogPageHandler(request);

  /// Renders the authorization confirmed page.
  @Route.get('/authorized')
  Future<Response> authorizationConfirmed(Request request) async =>
      authorizedHandler(request);

  /// Renders the page where an user can accept their invites/consents.
  @Route.get('/consent')
  Future<Response> consentPage(Request request) =>
      consentPageHandler(request, request.requestedUri.queryParameters['id']);

  // ****
  // **** Experimental task end-points
  // ****

  @Route.get('/experimental/task-log/<package>/<version>/')
  Future<Response> taskLog(
      Request request, String package, String version) async {
    checkPackageVersionParams(package, version);

    InvalidInputException.checkPackageName(package);
    version = InvalidInputException.checkSemanticVersion(version);

    if (!await packageBackend.isPackageVisible(package) ||
        (await packageBackend.lookupPackageVersion(package, version)) == null) {
      return Response.notFound('no such package');
    }

    final log = await taskBackend.taskLog(package, version);
    return Response.ok(
      log ?? 'no log',
      headers: {'content-type': 'plain/text'},
    );
  }

  @Route.get('/experimental/task-summary/<package>/<version>/')
  Future<Response> taskSummary(
      Request request, String package, String version) async {
    checkPackageVersionParams(package, version);

    InvalidInputException.checkPackageName(package);
    version = InvalidInputException.checkSemanticVersion(version);

    if (!await packageBackend.isPackageVisible(package) ||
        (await packageBackend.lookupPackageVersion(package, version)) == null) {
      return Response.notFound('no such package');
    }

    final summary = await taskBackend.panaSummary(package, version);

    return Response.ok(
      summary != null
          ? JsonEncoder.withIndent('  ').convert(summary.toJson())
          : 'no summary',
      headers: {'content-type': 'plain/text'},
    );
  }
}
