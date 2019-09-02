// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../shared/handlers.dart';

import 'account.dart';
import 'admin.dart';
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
  final Handler _pubServerHandler;
  PubSiteService(this._pubServerHandler);

  Router get router => _$PubSiteServiceRouter(this);

  @Route.mount('/')
  Router get _api => PubApi(_pubServerHandler).router;

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

  @Route.get('/flutter/packages')
  Future<Response> flutterPackages(Request request) =>
      flutterPackagesHandlerHtml(request);

  @Route.get('/web/packages')
  Future<Response> webPackages(Request request) =>
      webPackagesHandlerHtml(request);

  // ****
  // **** Packages
  // ****

  @Route.get('/packages/<package>/versions/<version>')
  Future<Response> packageVersion(
          Request request, String package, String version) =>
      packageVersionHandlerHtml(request, package, versionName: version);

  @Route.get('/packages/<package>/admin')
  Future<Response> packageAdmin(Request request, String package) =>
      packageAdminHandler(request, package);

  @Route.get('/packages/<package>/versions')
  Future<Response> packageVersionsJson(Request request, String package) =>
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

  /// Renders the publisher page.
  @Route.get('/publishers/<publisherId>')
  Future<Response> publisherPage(Request request, String publisherId) =>
      publisherPageHandler(request, publisherId);

  // ****
  // **** Site content and metadata
  // ****

  /// Renders the Atom XML feed
  @Route.get('/feed.atom')
  Future<Response> atomFeed(Request request) => atomFeedHandler(request);

  /// Renders the help page
  @Route.get('/help')
  Future<Response> helpPage(Request request) => helpPageHandler(request);

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

  /// Process oauth callbacks.
  @Route.get('/oauth/callback')
  Future<Response> oauthCallback(Request request) async =>
      oauthCallbackHandler(request);

  /// Renders the authorization confirmed page.
  @Route.get('/authorized')
  Future<Response> authorizationConfirmed(Request request) async =>
      authorizedHandler(request);

  /// Renders the page that initiates the confirmation and then finalizes the uploader.
  @Route.get('/admin/confirm/new-uploader/<package>/<email>/<nonce>')
  Future<Response> confirmUploader(
          Request request, String package, String email, String nonce) =>
      confirmNewUploaderHandler(request, package, email, nonce);

  /// Renders the page where an user can accept their invites/consents.
  @Route.get('/consent')
  Future<Response> consentPage(Request request) => consentPageHandler(request);
}
