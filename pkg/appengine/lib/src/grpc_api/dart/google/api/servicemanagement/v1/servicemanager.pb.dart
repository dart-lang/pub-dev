///
//  Generated code. Do not modify.
///
library google.api.servicemanagement.v1_servicemanager;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'resources.pb.dart';
import '../../service.pb.dart' as google$api;
import '../../../protobuf/any.pb.dart' as google$protobuf;
import '../../../longrunning/operations.pb.dart' as google$longrunning;

class ListServicesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServicesRequest')
    ..a/*<String>*/(1, 'producerProjectId', PbFieldType.OS)
    ..a/*<int>*/(5, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(6, 'pageToken', PbFieldType.OS)
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

  String get producerProjectId => $_get(0, 1, '');
  void set producerProjectId(String v) { $_setString(0, 1, v); }
  bool hasProducerProjectId() => $_has(0, 1);
  void clearProducerProjectId() => clearField(1);

  int get pageSize => $_get(1, 5, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 5, v); }
  bool hasPageSize() => $_has(1, 5);
  void clearPageSize() => clearField(5);

  String get pageToken => $_get(2, 6, '');
  void set pageToken(String v) { $_setString(2, 6, v); }
  bool hasPageToken() => $_has(2, 6);
  void clearPageToken() => clearField(6);
}

class _ReadonlyListServicesRequest extends ListServicesRequest with ReadonlyMessageMixin {}

class ListServicesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServicesResponse')
    ..pp/*<ManagedService>*/(1, 'services', PbFieldType.PM, ManagedService.$checkItem, ManagedService.create)
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

  List<ManagedService> get services => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListServicesResponse extends ListServicesResponse with ReadonlyMessageMixin {}

class GetServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetServiceRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
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

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);
}

class _ReadonlyGetServiceRequest extends GetServiceRequest with ReadonlyMessageMixin {}

class CreateServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateServiceRequest')
    ..a/*<ManagedService>*/(1, 'service', PbFieldType.OM, ManagedService.getDefault, ManagedService.create)
    ..hasRequiredFields = false
  ;

  CreateServiceRequest() : super();
  CreateServiceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateServiceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateServiceRequest clone() => new CreateServiceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateServiceRequest create() => new CreateServiceRequest();
  static PbList<CreateServiceRequest> createRepeated() => new PbList<CreateServiceRequest>();
  static CreateServiceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateServiceRequest();
    return _defaultInstance;
  }
  static CreateServiceRequest _defaultInstance;
  static void $checkItem(CreateServiceRequest v) {
    if (v is !CreateServiceRequest) checkItemFailed(v, 'CreateServiceRequest');
  }

  ManagedService get service => $_get(0, 1, null);
  void set service(ManagedService v) { setField(1, v); }
  bool hasService() => $_has(0, 1);
  void clearService() => clearField(1);
}

class _ReadonlyCreateServiceRequest extends CreateServiceRequest with ReadonlyMessageMixin {}

class DeleteServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteServiceRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
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

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);
}

class _ReadonlyDeleteServiceRequest extends DeleteServiceRequest with ReadonlyMessageMixin {}

class UndeleteServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UndeleteServiceRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  UndeleteServiceRequest() : super();
  UndeleteServiceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UndeleteServiceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UndeleteServiceRequest clone() => new UndeleteServiceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UndeleteServiceRequest create() => new UndeleteServiceRequest();
  static PbList<UndeleteServiceRequest> createRepeated() => new PbList<UndeleteServiceRequest>();
  static UndeleteServiceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUndeleteServiceRequest();
    return _defaultInstance;
  }
  static UndeleteServiceRequest _defaultInstance;
  static void $checkItem(UndeleteServiceRequest v) {
    if (v is !UndeleteServiceRequest) checkItemFailed(v, 'UndeleteServiceRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);
}

class _ReadonlyUndeleteServiceRequest extends UndeleteServiceRequest with ReadonlyMessageMixin {}

class UndeleteServiceResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UndeleteServiceResponse')
    ..a/*<ManagedService>*/(1, 'service', PbFieldType.OM, ManagedService.getDefault, ManagedService.create)
    ..hasRequiredFields = false
  ;

  UndeleteServiceResponse() : super();
  UndeleteServiceResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UndeleteServiceResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UndeleteServiceResponse clone() => new UndeleteServiceResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UndeleteServiceResponse create() => new UndeleteServiceResponse();
  static PbList<UndeleteServiceResponse> createRepeated() => new PbList<UndeleteServiceResponse>();
  static UndeleteServiceResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUndeleteServiceResponse();
    return _defaultInstance;
  }
  static UndeleteServiceResponse _defaultInstance;
  static void $checkItem(UndeleteServiceResponse v) {
    if (v is !UndeleteServiceResponse) checkItemFailed(v, 'UndeleteServiceResponse');
  }

  ManagedService get service => $_get(0, 1, null);
  void set service(ManagedService v) { setField(1, v); }
  bool hasService() => $_has(0, 1);
  void clearService() => clearField(1);
}

class _ReadonlyUndeleteServiceResponse extends UndeleteServiceResponse with ReadonlyMessageMixin {}

class GetServiceConfigRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetServiceConfigRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(2, 'configId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetServiceConfigRequest() : super();
  GetServiceConfigRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetServiceConfigRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetServiceConfigRequest clone() => new GetServiceConfigRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetServiceConfigRequest create() => new GetServiceConfigRequest();
  static PbList<GetServiceConfigRequest> createRepeated() => new PbList<GetServiceConfigRequest>();
  static GetServiceConfigRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetServiceConfigRequest();
    return _defaultInstance;
  }
  static GetServiceConfigRequest _defaultInstance;
  static void $checkItem(GetServiceConfigRequest v) {
    if (v is !GetServiceConfigRequest) checkItemFailed(v, 'GetServiceConfigRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  String get configId => $_get(1, 2, '');
  void set configId(String v) { $_setString(1, 2, v); }
  bool hasConfigId() => $_has(1, 2);
  void clearConfigId() => clearField(2);
}

class _ReadonlyGetServiceConfigRequest extends GetServiceConfigRequest with ReadonlyMessageMixin {}

class ListServiceConfigsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceConfigsRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListServiceConfigsRequest() : super();
  ListServiceConfigsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceConfigsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceConfigsRequest clone() => new ListServiceConfigsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceConfigsRequest create() => new ListServiceConfigsRequest();
  static PbList<ListServiceConfigsRequest> createRepeated() => new PbList<ListServiceConfigsRequest>();
  static ListServiceConfigsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceConfigsRequest();
    return _defaultInstance;
  }
  static ListServiceConfigsRequest _defaultInstance;
  static void $checkItem(ListServiceConfigsRequest v) {
    if (v is !ListServiceConfigsRequest) checkItemFailed(v, 'ListServiceConfigsRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  String get pageToken => $_get(1, 2, '');
  void set pageToken(String v) { $_setString(1, 2, v); }
  bool hasPageToken() => $_has(1, 2);
  void clearPageToken() => clearField(2);

  int get pageSize => $_get(2, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasPageSize() => $_has(2, 3);
  void clearPageSize() => clearField(3);
}

class _ReadonlyListServiceConfigsRequest extends ListServiceConfigsRequest with ReadonlyMessageMixin {}

class ListServiceConfigsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceConfigsResponse')
    ..pp/*<google$api.Service>*/(1, 'serviceConfigs', PbFieldType.PM, google$api.Service.$checkItem, google$api.Service.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListServiceConfigsResponse() : super();
  ListServiceConfigsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceConfigsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceConfigsResponse clone() => new ListServiceConfigsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceConfigsResponse create() => new ListServiceConfigsResponse();
  static PbList<ListServiceConfigsResponse> createRepeated() => new PbList<ListServiceConfigsResponse>();
  static ListServiceConfigsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceConfigsResponse();
    return _defaultInstance;
  }
  static ListServiceConfigsResponse _defaultInstance;
  static void $checkItem(ListServiceConfigsResponse v) {
    if (v is !ListServiceConfigsResponse) checkItemFailed(v, 'ListServiceConfigsResponse');
  }

  List<google$api.Service> get serviceConfigs => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListServiceConfigsResponse extends ListServiceConfigsResponse with ReadonlyMessageMixin {}

class CreateServiceConfigRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateServiceConfigRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<google$api.Service>*/(2, 'serviceConfig', PbFieldType.OM, google$api.Service.getDefault, google$api.Service.create)
    ..hasRequiredFields = false
  ;

  CreateServiceConfigRequest() : super();
  CreateServiceConfigRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateServiceConfigRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateServiceConfigRequest clone() => new CreateServiceConfigRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateServiceConfigRequest create() => new CreateServiceConfigRequest();
  static PbList<CreateServiceConfigRequest> createRepeated() => new PbList<CreateServiceConfigRequest>();
  static CreateServiceConfigRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateServiceConfigRequest();
    return _defaultInstance;
  }
  static CreateServiceConfigRequest _defaultInstance;
  static void $checkItem(CreateServiceConfigRequest v) {
    if (v is !CreateServiceConfigRequest) checkItemFailed(v, 'CreateServiceConfigRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  google$api.Service get serviceConfig => $_get(1, 2, null);
  void set serviceConfig(google$api.Service v) { setField(2, v); }
  bool hasServiceConfig() => $_has(1, 2);
  void clearServiceConfig() => clearField(2);
}

class _ReadonlyCreateServiceConfigRequest extends CreateServiceConfigRequest with ReadonlyMessageMixin {}

class SubmitConfigSourceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SubmitConfigSourceRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<ConfigSource>*/(2, 'configSource', PbFieldType.OM, ConfigSource.getDefault, ConfigSource.create)
    ..a/*<bool>*/(3, 'validateOnly', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  SubmitConfigSourceRequest() : super();
  SubmitConfigSourceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SubmitConfigSourceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SubmitConfigSourceRequest clone() => new SubmitConfigSourceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SubmitConfigSourceRequest create() => new SubmitConfigSourceRequest();
  static PbList<SubmitConfigSourceRequest> createRepeated() => new PbList<SubmitConfigSourceRequest>();
  static SubmitConfigSourceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySubmitConfigSourceRequest();
    return _defaultInstance;
  }
  static SubmitConfigSourceRequest _defaultInstance;
  static void $checkItem(SubmitConfigSourceRequest v) {
    if (v is !SubmitConfigSourceRequest) checkItemFailed(v, 'SubmitConfigSourceRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  ConfigSource get configSource => $_get(1, 2, null);
  void set configSource(ConfigSource v) { setField(2, v); }
  bool hasConfigSource() => $_has(1, 2);
  void clearConfigSource() => clearField(2);

  bool get validateOnly => $_get(2, 3, false);
  void set validateOnly(bool v) { $_setBool(2, 3, v); }
  bool hasValidateOnly() => $_has(2, 3);
  void clearValidateOnly() => clearField(3);
}

class _ReadonlySubmitConfigSourceRequest extends SubmitConfigSourceRequest with ReadonlyMessageMixin {}

class SubmitConfigSourceResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SubmitConfigSourceResponse')
    ..a/*<google$api.Service>*/(1, 'serviceConfig', PbFieldType.OM, google$api.Service.getDefault, google$api.Service.create)
    ..hasRequiredFields = false
  ;

  SubmitConfigSourceResponse() : super();
  SubmitConfigSourceResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SubmitConfigSourceResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SubmitConfigSourceResponse clone() => new SubmitConfigSourceResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SubmitConfigSourceResponse create() => new SubmitConfigSourceResponse();
  static PbList<SubmitConfigSourceResponse> createRepeated() => new PbList<SubmitConfigSourceResponse>();
  static SubmitConfigSourceResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySubmitConfigSourceResponse();
    return _defaultInstance;
  }
  static SubmitConfigSourceResponse _defaultInstance;
  static void $checkItem(SubmitConfigSourceResponse v) {
    if (v is !SubmitConfigSourceResponse) checkItemFailed(v, 'SubmitConfigSourceResponse');
  }

  google$api.Service get serviceConfig => $_get(0, 1, null);
  void set serviceConfig(google$api.Service v) { setField(1, v); }
  bool hasServiceConfig() => $_has(0, 1);
  void clearServiceConfig() => clearField(1);
}

class _ReadonlySubmitConfigSourceResponse extends SubmitConfigSourceResponse with ReadonlyMessageMixin {}

class CreateServiceRolloutRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateServiceRolloutRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<Rollout>*/(2, 'rollout', PbFieldType.OM, Rollout.getDefault, Rollout.create)
    ..hasRequiredFields = false
  ;

  CreateServiceRolloutRequest() : super();
  CreateServiceRolloutRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateServiceRolloutRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateServiceRolloutRequest clone() => new CreateServiceRolloutRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateServiceRolloutRequest create() => new CreateServiceRolloutRequest();
  static PbList<CreateServiceRolloutRequest> createRepeated() => new PbList<CreateServiceRolloutRequest>();
  static CreateServiceRolloutRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateServiceRolloutRequest();
    return _defaultInstance;
  }
  static CreateServiceRolloutRequest _defaultInstance;
  static void $checkItem(CreateServiceRolloutRequest v) {
    if (v is !CreateServiceRolloutRequest) checkItemFailed(v, 'CreateServiceRolloutRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  Rollout get rollout => $_get(1, 2, null);
  void set rollout(Rollout v) { setField(2, v); }
  bool hasRollout() => $_has(1, 2);
  void clearRollout() => clearField(2);
}

class _ReadonlyCreateServiceRolloutRequest extends CreateServiceRolloutRequest with ReadonlyMessageMixin {}

class ListServiceRolloutsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceRolloutsRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListServiceRolloutsRequest() : super();
  ListServiceRolloutsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceRolloutsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceRolloutsRequest clone() => new ListServiceRolloutsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceRolloutsRequest create() => new ListServiceRolloutsRequest();
  static PbList<ListServiceRolloutsRequest> createRepeated() => new PbList<ListServiceRolloutsRequest>();
  static ListServiceRolloutsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceRolloutsRequest();
    return _defaultInstance;
  }
  static ListServiceRolloutsRequest _defaultInstance;
  static void $checkItem(ListServiceRolloutsRequest v) {
    if (v is !ListServiceRolloutsRequest) checkItemFailed(v, 'ListServiceRolloutsRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  String get pageToken => $_get(1, 2, '');
  void set pageToken(String v) { $_setString(1, 2, v); }
  bool hasPageToken() => $_has(1, 2);
  void clearPageToken() => clearField(2);

  int get pageSize => $_get(2, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasPageSize() => $_has(2, 3);
  void clearPageSize() => clearField(3);
}

class _ReadonlyListServiceRolloutsRequest extends ListServiceRolloutsRequest with ReadonlyMessageMixin {}

class ListServiceRolloutsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListServiceRolloutsResponse')
    ..pp/*<Rollout>*/(1, 'rollouts', PbFieldType.PM, Rollout.$checkItem, Rollout.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListServiceRolloutsResponse() : super();
  ListServiceRolloutsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListServiceRolloutsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListServiceRolloutsResponse clone() => new ListServiceRolloutsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListServiceRolloutsResponse create() => new ListServiceRolloutsResponse();
  static PbList<ListServiceRolloutsResponse> createRepeated() => new PbList<ListServiceRolloutsResponse>();
  static ListServiceRolloutsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListServiceRolloutsResponse();
    return _defaultInstance;
  }
  static ListServiceRolloutsResponse _defaultInstance;
  static void $checkItem(ListServiceRolloutsResponse v) {
    if (v is !ListServiceRolloutsResponse) checkItemFailed(v, 'ListServiceRolloutsResponse');
  }

  List<Rollout> get rollouts => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListServiceRolloutsResponse extends ListServiceRolloutsResponse with ReadonlyMessageMixin {}

class GetServiceRolloutRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetServiceRolloutRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(2, 'rolloutId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetServiceRolloutRequest() : super();
  GetServiceRolloutRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetServiceRolloutRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetServiceRolloutRequest clone() => new GetServiceRolloutRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetServiceRolloutRequest create() => new GetServiceRolloutRequest();
  static PbList<GetServiceRolloutRequest> createRepeated() => new PbList<GetServiceRolloutRequest>();
  static GetServiceRolloutRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetServiceRolloutRequest();
    return _defaultInstance;
  }
  static GetServiceRolloutRequest _defaultInstance;
  static void $checkItem(GetServiceRolloutRequest v) {
    if (v is !GetServiceRolloutRequest) checkItemFailed(v, 'GetServiceRolloutRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  String get rolloutId => $_get(1, 2, '');
  void set rolloutId(String v) { $_setString(1, 2, v); }
  bool hasRolloutId() => $_has(1, 2);
  void clearRolloutId() => clearField(2);
}

class _ReadonlyGetServiceRolloutRequest extends GetServiceRolloutRequest with ReadonlyMessageMixin {}

class EnableServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EnableServiceRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(2, 'consumerId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  EnableServiceRequest() : super();
  EnableServiceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EnableServiceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EnableServiceRequest clone() => new EnableServiceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EnableServiceRequest create() => new EnableServiceRequest();
  static PbList<EnableServiceRequest> createRepeated() => new PbList<EnableServiceRequest>();
  static EnableServiceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEnableServiceRequest();
    return _defaultInstance;
  }
  static EnableServiceRequest _defaultInstance;
  static void $checkItem(EnableServiceRequest v) {
    if (v is !EnableServiceRequest) checkItemFailed(v, 'EnableServiceRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  String get consumerId => $_get(1, 2, '');
  void set consumerId(String v) { $_setString(1, 2, v); }
  bool hasConsumerId() => $_has(1, 2);
  void clearConsumerId() => clearField(2);
}

class _ReadonlyEnableServiceRequest extends EnableServiceRequest with ReadonlyMessageMixin {}

class DisableServiceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DisableServiceRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(2, 'consumerId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DisableServiceRequest() : super();
  DisableServiceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DisableServiceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DisableServiceRequest clone() => new DisableServiceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DisableServiceRequest create() => new DisableServiceRequest();
  static PbList<DisableServiceRequest> createRepeated() => new PbList<DisableServiceRequest>();
  static DisableServiceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDisableServiceRequest();
    return _defaultInstance;
  }
  static DisableServiceRequest _defaultInstance;
  static void $checkItem(DisableServiceRequest v) {
    if (v is !DisableServiceRequest) checkItemFailed(v, 'DisableServiceRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  String get consumerId => $_get(1, 2, '');
  void set consumerId(String v) { $_setString(1, 2, v); }
  bool hasConsumerId() => $_has(1, 2);
  void clearConsumerId() => clearField(2);
}

class _ReadonlyDisableServiceRequest extends DisableServiceRequest with ReadonlyMessageMixin {}

class GenerateConfigReportRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GenerateConfigReportRequest')
    ..a/*<google$protobuf.Any>*/(1, 'newConfig', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..a/*<google$protobuf.Any>*/(2, 'oldConfig', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..hasRequiredFields = false
  ;

  GenerateConfigReportRequest() : super();
  GenerateConfigReportRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GenerateConfigReportRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GenerateConfigReportRequest clone() => new GenerateConfigReportRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GenerateConfigReportRequest create() => new GenerateConfigReportRequest();
  static PbList<GenerateConfigReportRequest> createRepeated() => new PbList<GenerateConfigReportRequest>();
  static GenerateConfigReportRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGenerateConfigReportRequest();
    return _defaultInstance;
  }
  static GenerateConfigReportRequest _defaultInstance;
  static void $checkItem(GenerateConfigReportRequest v) {
    if (v is !GenerateConfigReportRequest) checkItemFailed(v, 'GenerateConfigReportRequest');
  }

  google$protobuf.Any get newConfig => $_get(0, 1, null);
  void set newConfig(google$protobuf.Any v) { setField(1, v); }
  bool hasNewConfig() => $_has(0, 1);
  void clearNewConfig() => clearField(1);

  google$protobuf.Any get oldConfig => $_get(1, 2, null);
  void set oldConfig(google$protobuf.Any v) { setField(2, v); }
  bool hasOldConfig() => $_has(1, 2);
  void clearOldConfig() => clearField(2);
}

class _ReadonlyGenerateConfigReportRequest extends GenerateConfigReportRequest with ReadonlyMessageMixin {}

class GenerateConfigReportResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GenerateConfigReportResponse')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..pp/*<ChangeReport>*/(3, 'changeReports', PbFieldType.PM, ChangeReport.$checkItem, ChangeReport.create)
    ..pp/*<Diagnostic>*/(4, 'diagnostics', PbFieldType.PM, Diagnostic.$checkItem, Diagnostic.create)
    ..hasRequiredFields = false
  ;

  GenerateConfigReportResponse() : super();
  GenerateConfigReportResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GenerateConfigReportResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GenerateConfigReportResponse clone() => new GenerateConfigReportResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GenerateConfigReportResponse create() => new GenerateConfigReportResponse();
  static PbList<GenerateConfigReportResponse> createRepeated() => new PbList<GenerateConfigReportResponse>();
  static GenerateConfigReportResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGenerateConfigReportResponse();
    return _defaultInstance;
  }
  static GenerateConfigReportResponse _defaultInstance;
  static void $checkItem(GenerateConfigReportResponse v) {
    if (v is !GenerateConfigReportResponse) checkItemFailed(v, 'GenerateConfigReportResponse');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);

  List<ChangeReport> get changeReports => $_get(2, 3, null);

  List<Diagnostic> get diagnostics => $_get(3, 4, null);
}

class _ReadonlyGenerateConfigReportResponse extends GenerateConfigReportResponse with ReadonlyMessageMixin {}

class ServiceManagerApi {
  RpcClient _client;
  ServiceManagerApi(this._client);

  Future<ListServicesResponse> listServices(ClientContext ctx, ListServicesRequest request) {
    var emptyResponse = new ListServicesResponse();
    return _client.invoke(ctx, 'ServiceManager', 'ListServices', request, emptyResponse);
  }
  Future<ManagedService> getService(ClientContext ctx, GetServiceRequest request) {
    var emptyResponse = new ManagedService();
    return _client.invoke(ctx, 'ServiceManager', 'GetService', request, emptyResponse);
  }
  Future<google$longrunning.Operation> createService(ClientContext ctx, CreateServiceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ServiceManager', 'CreateService', request, emptyResponse);
  }
  Future<google$longrunning.Operation> deleteService(ClientContext ctx, DeleteServiceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ServiceManager', 'DeleteService', request, emptyResponse);
  }
  Future<google$longrunning.Operation> undeleteService(ClientContext ctx, UndeleteServiceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ServiceManager', 'UndeleteService', request, emptyResponse);
  }
  Future<ListServiceConfigsResponse> listServiceConfigs(ClientContext ctx, ListServiceConfigsRequest request) {
    var emptyResponse = new ListServiceConfigsResponse();
    return _client.invoke(ctx, 'ServiceManager', 'ListServiceConfigs', request, emptyResponse);
  }
  Future<google$api.Service> getServiceConfig(ClientContext ctx, GetServiceConfigRequest request) {
    var emptyResponse = new google$api.Service();
    return _client.invoke(ctx, 'ServiceManager', 'GetServiceConfig', request, emptyResponse);
  }
  Future<google$api.Service> createServiceConfig(ClientContext ctx, CreateServiceConfigRequest request) {
    var emptyResponse = new google$api.Service();
    return _client.invoke(ctx, 'ServiceManager', 'CreateServiceConfig', request, emptyResponse);
  }
  Future<google$longrunning.Operation> submitConfigSource(ClientContext ctx, SubmitConfigSourceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ServiceManager', 'SubmitConfigSource', request, emptyResponse);
  }
  Future<ListServiceRolloutsResponse> listServiceRollouts(ClientContext ctx, ListServiceRolloutsRequest request) {
    var emptyResponse = new ListServiceRolloutsResponse();
    return _client.invoke(ctx, 'ServiceManager', 'ListServiceRollouts', request, emptyResponse);
  }
  Future<Rollout> getServiceRollout(ClientContext ctx, GetServiceRolloutRequest request) {
    var emptyResponse = new Rollout();
    return _client.invoke(ctx, 'ServiceManager', 'GetServiceRollout', request, emptyResponse);
  }
  Future<google$longrunning.Operation> createServiceRollout(ClientContext ctx, CreateServiceRolloutRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ServiceManager', 'CreateServiceRollout', request, emptyResponse);
  }
  Future<GenerateConfigReportResponse> generateConfigReport(ClientContext ctx, GenerateConfigReportRequest request) {
    var emptyResponse = new GenerateConfigReportResponse();
    return _client.invoke(ctx, 'ServiceManager', 'GenerateConfigReport', request, emptyResponse);
  }
  Future<google$longrunning.Operation> enableService(ClientContext ctx, EnableServiceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ServiceManager', 'EnableService', request, emptyResponse);
  }
  Future<google$longrunning.Operation> disableService(ClientContext ctx, DisableServiceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ServiceManager', 'DisableService', request, emptyResponse);
  }
}

