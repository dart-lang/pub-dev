// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../shared/handlers.dart';

import 'account.dart';
import 'atom_feed.dart';
import 'documentation.dart';
import 'landing.dart';
import 'listing.dart';
import 'misc.dart';
import 'package.dart';
import 'pubapi.dart' show PubApi;
import 'publisher.dart';

part 'routes.g.dart';

/// The main routes that are processed by the pub site's frontend.
class PubSiteService {
  Router get router => _$PubSiteServiceRouter(this);

  @Route.mount('/')
  Router get _api => PubApi().router;

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

  @Route.get('/packages/<package>/changelog')
  Future<Response> packageChangelog(Request request, String package) =>
      packageChangelogHandler(request, package);

  @Route.get('/packages/<package>/example')
  Future<Response> packageExample(Request request, String package) =>
      packageExampleHandler(request, package);

  @Route.get('/packages/<package>/install')
  Future<Response> packageInstall(Request request, String package) =>
      packageInstallHandler(request, package);

  @Route.get('/packages/<package>/score')
  Future<Response> packageScore(Request request, String package) =>
      packageScoreHandler(request, package);

  @Route.get('/packages/<package>/versions')
  Future<Response> packageVersions(Request request, String package) =>
      packageVersionsListHandler(request, package);

  @Route.get('/packages/<package>')
  Future<Response> package(Request request, String package) =>
      packageVersionHandlerHtml(request, package);

  // ****
  // **** Documentation
  // ****

  @Route.get('/documentation/<package>/<version>/<path|[^]*>')
  Future<Response> documentation(
          Request request, String package, String version, String path) =>
      // TODO: pass in the [package] and [version] parameters, and maybe also the rest of the path.
      // TODO: investigate if _originalRequest is still needed
      documentationHandler(
          request.context['_originalRequest'] as Request ?? request);

  @Route.get('/documentation/<package>/<version>')
  @Route.get('/documentation/<package>/<version>/')
  Future<Response> documentationVersion(
          Request request, String package, String version) =>
      // TODO: pass in the [package] and [version] parameters, and maybe also the rest of the path.
      // TODO: investigate if _originalRequest is still needed
      documentationHandler(
          request.context['_originalRequest'] as Request ?? request);

  @Route.get('/documentation/<package>')
  @Route.get('/documentation/<package>/')
  Future<Response> documentationLatest(Request request, String package) =>
      // TODO: pass in the [package] parameter, or do redirect to /latest/ here
      // TODO: investigate if _originalRequest is still needed
      documentationHandler(
          request.context['_originalRequest'] as Request ?? request);

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
      publisherPackagesPageHandler(request, publisherId);

  /// Renders the publisher's admin page.
  @Route.get('/publishers/<publisherId>/admin')
  Future<Response> publisherAdminPage(Request request, String publisherId) =>
      publisherAdminPageHandler(request, publisherId);

  // ****
  // **** Site content and metadata
  // ****

  /// Renders the Atom XML feed
  @Route.get('/feed.atom')
  Future<Response> atomFeed(Request request) => atomFeedHandler(request);

  /// Renders the help page
  @Route.get('/help')
  Future<Response> helpPage(Request request) => helpPageHandler(request);

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
  Future<Response> sitemapTxt(Request request) => siteMapTxtHandler(request);

  /// Renders the /sitemap-2.txt page
  @Route.get('/sitemap-2.txt')
  Future<Response> sitemapPublishersTxt(Request request) =>
      sitemapPublishersTxtHandler(request);

  /// Renders static assets
  @Route.get('/favicon.ico')
  @Route.get('/static/<path|[^]*>')
  Future<Response> staticAsset(Request request) => staticsHandler(request);

  /// Controls the experimental cookie.
  @Route.get('/experimental')
  Future<Response> experimental(Request request) =>
      experimentalHandler(request);

  // ****
  // **** Account, authentication and user administration
  // ****

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

  /// Renders the authorization confirmed page.
  @Route.get('/authorized')
  Future<Response> authorizationConfirmed(Request request) async =>
      authorizedHandler(request);

  /// Renders the page where an user can accept their invites/consents.
  @Route.get('/consent')
  Future<Response> consentPage(Request request) =>
      consentPageHandler(request, request.requestedUri.queryParameters['id']);
}
