import 'package:api_builder/api_builder.dart';
import 'package:client_data/publisher_api.dart';
import 'package:shelf/shelf.dart';

import '../../publisher/backend.dart';
import '../../shared/handlers.dart';
import 'account.dart';
import 'custom_api.dart';
import 'listing.dart';
import 'package.dart';
import 'publisher.dart';

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
      _pubServerHandler(request);

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
      _pubServerHandler(request);

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
      _pubServerHandler(request);

  /// Start async upload.
  ///
  /// GET /api/packages/versions/new
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L77-L107
  @EndPoint.get('/api/packages/versions/new')
  Future<Response> getPackageUploadUrl(Request request) async =>
      _pubServerHandler(request);

  /// Finish async upload.
  ///
  /// GET /api/packages/versions/newUploadFinish
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L77-L107
  @EndPoint.get('/api/packages/versions/newUploadFinish')
  Future<Response> packageUploadCallback(Request request) async =>
      _pubServerHandler(request);

  /// Adding a new uploader
  ///
  /// POST /api/packages/<package-name>/uploaders
  /// https://github.com/dart-lang/pub_server/blob/master/lib/shelf_pubserver.dart#L109-L116
  @EndPoint.post('/api/packages/<package>/uploaders')
  Future<Response> addUploader(Request request, String package) async =>
      _pubServerHandler(request);

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
      _pubServerHandler(request);

  // ****
  // **** Publisher API
  // ****

  /// Starts publisher creation flow.
  @EndPoint.post('/api/publisher/<publisherId>')
  Future<Response> createPublisher(Request request, String publisherId) =>
      createPublisherApiHandler(request, publisherId);

  /// Returns publisher data in a JSON form.
  @EndPoint.get('/api/publisher/<publisherId>')
  Future<Response> publisherInfo(Request request, String publisherId) =>
      getPublisherApiHandler(request, publisherId);

  /// Updates publisher data.
  @EndPoint.put('/api/publisher/<publisherId>')
  Future<PublisherInfo> updatePublisher(
          Request request, String publisherId, UpdatePublisherRequest update) =>
      publisherBackend.updatePublisher(publisherId, update);

  /// Returns a publisher's member data and role in a JSON form.
  @EndPoint.post('/api/publisher/<publisherId>/invite-member')
  Future<Response> invitePublisherMember(Request request, String publisherId) =>
      invitePublisherMemberHandler(request, publisherId);

  /// Returns publisher members data in a JSON form.
  @EndPoint.get('/api/publisher/<publisherId>/members')
  Future<Response> listPublisherMembers(Request request, String publisherId) =>
      getPublisherMembersApiHandler(request, publisherId);

  /// Returns a publisher's member data and role in a JSON form.
  @EndPoint.get('/api/publisher/<publisherId>/members/<userId>')
  Future<Response> publisherMemberInfo(
    Request request,
    String publisherId,
    String userId,
  ) =>
      getPublisherMemberDataApiHandler(request, publisherId, userId);

  /// Updates a publisher's member data and role.
  @EndPoint.put('/api/publisher/<publisherId>/members/<userId>')
  Future<Response> updatePublisherMember(
    Request request,
    String publisherId,
    String userId,
  ) =>
      putPublisherMemberDataApiHandler(request, publisherId, userId);

  /// Deletes a publisher's member.
  @EndPoint.delete('/api/publisher/<publisherId>/members/<userId>')
  Future<Response> removePublisherMember(
    Request request,
    String publisherId,
    String userId,
  ) =>
      deletePublisherMemberDataApiHandler(request, publisherId, userId);

  // ****
  // **** Account, authentication and user administration API
  // ****

  /// Returns the consent request details.
  @EndPoint.get('/api/account/consent/<consentId>')
  Future<Response> consentInfo(Request request, String consentId) =>
      getAccountConsentHandler(request, consentId);

  /// Accepts or declines the consent.
  @EndPoint.put('/api/account/consent/<consentId>')
  Future<Response> resolveConsent(Request request, String consentId) =>
      putAccountConsentHandler(request, consentId);

  // ****
  // **** Custom API
  // ****

  @EndPoint.get('/api/account/options/packages/<package>')
  Future<Response> accountPackageOptions(Request request, String package) =>
      accountPkgOptionsHandler(request, package);

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
  Future<Response> setPackageOptions(Request request, String package) =>
      putPackageOptionsHandler(request, package);

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
}
