// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ClientLibraryGenerator
// **************************************************************************

import 'package:api_builder/_client_utils.dart' as _i2;
import 'package:http/http.dart' as _i1;

export 'package:api_builder/_client_utils.dart' show RequestException;

/// Client for invoking `PubApi` through the generated router.
///
/// Reponses other than 2xx causes the methods to throw
/// `RequestException`. JSON encoding/decoding errors are not
/// handled gracefully. End-points that does not return a JSON
/// structure result in a method that returns the response body
/// as bytes
class PubApiClient {
  PubApiClient(String baseUrl, {_i1.Client client})
      : _client = _i2.Client(baseUrl, client: client);

  final _i2.Client _client;

  Future<List<int>> listVersions(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package',
    );
  }

  Future<List<int>> versionInfo(String package, String version) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/versions/$version',
    );
  }

  Future<List<int>> versionArchive(String package, String version) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/versions/$version.tar.gz',
    );
  }

  Future<List<int>> startUpload() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/versions/new',
    );
  }

  Future<List<int>> finishUpload() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/versions/newUploadFinish',
    );
  }

  Future<List<int>> addUploader(String package) async {
    return await _client.requestBytes(
      verb: 'post',
      path: '/api/packages/$package/uploaders',
    );
  }

  Future<List<int>> removeUploader(String package, String email) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/packages/$package/uploaders/$email',
    );
  }

  Future<List<int>> createPublisherApi(String publisherId) async {
    return await _client.requestBytes(
      verb: 'post',
      path: '/api/publisher/$publisherId',
    );
  }

  Future<List<int>> getPublisherApi(String publisherId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/publisher/$publisherId',
    );
  }

  Future<List<int>> updatePublisherApi(String publisherId) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/publisher/$publisherId',
    );
  }

  Future<List<int>> invitePublisherMember(String publisherId) async {
    return await _client.requestBytes(
      verb: 'post',
      path: '/api/publisher/$publisherId/invite-member',
    );
  }

  Future<List<int>> getPublisherMembersApi(String publisherId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/publisher/$publisherId/members',
    );
  }

  Future<List<int>> getPublisherMemberDataApi(
      String publisherId, String userId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/publisher/$publisherId/members/$userId',
    );
  }

  Future<List<int>> putPublisherMemberDataApi(
      String publisherId, String userId) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/publisher/$publisherId/members/$userId',
    );
  }

  Future<List<int>> deletePublisherMemberDataApi(
      String publisherId, String userId) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/publisher/$publisherId/members/$userId',
    );
  }

  Future<List<int>> getAccountConsent(String consentId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/account/consent/$consentId',
    );
  }

  Future<List<int>> putAccountConsent(String consentId) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/account/consent/$consentId',
    );
  }

  Future<List<int>> accountPkgOptions(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/account/options/packages/$package',
    );
  }

  Future<List<int>> apiDocumentation(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/documentation/$package',
    );
  }

  Future<List<int>> apiHistory() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/history',
    );
  }

  Future<List<int>> apiPackages() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages',
    );
  }

  Future<List<int>> apiPackageMetrics(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/metrics',
    );
  }

  Future<List<int>> getPackageOptions(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/options',
    );
  }

  Future<List<int>> putPackageOptions(String package) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/packages/$package/options',
    );
  }

  Future<List<int>> apiSearch() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/search',
    );
  }

  Future<List<int>> debug() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/debug',
    );
  }

  Future<List<int>> packagesJson() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/packages.json',
    );
  }
}
