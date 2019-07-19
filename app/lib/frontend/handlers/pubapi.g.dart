// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pubapi.dart';

// **************************************************************************
// ApiRouterGenerator
// **************************************************************************

Router _$PubApiRouter(PubApi service) {
  final router = Router();
  router.add('GET', r'/api/packages/<package>',
      (Request request, String package) async {
    try {
      final _$result = await service.listVersions(request, package);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/packages/<package>/versions/<version>',
      (Request request, String package, String version) async {
    try {
      final _$result = await service.versionInfo(request, package, version);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/packages/<package>/versions/<version>.tar.gz',
      (Request request, String package, String version) async {
    try {
      final _$result = await service.versionArchive(request, package, version);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/packages/<package>/versions/<version>.tar.gz',
      (Request request, String package, String version) async {
    try {
      final _$result = await service.versionArchive(request, package, version);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/packages/versions/new', (Request request) async {
    try {
      final _$result = await service.startUpload(request);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/packages/versions/newUploadFinish',
      (Request request) async {
    try {
      final _$result = await service.finishUpload(request);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('POST', r'/api/packages/<package>/uploaders',
      (Request request, String package) async {
    try {
      final _$result = await service.addUploader(request, package);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('DELETE', r'/api/packages/<package>/uploaders/<email>',
      (Request request, String package, String email) async {
    try {
      final _$result = await service.removeUploader(request, package, email);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('POST', r'/api/publisher/<publisherId>',
      (Request request, String publisherId) async {
    try {
      final _$result = await service.createPublisherApi(request, publisherId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/publisher/<publisherId>',
      (Request request, String publisherId) async {
    try {
      final _$result = await service.getPublisherApi(request, publisherId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('PUT', r'/api/publisher/<publisherId>',
      (Request request, String publisherId) async {
    try {
      final _$result = await service.updatePublisherApi(request, publisherId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('POST', r'/api/publisher/<publisherId>/invite-member',
      (Request request, String publisherId) async {
    try {
      final _$result =
          await service.invitePublisherMember(request, publisherId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/publisher/<publisherId>/members',
      (Request request, String publisherId) async {
    try {
      final _$result =
          await service.getPublisherMembersApi(request, publisherId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/publisher/<publisherId>/members/<userId>',
      (Request request, String publisherId, String userId) async {
    try {
      final _$result =
          await service.getPublisherMemberDataApi(request, publisherId, userId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('PUT', r'/api/publisher/<publisherId>/members/<userId>',
      (Request request, String publisherId, String userId) async {
    try {
      final _$result =
          await service.putPublisherMemberDataApi(request, publisherId, userId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('DELETE', r'/api/publisher/<publisherId>/members/<userId>',
      (Request request, String publisherId, String userId) async {
    try {
      final _$result = await service.deletePublisherMemberDataApi(
          request, publisherId, userId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/account/consent/<consentId>',
      (Request request, String consentId) async {
    try {
      final _$result = await service.getAccountConsent(request, consentId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('PUT', r'/api/account/consent/<consentId>',
      (Request request, String consentId) async {
    try {
      final _$result = await service.putAccountConsent(request, consentId);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/account/options/packages/<package>',
      (Request request, String package) async {
    try {
      final _$result = await service.accountPkgOptions(request, package);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/documentation/<package>',
      (Request request, String package) async {
    try {
      final _$result = await service.apiDocumentation(request, package);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/history', (Request request) async {
    try {
      final _$result = await service.apiHistory(request);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/packages', (Request request) async {
    try {
      final _$result = await service.apiPackages(request);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/packages/<package>/metrics',
      (Request request, String package) async {
    try {
      final _$result = await service.apiPackageMetrics(request, package);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/packages/<package>/options',
      (Request request, String package) async {
    try {
      final _$result = await service.getPackageOptions(request, package);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('PUT', r'/api/packages/<package>/options',
      (Request request, String package) async {
    try {
      final _$result = await service.putPackageOptions(request, package);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/api/search', (Request request) async {
    try {
      final _$result = await service.apiSearch(request);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/debug', (Request request) async {
    try {
      final _$result = await service.debug(request);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  router.add('GET', r'/packages.json', (Request request) async {
    try {
      final _$result = await service.packagesJson(request);
      return _$result;
    } on ResponseException catch (e) {
      return e.asResponse();
    }
  });
  return router;
}
