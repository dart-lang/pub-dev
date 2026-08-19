//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/appengine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../longrunning/operations.pb.dart' as $0;
import '../../protobuf/empty.pb.dart' as $1;
import 'appengine.pb.dart' as $2;
import 'application.pb.dart' as $3;
import 'certificate.pb.dart' as $8;
import 'domain_mapping.pb.dart' as $9;
import 'firewall.pb.dart' as $7;
import 'instance.pb.dart' as $6;
import 'service.pb.dart' as $4;
import 'version.pb.dart' as $5;

export 'appengine.pb.dart';

@$pb.GrpcServiceName('google.appengine.v1beta.Applications')
class ApplicationsClient extends $grpc.Client {
  static final _$getApplication =
      $grpc.ClientMethod<$2.GetApplicationRequest, $3.Application>(
          '/google.appengine.v1beta.Applications/GetApplication',
          ($2.GetApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.Application.fromBuffer(value));
  static final _$createApplication =
      $grpc.ClientMethod<$2.CreateApplicationRequest, $0.Operation>(
          '/google.appengine.v1beta.Applications/CreateApplication',
          ($2.CreateApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateApplication =
      $grpc.ClientMethod<$2.UpdateApplicationRequest, $0.Operation>(
          '/google.appengine.v1beta.Applications/UpdateApplication',
          ($2.UpdateApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$repairApplication =
      $grpc.ClientMethod<$2.RepairApplicationRequest, $0.Operation>(
          '/google.appengine.v1beta.Applications/RepairApplication',
          ($2.RepairApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  ApplicationsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.Application> getApplication(
      $2.GetApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getApplication, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createApplication(
      $2.CreateApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createApplication, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateApplication(
      $2.UpdateApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateApplication, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> repairApplication(
      $2.RepairApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$repairApplication, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.Applications')
abstract class ApplicationsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.Applications';

  ApplicationsServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetApplicationRequest, $3.Application>(
        'GetApplication',
        getApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetApplicationRequest.fromBuffer(value),
        ($3.Application value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CreateApplicationRequest, $0.Operation>(
        'CreateApplication',
        createApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateApplicationRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateApplicationRequest, $0.Operation>(
        'UpdateApplication',
        updateApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateApplicationRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RepairApplicationRequest, $0.Operation>(
        'RepairApplication',
        repairApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.RepairApplicationRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$3.Application> getApplication_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetApplicationRequest> request) async {
    return getApplication(call, await request);
  }

  $async.Future<$0.Operation> createApplication_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateApplicationRequest> request) async {
    return createApplication(call, await request);
  }

  $async.Future<$0.Operation> updateApplication_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateApplicationRequest> request) async {
    return updateApplication(call, await request);
  }

  $async.Future<$0.Operation> repairApplication_Pre($grpc.ServiceCall call,
      $async.Future<$2.RepairApplicationRequest> request) async {
    return repairApplication(call, await request);
  }

  $async.Future<$3.Application> getApplication(
      $grpc.ServiceCall call, $2.GetApplicationRequest request);
  $async.Future<$0.Operation> createApplication(
      $grpc.ServiceCall call, $2.CreateApplicationRequest request);
  $async.Future<$0.Operation> updateApplication(
      $grpc.ServiceCall call, $2.UpdateApplicationRequest request);
  $async.Future<$0.Operation> repairApplication(
      $grpc.ServiceCall call, $2.RepairApplicationRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1beta.Services')
class ServicesClient extends $grpc.Client {
  static final _$listServices =
      $grpc.ClientMethod<$2.ListServicesRequest, $2.ListServicesResponse>(
          '/google.appengine.v1beta.Services/ListServices',
          ($2.ListServicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ListServicesResponse.fromBuffer(value));
  static final _$getService =
      $grpc.ClientMethod<$2.GetServiceRequest, $4.Service>(
          '/google.appengine.v1beta.Services/GetService',
          ($2.GetServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.Service.fromBuffer(value));
  static final _$updateService =
      $grpc.ClientMethod<$2.UpdateServiceRequest, $0.Operation>(
          '/google.appengine.v1beta.Services/UpdateService',
          ($2.UpdateServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteService =
      $grpc.ClientMethod<$2.DeleteServiceRequest, $0.Operation>(
          '/google.appengine.v1beta.Services/DeleteService',
          ($2.DeleteServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  ServicesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ListServicesResponse> listServices(
      $2.ListServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServices, request, options: options);
  }

  $grpc.ResponseFuture<$4.Service> getService($2.GetServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateService(
      $2.UpdateServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteService(
      $2.DeleteServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteService, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.Services')
abstract class ServicesServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.Services';

  ServicesServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.ListServicesRequest, $2.ListServicesResponse>(
            'ListServices',
            listServices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.ListServicesRequest.fromBuffer(value),
            ($2.ListServicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetServiceRequest, $4.Service>(
        'GetService',
        getService_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetServiceRequest.fromBuffer(value),
        ($4.Service value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateServiceRequest, $0.Operation>(
        'UpdateService',
        updateService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteServiceRequest, $0.Operation>(
        'DeleteService',
        deleteService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DeleteServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$2.ListServicesResponse> listServices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ListServicesRequest> request) async {
    return listServices(call, await request);
  }

  $async.Future<$4.Service> getService_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetServiceRequest> request) async {
    return getService(call, await request);
  }

  $async.Future<$0.Operation> updateService_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateServiceRequest> request) async {
    return updateService(call, await request);
  }

  $async.Future<$0.Operation> deleteService_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteServiceRequest> request) async {
    return deleteService(call, await request);
  }

  $async.Future<$2.ListServicesResponse> listServices(
      $grpc.ServiceCall call, $2.ListServicesRequest request);
  $async.Future<$4.Service> getService(
      $grpc.ServiceCall call, $2.GetServiceRequest request);
  $async.Future<$0.Operation> updateService(
      $grpc.ServiceCall call, $2.UpdateServiceRequest request);
  $async.Future<$0.Operation> deleteService(
      $grpc.ServiceCall call, $2.DeleteServiceRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1beta.Versions')
class VersionsClient extends $grpc.Client {
  static final _$listVersions =
      $grpc.ClientMethod<$2.ListVersionsRequest, $2.ListVersionsResponse>(
          '/google.appengine.v1beta.Versions/ListVersions',
          ($2.ListVersionsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ListVersionsResponse.fromBuffer(value));
  static final _$getVersion =
      $grpc.ClientMethod<$2.GetVersionRequest, $5.Version>(
          '/google.appengine.v1beta.Versions/GetVersion',
          ($2.GetVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.Version.fromBuffer(value));
  static final _$createVersion =
      $grpc.ClientMethod<$2.CreateVersionRequest, $0.Operation>(
          '/google.appengine.v1beta.Versions/CreateVersion',
          ($2.CreateVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateVersion =
      $grpc.ClientMethod<$2.UpdateVersionRequest, $0.Operation>(
          '/google.appengine.v1beta.Versions/UpdateVersion',
          ($2.UpdateVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteVersion =
      $grpc.ClientMethod<$2.DeleteVersionRequest, $0.Operation>(
          '/google.appengine.v1beta.Versions/DeleteVersion',
          ($2.DeleteVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  VersionsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ListVersionsResponse> listVersions(
      $2.ListVersionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listVersions, request, options: options);
  }

  $grpc.ResponseFuture<$5.Version> getVersion($2.GetVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createVersion(
      $2.CreateVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateVersion(
      $2.UpdateVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteVersion(
      $2.DeleteVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteVersion, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.Versions')
abstract class VersionsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.Versions';

  VersionsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.ListVersionsRequest, $2.ListVersionsResponse>(
            'ListVersions',
            listVersions_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.ListVersionsRequest.fromBuffer(value),
            ($2.ListVersionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetVersionRequest, $5.Version>(
        'GetVersion',
        getVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetVersionRequest.fromBuffer(value),
        ($5.Version value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CreateVersionRequest, $0.Operation>(
        'CreateVersion',
        createVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateVersionRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateVersionRequest, $0.Operation>(
        'UpdateVersion',
        updateVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateVersionRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteVersionRequest, $0.Operation>(
        'DeleteVersion',
        deleteVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DeleteVersionRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$2.ListVersionsResponse> listVersions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ListVersionsRequest> request) async {
    return listVersions(call, await request);
  }

  $async.Future<$5.Version> getVersion_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetVersionRequest> request) async {
    return getVersion(call, await request);
  }

  $async.Future<$0.Operation> createVersion_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateVersionRequest> request) async {
    return createVersion(call, await request);
  }

  $async.Future<$0.Operation> updateVersion_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateVersionRequest> request) async {
    return updateVersion(call, await request);
  }

  $async.Future<$0.Operation> deleteVersion_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteVersionRequest> request) async {
    return deleteVersion(call, await request);
  }

  $async.Future<$2.ListVersionsResponse> listVersions(
      $grpc.ServiceCall call, $2.ListVersionsRequest request);
  $async.Future<$5.Version> getVersion(
      $grpc.ServiceCall call, $2.GetVersionRequest request);
  $async.Future<$0.Operation> createVersion(
      $grpc.ServiceCall call, $2.CreateVersionRequest request);
  $async.Future<$0.Operation> updateVersion(
      $grpc.ServiceCall call, $2.UpdateVersionRequest request);
  $async.Future<$0.Operation> deleteVersion(
      $grpc.ServiceCall call, $2.DeleteVersionRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1beta.Instances')
class InstancesClient extends $grpc.Client {
  static final _$listInstances =
      $grpc.ClientMethod<$2.ListInstancesRequest, $2.ListInstancesResponse>(
          '/google.appengine.v1beta.Instances/ListInstances',
          ($2.ListInstancesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ListInstancesResponse.fromBuffer(value));
  static final _$getInstance =
      $grpc.ClientMethod<$2.GetInstanceRequest, $6.Instance>(
          '/google.appengine.v1beta.Instances/GetInstance',
          ($2.GetInstanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $6.Instance.fromBuffer(value));
  static final _$deleteInstance =
      $grpc.ClientMethod<$2.DeleteInstanceRequest, $0.Operation>(
          '/google.appengine.v1beta.Instances/DeleteInstance',
          ($2.DeleteInstanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$debugInstance =
      $grpc.ClientMethod<$2.DebugInstanceRequest, $0.Operation>(
          '/google.appengine.v1beta.Instances/DebugInstance',
          ($2.DebugInstanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  InstancesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ListInstancesResponse> listInstances(
      $2.ListInstancesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listInstances, request, options: options);
  }

  $grpc.ResponseFuture<$6.Instance> getInstance($2.GetInstanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstance, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteInstance(
      $2.DeleteInstanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInstance, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> debugInstance(
      $2.DebugInstanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$debugInstance, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.Instances')
abstract class InstancesServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.Instances';

  InstancesServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.ListInstancesRequest, $2.ListInstancesResponse>(
            'ListInstances',
            listInstances_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.ListInstancesRequest.fromBuffer(value),
            ($2.ListInstancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetInstanceRequest, $6.Instance>(
        'GetInstance',
        getInstance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetInstanceRequest.fromBuffer(value),
        ($6.Instance value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteInstanceRequest, $0.Operation>(
        'DeleteInstance',
        deleteInstance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DeleteInstanceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DebugInstanceRequest, $0.Operation>(
        'DebugInstance',
        debugInstance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DebugInstanceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$2.ListInstancesResponse> listInstances_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ListInstancesRequest> request) async {
    return listInstances(call, await request);
  }

  $async.Future<$6.Instance> getInstance_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetInstanceRequest> request) async {
    return getInstance(call, await request);
  }

  $async.Future<$0.Operation> deleteInstance_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteInstanceRequest> request) async {
    return deleteInstance(call, await request);
  }

  $async.Future<$0.Operation> debugInstance_Pre($grpc.ServiceCall call,
      $async.Future<$2.DebugInstanceRequest> request) async {
    return debugInstance(call, await request);
  }

  $async.Future<$2.ListInstancesResponse> listInstances(
      $grpc.ServiceCall call, $2.ListInstancesRequest request);
  $async.Future<$6.Instance> getInstance(
      $grpc.ServiceCall call, $2.GetInstanceRequest request);
  $async.Future<$0.Operation> deleteInstance(
      $grpc.ServiceCall call, $2.DeleteInstanceRequest request);
  $async.Future<$0.Operation> debugInstance(
      $grpc.ServiceCall call, $2.DebugInstanceRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1beta.Firewall')
class FirewallClient extends $grpc.Client {
  static final _$listIngressRules = $grpc.ClientMethod<
          $2.ListIngressRulesRequest, $2.ListIngressRulesResponse>(
      '/google.appengine.v1beta.Firewall/ListIngressRules',
      ($2.ListIngressRulesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.ListIngressRulesResponse.fromBuffer(value));
  static final _$batchUpdateIngressRules = $grpc.ClientMethod<
          $2.BatchUpdateIngressRulesRequest,
          $2.BatchUpdateIngressRulesResponse>(
      '/google.appengine.v1beta.Firewall/BatchUpdateIngressRules',
      ($2.BatchUpdateIngressRulesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.BatchUpdateIngressRulesResponse.fromBuffer(value));
  static final _$createIngressRule =
      $grpc.ClientMethod<$2.CreateIngressRuleRequest, $7.FirewallRule>(
          '/google.appengine.v1beta.Firewall/CreateIngressRule',
          ($2.CreateIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.FirewallRule.fromBuffer(value));
  static final _$getIngressRule =
      $grpc.ClientMethod<$2.GetIngressRuleRequest, $7.FirewallRule>(
          '/google.appengine.v1beta.Firewall/GetIngressRule',
          ($2.GetIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.FirewallRule.fromBuffer(value));
  static final _$updateIngressRule =
      $grpc.ClientMethod<$2.UpdateIngressRuleRequest, $7.FirewallRule>(
          '/google.appengine.v1beta.Firewall/UpdateIngressRule',
          ($2.UpdateIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.FirewallRule.fromBuffer(value));
  static final _$deleteIngressRule =
      $grpc.ClientMethod<$2.DeleteIngressRuleRequest, $1.Empty>(
          '/google.appengine.v1beta.Firewall/DeleteIngressRule',
          ($2.DeleteIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  FirewallClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ListIngressRulesResponse> listIngressRules(
      $2.ListIngressRulesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listIngressRules, request, options: options);
  }

  $grpc.ResponseFuture<$2.BatchUpdateIngressRulesResponse>
      batchUpdateIngressRules($2.BatchUpdateIngressRulesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchUpdateIngressRules, request,
        options: options);
  }

  $grpc.ResponseFuture<$7.FirewallRule> createIngressRule(
      $2.CreateIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIngressRule, request, options: options);
  }

  $grpc.ResponseFuture<$7.FirewallRule> getIngressRule(
      $2.GetIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIngressRule, request, options: options);
  }

  $grpc.ResponseFuture<$7.FirewallRule> updateIngressRule(
      $2.UpdateIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateIngressRule, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteIngressRule(
      $2.DeleteIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteIngressRule, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.Firewall')
abstract class FirewallServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.Firewall';

  FirewallServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.ListIngressRulesRequest,
            $2.ListIngressRulesResponse>(
        'ListIngressRules',
        listIngressRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.ListIngressRulesRequest.fromBuffer(value),
        ($2.ListIngressRulesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.BatchUpdateIngressRulesRequest,
            $2.BatchUpdateIngressRulesResponse>(
        'BatchUpdateIngressRules',
        batchUpdateIngressRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.BatchUpdateIngressRulesRequest.fromBuffer(value),
        ($2.BatchUpdateIngressRulesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.CreateIngressRuleRequest, $7.FirewallRule>(
            'CreateIngressRule',
            createIngressRule_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.CreateIngressRuleRequest.fromBuffer(value),
            ($7.FirewallRule value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetIngressRuleRequest, $7.FirewallRule>(
        'GetIngressRule',
        getIngressRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetIngressRuleRequest.fromBuffer(value),
        ($7.FirewallRule value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.UpdateIngressRuleRequest, $7.FirewallRule>(
            'UpdateIngressRule',
            updateIngressRule_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.UpdateIngressRuleRequest.fromBuffer(value),
            ($7.FirewallRule value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteIngressRuleRequest, $1.Empty>(
        'DeleteIngressRule',
        deleteIngressRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DeleteIngressRuleRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$2.ListIngressRulesResponse> listIngressRules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ListIngressRulesRequest> request) async {
    return listIngressRules(call, await request);
  }

  $async.Future<$2.BatchUpdateIngressRulesResponse> batchUpdateIngressRules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.BatchUpdateIngressRulesRequest> request) async {
    return batchUpdateIngressRules(call, await request);
  }

  $async.Future<$7.FirewallRule> createIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateIngressRuleRequest> request) async {
    return createIngressRule(call, await request);
  }

  $async.Future<$7.FirewallRule> getIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetIngressRuleRequest> request) async {
    return getIngressRule(call, await request);
  }

  $async.Future<$7.FirewallRule> updateIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateIngressRuleRequest> request) async {
    return updateIngressRule(call, await request);
  }

  $async.Future<$1.Empty> deleteIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteIngressRuleRequest> request) async {
    return deleteIngressRule(call, await request);
  }

  $async.Future<$2.ListIngressRulesResponse> listIngressRules(
      $grpc.ServiceCall call, $2.ListIngressRulesRequest request);
  $async.Future<$2.BatchUpdateIngressRulesResponse> batchUpdateIngressRules(
      $grpc.ServiceCall call, $2.BatchUpdateIngressRulesRequest request);
  $async.Future<$7.FirewallRule> createIngressRule(
      $grpc.ServiceCall call, $2.CreateIngressRuleRequest request);
  $async.Future<$7.FirewallRule> getIngressRule(
      $grpc.ServiceCall call, $2.GetIngressRuleRequest request);
  $async.Future<$7.FirewallRule> updateIngressRule(
      $grpc.ServiceCall call, $2.UpdateIngressRuleRequest request);
  $async.Future<$1.Empty> deleteIngressRule(
      $grpc.ServiceCall call, $2.DeleteIngressRuleRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1beta.AuthorizedDomains')
class AuthorizedDomainsClient extends $grpc.Client {
  static final _$listAuthorizedDomains = $grpc.ClientMethod<
          $2.ListAuthorizedDomainsRequest, $2.ListAuthorizedDomainsResponse>(
      '/google.appengine.v1beta.AuthorizedDomains/ListAuthorizedDomains',
      ($2.ListAuthorizedDomainsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.ListAuthorizedDomainsResponse.fromBuffer(value));

  AuthorizedDomainsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ListAuthorizedDomainsResponse> listAuthorizedDomains(
      $2.ListAuthorizedDomainsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAuthorizedDomains, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.AuthorizedDomains')
abstract class AuthorizedDomainsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.AuthorizedDomains';

  AuthorizedDomainsServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.ListAuthorizedDomainsRequest,
            $2.ListAuthorizedDomainsResponse>(
        'ListAuthorizedDomains',
        listAuthorizedDomains_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.ListAuthorizedDomainsRequest.fromBuffer(value),
        ($2.ListAuthorizedDomainsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.ListAuthorizedDomainsResponse> listAuthorizedDomains_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ListAuthorizedDomainsRequest> request) async {
    return listAuthorizedDomains(call, await request);
  }

  $async.Future<$2.ListAuthorizedDomainsResponse> listAuthorizedDomains(
      $grpc.ServiceCall call, $2.ListAuthorizedDomainsRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1beta.AuthorizedCertificates')
class AuthorizedCertificatesClient extends $grpc.Client {
  static final _$listAuthorizedCertificates = $grpc.ClientMethod<
          $2.ListAuthorizedCertificatesRequest,
          $2.ListAuthorizedCertificatesResponse>(
      '/google.appengine.v1beta.AuthorizedCertificates/ListAuthorizedCertificates',
      ($2.ListAuthorizedCertificatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.ListAuthorizedCertificatesResponse.fromBuffer(value));
  static final _$getAuthorizedCertificate = $grpc.ClientMethod<
          $2.GetAuthorizedCertificateRequest, $8.AuthorizedCertificate>(
      '/google.appengine.v1beta.AuthorizedCertificates/GetAuthorizedCertificate',
      ($2.GetAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.AuthorizedCertificate.fromBuffer(value));
  static final _$createAuthorizedCertificate = $grpc.ClientMethod<
          $2.CreateAuthorizedCertificateRequest, $8.AuthorizedCertificate>(
      '/google.appengine.v1beta.AuthorizedCertificates/CreateAuthorizedCertificate',
      ($2.CreateAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.AuthorizedCertificate.fromBuffer(value));
  static final _$updateAuthorizedCertificate = $grpc.ClientMethod<
          $2.UpdateAuthorizedCertificateRequest, $8.AuthorizedCertificate>(
      '/google.appengine.v1beta.AuthorizedCertificates/UpdateAuthorizedCertificate',
      ($2.UpdateAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.AuthorizedCertificate.fromBuffer(value));
  static final _$deleteAuthorizedCertificate = $grpc.ClientMethod<
          $2.DeleteAuthorizedCertificateRequest, $1.Empty>(
      '/google.appengine.v1beta.AuthorizedCertificates/DeleteAuthorizedCertificate',
      ($2.DeleteAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  AuthorizedCertificatesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ListAuthorizedCertificatesResponse>
      listAuthorizedCertificates($2.ListAuthorizedCertificatesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAuthorizedCertificates, request,
        options: options);
  }

  $grpc.ResponseFuture<$8.AuthorizedCertificate> getAuthorizedCertificate(
      $2.GetAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAuthorizedCertificate, request,
        options: options);
  }

  $grpc.ResponseFuture<$8.AuthorizedCertificate> createAuthorizedCertificate(
      $2.CreateAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAuthorizedCertificate, request,
        options: options);
  }

  $grpc.ResponseFuture<$8.AuthorizedCertificate> updateAuthorizedCertificate(
      $2.UpdateAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAuthorizedCertificate, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteAuthorizedCertificate(
      $2.DeleteAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAuthorizedCertificate, request,
        options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.AuthorizedCertificates')
abstract class AuthorizedCertificatesServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.AuthorizedCertificates';

  AuthorizedCertificatesServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.ListAuthorizedCertificatesRequest,
            $2.ListAuthorizedCertificatesResponse>(
        'ListAuthorizedCertificates',
        listAuthorizedCertificates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.ListAuthorizedCertificatesRequest.fromBuffer(value),
        ($2.ListAuthorizedCertificatesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetAuthorizedCertificateRequest,
            $8.AuthorizedCertificate>(
        'GetAuthorizedCertificate',
        getAuthorizedCertificate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetAuthorizedCertificateRequest.fromBuffer(value),
        ($8.AuthorizedCertificate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CreateAuthorizedCertificateRequest,
            $8.AuthorizedCertificate>(
        'CreateAuthorizedCertificate',
        createAuthorizedCertificate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateAuthorizedCertificateRequest.fromBuffer(value),
        ($8.AuthorizedCertificate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateAuthorizedCertificateRequest,
            $8.AuthorizedCertificate>(
        'UpdateAuthorizedCertificate',
        updateAuthorizedCertificate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateAuthorizedCertificateRequest.fromBuffer(value),
        ($8.AuthorizedCertificate value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.DeleteAuthorizedCertificateRequest, $1.Empty>(
            'DeleteAuthorizedCertificate',
            deleteAuthorizedCertificate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.DeleteAuthorizedCertificateRequest.fromBuffer(value),
            ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$2.ListAuthorizedCertificatesResponse>
      listAuthorizedCertificates_Pre($grpc.ServiceCall call,
          $async.Future<$2.ListAuthorizedCertificatesRequest> request) async {
    return listAuthorizedCertificates(call, await request);
  }

  $async.Future<$8.AuthorizedCertificate> getAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.GetAuthorizedCertificateRequest> request) async {
    return getAuthorizedCertificate(call, await request);
  }

  $async.Future<$8.AuthorizedCertificate> createAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.CreateAuthorizedCertificateRequest> request) async {
    return createAuthorizedCertificate(call, await request);
  }

  $async.Future<$8.AuthorizedCertificate> updateAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.UpdateAuthorizedCertificateRequest> request) async {
    return updateAuthorizedCertificate(call, await request);
  }

  $async.Future<$1.Empty> deleteAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.DeleteAuthorizedCertificateRequest> request) async {
    return deleteAuthorizedCertificate(call, await request);
  }

  $async.Future<$2.ListAuthorizedCertificatesResponse>
      listAuthorizedCertificates(
          $grpc.ServiceCall call, $2.ListAuthorizedCertificatesRequest request);
  $async.Future<$8.AuthorizedCertificate> getAuthorizedCertificate(
      $grpc.ServiceCall call, $2.GetAuthorizedCertificateRequest request);
  $async.Future<$8.AuthorizedCertificate> createAuthorizedCertificate(
      $grpc.ServiceCall call, $2.CreateAuthorizedCertificateRequest request);
  $async.Future<$8.AuthorizedCertificate> updateAuthorizedCertificate(
      $grpc.ServiceCall call, $2.UpdateAuthorizedCertificateRequest request);
  $async.Future<$1.Empty> deleteAuthorizedCertificate(
      $grpc.ServiceCall call, $2.DeleteAuthorizedCertificateRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1beta.DomainMappings')
class DomainMappingsClient extends $grpc.Client {
  static final _$listDomainMappings = $grpc.ClientMethod<
          $2.ListDomainMappingsRequest, $2.ListDomainMappingsResponse>(
      '/google.appengine.v1beta.DomainMappings/ListDomainMappings',
      ($2.ListDomainMappingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.ListDomainMappingsResponse.fromBuffer(value));
  static final _$getDomainMapping =
      $grpc.ClientMethod<$2.GetDomainMappingRequest, $9.DomainMapping>(
          '/google.appengine.v1beta.DomainMappings/GetDomainMapping',
          ($2.GetDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $9.DomainMapping.fromBuffer(value));
  static final _$createDomainMapping =
      $grpc.ClientMethod<$2.CreateDomainMappingRequest, $0.Operation>(
          '/google.appengine.v1beta.DomainMappings/CreateDomainMapping',
          ($2.CreateDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateDomainMapping =
      $grpc.ClientMethod<$2.UpdateDomainMappingRequest, $0.Operation>(
          '/google.appengine.v1beta.DomainMappings/UpdateDomainMapping',
          ($2.UpdateDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteDomainMapping =
      $grpc.ClientMethod<$2.DeleteDomainMappingRequest, $0.Operation>(
          '/google.appengine.v1beta.DomainMappings/DeleteDomainMapping',
          ($2.DeleteDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  DomainMappingsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ListDomainMappingsResponse> listDomainMappings(
      $2.ListDomainMappingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listDomainMappings, request, options: options);
  }

  $grpc.ResponseFuture<$9.DomainMapping> getDomainMapping(
      $2.GetDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDomainMapping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createDomainMapping(
      $2.CreateDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDomainMapping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateDomainMapping(
      $2.UpdateDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDomainMapping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteDomainMapping(
      $2.DeleteDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDomainMapping, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1beta.DomainMappings')
abstract class DomainMappingsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1beta.DomainMappings';

  DomainMappingsServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.ListDomainMappingsRequest,
            $2.ListDomainMappingsResponse>(
        'ListDomainMappings',
        listDomainMappings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.ListDomainMappingsRequest.fromBuffer(value),
        ($2.ListDomainMappingsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.GetDomainMappingRequest, $9.DomainMapping>(
            'GetDomainMapping',
            getDomainMapping_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.GetDomainMappingRequest.fromBuffer(value),
            ($9.DomainMapping value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CreateDomainMappingRequest, $0.Operation>(
        'CreateDomainMapping',
        createDomainMapping_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateDomainMappingRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateDomainMappingRequest, $0.Operation>(
        'UpdateDomainMapping',
        updateDomainMapping_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateDomainMappingRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteDomainMappingRequest, $0.Operation>(
        'DeleteDomainMapping',
        deleteDomainMapping_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DeleteDomainMappingRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$2.ListDomainMappingsResponse> listDomainMappings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ListDomainMappingsRequest> request) async {
    return listDomainMappings(call, await request);
  }

  $async.Future<$9.DomainMapping> getDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetDomainMappingRequest> request) async {
    return getDomainMapping(call, await request);
  }

  $async.Future<$0.Operation> createDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateDomainMappingRequest> request) async {
    return createDomainMapping(call, await request);
  }

  $async.Future<$0.Operation> updateDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateDomainMappingRequest> request) async {
    return updateDomainMapping(call, await request);
  }

  $async.Future<$0.Operation> deleteDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteDomainMappingRequest> request) async {
    return deleteDomainMapping(call, await request);
  }

  $async.Future<$2.ListDomainMappingsResponse> listDomainMappings(
      $grpc.ServiceCall call, $2.ListDomainMappingsRequest request);
  $async.Future<$9.DomainMapping> getDomainMapping(
      $grpc.ServiceCall call, $2.GetDomainMappingRequest request);
  $async.Future<$0.Operation> createDomainMapping(
      $grpc.ServiceCall call, $2.CreateDomainMappingRequest request);
  $async.Future<$0.Operation> updateDomainMapping(
      $grpc.ServiceCall call, $2.UpdateDomainMappingRequest request);
  $async.Future<$0.Operation> deleteDomainMapping(
      $grpc.ServiceCall call, $2.DeleteDomainMappingRequest request);
}
