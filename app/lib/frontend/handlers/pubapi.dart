// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:_pub_shared/data/task_api.dart';
import 'package:api_builder/api_builder.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../account/consent_backend.dart';
import '../../admin/backend.dart';
import '../../package/backend.dart' hide InviteStatus;
import '../../publisher/backend.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
import '../../shared/urls.dart' as urls;
import '../../task/backend.dart' show taskBackend;
import 'account.dart';
import 'custom_api.dart';
import 'listing.dart';
import 'package.dart';

part 'pubapi.g.dart';

class PubApi {
  Router get router => _$PubApiRouter(this);

  // ****
  // **** pub client APIs
  // ****

  /// Getting information about all versions of a package.
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#list-all-versions-of-a-package
  @EndPoint.get('/api/packages/<package>')
  Future<Response> listVersions(Request request, String package) async {
    return await listVersionsHandler(request, package);
  }

  /// Getting information about a specific (package, version) pair.
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#deprecated-inspect-a-specific-version-of-a-package
  @EndPoint.get('/api/packages/<package>/versions/<version>')
  Future<VersionInfo> packageVersionInfo(
    Request request,
    String package,
    String version,
  ) async =>
      await packageBackend.lookupVersion(package, version);

  /// Downloading package.
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#download-a-specific-version-of-a-package
  ///
  /// NOTE: `/packages/<package>/versions/<version>.tar.gz` is hardcoded into the
  /// clients, so while this is deprecated we need to support it indefinitely.
  @EndPoint.get('/api/packages/<package>/versions/<version>/archive.tar.gz')
  @EndPoint.get('/packages/<package>/versions/<version>.tar.gz')
  Future<Response> fetchPackage(
    Request request,
    String package,
    String version,
  ) async {
    checkPackageVersionParams(package, version);
    return Response.seeOther(
        await packageBackend.downloadUrl(package, version));
  }

  /// Start async upload.
  /// TODO: Link to the spec once it has the details updated:
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#publishing-packages
  ///
  ///     GET /api/packages/versions/new
  ///     Headers:
  ///       Authorization: Bearer <oauth2-token>
  ///     [200 OK]
  ///     {
  ///       "fields" : {
  ///           "a": "...",
  ///           "b": "...",
  ///           ...
  ///       },
  ///       "url" : "https://storage.googleapis.com"
  ///     }
  ///
  ///     POST "https://storage.googleapis.com"
  ///     Headers:
  ///       a: ...
  ///       b: ...
  ///       ...
  ///     <multipart> file package.tar.gz
  ///     [302 Found / Temporary Redirect]
  ///     Location: https://pub.dartlang.org/finishUploadUrl
  @EndPoint.get('/api/packages/versions/new')
  Future<UploadInfo> getPackageUploadUrl(Request request) async =>
      // Note: we do not _normalizeHost here as we wish to be redirected to
      // packageUploadCallback on the same host. Otherwise, we can't do
      // integration tests before we switch traffic.
      await packageBackend.startUpload(
        request.requestedUri.resolve('/api/packages/versions/newUploadFinish'),
      );

  /// Finish async upload.
  /// TODO: Link to the spec once it has the details updated:
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#publishing-packages
  ///
  ///     GET /api/packages/versions/newUploadFinish
  ///     [200 OK]
  ///     {
  ///       "success" : {
  ///         "message": "Successfully uploaded `package` version `version`.",
  ///       },
  ///     }
  @EndPoint.get('/api/packages/versions/newUploadFinish')
  Future<SuccessMessage> packageUploadCallback(Request request) async {
    final uploadId = request.requestedUri.queryParameters['upload_id'];
    InvalidInputException.checkNotNull(uploadId, 'upload_id');
    return await finishPackageUpload(request, uploadId!);
  }

  @EndPoint.get('/api/packages/versions/newUploadFinish/<uploadId>')
  Future<SuccessMessage> finishPackageUpload(
      Request request, String uploadId) async {
    final pv = await packageBackend.publishUploadedBlob(uploadId);
    return SuccessMessage(
        success: Message(
            message:
                'Successfully uploaded ${urls.pkgPageUrl(pv.package, includeHost: true)} version ${pv.version}.'));
  }

  /// Adding a new uploader
  /// TODO: Link to the spec once it has the details updated:
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#publishing-packages
  ///
  ///     POST /api/packages/<package-name>/uploaders
  ///     email=<uploader-email>
  ///
  ///     [200 OK] [Content-Type: application/json]
  ///     or
  ///     [400 Client Error]
  @EndPoint.post('/api/packages/<package>/uploaders')
  Future<SuccessMessage> addUploader(Request request, String package) async {
    throw OperationForbiddenException.pubToolUploaderNotSupported(
        adminPageUrl: urls.pkgAdminUrl(package, includeHost: true));
  }

  /// Removing an existing uploader.
  /// TODO: Link to the spec once it has the details updated:
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#publishing-packages
  ///
  ///     DELETE /api/packages/<package-name>/uploaders/<uploader-email>
  ///     [200 OK] [Content-Type: application/json]
  ///     or
  ///     [400 Client Error]
  @EndPoint.delete('/api/packages/<package>/uploaders/<email>')
  Future<SuccessMessage> removeUploader(
    Request request,
    String package,
    String email,
  ) async {
    throw OperationForbiddenException.pubToolUploaderNotSupported(
        adminPageUrl: urls.pkgAdminUrl(package, includeHost: true));
  }

  /// Remove an existing uploader.
  ///
  /// This is a different API endpoint than the pub CLI tool is using, because
  /// we want to use a separate authentication mechanism going forward.
  @EndPoint.post('/api/packages/<package>/remove-uploader')
  Future<SuccessMessage> removeUploaderFromUI(
    Request request,
    String package,
    RemoveUploaderRequest payload,
  ) async =>
      await packageBackend.removeUploader(package, payload.email);

  /// Returns a uploader's invitation status in a JSON form.
  @EndPoint.post('/api/packages/<package>/invite-uploader')
  Future<InviteStatus> invitePackageUploader(
    Request request,
    String package,
    InviteUploaderRequest invite,
  ) async =>
      await packageBackend.inviteUploader(package, invite);

  // ****
  // **** Publisher API
  // ****

  /// Starts publisher creation flow.
  @EndPoint.post('/api/publishers/<publisherId>')
  Future<PublisherInfo> createPublisher(
    Request request,
    String publisherId,
  ) =>
      publisherBackend.createPublisher(publisherId);

  /// Returns publisher data in a JSON form.
  @EndPoint.get('/api/publishers/<publisherId>')
  Future<PublisherInfo> publisherInfo(Request request, String publisherId) =>
      publisherBackend.getPublisherInfo(publisherId);

  /// Updates publisher data.
  @EndPoint.put('/api/publishers/<publisherId>')
  Future<PublisherInfo> updatePublisher(
          Request request, String publisherId, UpdatePublisherRequest update) =>
      publisherBackend.updatePublisher(publisherId, update);

  /// Returns a publisher's member data and role in a JSON form.
  @EndPoint.post('/api/publishers/<publisherId>/invite-member')
  Future<InviteStatus> invitePublisherMember(
          Request request, String publisherId, InviteMemberRequest invite) =>
      publisherBackend.invitePublisherMember(publisherId, invite);

  /// Returns publisher members data in a JSON form.
  @EndPoint.get('/api/publishers/<publisherId>/members')
  Future<PublisherMembers> listPublisherMembers(
          Request request, String publisherId) =>
      publisherBackend.handleListPublisherMembers(publisherId);

  /// Returns a publisher's member data and role in a JSON form.
  @EndPoint.get('/api/publishers/<publisherId>/members/<userId>')
  Future<PublisherMember> publisherMemberInfo(
    Request request,
    String publisherId,
    String userId,
  ) =>
      publisherBackend.publisherMemberInfo(publisherId, userId);

  /// Updates a publisher's member data and role.
  @EndPoint.put('/api/publishers/<publisherId>/members/<userId>')
  Future<PublisherMember> updatePublisherMember(
    Request request,
    String publisherId,
    String userId,
    UpdatePublisherMemberRequest update,
  ) =>
      publisherBackend.updatePublisherMember(publisherId, userId, update);

  /// Deletes a publisher's member.
  @EndPoint.delete('/api/publishers/<publisherId>/members/<userId>')
  Future<Response> removePublisherMember(
    Request request,
    String publisherId,
    String userId,
  ) async {
    await publisherBackend.deletePublisherMember(publisherId, userId);
    return jsonResponse({'status': 'OK'});
  }

  // ****
  // **** Account, authentication and user administration API
  // ****

  /// Returns the consent request details.
  @EndPoint.get('/api/account/consent/<consentId>')
  Future<Consent> consentInfo(Request request, String consentId) =>
      consentBackend.handleGetConsent(consentId);

  /// Accepts or declines the consent.
  @EndPoint.put('/api/account/consent/<consentId>')
  Future<ConsentResult> resolveConsent(
          Request request, String consentId, ConsentResult result) =>
      consentBackend.resolveConsent(consentId, result);

  /// Gets the current session information.
  @EndPoint.get('/api/account/session')
  Future<ClientSessionStatus> getAccountSession(Request request) =>
      getAccountSessionHandler(request);

  /// Removes the user session.
  ///
  /// This endpoint should be called after an explicit logout action or when the
  /// client-side auth library logs out the current session.
  ///
  /// The response header will contain the session cookie with an immediate
  /// expiration (clearing the cookie), and the body is a [ClientSessionStatus].
  @EndPoint.delete('/api/account/session')
  Future<Response> invalidateSession(Request request) =>
      invalidateSessionHandler(request);

  // ****
  // **** Custom API
  // ****

  @EndPoint.get('/api/account/options/packages/<package>')
  Future<AccountPkgOptions> accountPackageOptions(
          Request request, String package) =>
      accountPkgOptionsHandler(request, package);

  @EndPoint.get('/api/account/options/publishers/<publisherId>')
  Future<AccountPublisherOptions> accountPublisherOptions(
          Request request, String publisherId) =>
      accountPublisherOptionsHandler(request, publisherId);

  @EndPoint.get('/api/account/likes')
  Future<LikedPackagesRepsonse> listPackageLikes(Request request) =>
      listPackageLikesHandler(request);

  @EndPoint.get('/api/account/likes/<package>')
  Future<PackageLikeResponse> getLikePackage(Request request, String package) =>
      getLikePackageHandler(request, package);

  @EndPoint.put('/api/account/likes/<package>')
  Future<PackageLikeResponse> likePackage(Request request, String package) =>
      likePackageHandler(request, package);

  @EndPoint.delete('/api/account/likes/<package>')
  Future<Response> unlikePackage(Request request, String package) =>
      unlikePackageHandler(request, package);

  @EndPoint.get('/api/documentation/<package>')
  Future<Response> documentation(Request request, String package) =>
      apiDocumentationHandler(request, package);

  @EndPoint.get('/api/packages')
  Future<Response> listPackages(Request request) async {
    if (request.requestedUri.queryParameters['compact'] == '1') {
      return apiPackagesCompactListHandler(request);
    } else {
      // /api/packages?page=<num>
      return apiPackagesHandler(request);
    }
  }

  @EndPoint.get('/api/package-names')
  Future<Response> packageNames(Request request) async {
    return apiPackageNamesHandler(request);
  }

  /// NOTE: This is a public API.
  @EndPoint.get('/api/package-name-completion-data')
  Future<Response> packageNameCompletionData(Request request) async {
    return apiPackageNameCompletionDataHandler(request);
  }

  @EndPoint.get('/api/packages/<package>/metrics')
  Future<Response> packageMetrics(Request request, String package) =>
      apiPackageMetricsHandler(request, package);

  @EndPoint.get('/api/packages/<package>/options')
  Future<PkgOptions> packageOptions(Request request, String package) =>
      getPackageOptionsHandler(request, package);

  @EndPoint.get('/api/topic-name-completion-data')
  Future<Response> topicNameCompletionData(Request request) async {
    return apiTopicNameCompletionDataHandler(request);
  }

  @EndPoint.put('/api/packages/<package>/options')
  Future<PkgOptions> setPackageOptions(
          Request request, String package, PkgOptions body) =>
      putPackageOptionsHandler(request, package, body);

  @EndPoint.put('/api/packages/<package>/automated-publishing')
  Future<AutomatedPublishingConfig> setAutomatedPublishing(
          Request request, String package, AutomatedPublishingConfig body) =>
      packageBackend.setAutomatedPublishing(package, body);

  @EndPoint.get('/api/packages/<package>/versions/<version>/options')
  Future<VersionOptions> getVersionOptions(
          Request request, String package, String version) =>
      getVersionOptionsHandler(request, package, version);

  @EndPoint.put('/api/packages/<package>/versions/<version>/options')
  Future<VersionOptions> setVersionOptions(Request request, String package,
          String version, VersionOptions body) =>
      putVersionOptionsHandler(request, package, version, body);

  @EndPoint.get('/api/packages/<package>/publisher')
  Future<PackagePublisherInfo> getPackagePublisher(
    Request request,
    String package,
  ) =>
      packageBackend.getPublisherInfo(package);

  @EndPoint.get('/api/packages/<package>/likes')
  Future<PackageLikesCount> getPackageLikes(
    Request request,
    String package,
  ) =>
      packageBackend.getPackageLikesCount(package);

  @EndPoint.put('/api/packages/<package>/publisher')
  Future<PackagePublisherInfo> setPackagePublisher(
    Request request,
    String package,
    PackagePublisherInfo body,
  ) =>
      packageBackend.setPublisher(package, body);

  @EndPoint.delete('/api/packages/<package>/publisher')
  Future<PackagePublisherInfo> removePackagePublisher(
          Request request, String package) =>
      packageBackend.removePublisher(package);

  @EndPoint.get('/api/packages/<package>/score')
  Future<VersionScore> packageScore(Request request, String package) =>
      packageVersionScoreHandler(request, package);

  @EndPoint.get('/api/packages/<package>/versions/<version>/score')
  Future<VersionScore> packageVersionScore(
          Request request, String package, String version) =>
      packageVersionScoreHandler(request, package, version: version);

  @EndPoint.get('/api/search')
  Future<Response> search(Request request) => apiSearchHandler(request);

  @EndPoint.get('/debug')
  Future<Response> debug(Request request) async => debugResponse({
        'package': packageDebugStats(),
        'search': searchDebugStats(),
      });

  @EndPoint.get('/packages.json')
  Future<Response> packages(Request request) => packagesHandler(request);

  @EndPoint.get('/packages/<package>.json')
  Future<Response> packageJson(Request request, String package) =>
      packageShowHandlerJson(request, package);

  // ****
  // **** Task API
  // ****

  @EndPoint.post('/api/tasks/<package>/<version>/upload')
  Future<UploadTaskResultResponse> taskUploadResult(
    Request request,
    String package,
    String version,
  ) =>
      taskBackend.handleUploadResult(
        request,
        package,
        version,
      );

  @EndPoint.post('/api/tasks/<package>/<version>/finished')
  Future<Response> taskUploadFinished(
    Request request,
    String package,
    String version,
  ) =>
      taskBackend.handleUploadFinished(
        request,
        package,
        version,
      );

  // ****
  // **** Admin API
  // ****

  @EndPoint.post('/api/admin/tools/<tool>/<args|[^]*>')
  Future<Response> adminExecuteTool(
      Request request, String tool, String args) async {
    final parsedArgs = request.requestedUri.pathSegments.skip(4).toList();
    return Response.ok(await adminBackend.executeTool(tool, parsedArgs));
  }

  @EndPoint.get('/api/admin/users')
  Future<AdminListUsersResponse> adminListUsers(
    Request request, {
    String? email, // Filter by email
    String? ouid, // Filter by OAuthUserID
    String? ct, // continuationToken
  }) {
    return adminBackend.listUsers(
      email: email,
      oauthUserId: ouid,
      continuationToken: ct,
    );
  }

  @EndPoint.delete('/api/admin/users/<userId>')
  Future<Response> adminRemoveUser(Request request, String userId) async {
    await adminBackend.removeUser(userId);
    return jsonResponse({'status': 'OK'});
  }

  @EndPoint.delete('/api/admin/packages/<package>')
  Future<Response> adminRemovePackage(Request request, String package) async {
    await adminBackend.removePackage(package);
    return jsonResponse({'status': 'OK'});
  }

  @EndPoint.delete('/api/admin/packages/<package>/versions/<version>')
  Future<Response> adminRemovePackageVersion(
      Request request, String package, String version) async {
    await adminBackend.removePackageVersion(package, version);
    return jsonResponse({'status': 'OK'});
  }

  @EndPoint.put('/api/admin/packages/<package>/versions/<version>/options')
  Future<VersionOptions> adminUpdateVersionOptions(Request request,
      String package, String version, VersionOptions options) async {
    await adminBackend.updateVersionOptions(package, version, options);
    return getVersionOptionsHandler(request, package, version);
  }

  @EndPoint.get('/api/admin/packages/<package>/assigned-tags')
  Future<AssignedTags> adminGetAssignedTags(
    Request request,
    String package,
  ) =>
      adminBackend.handleGetAssignedTags(package);

  @EndPoint.post('/api/admin/packages/<package>/assigned-tags')
  Future<AssignedTags> adminPostAssignedTags(
    Request request,
    String package,
    PatchAssignedTags body,
  ) =>
      adminBackend.handlePostAssignedTags(package, body);

  @EndPoint.get('/api/admin/packages/<package>/uploaders')
  Future<PackageUploaders> adminGetPackageUploaders(
    Request request,
    String package,
  ) =>
      adminBackend.handleGetPackageUploaders(package);

  @EndPoint.put('/api/admin/packages/<package>/uploaders/<email>')
  Future<PackageUploaders> adminAddPackageUploader(
          Request request, String package, String email) =>
      adminBackend.handleAddPackageUploader(package, email);

  @EndPoint.delete('/api/admin/packages/<package>/uploaders/<email>')
  Future<PackageUploaders> adminRemovePackageUploader(
          Request request, String package, String email) =>
      adminBackend.handleRemovePackageUploader(package, email);
}
