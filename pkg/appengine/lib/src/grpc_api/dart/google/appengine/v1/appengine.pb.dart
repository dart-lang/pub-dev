///
//  Generated code. Do not modify.
///
library google.appengine.v1_appengine;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'service.pb.dart';
import '../../protobuf/field_mask.pb.dart' as google$protobuf;
import 'version.pb.dart';
import 'instance.pb.dart';
import '../../longrunning/operations.pb.dart' as google$longrunning;
import 'application.pb.dart';

import 'appengine.pbenum.dart';

export 'appengine.pbenum.dart';

class GetApplicationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetApplicationRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetApplicationRequest() : super();
  GetApplicationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetApplicationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetApplicationRequest clone() => new GetApplicationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetApplicationRequest create() => new GetApplicationRequest();
  static PbList<GetApplicationRequest> createRepeated() => new PbList<GetApplicationRequest>();
  static GetApplicationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetApplicationRequest();
    return _defaultInstance;
  }
  static GetApplicationRequest _defaultInstance;
  static void $checkItem(GetApplicationRequest v) {
    if (v is !GetApplicationRequest) checkItemFailed(v, 'GetApplicationRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetApplicationRequest extends GetApplicationRequest with ReadonlyMessageMixin {}

class RepairApplicationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RepairApplicationRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RepairApplicationRequest() : super();
  RepairApplicationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RepairApplicationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RepairApplicationRequest clone() => new RepairApplicationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RepairApplicationRequest create() => new RepairApplicationRequest();
  static PbList<RepairApplicationRequest> createRepeated() => new PbList<RepairApplicationRequest>();
  static RepairApplicationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRepairApplicationRequest();
    return _defaultInstance;
  }
  static RepairApplicationRequest _defaultInstance;
  static void $checkItem(RepairApplicationRequest v) {
    if (v is !RepairApplicationRequest) checkItemFailed(v, 'RepairApplicationRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyRepairApplicationRequest extends RepairApplicationRequest with ReadonlyMessageMixin {}

class ListServicesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServicesRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListServicesRequest() : super();
  ListServicesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServicesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServicesRequest clone() => new ListServicesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServicesRequest create() => new ListServicesRequest();
  static PbList<ListServicesRequest> createRepeated() => new PbList<ListServicesRequest>();
  static ListServicesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServicesRequest();
    return _defaultInstance;
  }
  static ListServicesRequest _defaultInstance;
  static void $checkItem(ListServicesRequest v) {
    if (v is !ListServicesRequest) checkItemFailed(v, 'ListServicesRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListServicesRequest extends ListServicesRequest with ReadonlyMessageMixin {}

class ListServicesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServicesResponse')
    ..pp/*<Service>*/(1, 'services', PbFieldType.PM, Service.$checkItem, Service.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListServicesResponse() : super();
  ListServicesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServicesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServicesResponse clone() => new ListServicesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServicesResponse create() => new ListServicesResponse();
  static PbList<ListServicesResponse> createRepeated() => new PbList<ListServicesResponse>();
  static ListServicesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServicesResponse();
    return _defaultInstance;
  }
  static ListServicesResponse _defaultInstance;
  static void $checkItem(ListServicesResponse v) {
    if (v is !ListServicesResponse) checkItemFailed(v, 'ListServicesResponse');
  }

  List<Service> get services => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListServicesResponse extends ListServicesResponse with ReadonlyMessageMixin {}

class GetServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetServiceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetServiceRequest() : super();
  GetServiceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetServiceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetServiceRequest clone() => new GetServiceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetServiceRequest create() => new GetServiceRequest();
  static PbList<GetServiceRequest> createRepeated() => new PbList<GetServiceRequest>();
  static GetServiceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetServiceRequest();
    return _defaultInstance;
  }
  static GetServiceRequest _defaultInstance;
  static void $checkItem(GetServiceRequest v) {
    if (v is !GetServiceRequest) checkItemFailed(v, 'GetServiceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetServiceRequest extends GetServiceRequest with ReadonlyMessageMixin {}

class UpdateServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateServiceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<Service>*/(2, 'service', PbFieldType.OM, Service.getDefault, Service.create)
    ..a/*<google$protobuf.FieldMask>*/(3, 'updateMask', PbFieldType.OM, google$protobuf.FieldMask.getDefault, google$protobuf.FieldMask.create)
    ..a/*<bool>*/(4, 'migrateTraffic', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  UpdateServiceRequest() : super();
  UpdateServiceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateServiceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateServiceRequest clone() => new UpdateServiceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateServiceRequest create() => new UpdateServiceRequest();
  static PbList<UpdateServiceRequest> createRepeated() => new PbList<UpdateServiceRequest>();
  static UpdateServiceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateServiceRequest();
    return _defaultInstance;
  }
  static UpdateServiceRequest _defaultInstance;
  static void $checkItem(UpdateServiceRequest v) {
    if (v is !UpdateServiceRequest) checkItemFailed(v, 'UpdateServiceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Service get service => $_get(1, 2, null);
  void set service(Service v) { setField(2, v); }
  bool hasService() => $_has(1, 2);
  void clearService() => clearField(2);

  google$protobuf.FieldMask get updateMask => $_get(2, 3, null);
  void set updateMask(google$protobuf.FieldMask v) { setField(3, v); }
  bool hasUpdateMask() => $_has(2, 3);
  void clearUpdateMask() => clearField(3);

  bool get migrateTraffic => $_get(3, 4, false);
  void set migrateTraffic(bool v) { $_setBool(3, 4, v); }
  bool hasMigrateTraffic() => $_has(3, 4);
  void clearMigrateTraffic() => clearField(4);
}

class _ReadonlyUpdateServiceRequest extends UpdateServiceRequest with ReadonlyMessageMixin {}

class DeleteServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteServiceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteServiceRequest() : super();
  DeleteServiceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteServiceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteServiceRequest clone() => new DeleteServiceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteServiceRequest create() => new DeleteServiceRequest();
  static PbList<DeleteServiceRequest> createRepeated() => new PbList<DeleteServiceRequest>();
  static DeleteServiceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteServiceRequest();
    return _defaultInstance;
  }
  static DeleteServiceRequest _defaultInstance;
  static void $checkItem(DeleteServiceRequest v) {
    if (v is !DeleteServiceRequest) checkItemFailed(v, 'DeleteServiceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteServiceRequest extends DeleteServiceRequest with ReadonlyMessageMixin {}

class ListVersionsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListVersionsRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..e/*<VersionView>*/(2, 'view', PbFieldType.OE, VersionView.BASIC, VersionView.valueOf)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListVersionsRequest() : super();
  ListVersionsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListVersionsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListVersionsRequest clone() => new ListVersionsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListVersionsRequest create() => new ListVersionsRequest();
  static PbList<ListVersionsRequest> createRepeated() => new PbList<ListVersionsRequest>();
  static ListVersionsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListVersionsRequest();
    return _defaultInstance;
  }
  static ListVersionsRequest _defaultInstance;
  static void $checkItem(ListVersionsRequest v) {
    if (v is !ListVersionsRequest) checkItemFailed(v, 'ListVersionsRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  VersionView get view => $_get(1, 2, null);
  void set view(VersionView v) { setField(2, v); }
  bool hasView() => $_has(1, 2);
  void clearView() => clearField(2);

  int get pageSize => $_get(2, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasPageSize() => $_has(2, 3);
  void clearPageSize() => clearField(3);

  String get pageToken => $_get(3, 4, '');
  void set pageToken(String v) { $_setString(3, 4, v); }
  bool hasPageToken() => $_has(3, 4);
  void clearPageToken() => clearField(4);
}

class _ReadonlyListVersionsRequest extends ListVersionsRequest with ReadonlyMessageMixin {}

class ListVersionsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListVersionsResponse')
    ..pp/*<Version>*/(1, 'versions', PbFieldType.PM, Version.$checkItem, Version.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListVersionsResponse() : super();
  ListVersionsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListVersionsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListVersionsResponse clone() => new ListVersionsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListVersionsResponse create() => new ListVersionsResponse();
  static PbList<ListVersionsResponse> createRepeated() => new PbList<ListVersionsResponse>();
  static ListVersionsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListVersionsResponse();
    return _defaultInstance;
  }
  static ListVersionsResponse _defaultInstance;
  static void $checkItem(ListVersionsResponse v) {
    if (v is !ListVersionsResponse) checkItemFailed(v, 'ListVersionsResponse');
  }

  List<Version> get versions => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListVersionsResponse extends ListVersionsResponse with ReadonlyMessageMixin {}

class GetVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetVersionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..e/*<VersionView>*/(2, 'view', PbFieldType.OE, VersionView.BASIC, VersionView.valueOf)
    ..hasRequiredFields = false
  ;

  GetVersionRequest() : super();
  GetVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetVersionRequest clone() => new GetVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetVersionRequest create() => new GetVersionRequest();
  static PbList<GetVersionRequest> createRepeated() => new PbList<GetVersionRequest>();
  static GetVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetVersionRequest();
    return _defaultInstance;
  }
  static GetVersionRequest _defaultInstance;
  static void $checkItem(GetVersionRequest v) {
    if (v is !GetVersionRequest) checkItemFailed(v, 'GetVersionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  VersionView get view => $_get(1, 2, null);
  void set view(VersionView v) { setField(2, v); }
  bool hasView() => $_has(1, 2);
  void clearView() => clearField(2);
}

class _ReadonlyGetVersionRequest extends GetVersionRequest with ReadonlyMessageMixin {}

class CreateVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateVersionRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<Version>*/(2, 'version', PbFieldType.OM, Version.getDefault, Version.create)
    ..hasRequiredFields = false
  ;

  CreateVersionRequest() : super();
  CreateVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateVersionRequest clone() => new CreateVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateVersionRequest create() => new CreateVersionRequest();
  static PbList<CreateVersionRequest> createRepeated() => new PbList<CreateVersionRequest>();
  static CreateVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateVersionRequest();
    return _defaultInstance;
  }
  static CreateVersionRequest _defaultInstance;
  static void $checkItem(CreateVersionRequest v) {
    if (v is !CreateVersionRequest) checkItemFailed(v, 'CreateVersionRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  Version get version => $_get(1, 2, null);
  void set version(Version v) { setField(2, v); }
  bool hasVersion() => $_has(1, 2);
  void clearVersion() => clearField(2);
}

class _ReadonlyCreateVersionRequest extends CreateVersionRequest with ReadonlyMessageMixin {}

class UpdateVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateVersionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<Version>*/(2, 'version', PbFieldType.OM, Version.getDefault, Version.create)
    ..a/*<google$protobuf.FieldMask>*/(3, 'updateMask', PbFieldType.OM, google$protobuf.FieldMask.getDefault, google$protobuf.FieldMask.create)
    ..hasRequiredFields = false
  ;

  UpdateVersionRequest() : super();
  UpdateVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateVersionRequest clone() => new UpdateVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateVersionRequest create() => new UpdateVersionRequest();
  static PbList<UpdateVersionRequest> createRepeated() => new PbList<UpdateVersionRequest>();
  static UpdateVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateVersionRequest();
    return _defaultInstance;
  }
  static UpdateVersionRequest _defaultInstance;
  static void $checkItem(UpdateVersionRequest v) {
    if (v is !UpdateVersionRequest) checkItemFailed(v, 'UpdateVersionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Version get version => $_get(1, 2, null);
  void set version(Version v) { setField(2, v); }
  bool hasVersion() => $_has(1, 2);
  void clearVersion() => clearField(2);

  google$protobuf.FieldMask get updateMask => $_get(2, 3, null);
  void set updateMask(google$protobuf.FieldMask v) { setField(3, v); }
  bool hasUpdateMask() => $_has(2, 3);
  void clearUpdateMask() => clearField(3);
}

class _ReadonlyUpdateVersionRequest extends UpdateVersionRequest with ReadonlyMessageMixin {}

class DeleteVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteVersionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteVersionRequest() : super();
  DeleteVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteVersionRequest clone() => new DeleteVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteVersionRequest create() => new DeleteVersionRequest();
  static PbList<DeleteVersionRequest> createRepeated() => new PbList<DeleteVersionRequest>();
  static DeleteVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteVersionRequest();
    return _defaultInstance;
  }
  static DeleteVersionRequest _defaultInstance;
  static void $checkItem(DeleteVersionRequest v) {
    if (v is !DeleteVersionRequest) checkItemFailed(v, 'DeleteVersionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteVersionRequest extends DeleteVersionRequest with ReadonlyMessageMixin {}

class ListInstancesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListInstancesRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListInstancesRequest() : super();
  ListInstancesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListInstancesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListInstancesRequest clone() => new ListInstancesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListInstancesRequest create() => new ListInstancesRequest();
  static PbList<ListInstancesRequest> createRepeated() => new PbList<ListInstancesRequest>();
  static ListInstancesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListInstancesRequest();
    return _defaultInstance;
  }
  static ListInstancesRequest _defaultInstance;
  static void $checkItem(ListInstancesRequest v) {
    if (v is !ListInstancesRequest) checkItemFailed(v, 'ListInstancesRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListInstancesRequest extends ListInstancesRequest with ReadonlyMessageMixin {}

class ListInstancesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListInstancesResponse')
    ..pp/*<Instance>*/(1, 'instances', PbFieldType.PM, Instance.$checkItem, Instance.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListInstancesResponse() : super();
  ListInstancesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListInstancesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListInstancesResponse clone() => new ListInstancesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListInstancesResponse create() => new ListInstancesResponse();
  static PbList<ListInstancesResponse> createRepeated() => new PbList<ListInstancesResponse>();
  static ListInstancesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListInstancesResponse();
    return _defaultInstance;
  }
  static ListInstancesResponse _defaultInstance;
  static void $checkItem(ListInstancesResponse v) {
    if (v is !ListInstancesResponse) checkItemFailed(v, 'ListInstancesResponse');
  }

  List<Instance> get instances => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListInstancesResponse extends ListInstancesResponse with ReadonlyMessageMixin {}

class GetInstanceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetInstanceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetInstanceRequest() : super();
  GetInstanceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetInstanceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetInstanceRequest clone() => new GetInstanceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetInstanceRequest create() => new GetInstanceRequest();
  static PbList<GetInstanceRequest> createRepeated() => new PbList<GetInstanceRequest>();
  static GetInstanceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetInstanceRequest();
    return _defaultInstance;
  }
  static GetInstanceRequest _defaultInstance;
  static void $checkItem(GetInstanceRequest v) {
    if (v is !GetInstanceRequest) checkItemFailed(v, 'GetInstanceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetInstanceRequest extends GetInstanceRequest with ReadonlyMessageMixin {}

class DeleteInstanceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteInstanceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteInstanceRequest() : super();
  DeleteInstanceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteInstanceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteInstanceRequest clone() => new DeleteInstanceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteInstanceRequest create() => new DeleteInstanceRequest();
  static PbList<DeleteInstanceRequest> createRepeated() => new PbList<DeleteInstanceRequest>();
  static DeleteInstanceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteInstanceRequest();
    return _defaultInstance;
  }
  static DeleteInstanceRequest _defaultInstance;
  static void $checkItem(DeleteInstanceRequest v) {
    if (v is !DeleteInstanceRequest) checkItemFailed(v, 'DeleteInstanceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteInstanceRequest extends DeleteInstanceRequest with ReadonlyMessageMixin {}

class DebugInstanceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DebugInstanceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DebugInstanceRequest() : super();
  DebugInstanceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DebugInstanceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DebugInstanceRequest clone() => new DebugInstanceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DebugInstanceRequest create() => new DebugInstanceRequest();
  static PbList<DebugInstanceRequest> createRepeated() => new PbList<DebugInstanceRequest>();
  static DebugInstanceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDebugInstanceRequest();
    return _defaultInstance;
  }
  static DebugInstanceRequest _defaultInstance;
  static void $checkItem(DebugInstanceRequest v) {
    if (v is !DebugInstanceRequest) checkItemFailed(v, 'DebugInstanceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDebugInstanceRequest extends DebugInstanceRequest with ReadonlyMessageMixin {}

class InstancesApi {
  RpcClient _client;
  InstancesApi(this._client);

  Future<ListInstancesResponse> listInstances(ClientContext ctx, ListInstancesRequest request) {
    var emptyResponse = new ListInstancesResponse();
    return _client.invoke(ctx, 'Instances', 'ListInstances', request, emptyResponse);
  }
  Future<Instance> getInstance(ClientContext ctx, GetInstanceRequest request) {
    var emptyResponse = new Instance();
    return _client.invoke(ctx, 'Instances', 'GetInstance', request, emptyResponse);
  }
  Future<google$longrunning.Operation> deleteInstance(ClientContext ctx, DeleteInstanceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Instances', 'DeleteInstance', request, emptyResponse);
  }
  Future<google$longrunning.Operation> debugInstance(ClientContext ctx, DebugInstanceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Instances', 'DebugInstance', request, emptyResponse);
  }
}

class VersionsApi {
  RpcClient _client;
  VersionsApi(this._client);

  Future<ListVersionsResponse> listVersions(ClientContext ctx, ListVersionsRequest request) {
    var emptyResponse = new ListVersionsResponse();
    return _client.invoke(ctx, 'Versions', 'ListVersions', request, emptyResponse);
  }
  Future<Version> getVersion(ClientContext ctx, GetVersionRequest request) {
    var emptyResponse = new Version();
    return _client.invoke(ctx, 'Versions', 'GetVersion', request, emptyResponse);
  }
  Future<google$longrunning.Operation> createVersion(ClientContext ctx, CreateVersionRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Versions', 'CreateVersion', request, emptyResponse);
  }
  Future<google$longrunning.Operation> updateVersion(ClientContext ctx, UpdateVersionRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Versions', 'UpdateVersion', request, emptyResponse);
  }
  Future<google$longrunning.Operation> deleteVersion(ClientContext ctx, DeleteVersionRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Versions', 'DeleteVersion', request, emptyResponse);
  }
}

class ServicesApi {
  RpcClient _client;
  ServicesApi(this._client);

  Future<ListServicesResponse> listServices(ClientContext ctx, ListServicesRequest request) {
    var emptyResponse = new ListServicesResponse();
    return _client.invoke(ctx, 'Services', 'ListServices', request, emptyResponse);
  }
  Future<Service> getService(ClientContext ctx, GetServiceRequest request) {
    var emptyResponse = new Service();
    return _client.invoke(ctx, 'Services', 'GetService', request, emptyResponse);
  }
  Future<google$longrunning.Operation> updateService(ClientContext ctx, UpdateServiceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Services', 'UpdateService', request, emptyResponse);
  }
  Future<google$longrunning.Operation> deleteService(ClientContext ctx, DeleteServiceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Services', 'DeleteService', request, emptyResponse);
  }
}

class ApplicationsApi {
  RpcClient _client;
  ApplicationsApi(this._client);

  Future<Application> getApplication(ClientContext ctx, GetApplicationRequest request) {
    var emptyResponse = new Application();
    return _client.invoke(ctx, 'Applications', 'GetApplication', request, emptyResponse);
  }
  Future<google$longrunning.Operation> repairApplication(ClientContext ctx, RepairApplicationRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Applications', 'RepairApplication', request, emptyResponse);
  }
}

