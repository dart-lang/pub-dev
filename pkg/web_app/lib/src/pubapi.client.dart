// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ClientLibraryGenerator
// **************************************************************************

import 'package:api_builder/_client_utils.dart' as _i2;
import 'package:client_data/account_api.dart' as _i4;
import 'package:client_data/admin_api.dart' as _i6;
import 'package:client_data/package_api.dart' as _i5;
import 'package:client_data/publisher_api.dart' as _i3;
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

  Future<_i3.PublisherInfo> createPublisher(
      String publisherId, _i3.CreatePublisherRequest payload) async {
    return _i3.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'post',
      path: '/api/publishers/$publisherId',
      body: payload.toJson(),
    ));
  }

  Future<_i3.PublisherInfo> publisherInfo(String publisherId) async {
    return _i3.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/publishers/$publisherId',
    ));
  }

  Future<_i3.PublisherInfo> updatePublisher(
      String publisherId, _i3.UpdatePublisherRequest payload) async {
    return _i3.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/publishers/$publisherId',
      body: payload.toJson(),
    ));
  }

  Future<_i4.InviteStatus> invitePublisherMember(
      String publisherId, _i3.InviteMemberRequest payload) async {
    return _i4.InviteStatus.fromJson(await _client.requestJson(
      verb: 'post',
      path: '/api/publishers/$publisherId/invite-member',
      body: payload.toJson(),
    ));
  }

  Future<_i3.PublisherMembers> listPublisherMembers(String publisherId) async {
    return _i3.PublisherMembers.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/publishers/$publisherId/members',
    ));
  }

  Future<_i3.PublisherMember> publisherMemberInfo(
      String publisherId, String userId) async {
    return _i3.PublisherMember.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/publishers/$publisherId/members/$userId',
    ));
  }

  Future<_i3.PublisherMember> updatePublisherMember(String publisherId,
      String userId, _i3.UpdatePublisherMemberRequest payload) async {
    return _i3.PublisherMember.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/publishers/$publisherId/members/$userId',
      body: payload.toJson(),
    ));
  }

  Future<List<int>> removePublisherMember(
      String publisherId, String userId) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/publishers/$publisherId/members/$userId',
    );
  }

  Future<_i4.Consent> consentInfo(String consentId) async {
    return _i4.Consent.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/consent/$consentId',
    ));
  }

  Future<_i4.ConsentResult> resolveConsent(
      String consentId, _i4.ConsentResult payload) async {
    return _i4.ConsentResult.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/account/consent/$consentId',
      body: payload.toJson(),
    ));
  }

  Future<_i4.AccountPkgOptions> accountPackageOptions(String package) async {
    return _i4.AccountPkgOptions.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/options/packages/$package',
    ));
  }

  Future<_i4.AccountPublisherOptions> accountPublisherOptions(
      String publisherId) async {
    return _i4.AccountPublisherOptions.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/options/publishers/$publisherId',
    ));
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

  Future<List<int>> setPackageOptions(
      String package, _i5.PkgOptions payload) async {
    return await _client.requestBytes(
      verb: 'put',
      path: '/api/packages/$package/options',
      body: payload.toJson(),
    );
  }

  Future<_i5.PackagePublisherInfo> getPackagePublisher(String package) async {
    return _i5.PackagePublisherInfo.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/packages/$package/publisher',
    ));
  }

  Future<_i5.PackagePublisherInfo> setPackagePublisher(
      String package, _i5.PackagePublisherInfo payload) async {
    return _i5.PackagePublisherInfo.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/packages/$package/publisher',
      body: payload.toJson(),
    ));
  }

  Future<_i5.PackagePublisherInfo> removePackagePublisher(
      String package) async {
    return _i5.PackagePublisherInfo.fromJson(await _client.requestJson(
      verb: 'delete',
      path: '/api/packages/$package/publisher',
    ));
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

  Future<List<int>> packageJson(String package) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/packages/$package.json',
    );
  }

  Future<_i6.AdminListUsersResponse> adminListUsers(
      {String email, String ouid, String ct}) async {
    return _i6.AdminListUsersResponse.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/admin/users',
      query: email != null || ouid != null || ct != null
          ? <String, String>{
              if (email != null) 'email': email,
              if (ouid != null) 'ouid': ouid,
              if (ct != null) 'ct': ct
            }
          : null,
    ));
  }

  Future<List<int>> adminRemoveUser(String userId) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/admin/users/$userId',
    );
  }
}
