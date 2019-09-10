// GENERATED CODE - DO NOT MODIFY BY HAND

part of pub_dartlang_org.handlers_redirects;

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PubDartlangOrgServiceRouter(PubDartlangOrgService service) {
  final router = Router();
  router.add('GET', r'/doc', service.doc);
  router.add('GET', r'/doc/<path|[^]*>', service.doc);
  router.add('GET', r'/server', service.server);
  router.add('GET', r'/flutter/plugins', service.flutterPlugins);
  router.add('GET', r'/server/packages', service.serverPackages);
  router.add('GET', r'/search', service.search);
  return router;
}

Router _$LegacyDartdocServiceRouter(LegacyDartdocService service) {
  final router = Router();
  router.add('GET', r'/', service.index);
  router.add('GET', r'/documentation', service.documentation);
  router.add('GET', r'/documentation/<path|[^]*>', service.documentation);
  router.all(r'/<_|.*>', service.catchAll);
  return router;
}
