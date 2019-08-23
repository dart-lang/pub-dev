// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PubSiteServiceRouter(PubSiteService service) {
  final router = Router();
  router.mount('/', service._api);
  router.add('GET', '/liveness_check', service.livenessCheck);
  router.add('GET', '/readiness_check', service.readinessCheck);
  router.add('GET', '/', service.index);
  router.add('GET', '/flutter', service.flutter);
  router.add('GET', '/web', service.web);
  router.add('GET', '/packages', service.packages);
  router.add('GET', '/flutter/packages', service.flutterPackages);
  router.add('GET', '/web/packages', service.webPackages);
  router.add(
      'GET', '/packages/<package>/versions/<version>', service.packageVersion);
  router.add('GET', '/packages/<package>/admin', service.packageAdmin);
  router.add(
      'GET', '/packages/<package>/versions', service.packageVersionsJson);
  router.add('GET', '/packages/<package>', service.package);
  router.add('GET', '/documentation/<package>/<version>/<path|[^]*>',
      service.documentation);
  router.add('GET', '/documentation/<package>/<version>',
      service.documentationVersion);
  router.add('GET', '/documentation/<package>/<version>/',
      service.documentationVersion);
  router.add('GET', '/documentation/<package>', service.documentationLatest);
  router.add('GET', '/documentation/<package>/', service.documentationLatest);
  router.add('GET', '/create-publisher', service.createPublisherPage);
  router.add('GET', '/feed.atom', service.atomFeed);
  router.add('GET', '/help', service.helpPage);
  router.add('GET', '/robots.txt', service.robotsTxt);
  router.add('GET', '/security', service.securityPage);
  router.add('GET', '/sitemap.txt', service.sitemapTxt);
  router.add('GET', '/favicon.ico', service.staticAsset);
  router.add('GET', '/static/<path|[^]*>', service.staticAsset);
  router.add('GET', '/experimental', service.experimental);
  router.add('GET', '/oauth/callback', service.oauthCallback);
  router.add('GET', '/authorized', service.authorizationConfirmed);
  router.add('GET', '/admin/confirm/new-uploader/<package>/<email>/<nonce>',
      service.confirmUploader);
  router.add('GET', '/consent', service.consentPage);
  return router;
}
