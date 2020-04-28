// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ClientLibraryGenerator
// **************************************************************************

import 'package:api_builder/_client_utils.dart' as _i2;
import 'package:client_data/account_api.dart' as _i5;
import 'package:client_data/admin_api.dart' as _i6;
import 'package:client_data/package_api.dart' as _i3;
import 'package:client_data/publisher_api.dart' as _i4;
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

  Future<_i3.VersionInfo> packageVersionInfo(
      String package, String version) async {
    return _i3.VersionInfo.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/packages/$package/versions/$version',
    ));
  }

  Future<List<int>> fetchPackage(String package, String version) async {
    return await _client.requestBytes(
      verb: 'get',
      path: '/api/packages/$package/versions/$version/archive.tar.gz',
    );
  }

  Future<_i3.UploadInfo> getPackageUploadUrl() async {
    return _i3.UploadInfo.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/packages/versions/new',
    ));
  }

  Future<_i3.SuccessMessage> packageUploadCallback() async {
    return _i3.SuccessMessage.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/packages/versions/newUploadFinish',
    ));
  }

  Future<_i3.SuccessMessage> addUploader(String package) async {
    return _i3.SuccessMessage.fromJson(await _client.requestJson(
      verb: 'post',
      path: '/api/packages/$package/uploaders',
    ));
  }

  Future<_i3.SuccessMessage> removeUploader(
      String package, String email) async {
    return _i3.SuccessMessage.fromJson(await _client.requestJson(
      verb: 'delete',
      path: '/api/packages/$package/uploaders/$email',
    ));
  }

  Future<_i4.PublisherInfo> createPublisher(
      String publisherId, _i4.CreatePublisherRequest payload) async {
    return _i4.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'post',
      path: '/api/publishers/$publisherId',
      body: payload.toJson(),
    ));
  }

  Future<_i4.PublisherInfo> publisherInfo(String publisherId) async {
    return _i4.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/publishers/$publisherId',
    ));
  }

  Future<_i4.PublisherInfo> updatePublisher(
      String publisherId, _i4.UpdatePublisherRequest payload) async {
    return _i4.PublisherInfo.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/publishers/$publisherId',
      body: payload.toJson(),
    ));
  }

  Future<_i5.InviteStatus> invitePublisherMember(
      String publisherId, _i4.InviteMemberRequest payload) async {
    return _i5.InviteStatus.fromJson(await _client.requestJson(
      verb: 'post',
      path: '/api/publishers/$publisherId/invite-member',
      body: payload.toJson(),
    ));
  }

  Future<_i4.PublisherMembers> listPublisherMembers(String publisherId) async {
    return _i4.PublisherMembers.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/publishers/$publisherId/members',
    ));
  }

  Future<_i4.PublisherMember> publisherMemberInfo(
      String publisherId, String userId) async {
    return _i4.PublisherMember.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/publishers/$publisherId/members/$userId',
    ));
  }

  Future<_i4.PublisherMember> updatePublisherMember(String publisherId,
      String userId, _i4.UpdatePublisherMemberRequest payload) async {
    return _i4.PublisherMember.fromJson(await _client.requestJson(
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

  Future<_i5.Consent> consentInfo(String consentId) async {
    return _i5.Consent.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/consent/$consentId',
    ));
  }

  Future<_i5.ConsentResult> resolveConsent(
      String consentId, _i5.ConsentResult payload) async {
    return _i5.ConsentResult.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/account/consent/$consentId',
      body: payload.toJson(),
    ));
  }

  Future<List<int>> updateSession(_i5.ClientSessionRequest payload) async {
    return await _client.requestBytes(
      verb: 'post',
      path: '/api/account/session',
      body: payload.toJson(),
    );
  }

  Future<List<int>> invalidateSession() async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/account/session',
    );
  }

  Future<_i5.AccountPkgOptions> accountPackageOptions(String package) async {
    return _i5.AccountPkgOptions.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/options/packages/$package',
    ));
  }

  Future<_i5.AccountPublisherOptions> accountPublisherOptions(
      String publisherId) async {
    return _i5.AccountPublisherOptions.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/options/publishers/$publisherId',
    ));
  }

  Future<_i5.LikedPackagesRepsonse> listPackageLikes() async {
    return _i5.LikedPackagesRepsonse.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/likes',
    ));
  }

  Future<_i5.PackageLikeResponse> getLikePackage(String package) async {
    return _i5.PackageLikeResponse.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/account/likes/$package',
    ));
  }

  Future<_i5.PackageLikeResponse> likePackage(String package) async {
    return _i5.PackageLikeResponse.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/account/likes/$package',
    ));
  }

  Future<List<int>> unlikePackage(String package) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/account/likes/$package',
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

  Future<_i3.PkgOptions> packageOptions(String package) async {
    return _i3.PkgOptions.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/packages/$package/options',
    ));
  }

  Future<_i3.PkgOptions> setPackageOptions(
      String package, _i3.PkgOptions payload) async {
    return _i3.PkgOptions.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/packages/$package/options',
      body: payload.toJson(),
    ));
  }

  Future<_i3.PackagePublisherInfo> getPackagePublisher(String package) async {
    return _i3.PackagePublisherInfo.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/packages/$package/publisher',
    ));
  }

  Future<_i5.PackageLikesCount> getPackageLikes(String package) async {
    return _i5.PackageLikesCount.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/packages/$package/likes',
    ));
  }

  Future<_i3.PackagePublisherInfo> setPackagePublisher(
      String package, _i3.PackagePublisherInfo payload) async {
    return _i3.PackagePublisherInfo.fromJson(await _client.requestJson(
      verb: 'put',
      path: '/api/packages/$package/publisher',
      body: payload.toJson(),
    ));
  }

  Future<_i3.PackagePublisherInfo> removePackagePublisher(
      String package) async {
    return _i3.PackagePublisherInfo.fromJson(await _client.requestJson(
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

  Future<List<int>> adminRemovePackage(String package) async {
    return await _client.requestBytes(
      verb: 'delete',
      path: '/api/admin/packages/$package',
    );
  }

  Future<_i6.AssignedTags> adminGetAssignedTags(String package) async {
    return _i6.AssignedTags.fromJson(await _client.requestJson(
      verb: 'get',
      path: '/api/admin/packages/$package/assigned-tags',
    ));
  }

  Future<_i6.AssignedTags> adminPostAssignedTags(
      String package, _i6.PatchAssignedTags payload) async {
    return _i6.AssignedTags.fromJson(await _client.requestJson(
      verb: 'post',
      path: '/api/admin/packages/$package/assigned-tags',
      body: payload.toJson(),
    ));
  }
}
