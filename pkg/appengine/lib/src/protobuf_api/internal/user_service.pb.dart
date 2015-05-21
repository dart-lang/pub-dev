///
//  Generated code. Do not modify.
///
library appengine.user;

import 'package:protobuf/protobuf.dart';

class UserServiceError_ErrorCode extends ProtobufEnum {
  static const UserServiceError_ErrorCode OK = const UserServiceError_ErrorCode._(0, 'OK');
  static const UserServiceError_ErrorCode REDIRECT_URL_TOO_LONG = const UserServiceError_ErrorCode._(1, 'REDIRECT_URL_TOO_LONG');
  static const UserServiceError_ErrorCode NOT_ALLOWED = const UserServiceError_ErrorCode._(2, 'NOT_ALLOWED');
  static const UserServiceError_ErrorCode OAUTH_INVALID_TOKEN = const UserServiceError_ErrorCode._(3, 'OAUTH_INVALID_TOKEN');
  static const UserServiceError_ErrorCode OAUTH_INVALID_REQUEST = const UserServiceError_ErrorCode._(4, 'OAUTH_INVALID_REQUEST');
  static const UserServiceError_ErrorCode OAUTH_ERROR = const UserServiceError_ErrorCode._(5, 'OAUTH_ERROR');

  static const List<UserServiceError_ErrorCode> values = const <UserServiceError_ErrorCode> [
    OK,
    REDIRECT_URL_TOO_LONG,
    NOT_ALLOWED,
    OAUTH_INVALID_TOKEN,
    OAUTH_INVALID_REQUEST,
    OAUTH_ERROR,
  ];

  static final Map<int, UserServiceError_ErrorCode> _byValue = ProtobufEnum.initByValue(values);
  static UserServiceError_ErrorCode valueOf(int value) => _byValue[value];

  const UserServiceError_ErrorCode._(int v, String n) : super(v, n);
}

class UserServiceError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UserServiceError')
    ..hasRequiredFields = false
  ;

  UserServiceError() : super();
  UserServiceError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UserServiceError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UserServiceError clone() => new UserServiceError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class CreateLoginURLRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateLoginURLRequest')
    ..a(1, 'destinationUrl', GeneratedMessage.QS)
    ..a(2, 'authDomain', GeneratedMessage.OS)
    ..a(3, 'federatedIdentity', GeneratedMessage.OS)
  ;

  CreateLoginURLRequest() : super();
  CreateLoginURLRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateLoginURLRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateLoginURLRequest clone() => new CreateLoginURLRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get destinationUrl => getField(1);
  void set destinationUrl(String v) { setField(1, v); }
  bool hasDestinationUrl() => hasField(1);
  void clearDestinationUrl() => clearField(1);

  String get authDomain => getField(2);
  void set authDomain(String v) { setField(2, v); }
  bool hasAuthDomain() => hasField(2);
  void clearAuthDomain() => clearField(2);

  String get federatedIdentity => getField(3);
  void set federatedIdentity(String v) { setField(3, v); }
  bool hasFederatedIdentity() => hasField(3);
  void clearFederatedIdentity() => clearField(3);
}

class CreateLoginURLResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateLoginURLResponse')
    ..a(1, 'loginUrl', GeneratedMessage.QS)
  ;

  CreateLoginURLResponse() : super();
  CreateLoginURLResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateLoginURLResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateLoginURLResponse clone() => new CreateLoginURLResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get loginUrl => getField(1);
  void set loginUrl(String v) { setField(1, v); }
  bool hasLoginUrl() => hasField(1);
  void clearLoginUrl() => clearField(1);
}

class CreateLogoutURLRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateLogoutURLRequest')
    ..a(1, 'destinationUrl', GeneratedMessage.QS)
    ..a(2, 'authDomain', GeneratedMessage.OS)
  ;

  CreateLogoutURLRequest() : super();
  CreateLogoutURLRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateLogoutURLRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateLogoutURLRequest clone() => new CreateLogoutURLRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get destinationUrl => getField(1);
  void set destinationUrl(String v) { setField(1, v); }
  bool hasDestinationUrl() => hasField(1);
  void clearDestinationUrl() => clearField(1);

  String get authDomain => getField(2);
  void set authDomain(String v) { setField(2, v); }
  bool hasAuthDomain() => hasField(2);
  void clearAuthDomain() => clearField(2);
}

class CreateLogoutURLResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateLogoutURLResponse')
    ..a(1, 'logoutUrl', GeneratedMessage.QS)
  ;

  CreateLogoutURLResponse() : super();
  CreateLogoutURLResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateLogoutURLResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateLogoutURLResponse clone() => new CreateLogoutURLResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get logoutUrl => getField(1);
  void set logoutUrl(String v) { setField(1, v); }
  bool hasLogoutUrl() => hasField(1);
  void clearLogoutUrl() => clearField(1);
}

class GetOAuthUserRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetOAuthUserRequest')
    ..a(1, 'scope', GeneratedMessage.OS)
    ..p(2, 'scopes', GeneratedMessage.PS)
    ..hasRequiredFields = false
  ;

  GetOAuthUserRequest() : super();
  GetOAuthUserRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetOAuthUserRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetOAuthUserRequest clone() => new GetOAuthUserRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get scope => getField(1);
  void set scope(String v) { setField(1, v); }
  bool hasScope() => hasField(1);
  void clearScope() => clearField(1);

  List<String> get scopes => getField(2);
}

class GetOAuthUserResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetOAuthUserResponse')
    ..a(1, 'email', GeneratedMessage.QS)
    ..a(2, 'userId', GeneratedMessage.QS)
    ..a(3, 'authDomain', GeneratedMessage.QS)
    ..a(4, 'userOrganization', GeneratedMessage.OS)
    ..a(5, 'isAdmin', GeneratedMessage.OB)
    ..a(6, 'clientId', GeneratedMessage.OS)
    ..p(7, 'scopes', GeneratedMessage.PS)
  ;

  GetOAuthUserResponse() : super();
  GetOAuthUserResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetOAuthUserResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetOAuthUserResponse clone() => new GetOAuthUserResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get email => getField(1);
  void set email(String v) { setField(1, v); }
  bool hasEmail() => hasField(1);
  void clearEmail() => clearField(1);

  String get userId => getField(2);
  void set userId(String v) { setField(2, v); }
  bool hasUserId() => hasField(2);
  void clearUserId() => clearField(2);

  String get authDomain => getField(3);
  void set authDomain(String v) { setField(3, v); }
  bool hasAuthDomain() => hasField(3);
  void clearAuthDomain() => clearField(3);

  String get userOrganization => getField(4);
  void set userOrganization(String v) { setField(4, v); }
  bool hasUserOrganization() => hasField(4);
  void clearUserOrganization() => clearField(4);

  bool get isAdmin => getField(5);
  void set isAdmin(bool v) { setField(5, v); }
  bool hasIsAdmin() => hasField(5);
  void clearIsAdmin() => clearField(5);

  String get clientId => getField(6);
  void set clientId(String v) { setField(6, v); }
  bool hasClientId() => hasField(6);
  void clearClientId() => clearField(6);

  List<String> get scopes => getField(7);
}

class CheckOAuthSignatureRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CheckOAuthSignatureRequest')
    ..hasRequiredFields = false
  ;

  CheckOAuthSignatureRequest() : super();
  CheckOAuthSignatureRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CheckOAuthSignatureRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CheckOAuthSignatureRequest clone() => new CheckOAuthSignatureRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class CheckOAuthSignatureResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CheckOAuthSignatureResponse')
    ..a(1, 'oauthConsumerKey', GeneratedMessage.QS)
  ;

  CheckOAuthSignatureResponse() : super();
  CheckOAuthSignatureResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CheckOAuthSignatureResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CheckOAuthSignatureResponse clone() => new CheckOAuthSignatureResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get oauthConsumerKey => getField(1);
  void set oauthConsumerKey(String v) { setField(1, v); }
  bool hasOauthConsumerKey() => hasField(1);
  void clearOauthConsumerKey() => clearField(1);
}

