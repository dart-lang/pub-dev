///
//  Generated code. Do not modify.
///
library google.iam.admin.v1_iam;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../protobuf/empty.pb.dart' as google$protobuf;
import '../../v1/iam_policy.pb.dart' as google$iam$v1;
import '../../v1/policy.pb.dart' as google$iam$v1;

import 'iam.pbenum.dart';

export 'iam.pbenum.dart';

class ServiceAccount extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ServiceAccount')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(4, 'uniqueId', PbFieldType.OS)
    ..a/*<String>*/(5, 'email', PbFieldType.OS)
    ..a/*<String>*/(6, 'displayName', PbFieldType.OS)
    ..a/*<List<int>>*/(7, 'etag', PbFieldType.OY)
    ..a/*<String>*/(9, 'oauth2ClientId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ServiceAccount() : super();
  ServiceAccount.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServiceAccount.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServiceAccount clone() => new ServiceAccount()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ServiceAccount create() => new ServiceAccount();
  static PbList<ServiceAccount> createRepeated() => new PbList<ServiceAccount>();
  static ServiceAccount getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyServiceAccount();
    return _defaultInstance;
  }
  static ServiceAccount _defaultInstance;
  static void $checkItem(ServiceAccount v) {
    if (v is !ServiceAccount) checkItemFailed(v, 'ServiceAccount');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get projectId => $_get(1, 2, '');
  void set projectId(String v) { $_setString(1, 2, v); }
  bool hasProjectId() => $_has(1, 2);
  void clearProjectId() => clearField(2);

  String get uniqueId => $_get(2, 4, '');
  void set uniqueId(String v) { $_setString(2, 4, v); }
  bool hasUniqueId() => $_has(2, 4);
  void clearUniqueId() => clearField(4);

  String get email => $_get(3, 5, '');
  void set email(String v) { $_setString(3, 5, v); }
  bool hasEmail() => $_has(3, 5);
  void clearEmail() => clearField(5);

  String get displayName => $_get(4, 6, '');
  void set displayName(String v) { $_setString(4, 6, v); }
  bool hasDisplayName() => $_has(4, 6);
  void clearDisplayName() => clearField(6);

  List<int> get etag => $_get(5, 7, null);
  void set etag(List<int> v) { $_setBytes(5, 7, v); }
  bool hasEtag() => $_has(5, 7);
  void clearEtag() => clearField(7);

  String get oauth2ClientId => $_get(6, 9, '');
  void set oauth2ClientId(String v) { $_setString(6, 9, v); }
  bool hasOauth2ClientId() => $_has(6, 9);
  void clearOauth2ClientId() => clearField(9);
}

class _ReadonlyServiceAccount extends ServiceAccount with ReadonlyMessageMixin {}

class CreateServiceAccountRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateServiceAccountRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'accountId', PbFieldType.OS)
    ..a/*<ServiceAccount>*/(3, 'serviceAccount', PbFieldType.OM, ServiceAccount.getDefault, ServiceAccount.create)
    ..hasRequiredFields = false
  ;

  CreateServiceAccountRequest() : super();
  CreateServiceAccountRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateServiceAccountRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateServiceAccountRequest clone() => new CreateServiceAccountRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateServiceAccountRequest create() => new CreateServiceAccountRequest();
  static PbList<CreateServiceAccountRequest> createRepeated() => new PbList<CreateServiceAccountRequest>();
  static CreateServiceAccountRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateServiceAccountRequest();
    return _defaultInstance;
  }
  static CreateServiceAccountRequest _defaultInstance;
  static void $checkItem(CreateServiceAccountRequest v) {
    if (v is !CreateServiceAccountRequest) checkItemFailed(v, 'CreateServiceAccountRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get accountId => $_get(1, 2, '');
  void set accountId(String v) { $_setString(1, 2, v); }
  bool hasAccountId() => $_has(1, 2);
  void clearAccountId() => clearField(2);

  ServiceAccount get serviceAccount => $_get(2, 3, null);
  void set serviceAccount(ServiceAccount v) { setField(3, v); }
  bool hasServiceAccount() => $_has(2, 3);
  void clearServiceAccount() => clearField(3);
}

class _ReadonlyCreateServiceAccountRequest extends CreateServiceAccountRequest with ReadonlyMessageMixin {}

class ListServiceAccountsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceAccountsRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListServiceAccountsRequest() : super();
  ListServiceAccountsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceAccountsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceAccountsRequest clone() => new ListServiceAccountsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceAccountsRequest create() => new ListServiceAccountsRequest();
  static PbList<ListServiceAccountsRequest> createRepeated() => new PbList<ListServiceAccountsRequest>();
  static ListServiceAccountsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceAccountsRequest();
    return _defaultInstance;
  }
  static ListServiceAccountsRequest _defaultInstance;
  static void $checkItem(ListServiceAccountsRequest v) {
    if (v is !ListServiceAccountsRequest) checkItemFailed(v, 'ListServiceAccountsRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListServiceAccountsRequest extends ListServiceAccountsRequest with ReadonlyMessageMixin {}

class ListServiceAccountsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceAccountsResponse')
    ..pp/*<ServiceAccount>*/(1, 'accounts', PbFieldType.PM, ServiceAccount.$checkItem, ServiceAccount.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListServiceAccountsResponse() : super();
  ListServiceAccountsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceAccountsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceAccountsResponse clone() => new ListServiceAccountsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceAccountsResponse create() => new ListServiceAccountsResponse();
  static PbList<ListServiceAccountsResponse> createRepeated() => new PbList<ListServiceAccountsResponse>();
  static ListServiceAccountsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceAccountsResponse();
    return _defaultInstance;
  }
  static ListServiceAccountsResponse _defaultInstance;
  static void $checkItem(ListServiceAccountsResponse v) {
    if (v is !ListServiceAccountsResponse) checkItemFailed(v, 'ListServiceAccountsResponse');
  }

  List<ServiceAccount> get accounts => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListServiceAccountsResponse extends ListServiceAccountsResponse with ReadonlyMessageMixin {}

class GetServiceAccountRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetServiceAccountRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetServiceAccountRequest() : super();
  GetServiceAccountRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetServiceAccountRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetServiceAccountRequest clone() => new GetServiceAccountRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetServiceAccountRequest create() => new GetServiceAccountRequest();
  static PbList<GetServiceAccountRequest> createRepeated() => new PbList<GetServiceAccountRequest>();
  static GetServiceAccountRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetServiceAccountRequest();
    return _defaultInstance;
  }
  static GetServiceAccountRequest _defaultInstance;
  static void $checkItem(GetServiceAccountRequest v) {
    if (v is !GetServiceAccountRequest) checkItemFailed(v, 'GetServiceAccountRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetServiceAccountRequest extends GetServiceAccountRequest with ReadonlyMessageMixin {}

class DeleteServiceAccountRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteServiceAccountRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteServiceAccountRequest() : super();
  DeleteServiceAccountRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteServiceAccountRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteServiceAccountRequest clone() => new DeleteServiceAccountRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteServiceAccountRequest create() => new DeleteServiceAccountRequest();
  static PbList<DeleteServiceAccountRequest> createRepeated() => new PbList<DeleteServiceAccountRequest>();
  static DeleteServiceAccountRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteServiceAccountRequest();
    return _defaultInstance;
  }
  static DeleteServiceAccountRequest _defaultInstance;
  static void $checkItem(DeleteServiceAccountRequest v) {
    if (v is !DeleteServiceAccountRequest) checkItemFailed(v, 'DeleteServiceAccountRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteServiceAccountRequest extends DeleteServiceAccountRequest with ReadonlyMessageMixin {}

class ListServiceAccountKeysRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceAccountKeysRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..pp/*<ListServiceAccountKeysRequest_KeyType>*/(2, 'keyTypes', PbFieldType.PE, ListServiceAccountKeysRequest_KeyType.$checkItem, null, ListServiceAccountKeysRequest_KeyType.valueOf)
    ..hasRequiredFields = false
  ;

  ListServiceAccountKeysRequest() : super();
  ListServiceAccountKeysRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceAccountKeysRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceAccountKeysRequest clone() => new ListServiceAccountKeysRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceAccountKeysRequest create() => new ListServiceAccountKeysRequest();
  static PbList<ListServiceAccountKeysRequest> createRepeated() => new PbList<ListServiceAccountKeysRequest>();
  static ListServiceAccountKeysRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceAccountKeysRequest();
    return _defaultInstance;
  }
  static ListServiceAccountKeysRequest _defaultInstance;
  static void $checkItem(ListServiceAccountKeysRequest v) {
    if (v is !ListServiceAccountKeysRequest) checkItemFailed(v, 'ListServiceAccountKeysRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<ListServiceAccountKeysRequest_KeyType> get keyTypes => $_get(1, 2, null);
}

class _ReadonlyListServiceAccountKeysRequest extends ListServiceAccountKeysRequest with ReadonlyMessageMixin {}

class ListServiceAccountKeysResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceAccountKeysResponse')
    ..pp/*<ServiceAccountKey>*/(1, 'keys', PbFieldType.PM, ServiceAccountKey.$checkItem, ServiceAccountKey.create)
    ..hasRequiredFields = false
  ;

  ListServiceAccountKeysResponse() : super();
  ListServiceAccountKeysResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceAccountKeysResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceAccountKeysResponse clone() => new ListServiceAccountKeysResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceAccountKeysResponse create() => new ListServiceAccountKeysResponse();
  static PbList<ListServiceAccountKeysResponse> createRepeated() => new PbList<ListServiceAccountKeysResponse>();
  static ListServiceAccountKeysResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceAccountKeysResponse();
    return _defaultInstance;
  }
  static ListServiceAccountKeysResponse _defaultInstance;
  static void $checkItem(ListServiceAccountKeysResponse v) {
    if (v is !ListServiceAccountKeysResponse) checkItemFailed(v, 'ListServiceAccountKeysResponse');
  }

  List<ServiceAccountKey> get keys => $_get(0, 1, null);
}

class _ReadonlyListServiceAccountKeysResponse extends ListServiceAccountKeysResponse with ReadonlyMessageMixin {}

class GetServiceAccountKeyRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetServiceAccountKeyRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<ServiceAccountPublicKeyType>*/(2, 'publicKeyType', PbFieldType.OE, ServiceAccountPublicKeyType.TYPE_NONE, ServiceAccountPublicKeyType.valueOf)
    ..hasRequiredFields = false
  ;

  GetServiceAccountKeyRequest() : super();
  GetServiceAccountKeyRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetServiceAccountKeyRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetServiceAccountKeyRequest clone() => new GetServiceAccountKeyRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetServiceAccountKeyRequest create() => new GetServiceAccountKeyRequest();
  static PbList<GetServiceAccountKeyRequest> createRepeated() => new PbList<GetServiceAccountKeyRequest>();
  static GetServiceAccountKeyRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetServiceAccountKeyRequest();
    return _defaultInstance;
  }
  static GetServiceAccountKeyRequest _defaultInstance;
  static void $checkItem(GetServiceAccountKeyRequest v) {
    if (v is !GetServiceAccountKeyRequest) checkItemFailed(v, 'GetServiceAccountKeyRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  ServiceAccountPublicKeyType get publicKeyType => $_get(1, 2, null);
  void set publicKeyType(ServiceAccountPublicKeyType v) { setField(2, v); }
  bool hasPublicKeyType() => $_has(1, 2);
  void clearPublicKeyType() => clearField(2);
}

class _ReadonlyGetServiceAccountKeyRequest extends GetServiceAccountKeyRequest with ReadonlyMessageMixin {}

class ServiceAccountKey extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ServiceAccountKey')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<ServiceAccountPrivateKeyType>*/(2, 'privateKeyType', PbFieldType.OE, ServiceAccountPrivateKeyType.TYPE_UNSPECIFIED, ServiceAccountPrivateKeyType.valueOf)
    ..a/*<List<int>>*/(3, 'privateKeyData', PbFieldType.OY)
    ..a/*<google$protobuf.Timestamp>*/(4, 'validAfterTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'validBeforeTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<List<int>>*/(7, 'publicKeyData', PbFieldType.OY)
    ..e/*<ServiceAccountKeyAlgorithm>*/(8, 'keyAlgorithm', PbFieldType.OE, ServiceAccountKeyAlgorithm.KEY_ALG_UNSPECIFIED, ServiceAccountKeyAlgorithm.valueOf)
    ..hasRequiredFields = false
  ;

  ServiceAccountKey() : super();
  ServiceAccountKey.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServiceAccountKey.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServiceAccountKey clone() => new ServiceAccountKey()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ServiceAccountKey create() => new ServiceAccountKey();
  static PbList<ServiceAccountKey> createRepeated() => new PbList<ServiceAccountKey>();
  static ServiceAccountKey getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyServiceAccountKey();
    return _defaultInstance;
  }
  static ServiceAccountKey _defaultInstance;
  static void $checkItem(ServiceAccountKey v) {
    if (v is !ServiceAccountKey) checkItemFailed(v, 'ServiceAccountKey');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  ServiceAccountPrivateKeyType get privateKeyType => $_get(1, 2, null);
  void set privateKeyType(ServiceAccountPrivateKeyType v) { setField(2, v); }
  bool hasPrivateKeyType() => $_has(1, 2);
  void clearPrivateKeyType() => clearField(2);

  List<int> get privateKeyData => $_get(2, 3, null);
  void set privateKeyData(List<int> v) { $_setBytes(2, 3, v); }
  bool hasPrivateKeyData() => $_has(2, 3);
  void clearPrivateKeyData() => clearField(3);

  google$protobuf.Timestamp get validAfterTime => $_get(3, 4, null);
  void set validAfterTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasValidAfterTime() => $_has(3, 4);
  void clearValidAfterTime() => clearField(4);

  google$protobuf.Timestamp get validBeforeTime => $_get(4, 5, null);
  void set validBeforeTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasValidBeforeTime() => $_has(4, 5);
  void clearValidBeforeTime() => clearField(5);

  List<int> get publicKeyData => $_get(5, 7, null);
  void set publicKeyData(List<int> v) { $_setBytes(5, 7, v); }
  bool hasPublicKeyData() => $_has(5, 7);
  void clearPublicKeyData() => clearField(7);

  ServiceAccountKeyAlgorithm get keyAlgorithm => $_get(6, 8, null);
  void set keyAlgorithm(ServiceAccountKeyAlgorithm v) { setField(8, v); }
  bool hasKeyAlgorithm() => $_has(6, 8);
  void clearKeyAlgorithm() => clearField(8);
}

class _ReadonlyServiceAccountKey extends ServiceAccountKey with ReadonlyMessageMixin {}

class CreateServiceAccountKeyRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateServiceAccountKeyRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<ServiceAccountPrivateKeyType>*/(2, 'privateKeyType', PbFieldType.OE, ServiceAccountPrivateKeyType.TYPE_UNSPECIFIED, ServiceAccountPrivateKeyType.valueOf)
    ..e/*<ServiceAccountKeyAlgorithm>*/(3, 'keyAlgorithm', PbFieldType.OE, ServiceAccountKeyAlgorithm.KEY_ALG_UNSPECIFIED, ServiceAccountKeyAlgorithm.valueOf)
    ..hasRequiredFields = false
  ;

  CreateServiceAccountKeyRequest() : super();
  CreateServiceAccountKeyRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateServiceAccountKeyRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateServiceAccountKeyRequest clone() => new CreateServiceAccountKeyRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateServiceAccountKeyRequest create() => new CreateServiceAccountKeyRequest();
  static PbList<CreateServiceAccountKeyRequest> createRepeated() => new PbList<CreateServiceAccountKeyRequest>();
  static CreateServiceAccountKeyRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateServiceAccountKeyRequest();
    return _defaultInstance;
  }
  static CreateServiceAccountKeyRequest _defaultInstance;
  static void $checkItem(CreateServiceAccountKeyRequest v) {
    if (v is !CreateServiceAccountKeyRequest) checkItemFailed(v, 'CreateServiceAccountKeyRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  ServiceAccountPrivateKeyType get privateKeyType => $_get(1, 2, null);
  void set privateKeyType(ServiceAccountPrivateKeyType v) { setField(2, v); }
  bool hasPrivateKeyType() => $_has(1, 2);
  void clearPrivateKeyType() => clearField(2);

  ServiceAccountKeyAlgorithm get keyAlgorithm => $_get(2, 3, null);
  void set keyAlgorithm(ServiceAccountKeyAlgorithm v) { setField(3, v); }
  bool hasKeyAlgorithm() => $_has(2, 3);
  void clearKeyAlgorithm() => clearField(3);
}

class _ReadonlyCreateServiceAccountKeyRequest extends CreateServiceAccountKeyRequest with ReadonlyMessageMixin {}

class DeleteServiceAccountKeyRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteServiceAccountKeyRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteServiceAccountKeyRequest() : super();
  DeleteServiceAccountKeyRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteServiceAccountKeyRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteServiceAccountKeyRequest clone() => new DeleteServiceAccountKeyRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteServiceAccountKeyRequest create() => new DeleteServiceAccountKeyRequest();
  static PbList<DeleteServiceAccountKeyRequest> createRepeated() => new PbList<DeleteServiceAccountKeyRequest>();
  static DeleteServiceAccountKeyRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteServiceAccountKeyRequest();
    return _defaultInstance;
  }
  static DeleteServiceAccountKeyRequest _defaultInstance;
  static void $checkItem(DeleteServiceAccountKeyRequest v) {
    if (v is !DeleteServiceAccountKeyRequest) checkItemFailed(v, 'DeleteServiceAccountKeyRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteServiceAccountKeyRequest extends DeleteServiceAccountKeyRequest with ReadonlyMessageMixin {}

class SignBlobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SignBlobRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'bytesToSign', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  SignBlobRequest() : super();
  SignBlobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SignBlobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SignBlobRequest clone() => new SignBlobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SignBlobRequest create() => new SignBlobRequest();
  static PbList<SignBlobRequest> createRepeated() => new PbList<SignBlobRequest>();
  static SignBlobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySignBlobRequest();
    return _defaultInstance;
  }
  static SignBlobRequest _defaultInstance;
  static void $checkItem(SignBlobRequest v) {
    if (v is !SignBlobRequest) checkItemFailed(v, 'SignBlobRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<int> get bytesToSign => $_get(1, 2, null);
  void set bytesToSign(List<int> v) { $_setBytes(1, 2, v); }
  bool hasBytesToSign() => $_has(1, 2);
  void clearBytesToSign() => clearField(2);
}

class _ReadonlySignBlobRequest extends SignBlobRequest with ReadonlyMessageMixin {}

class SignBlobResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SignBlobResponse')
    ..a/*<String>*/(1, 'keyId', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'signature', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  SignBlobResponse() : super();
  SignBlobResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SignBlobResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SignBlobResponse clone() => new SignBlobResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SignBlobResponse create() => new SignBlobResponse();
  static PbList<SignBlobResponse> createRepeated() => new PbList<SignBlobResponse>();
  static SignBlobResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySignBlobResponse();
    return _defaultInstance;
  }
  static SignBlobResponse _defaultInstance;
  static void $checkItem(SignBlobResponse v) {
    if (v is !SignBlobResponse) checkItemFailed(v, 'SignBlobResponse');
  }

  String get keyId => $_get(0, 1, '');
  void set keyId(String v) { $_setString(0, 1, v); }
  bool hasKeyId() => $_has(0, 1);
  void clearKeyId() => clearField(1);

  List<int> get signature => $_get(1, 2, null);
  void set signature(List<int> v) { $_setBytes(1, 2, v); }
  bool hasSignature() => $_has(1, 2);
  void clearSignature() => clearField(2);
}

class _ReadonlySignBlobResponse extends SignBlobResponse with ReadonlyMessageMixin {}

class Role extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Role')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'title', PbFieldType.OS)
    ..a/*<String>*/(3, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Role() : super();
  Role.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Role.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Role clone() => new Role()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Role create() => new Role();
  static PbList<Role> createRepeated() => new PbList<Role>();
  static Role getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRole();
    return _defaultInstance;
  }
  static Role _defaultInstance;
  static void $checkItem(Role v) {
    if (v is !Role) checkItemFailed(v, 'Role');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get title => $_get(1, 2, '');
  void set title(String v) { $_setString(1, 2, v); }
  bool hasTitle() => $_has(1, 2);
  void clearTitle() => clearField(2);

  String get description => $_get(2, 3, '');
  void set description(String v) { $_setString(2, 3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);
}

class _ReadonlyRole extends Role with ReadonlyMessageMixin {}

class QueryGrantableRolesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryGrantableRolesRequest')
    ..a/*<String>*/(1, 'fullResourceName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  QueryGrantableRolesRequest() : super();
  QueryGrantableRolesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryGrantableRolesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryGrantableRolesRequest clone() => new QueryGrantableRolesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QueryGrantableRolesRequest create() => new QueryGrantableRolesRequest();
  static PbList<QueryGrantableRolesRequest> createRepeated() => new PbList<QueryGrantableRolesRequest>();
  static QueryGrantableRolesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQueryGrantableRolesRequest();
    return _defaultInstance;
  }
  static QueryGrantableRolesRequest _defaultInstance;
  static void $checkItem(QueryGrantableRolesRequest v) {
    if (v is !QueryGrantableRolesRequest) checkItemFailed(v, 'QueryGrantableRolesRequest');
  }

  String get fullResourceName => $_get(0, 1, '');
  void set fullResourceName(String v) { $_setString(0, 1, v); }
  bool hasFullResourceName() => $_has(0, 1);
  void clearFullResourceName() => clearField(1);
}

class _ReadonlyQueryGrantableRolesRequest extends QueryGrantableRolesRequest with ReadonlyMessageMixin {}

class QueryGrantableRolesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryGrantableRolesResponse')
    ..pp/*<Role>*/(1, 'roles', PbFieldType.PM, Role.$checkItem, Role.create)
    ..hasRequiredFields = false
  ;

  QueryGrantableRolesResponse() : super();
  QueryGrantableRolesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryGrantableRolesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryGrantableRolesResponse clone() => new QueryGrantableRolesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QueryGrantableRolesResponse create() => new QueryGrantableRolesResponse();
  static PbList<QueryGrantableRolesResponse> createRepeated() => new PbList<QueryGrantableRolesResponse>();
  static QueryGrantableRolesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQueryGrantableRolesResponse();
    return _defaultInstance;
  }
  static QueryGrantableRolesResponse _defaultInstance;
  static void $checkItem(QueryGrantableRolesResponse v) {
    if (v is !QueryGrantableRolesResponse) checkItemFailed(v, 'QueryGrantableRolesResponse');
  }

  List<Role> get roles => $_get(0, 1, null);
}

class _ReadonlyQueryGrantableRolesResponse extends QueryGrantableRolesResponse with ReadonlyMessageMixin {}

class IAMApi {
  RpcClient _client;
  IAMApi(this._client);

  Future<ListServiceAccountsResponse> listServiceAccounts(ClientContext ctx, ListServiceAccountsRequest request) {
    var emptyResponse = new ListServiceAccountsResponse();
    return _client.invoke(ctx, 'IAM', 'ListServiceAccounts', request, emptyResponse);
  }
  Future<ServiceAccount> getServiceAccount(ClientContext ctx, GetServiceAccountRequest request) {
    var emptyResponse = new ServiceAccount();
    return _client.invoke(ctx, 'IAM', 'GetServiceAccount', request, emptyResponse);
  }
  Future<ServiceAccount> createServiceAccount(ClientContext ctx, CreateServiceAccountRequest request) {
    var emptyResponse = new ServiceAccount();
    return _client.invoke(ctx, 'IAM', 'CreateServiceAccount', request, emptyResponse);
  }
  Future<ServiceAccount> updateServiceAccount(ClientContext ctx, ServiceAccount request) {
    var emptyResponse = new ServiceAccount();
    return _client.invoke(ctx, 'IAM', 'UpdateServiceAccount', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteServiceAccount(ClientContext ctx, DeleteServiceAccountRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'IAM', 'DeleteServiceAccount', request, emptyResponse);
  }
  Future<ListServiceAccountKeysResponse> listServiceAccountKeys(ClientContext ctx, ListServiceAccountKeysRequest request) {
    var emptyResponse = new ListServiceAccountKeysResponse();
    return _client.invoke(ctx, 'IAM', 'ListServiceAccountKeys', request, emptyResponse);
  }
  Future<ServiceAccountKey> getServiceAccountKey(ClientContext ctx, GetServiceAccountKeyRequest request) {
    var emptyResponse = new ServiceAccountKey();
    return _client.invoke(ctx, 'IAM', 'GetServiceAccountKey', request, emptyResponse);
  }
  Future<ServiceAccountKey> createServiceAccountKey(ClientContext ctx, CreateServiceAccountKeyRequest request) {
    var emptyResponse = new ServiceAccountKey();
    return _client.invoke(ctx, 'IAM', 'CreateServiceAccountKey', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteServiceAccountKey(ClientContext ctx, DeleteServiceAccountKeyRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'IAM', 'DeleteServiceAccountKey', request, emptyResponse);
  }
  Future<SignBlobResponse> signBlob(ClientContext ctx, SignBlobRequest request) {
    var emptyResponse = new SignBlobResponse();
    return _client.invoke(ctx, 'IAM', 'SignBlob', request, emptyResponse);
  }
  Future<google$iam$v1.Policy> getIamPolicy(ClientContext ctx, google$iam$v1.GetIamPolicyRequest request) {
    var emptyResponse = new google$iam$v1.Policy();
    return _client.invoke(ctx, 'IAM', 'GetIamPolicy', request, emptyResponse);
  }
  Future<google$iam$v1.Policy> setIamPolicy(ClientContext ctx, google$iam$v1.SetIamPolicyRequest request) {
    var emptyResponse = new google$iam$v1.Policy();
    return _client.invoke(ctx, 'IAM', 'SetIamPolicy', request, emptyResponse);
  }
  Future<google$iam$v1.TestIamPermissionsResponse> testIamPermissions(ClientContext ctx, google$iam$v1.TestIamPermissionsRequest request) {
    var emptyResponse = new google$iam$v1.TestIamPermissionsResponse();
    return _client.invoke(ctx, 'IAM', 'TestIamPermissions', request, emptyResponse);
  }
  Future<QueryGrantableRolesResponse> queryGrantableRoles(ClientContext ctx, QueryGrantableRolesRequest request) {
    var emptyResponse = new QueryGrantableRolesResponse();
    return _client.invoke(ctx, 'IAM', 'QueryGrantableRoles', request, emptyResponse);
  }
}

