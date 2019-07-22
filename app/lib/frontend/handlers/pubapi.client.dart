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

  Future<List<int>> listPackageVersions(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package',
    );
  }

  Future<List<int>> packageVersionInfo(String package, String version) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/versions/$version',
    );
  }

  Future<List<int>> fetchPackage(String package, String version) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/versions/$version.tar.gz',
    );
  }

  Future<List<int>> getPackageUploadUrl() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/versions/new',
    );
  }

  Future<List<int>> packageUploadCallback() async {
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

  Future<List<int>> createPublisher(String publisherId) async {
    return await _client.requestBytes(
      verb: 'post',
      path: '/api/publisher/$publisherId',
    );
  }

  Future<List<int>> publisherInfo(String publisherId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/publisher/$publisherId',
    );
  }

  Future<List<int>> updatePublisher(String publisherId) async {
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

  Future<List<int>> listPublisherMembers(String publisherId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/publisher/$publisherId/members',
    );
  }

  Future<List<int>> publisherMemberInfo(
      String publisherId, String userId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/publisher/$publisherId/members/$userId',
    );
  }

  Future<List<int>> updatePublisherMember(
      String publisherId, String userId) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/publisher/$publisherId/members/$userId',
    );
  }

  Future<List<int>> removePublisherMember(
      String publisherId, String userId) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/publisher/$publisherId/members/$userId',
    );
  }

  Future<List<int>> consentInfo(String consentId) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/account/consent/$consentId',
    );
  }

  Future<List<int>> resolveConsent(String consentId) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/account/consent/$consentId',
    );
  }

  Future<List<int>> accountPackageOptions(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/account/options/packages/$package',
    );
  }

  Future<List<int>> documentation(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/documentation/$package',
    );
  }

  Future<List<int>> history() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/history',
    );
  }

  Future<List<int>> listPackages() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages',
    );
  }

  Future<List<int>> packageMetrics(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/metrics',
    );
  }

  Future<List<int>> packageOptions(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/options',
    );
  }

  Future<List<int>> setPackageOptions(String package) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/packages/$package/options',
    );
  }

  Future<List<int>> search() async {
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

  Future<List<int>> packages() async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/packages.json',
    );
  }
}
