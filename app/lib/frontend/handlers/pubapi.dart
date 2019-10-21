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
import '../../shared/handlers.dart';
import 'account.dart';
import 'custom_api.dart';
import 'listing.dart';
import 'package.dart';

part 'pubapi.g.dart';

class PubApi {
  final Handler _pubServerHandler;

  PubApi(this._pubServerHandler);

  Router get router => _$PubApiRouter(this);

  // ****
  // **** pub client APIs
  // ****

  /// Getting information about all versions of a package.
  ///
  /// GET /api/packages/<package-name>
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L28-L49
  @EndPoint.get('/api/packages/<package>')
  Future<Response> listPackageVersions(Request request, String package) async =>
      _pubServerHandler(_normalizeHost(request));

  /// Getting information about a specific (package, version) pair.
  ///
  /// GET /api/packages/<package-name>/versions/<version-name>
  ///
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L51-L65
  @EndPoint.get('/api/packages/<package>/versions/<version>')
  Future<Response> packageVersionInfo(
    Request request,
    String package,
    String version,
  ) async =>
      _pubServerHandler(_normalizeHost(request));

  /// Downloading package.
  ///
  /// GET /api/packages/<package-name>/versions/<version-name>.tar.gz
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L67-L75
  @EndPoint.get('/api/packages/<package>/versions/<version>.tar.gz')
  @EndPoint.get('/packages/<package>/versions/<version>.tar.gz')
  Future<Response> fetchPackage(
    Request request,
    String package,
    String version,
  ) async =>
      _pubServerHandler(_normalizeHost(request));

  /// Start async upload.
  ///
  /// GET /api/packages/versions/new
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L77-L107
  @EndPoint.get('/api/packages/versions/new')
  Future<Response> getPackageUploadUrl(Request request) async =>
      // Note: we do not _normalizeHost here as we wish to be redirected to
      // packageUploadCallback on the same host. Otherwise, we can't do
      // integration tests before we switch traffic.
      _pubServerHandler(request);

  /// Finish async upload.
  ///
  /// GET /api/packages/versions/newUploadFinish
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L77-L107
  @EndPoint.get('/api/packages/versions/newUploadFinish')
  Future<Response> packageUploadCallback(Request request) async =>
      _pubServerHandler(_normalizeHost(request));

  /// Adding a new uploader
  ///
  /// POST /api/packages/<package-name>/uploaders
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L109-L116
  @EndPoint.post('/api/packages/<package>/uploaders')
  Future<Response> addUploader(Request request, String package) async =>
      _pubServerHandler(_normalizeHost(request));

  /// Removing an existing uploader.
  ///
  /// DELETE /api/packages/<package-name>/uploaders/<uploader-email>
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L118-L123
  @EndPoint.delete('/api/packages/<package>/uploaders/<email>')
  Future<Response> removeUploader(
    Request request,
    String package,
    String email,
  ) async =>
      _pubServerHandler(_normalizeHost(request));

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
  Future<Response> updateSession(
          Request request, ClientSessionData sessionData) =>
      updateSessionHandler(request, clientSessionData: sessionData);

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
  Future<Response> packageOptions(Request request, String package) =>
      getPackageOptionsHandler(request, package);

  @EndPoint.put('/api/packages/<package>/options')
  Future<Response> setPackageOptions(
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
}

/// Replaces the requested uri with the primary API uri.
///
/// A few API endpoint use the requested uri as a base to generate further URLs
/// that we return in the response. Such generated URLs may end up in our cache,
/// and it is critical that we only cache the values with the proper URLs.
Request _normalizeHost(Request request) {
  final requestedUri = activeConfiguration.primaryApiUri.replace(
    path: request.requestedUri.path,
    queryParameters: request.requestedUri.queryParameters.isEmpty
        ? null
        : request.requestedUri.queryParametersAll,
  );
  return Request(
    request.method,
    requestedUri,
    body: request.read(),
    headers: request.headers,
    context: request.context,
    encoding: request.encoding,
    handlerPath: request.handlerPath,
    protocolVersion: request.protocolVersion,
  );
}
