// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../shared/handlers.dart';

import 'account.dart';
import 'admin.dart';
import 'atom_feed.dart';
import 'custom_api.dart';
import 'documentation.dart';
import 'landing.dart';
import 'listing.dart';
import 'misc.dart';
import 'package.dart';

part 'routes.g.dart';

/// The main routes that are processed by the pub site's frontend.
class PubSiteService {
  final Handler _pubServerHandler;
  PubSiteService(this._pubServerHandler);

  Router get router => _$PubSiteServiceRouter(this);

  // ****
  // **** pub client APIs
  // ****

  /// Getting information about all versions of a package.
  ///
  /// GET /api/packages/<package-name>
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L28-L49
  @Route.get('/api/packages/<package>')
  Future<Response> listVersions(Request request, String package) async =>
      _pubServerHandler(request);

  /// Getting information about a specific (package, version) pair.
  ///
  /// GET /api/packages/<package-name>/versions/<version-name>
  ///
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L51-L65
  @Route.get('/api/packages/<package>/versions/<version>')
  Future<Response> versionInfo(
          Request request, String package, String version) async =>
      _pubServerHandler(request);

  /// Downloading package.
  ///
  /// GET /api/packages/<package-name>/versions/<version-name>.tar.gz
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L67-L75
  @Route.get('/api/packages/<package>/versions/<version>.tar.gz')
  @Route.get('/packages/<package>/versions/<version>.tar.gz')
  Future<Response> versionArchive(
          Request request, String package, String version) async =>
      _pubServerHandler(request);

  /// Start async upload.
  ///
  /// GET /api/packages/versions/new
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L77-L107
  @Route.get('/api/packages/versions/new')
  Future<Response> startUpload(Request request) async =>
      _pubServerHandler(request);

  /// Finish async upload.
  ///
  /// GET /api/packages/versions/newUploadFinish
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L77-L107
  @Route.get('/api/packages/versions/newUploadFinish')
  Future<Response> finishUpload(Request request) async =>
      _pubServerHandler(request);

  /// Adding a new uploader
  ///
  /// POST /api/packages/<package-name>/uploaders
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L109-L116
  @Route.post('/api/packages/<package>/uploaders')
  Future<Response> addUploader(Request request, String package) async =>
      _pubServerHandler(request);

  /// Removing an existing uploader.
  ///
  /// DELETE /api/packages/<package-name>/uploaders/<uploader-email>
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L118-L123
  @Route.delete('/api/packages/<package>/uploaders/<email>')
  Future<Response> removeUploader(
          Request request, String package, String email) async =>
      _pubServerHandler(request);

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

  /// (Old) server index redirect
  @Route.get('/server')
  Future<Response> server(Request request) async => redirectResponse('/');

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

  /// (Old) Flutter plugins redirect
  @Route.get('/flutter/plugins')
  Future<Response> flutterPlugins(Request request) async =>
      redirectResponse('/flutter/packages');

  /// (Old) Server packages redirect
  @Route.get('/server/packages')
  Future<Response> serverPackages(Request request) async => redirectResponse(
      request.requestedUri.replace(path: '/packages').toString());

  /// (Old) Search redirect
  @Route.get('/search')
  Future<Response> search(Request request) async => redirectResponse(
      request.requestedUri.replace(path: '/packages').toString());

  // ****
  // **** Packages
  // ****

  @Route.get('/packages/<package>/versions/<version>')
  Future<Response> packageVersion(
          Request request, String package, String version) =>
      packageVersionHandlerHtml(request, package, versionName: version);

  @Route.get('/packages/<package>/versions')
  Future<Response> packageVersionsJson(Request request, String package) =>
      packageVersionsListHandler(request, package);

  @Route.get('/packages/<package>.json')
  Future<Response> packageJson(Request request, String package) =>
      packageShowHandlerJson(request, package);

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

  /// Renders the /sitemap.txt page
  @Route.get('/sitemap.txt')
  Future<Response> sitemapTxt(Request request) => siteMapTxtHandler(request);

  /// Renders static assets
  @Route.get('/static/<path|[^]*>')
  Future<Response> staticAsset(Request request, String path) {
    // TODO: pass-in the [path] parameter
    return staticsHandler(request);
  }

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

  // ****
  // **** Custom API
  // ****

  @Route.get('/api/account/info')
  Future<Response> accountV1Info(Request request) => accountV1InfoHandler(request);

  @Route.get('/api/documentation/<package>')
  Future<Response> apiDocumentation(Request request, String package) =>
      apiDocumentationHandler(request, package);

  /// Exposes History entities.
  ///
  /// NOTE: experimental, do not rely on it
  @Route.get('/api/history')
  Future<Response> apiHistory(Request request) => apiHistoryHandler(request);

  @Route.get('/api/packages')
  Future<Response> apiPackages(Request request) async {
    if (request.requestedUri.queryParameters['compact'] == '1') {
      return apiPackagesCompactListHandler(request);
    } else {
      // /api/packages?page=<num>
      return apiPackagesHandler(request);
    }
  }

  @Route.get('/api/packages/<package>/metrics')
  Future<Response> apiPackageMetrics(Request request, String package) =>
      apiPackageMetricsHandler(request, package);

  @Route.get('/api/search')
  Future<Response> apiSearch(Request request) => apiSearchHandler(request);

  @Route.get('/debug')
  Future<Response> debug(Request request) async => debugResponse({
        'package': packageDebugStats(),
        'search': searchDebugStats(),
      });

  @Route.get('/packages.json')
  Future<Response> packagesJson(Request request) => packagesHandler(request);
}
