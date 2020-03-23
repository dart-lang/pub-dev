// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PubSiteServiceRouter(PubSiteService service) {
  final router = Router();
  router.mount(r'/', service._api);
  router.add('GET', r'/liveness_check', service.livenessCheck);
  router.add('GET', r'/readiness_check', service.readinessCheck);
  router.add('GET', r'/', service.index);
  router.add('GET', r'/dart', service.dart);
  router.add('GET', r'/flutter', service.flutter);
  router.add('GET', r'/web', service.web);
  router.add('GET', r'/packages', service.packages);
  router.add('GET', r'/dart/packages', service.dartPackages);
  router.add('GET', r'/flutter/packages', service.flutterPackages);
  router.add('GET', r'/flutter/favorites', service.flutterFavoritesPackages);
  router.add('GET', r'/web/packages', service.webPackages);
  router.add('GET', r'/packages/<package>/versions/<version>/changelog',
      service.packageVersionChangelog);
  router.add('GET', r'/packages/<package>/versions/<version>/example',
      service.packageVersionExample);
  router.add('GET', r'/packages/<package>/versions/<version>/install',
      service.packageVersionInstall);
  router.add('GET', r'/packages/<package>/versions/<version>/score',
      service.packageVersionScore);
  router.add(
      'GET', r'/packages/<package>/versions/<version>', service.packageVersion);
  router.add('GET', r'/packages/<package>/admin', service.packageAdmin);
  router.add('GET', r'/packages/<package>/changelog', service.packageChangelog);
  router.add('GET', r'/packages/<package>/example', service.packageExample);
  router.add('GET', r'/packages/<package>/install', service.packageInstall);
  router.add('GET', r'/packages/<package>/score', service.packageScore);
  router.add('GET', r'/packages/<package>/versions', service.packageVersions);
  router.add('GET', r'/packages/<package>', service.package);
  router.add('GET', r'/documentation/<package>/<version>/<path|[^]*>',
      service.documentation);
  router.add('GET', r'/documentation/<package>/<version>',
      service.documentationVersion);
  router.add('GET', r'/documentation/<package>/<version>/',
      service.documentationVersion);
  router.add('GET', r'/documentation/<package>', service.documentationLatest);
  router.add('GET', r'/documentation/<package>/', service.documentationLatest);
  router.add('GET', r'/create-publisher', service.createPublisherPage);
  router.add('GET', r'/publishers', service.publisherList);
  router.add('GET', r'/publishers/<publisherId>', service.publisherPage);
  router.add('GET', r'/publishers/<publisherId>/packages',
      service.publisherPackagesPage);
  router.add(
      'GET', r'/publishers/<publisherId>/admin', service.publisherAdminPage);
  router.add('GET', r'/feed.atom', service.atomFeed);
  router.add('GET', r'/help', service.helpPage);
  router.add('GET', r'/policy', service.policyPage);
  router.add('GET', r'/robots.txt', service.robotsTxt);
  router.add('GET', r'/security', service.securityPage);
  router.add('GET', r'/sitemap.txt', service.sitemapTxt);
  router.add('GET', r'/sitemap-2.txt', service.sitemapPublishersTxt);
  router.add('GET', r'/favicon.ico', service.staticAsset);
  router.add('GET', r'/static/<path|[^]*>', service.staticAsset);
  router.add('GET', r'/experimental', service.experimental);
  router.add('GET', r'/my-packages', service.accountPackagesPage);
  router.add('GET', r'/my-liked-packages', service.accountMyLikedPackagesPage);
  router.add('GET', r'/my-publishers', service.accountPublishersPage);
  router.add('GET', r'/authorized', service.authorizationConfirmed);
  router.add('GET', r'/consent', service.consentPage);
  return router;
}
