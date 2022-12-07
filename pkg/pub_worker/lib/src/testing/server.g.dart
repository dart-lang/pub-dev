// GENERATED CODE - DO NOT MODIFY BY HAND

part of server;

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PubWorkerTestServerRouter(PubWorkerTestServer service) {
  final router = Router();
  router.add(
    'GET',
    r'/api/packages/<package>',
    service._listPackageVersions,
  );
  router.add(
    'GET',
    r'/api/packages/<package>/versions/<version>.tar.gz',
    service._downloadPackage,
  );
  router.add(
    'POST',
    r'/api/tasks/<package>/<version>/upload',
    service._taskUploadUrls,
  );
  router.add(
    'POST',
    r'/api/tasks/<package>/<version>/finished',
    service._reportTaskFinished,
  );
  router.add(
    'POST',
    r'/upload-result/<package>/<version>/<name>',
    service._uploadResult,
  );
  return router;
}
