// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:api_builder/api_builder.dart';
import 'package:client_data/account_api.dart';
import 'package:client_data/admin_api.dart';
import 'package:client_data/package_api.dart';
import 'package:client_data/publisher_api.dart';
import 'package:shelf/shelf.dart';

import '../../account/consent_backend.dart';
import '../../admin/backend.dart';
import '../../package/backend.dart' hide InviteStatus;
import '../../publisher/backend.dart';
import '../../shared/configuration.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
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
    final baseUri = _replaceHost(request.requestedUri);
    return await listVersionsHandler(request, baseUri, package);
  }

  /// Getting information about a specific (package, version) pair.
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#deprecated-inspect-a-specific-version-of-a-package
  @EndPoint.get('/api/packages/<package>/versions/<version>')
  Future<VersionInfo> packageVersionInfo(
    Request request,
    String package,
    String version,
  ) async =>
      await packageBackend.lookupVersion(
          _replaceHost(request.requestedUri), package, version);

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
  ) async =>
      Response.seeOther(await packageBackend.downloadUrl(package, version));

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
  ///         "message": "Successfully uploaded package.",
  ///       },
  ///     }
  @EndPoint.get('/api/packages/versions/newUploadFinish')
  Future<SuccessMessage> packageUploadCallback(Request request) async {
    await packageBackend
        .publishUploadedBlob(_replaceHost(request.requestedUri));
    return SuccessMessage(
        success: Message(message: 'Successfully uploaded package.'));
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
    String email;
    try {
      final body = await request.readAsString();
      final params = Uri.splitQueryString(body);
      email = params['email'];
    } on FormatException catch (_) {}
    InvalidInputException.checkNotNull(email, 'email');
    return await packageBackend.addUploader(package, email);
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
  ) async =>
      await packageBackend.removeUploader(package, email);

  // ****
  // **** Publisher API
  // ****

  /// Starts publisher creation flow.
  @EndPoint.post('/api/publishers/<publisherId>')
  Future<PublisherInfo> createPublisher(
    Request request,
    String publisherId,
    CreatePublisherRequest body,
  ) =>
      publisherBackend.createPublisher(publisherId, body);

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

  /// Registers (or extends) a user session.
  ///
  /// This endpoint should be called after an explicit login action or when the
  /// client-side auth library receives an updated GoogleUser object
  /// (automatic updates).
  ///
  /// The response header will contain the updated session cookie, and the body
  /// is a [ClientSessionStatus].
  @EndPoint.post('/api/account/session')
  Future<Response> updateSession(Request request, ClientSessionRequest body) =>
      updateSessionHandler(request, body);

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

  /// Exposes History entities.
  ///
  /// NOTE: experimental, do not rely on it
  @EndPoint.get('/api/history')
  Future<Response> history(Request request) => apiHistoryHandler(request);

  @EndPoint.get('/api/packages')
  Future<Response> listPackages(Request request) async {
    if (request.requestedUri.queryParameters['compact'] == '1') {
      return apiPackagesCompactListHandler(request);
    } else {
      // /api/packages?page=<num>
      return apiPackagesHandler(request);
    }
  }

  @EndPoint.get('/api/packages/<package>/metrics')
  Future<Response> packageMetrics(Request request, String package) =>
      apiPackageMetricsHandler(request, package);

  @EndPoint.get('/api/packages/<package>/options')
  Future<PkgOptions> packageOptions(Request request, String package) =>
      getPackageOptionsHandler(request, package);

  @EndPoint.put('/api/packages/<package>/options')
  Future<PkgOptions> setPackageOptions(
          Request request, String package, PkgOptions body) =>
      putPackageOptionsHandler(request, package, body);

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
  // **** Admin API
  // ****

  @EndPoint.get('/api/admin/users')
  Future<AdminListUsersResponse> adminListUsers(
    Request request, {
    String email, // Filter by email
    String ouid, // Filter by OAuthUserID
    String ct, // continuationToken
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
}

/// Replaces the requested uri with the primary API uri.
///
/// A few API endpoint use the requested uri as a base to generate further URLs
/// that we return in the response. Such generated URLs may end up in our cache,
/// and it is critical that we only cache the values with the proper URLs.
Uri _replaceHost(Uri requestedUri) {
  return activeConfiguration.primaryApiUri.replace(
    path: requestedUri.path,
    queryParameters: requestedUri.queryParameters.isEmpty
        ? null
        : requestedUri.queryParametersAll,
  );
}
