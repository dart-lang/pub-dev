// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PubSiteServiceRouter(PubSiteService service) {
  final router = Router();
  router.add('GET', '/liveness_check', service.livenessCheck);
  router.add('GET', '/readiness_check', service.readinessCheck);
  router.add('GET', '/api/packages/<package>', service.listVersions);
  router.add(
      'GET', '/api/packages/<package>/versions/<version>', service.versionInfo);
  router.add('GET', '/api/packages/<package>/versions/<version>.tar.gz',
      service.versionArchive);
  router.add('GET', '/packages/<package>/versions/<version>.tar.gz',
      service.versionArchive);
  router.add('GET', '/api/packages/versions/new', service.startUpload);
  router.add(
      'GET', '/api/packages/versions/newUploadFinish', service.finishUpload);
  router.add('POST', '/api/packages/<package>/uploaders', service.addUploader);
  router.add('DELETE', '/api/packages/<package>/uploaders/<email>',
      service.removeUploader);
  router.add('GET', '/', service.index);
  router.add('GET', '/flutter', service.flutter);
  router.add('GET', '/web', service.web);
  router.add('GET', '/packages', service.packages);
  router.add('GET', '/flutter/packages', service.flutterPackages);
  router.add('GET', '/web/packages', service.webPackages);
  router.add(
      'GET', '/packages/<package>/versions/<version>', service.packageVersion);
  router.add(
      'GET', '/packages/<package>/versions', service.packageVersionsJson);
  router.add('GET', '/packages/<package>.json', service.packageJson);
  router.add('GET', '/packages/<package>', service.package);
  router.add('GET', '/documentation/<package>/<version>/<path|[^]*>',
      service.documentation);
  router.add('GET', '/documentation/<package>/<version>',
      service.documentationVersion);
  router.add('GET', '/documentation/<package>/<version>/',
      service.documentationVersion);
  router.add('GET', '/documentation/<package>', service.documentationLatest);
  router.add('GET', '/documentation/<package>/', service.documentationLatest);
  router.add('GET', '/feed.atom', service.atomFeed);
  router.add('GET', '/help', service.helpPage);
  router.add('GET', '/robots.txt', service.robotsTxt);
  router.add('GET', '/sitemap.txt', service.sitemapTxt);
  router.add('GET', '/favicon.ico', service.staticAsset);
  router.add('GET', '/static/<path|[^]*>', service.staticAsset);
  router.add('GET', '/experimental', service.experimental);
  router.add('GET', '/oauth/callback', service.oauthCallback);
  router.add('GET', '/authorized', service.authorizationConfirmed);
  router.add('GET', '/admin/confirm/new-uploader/<package>/<email>/<nonce>',
      service.confirmUploader);
  router.add('GET', '/api/account/options/packages/<package>',
      service.accountPkgOptions);
  router.add('GET', '/api/documentation/<package>', service.apiDocumentation);
  router.add('GET', '/api/history', service.apiHistory);
  router.add('GET', '/api/packages', service.apiPackages);
  router.add(
      'GET', '/api/packages/<package>/metrics', service.apiPackageMetrics);
  router.add(
      'GET', '/api/packages/<package>/options', service.getPackageOptions);
  router.add(
      'PUT', '/api/packages/<package>/options', service.putPackageOptions);
  router.add('GET', '/api/search', service.apiSearch);
  router.add('GET', '/debug', service.debug);
  router.add('GET', '/packages.json', service.packagesJson);
  return router;
}
