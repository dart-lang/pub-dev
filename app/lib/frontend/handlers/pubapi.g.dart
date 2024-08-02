// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pubapi.dart';

// **************************************************************************
// ApiRouterGenerator
// **************************************************************************

Router _$PubApiRouter(PubApi service) {
  final router = Router();
  router.add(
    'GET',
    r'/api/packages/<package>',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.listVersions(
          request,
          package,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/versions/<version>',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.packageVersionInfo(
          request,
          package,
          version,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/versions/<version>/archive.tar.gz',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.redirectToFetchPackage(
          request,
          package,
          version,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/packages/<package>/versions/<version>.tar.gz',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.redirectToFetchPackage(
          request,
          package,
          version,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/archives/<package|[^-/]+>-<version>.tar.gz',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.fetchPackage(
          request,
          package,
          version,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/versions/new',
    (Request request) async {
      try {
        final _$result = await service.getPackageUploadUrl(
          request,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/versions/newUploadFinish',
    (Request request) async {
      try {
        final _$result = await service.packageUploadCallback(
          request,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/versions/newUploadFinish/<uploadId>',
    (
      Request request,
      String uploadId,
    ) async {
      try {
        final _$result = await service.finishPackageUpload(
          request,
          uploadId,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/packages/<package>/uploaders',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.addUploader(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/packages/<package>/uploaders/<email>',
    (
      Request request,
      String package,
      String email,
    ) async {
      try {
        final _$result = await service.removeUploader(
          request,
          package,
          email,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/packages/<package>/remove-uploader',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.removeUploaderFromUI(
          request,
          package,
          await $utilities.decodeJson<RemoveUploaderRequest>(
              request, (o) => RemoveUploaderRequest.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/packages/<package>/invite-uploader',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.invitePackageUploader(
          request,
          package,
          await $utilities.decodeJson<InviteUploaderRequest>(
              request, (o) => InviteUploaderRequest.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/publishers/<publisherId>',
    (
      Request request,
      String publisherId,
    ) async {
      try {
        final _$result = await service.createPublisher(
          request,
          publisherId,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/publishers/<publisherId>',
    (
      Request request,
      String publisherId,
    ) async {
      try {
        final _$result = await service.publisherInfo(
          request,
          publisherId,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/publishers/<publisherId>',
    (
      Request request,
      String publisherId,
    ) async {
      try {
        final _$result = await service.updatePublisher(
          request,
          publisherId,
          await $utilities.decodeJson<UpdatePublisherRequest>(
              request, (o) => UpdatePublisherRequest.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/publishers/<publisherId>/invite-member',
    (
      Request request,
      String publisherId,
    ) async {
      try {
        final _$result = await service.invitePublisherMember(
          request,
          publisherId,
          await $utilities.decodeJson<InviteMemberRequest>(
              request, (o) => InviteMemberRequest.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/publishers/<publisherId>/members',
    (
      Request request,
      String publisherId,
    ) async {
      try {
        final _$result = await service.listPublisherMembers(
          request,
          publisherId,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/publishers/<publisherId>/members/<userId>',
    (
      Request request,
      String publisherId,
      String userId,
    ) async {
      try {
        final _$result = await service.publisherMemberInfo(
          request,
          publisherId,
          userId,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/publishers/<publisherId>/members/<userId>',
    (
      Request request,
      String publisherId,
      String userId,
    ) async {
      try {
        final _$result = await service.updatePublisherMember(
          request,
          publisherId,
          userId,
          await $utilities.decodeJson<UpdatePublisherMemberRequest>(
              request, (o) => UpdatePublisherMemberRequest.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/publishers/<publisherId>/members/<userId>',
    (
      Request request,
      String publisherId,
      String userId,
    ) async {
      try {
        final _$result = await service.removePublisherMember(
          request,
          publisherId,
          userId,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/account/consent/<consentId>',
    (
      Request request,
      String consentId,
    ) async {
      try {
        final _$result = await service.consentInfo(
          request,
          consentId,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/account/consent/<consentId>',
    (
      Request request,
      String consentId,
    ) async {
      try {
        final _$result = await service.resolveConsent(
          request,
          consentId,
          await $utilities.decodeJson<ConsentResult>(
              request, (o) => ConsentResult.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/account/session',
    (Request request) async {
      try {
        final _$result = await service.getAccountSession(
          request,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/account/session',
    (Request request) async {
      try {
        final _$result = await service.invalidateSession(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/account/options/packages/<package>',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.accountPackageOptions(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/account/options/publishers/<publisherId>',
    (
      Request request,
      String publisherId,
    ) async {
      try {
        final _$result = await service.accountPublisherOptions(
          request,
          publisherId,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/account/likes',
    (Request request) async {
      try {
        final _$result = await service.listPackageLikes(
          request,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/account/likes/<package>',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.getLikePackage(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/account/likes/<package>',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.likePackage(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/account/likes/<package>',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.unlikePackage(
          request,
          package,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/documentation/<package>',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.documentation(
          request,
          package,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages',
    (Request request) async {
      try {
        final _$result = await service.listPackages(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/package-names',
    (Request request) async {
      try {
        final _$result = await service.packageNames(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/package-name-completion-data',
    (Request request) async {
      try {
        final _$result = await service.packageNameCompletionData(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/metrics',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.packageMetrics(
          request,
          package,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/options',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.packageOptions(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/topic-name-completion-data',
    (Request request) async {
      try {
        final _$result = await service.topicNameCompletionData(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/packages/<package>/options',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.setPackageOptions(
          request,
          package,
          await $utilities.decodeJson<PkgOptions>(
              request, (o) => PkgOptions.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/packages/<package>/automated-publishing',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.setAutomatedPublishing(
          request,
          package,
          await $utilities.decodeJson<AutomatedPublishingConfig>(
              request, (o) => AutomatedPublishingConfig.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/versions/<version>/options',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.getVersionOptions(
          request,
          package,
          version,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/packages/<package>/versions/<version>/options',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.setVersionOptions(
          request,
          package,
          version,
          await $utilities.decodeJson<VersionOptions>(
              request, (o) => VersionOptions.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/publisher',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.getPackagePublisher(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/likes',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.getPackageLikes(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/packages/<package>/publisher',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.setPackagePublisher(
          request,
          package,
          await $utilities.decodeJson<PackagePublisherInfo>(
              request, (o) => PackagePublisherInfo.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/score',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.packageScore(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/versions/<version>/score',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.packageVersionScore(
          request,
          package,
          version,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/search',
    (Request request) async {
      try {
        final _$result = await service.search(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/debug',
    (Request request) async {
      try {
        final _$result = await service.debug(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/packages.json',
    (Request request) async {
      try {
        final _$result = await service.packages(
          request,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/packages/<package>.json',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.packageJson(
          request,
          package,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/tasks/<package>/<version>/upload',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.taskUploadResult(
          request,
          package,
          version,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/tasks/<package>/<version>/finished',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.taskUploadFinished(
          request,
          package,
          version,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/admin/tools/<tool>/<args|[^]*>',
    (
      Request request,
      String tool,
      String args,
    ) async {
      try {
        final _$result = await service.adminExecuteTool(
          request,
          tool,
          args,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/admin/actions',
    (Request request) async {
      try {
        final _$result = await service.adminListActions(
          request,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/admin/actions/<action>',
    (
      Request request,
      String action,
    ) async {
      try {
        final _$result = await service.adminInvokeAction(
          request,
          action,
          await $utilities.decodeJson<AdminInvokeActionArguments>(
              request, (o) => AdminInvokeActionArguments.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/admin/users',
    (Request request) async {
      try {
        final _$result = await service.adminListUsers(
          request,
          email: request.requestedUri.queryParameters['email'],
          ouid: request.requestedUri.queryParameters['ouid'],
          ct: request.requestedUri.queryParameters['ct'],
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/admin/users/<userId>',
    (
      Request request,
      String userId,
    ) async {
      try {
        final _$result = await service.adminRemoveUser(
          request,
          userId,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/admin/packages/<package>',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.adminRemovePackage(
          request,
          package,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/admin/packages/<package>/versions/<version>',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.adminRemovePackageVersion(
          request,
          package,
          version,
        );
        return _$result;
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/admin/packages/<package>/versions/<version>/options',
    (
      Request request,
      String package,
      String version,
    ) async {
      try {
        final _$result = await service.adminUpdateVersionOptions(
          request,
          package,
          version,
          await $utilities.decodeJson<VersionOptions>(
              request, (o) => VersionOptions.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/admin/packages/<package>/assigned-tags',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.adminGetAssignedTags(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/admin/packages/<package>/assigned-tags',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.adminPostAssignedTags(
          request,
          package,
          await $utilities.decodeJson<PatchAssignedTags>(
              request, (o) => PatchAssignedTags.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/admin/packages/<package>/uploaders',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.adminGetPackageUploaders(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'PUT',
    r'/api/admin/packages/<package>/uploaders/<email>',
    (
      Request request,
      String package,
      String email,
    ) async {
      try {
        final _$result = await service.adminAddPackageUploader(
          request,
          package,
          email,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'DELETE',
    r'/api/admin/packages/<package>/uploaders/<email>',
    (
      Request request,
      String package,
      String email,
    ) async {
      try {
        final _$result = await service.adminRemovePackageUploader(
          request,
          package,
          email,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'GET',
    r'/api/packages/<package>/advisories',
    (
      Request request,
      String package,
    ) async {
      try {
        final _$result = await service.getPackageAdvisories(
          request,
          package,
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  router.add(
    'POST',
    r'/api/report',
    (Request request) async {
      try {
        final _$result = await service.postReport(
          request,
          await $utilities.decodeJson<ReportForm>(
              request, (o) => ReportForm.fromJson(o)),
        );
        return $utilities.jsonResponse(_$result.toJson());
      } on ApiResponseException catch (e) {
        return e.asApiResponse();
      } catch (e, st) {
        return $utilities.unhandledError(e, st);
      }
    },
  );
  return router;
}
