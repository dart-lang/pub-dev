//
//  Generated code. Do not modify.
//  source: google/appengine/v1/appengine.proto
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
import 'appengine.pb.dart' as $10;
import 'application.pb.dart' as $11;
import 'certificate.pb.dart' as $16;
import 'domain_mapping.pb.dart' as $17;
import 'firewall.pb.dart' as $15;
import 'instance.pb.dart' as $14;
import 'service.pb.dart' as $12;
import 'version.pb.dart' as $13;

export 'appengine.pb.dart';

@$pb.GrpcServiceName('google.appengine.v1.Applications')
class ApplicationsClient extends $grpc.Client {
  static final _$getApplication =
      $grpc.ClientMethod<$10.GetApplicationRequest, $11.Application>(
          '/google.appengine.v1.Applications/GetApplication',
          ($10.GetApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $11.Application.fromBuffer(value));
  static final _$createApplication =
      $grpc.ClientMethod<$10.CreateApplicationRequest, $0.Operation>(
          '/google.appengine.v1.Applications/CreateApplication',
          ($10.CreateApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateApplication =
      $grpc.ClientMethod<$10.UpdateApplicationRequest, $0.Operation>(
          '/google.appengine.v1.Applications/UpdateApplication',
          ($10.UpdateApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$repairApplication =
      $grpc.ClientMethod<$10.RepairApplicationRequest, $0.Operation>(
          '/google.appengine.v1.Applications/RepairApplication',
          ($10.RepairApplicationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  ApplicationsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$11.Application> getApplication(
      $10.GetApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getApplication, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createApplication(
      $10.CreateApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createApplication, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateApplication(
      $10.UpdateApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateApplication, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> repairApplication(
      $10.RepairApplicationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$repairApplication, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.Applications')
abstract class ApplicationsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.Applications';

  ApplicationsServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.GetApplicationRequest, $11.Application>(
        'GetApplication',
        getApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetApplicationRequest.fromBuffer(value),
        ($11.Application value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.CreateApplicationRequest, $0.Operation>(
        'CreateApplication',
        createApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CreateApplicationRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.UpdateApplicationRequest, $0.Operation>(
        'UpdateApplication',
        updateApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.UpdateApplicationRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.RepairApplicationRequest, $0.Operation>(
        'RepairApplication',
        repairApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.RepairApplicationRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$11.Application> getApplication_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetApplicationRequest> request) async {
    return getApplication(call, await request);
  }

  $async.Future<$0.Operation> createApplication_Pre($grpc.ServiceCall call,
      $async.Future<$10.CreateApplicationRequest> request) async {
    return createApplication(call, await request);
  }

  $async.Future<$0.Operation> updateApplication_Pre($grpc.ServiceCall call,
      $async.Future<$10.UpdateApplicationRequest> request) async {
    return updateApplication(call, await request);
  }

  $async.Future<$0.Operation> repairApplication_Pre($grpc.ServiceCall call,
      $async.Future<$10.RepairApplicationRequest> request) async {
    return repairApplication(call, await request);
  }

  $async.Future<$11.Application> getApplication(
      $grpc.ServiceCall call, $10.GetApplicationRequest request);
  $async.Future<$0.Operation> createApplication(
      $grpc.ServiceCall call, $10.CreateApplicationRequest request);
  $async.Future<$0.Operation> updateApplication(
      $grpc.ServiceCall call, $10.UpdateApplicationRequest request);
  $async.Future<$0.Operation> repairApplication(
      $grpc.ServiceCall call, $10.RepairApplicationRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1.Services')
class ServicesClient extends $grpc.Client {
  static final _$listServices =
      $grpc.ClientMethod<$10.ListServicesRequest, $10.ListServicesResponse>(
          '/google.appengine.v1.Services/ListServices',
          ($10.ListServicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.ListServicesResponse.fromBuffer(value));
  static final _$getService =
      $grpc.ClientMethod<$10.GetServiceRequest, $12.Service>(
          '/google.appengine.v1.Services/GetService',
          ($10.GetServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $12.Service.fromBuffer(value));
  static final _$updateService =
      $grpc.ClientMethod<$10.UpdateServiceRequest, $0.Operation>(
          '/google.appengine.v1.Services/UpdateService',
          ($10.UpdateServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteService =
      $grpc.ClientMethod<$10.DeleteServiceRequest, $0.Operation>(
          '/google.appengine.v1.Services/DeleteService',
          ($10.DeleteServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  ServicesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.ListServicesResponse> listServices(
      $10.ListServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServices, request, options: options);
  }

  $grpc.ResponseFuture<$12.Service> getService($10.GetServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateService(
      $10.UpdateServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteService(
      $10.DeleteServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteService, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.Services')
abstract class ServicesServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.Services';

  ServicesServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$10.ListServicesRequest, $10.ListServicesResponse>(
            'ListServices',
            listServices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.ListServicesRequest.fromBuffer(value),
            ($10.ListServicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetServiceRequest, $12.Service>(
        'GetService',
        getService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetServiceRequest.fromBuffer(value),
        ($12.Service value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.UpdateServiceRequest, $0.Operation>(
        'UpdateService',
        updateService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.UpdateServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DeleteServiceRequest, $0.Operation>(
        'DeleteService',
        deleteService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.DeleteServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$10.ListServicesResponse> listServices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListServicesRequest> request) async {
    return listServices(call, await request);
  }

  $async.Future<$12.Service> getService_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetServiceRequest> request) async {
    return getService(call, await request);
  }

  $async.Future<$0.Operation> updateService_Pre($grpc.ServiceCall call,
      $async.Future<$10.UpdateServiceRequest> request) async {
    return updateService(call, await request);
  }

  $async.Future<$0.Operation> deleteService_Pre($grpc.ServiceCall call,
      $async.Future<$10.DeleteServiceRequest> request) async {
    return deleteService(call, await request);
  }

  $async.Future<$10.ListServicesResponse> listServices(
      $grpc.ServiceCall call, $10.ListServicesRequest request);
  $async.Future<$12.Service> getService(
      $grpc.ServiceCall call, $10.GetServiceRequest request);
  $async.Future<$0.Operation> updateService(
      $grpc.ServiceCall call, $10.UpdateServiceRequest request);
  $async.Future<$0.Operation> deleteService(
      $grpc.ServiceCall call, $10.DeleteServiceRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1.Versions')
class VersionsClient extends $grpc.Client {
  static final _$listVersions =
      $grpc.ClientMethod<$10.ListVersionsRequest, $10.ListVersionsResponse>(
          '/google.appengine.v1.Versions/ListVersions',
          ($10.ListVersionsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.ListVersionsResponse.fromBuffer(value));
  static final _$getVersion =
      $grpc.ClientMethod<$10.GetVersionRequest, $13.Version>(
          '/google.appengine.v1.Versions/GetVersion',
          ($10.GetVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $13.Version.fromBuffer(value));
  static final _$createVersion =
      $grpc.ClientMethod<$10.CreateVersionRequest, $0.Operation>(
          '/google.appengine.v1.Versions/CreateVersion',
          ($10.CreateVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateVersion =
      $grpc.ClientMethod<$10.UpdateVersionRequest, $0.Operation>(
          '/google.appengine.v1.Versions/UpdateVersion',
          ($10.UpdateVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteVersion =
      $grpc.ClientMethod<$10.DeleteVersionRequest, $0.Operation>(
          '/google.appengine.v1.Versions/DeleteVersion',
          ($10.DeleteVersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  VersionsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.ListVersionsResponse> listVersions(
      $10.ListVersionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listVersions, request, options: options);
  }

  $grpc.ResponseFuture<$13.Version> getVersion($10.GetVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createVersion(
      $10.CreateVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateVersion(
      $10.UpdateVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateVersion, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteVersion(
      $10.DeleteVersionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteVersion, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.Versions')
abstract class VersionsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.Versions';

  VersionsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$10.ListVersionsRequest, $10.ListVersionsResponse>(
            'ListVersions',
            listVersions_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.ListVersionsRequest.fromBuffer(value),
            ($10.ListVersionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetVersionRequest, $13.Version>(
        'GetVersion',
        getVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetVersionRequest.fromBuffer(value),
        ($13.Version value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.CreateVersionRequest, $0.Operation>(
        'CreateVersion',
        createVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CreateVersionRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.UpdateVersionRequest, $0.Operation>(
        'UpdateVersion',
        updateVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.UpdateVersionRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DeleteVersionRequest, $0.Operation>(
        'DeleteVersion',
        deleteVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.DeleteVersionRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$10.ListVersionsResponse> listVersions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListVersionsRequest> request) async {
    return listVersions(call, await request);
  }

  $async.Future<$13.Version> getVersion_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetVersionRequest> request) async {
    return getVersion(call, await request);
  }

  $async.Future<$0.Operation> createVersion_Pre($grpc.ServiceCall call,
      $async.Future<$10.CreateVersionRequest> request) async {
    return createVersion(call, await request);
  }

  $async.Future<$0.Operation> updateVersion_Pre($grpc.ServiceCall call,
      $async.Future<$10.UpdateVersionRequest> request) async {
    return updateVersion(call, await request);
  }

  $async.Future<$0.Operation> deleteVersion_Pre($grpc.ServiceCall call,
      $async.Future<$10.DeleteVersionRequest> request) async {
    return deleteVersion(call, await request);
  }

  $async.Future<$10.ListVersionsResponse> listVersions(
      $grpc.ServiceCall call, $10.ListVersionsRequest request);
  $async.Future<$13.Version> getVersion(
      $grpc.ServiceCall call, $10.GetVersionRequest request);
  $async.Future<$0.Operation> createVersion(
      $grpc.ServiceCall call, $10.CreateVersionRequest request);
  $async.Future<$0.Operation> updateVersion(
      $grpc.ServiceCall call, $10.UpdateVersionRequest request);
  $async.Future<$0.Operation> deleteVersion(
      $grpc.ServiceCall call, $10.DeleteVersionRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1.Instances')
class InstancesClient extends $grpc.Client {
  static final _$listInstances =
      $grpc.ClientMethod<$10.ListInstancesRequest, $10.ListInstancesResponse>(
          '/google.appengine.v1.Instances/ListInstances',
          ($10.ListInstancesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.ListInstancesResponse.fromBuffer(value));
  static final _$getInstance =
      $grpc.ClientMethod<$10.GetInstanceRequest, $14.Instance>(
          '/google.appengine.v1.Instances/GetInstance',
          ($10.GetInstanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $14.Instance.fromBuffer(value));
  static final _$deleteInstance =
      $grpc.ClientMethod<$10.DeleteInstanceRequest, $0.Operation>(
          '/google.appengine.v1.Instances/DeleteInstance',
          ($10.DeleteInstanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$debugInstance =
      $grpc.ClientMethod<$10.DebugInstanceRequest, $0.Operation>(
          '/google.appengine.v1.Instances/DebugInstance',
          ($10.DebugInstanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  InstancesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.ListInstancesResponse> listInstances(
      $10.ListInstancesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listInstances, request, options: options);
  }

  $grpc.ResponseFuture<$14.Instance> getInstance($10.GetInstanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstance, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteInstance(
      $10.DeleteInstanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInstance, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> debugInstance(
      $10.DebugInstanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$debugInstance, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.Instances')
abstract class InstancesServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.Instances';

  InstancesServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.ListInstancesRequest,
            $10.ListInstancesResponse>(
        'ListInstances',
        listInstances_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.ListInstancesRequest.fromBuffer(value),
        ($10.ListInstancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetInstanceRequest, $14.Instance>(
        'GetInstance',
        getInstance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetInstanceRequest.fromBuffer(value),
        ($14.Instance value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DeleteInstanceRequest, $0.Operation>(
        'DeleteInstance',
        deleteInstance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.DeleteInstanceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DebugInstanceRequest, $0.Operation>(
        'DebugInstance',
        debugInstance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.DebugInstanceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$10.ListInstancesResponse> listInstances_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListInstancesRequest> request) async {
    return listInstances(call, await request);
  }

  $async.Future<$14.Instance> getInstance_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetInstanceRequest> request) async {
    return getInstance(call, await request);
  }

  $async.Future<$0.Operation> deleteInstance_Pre($grpc.ServiceCall call,
      $async.Future<$10.DeleteInstanceRequest> request) async {
    return deleteInstance(call, await request);
  }

  $async.Future<$0.Operation> debugInstance_Pre($grpc.ServiceCall call,
      $async.Future<$10.DebugInstanceRequest> request) async {
    return debugInstance(call, await request);
  }

  $async.Future<$10.ListInstancesResponse> listInstances(
      $grpc.ServiceCall call, $10.ListInstancesRequest request);
  $async.Future<$14.Instance> getInstance(
      $grpc.ServiceCall call, $10.GetInstanceRequest request);
  $async.Future<$0.Operation> deleteInstance(
      $grpc.ServiceCall call, $10.DeleteInstanceRequest request);
  $async.Future<$0.Operation> debugInstance(
      $grpc.ServiceCall call, $10.DebugInstanceRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1.Firewall')
class FirewallClient extends $grpc.Client {
  static final _$listIngressRules = $grpc.ClientMethod<
          $10.ListIngressRulesRequest, $10.ListIngressRulesResponse>(
      '/google.appengine.v1.Firewall/ListIngressRules',
      ($10.ListIngressRulesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.ListIngressRulesResponse.fromBuffer(value));
  static final _$batchUpdateIngressRules = $grpc.ClientMethod<
          $10.BatchUpdateIngressRulesRequest,
          $10.BatchUpdateIngressRulesResponse>(
      '/google.appengine.v1.Firewall/BatchUpdateIngressRules',
      ($10.BatchUpdateIngressRulesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.BatchUpdateIngressRulesResponse.fromBuffer(value));
  static final _$createIngressRule =
      $grpc.ClientMethod<$10.CreateIngressRuleRequest, $15.FirewallRule>(
          '/google.appengine.v1.Firewall/CreateIngressRule',
          ($10.CreateIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $15.FirewallRule.fromBuffer(value));
  static final _$getIngressRule =
      $grpc.ClientMethod<$10.GetIngressRuleRequest, $15.FirewallRule>(
          '/google.appengine.v1.Firewall/GetIngressRule',
          ($10.GetIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $15.FirewallRule.fromBuffer(value));
  static final _$updateIngressRule =
      $grpc.ClientMethod<$10.UpdateIngressRuleRequest, $15.FirewallRule>(
          '/google.appengine.v1.Firewall/UpdateIngressRule',
          ($10.UpdateIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $15.FirewallRule.fromBuffer(value));
  static final _$deleteIngressRule =
      $grpc.ClientMethod<$10.DeleteIngressRuleRequest, $1.Empty>(
          '/google.appengine.v1.Firewall/DeleteIngressRule',
          ($10.DeleteIngressRuleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  FirewallClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.ListIngressRulesResponse> listIngressRules(
      $10.ListIngressRulesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listIngressRules, request, options: options);
  }

  $grpc.ResponseFuture<$10.BatchUpdateIngressRulesResponse>
      batchUpdateIngressRules($10.BatchUpdateIngressRulesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchUpdateIngressRules, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.FirewallRule> createIngressRule(
      $10.CreateIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIngressRule, request, options: options);
  }

  $grpc.ResponseFuture<$15.FirewallRule> getIngressRule(
      $10.GetIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIngressRule, request, options: options);
  }

  $grpc.ResponseFuture<$15.FirewallRule> updateIngressRule(
      $10.UpdateIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateIngressRule, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteIngressRule(
      $10.DeleteIngressRuleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteIngressRule, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.Firewall')
abstract class FirewallServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.Firewall';

  FirewallServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.ListIngressRulesRequest,
            $10.ListIngressRulesResponse>(
        'ListIngressRules',
        listIngressRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.ListIngressRulesRequest.fromBuffer(value),
        ($10.ListIngressRulesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.BatchUpdateIngressRulesRequest,
            $10.BatchUpdateIngressRulesResponse>(
        'BatchUpdateIngressRules',
        batchUpdateIngressRules_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.BatchUpdateIngressRulesRequest.fromBuffer(value),
        ($10.BatchUpdateIngressRulesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.CreateIngressRuleRequest, $15.FirewallRule>(
            'CreateIngressRule',
            createIngressRule_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.CreateIngressRuleRequest.fromBuffer(value),
            ($15.FirewallRule value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetIngressRuleRequest, $15.FirewallRule>(
        'GetIngressRule',
        getIngressRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetIngressRuleRequest.fromBuffer(value),
        ($15.FirewallRule value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.UpdateIngressRuleRequest, $15.FirewallRule>(
            'UpdateIngressRule',
            updateIngressRule_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.UpdateIngressRuleRequest.fromBuffer(value),
            ($15.FirewallRule value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DeleteIngressRuleRequest, $1.Empty>(
        'DeleteIngressRule',
        deleteIngressRule_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.DeleteIngressRuleRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$10.ListIngressRulesResponse> listIngressRules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListIngressRulesRequest> request) async {
    return listIngressRules(call, await request);
  }

  $async.Future<$10.BatchUpdateIngressRulesResponse>
      batchUpdateIngressRules_Pre($grpc.ServiceCall call,
          $async.Future<$10.BatchUpdateIngressRulesRequest> request) async {
    return batchUpdateIngressRules(call, await request);
  }

  $async.Future<$15.FirewallRule> createIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$10.CreateIngressRuleRequest> request) async {
    return createIngressRule(call, await request);
  }

  $async.Future<$15.FirewallRule> getIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetIngressRuleRequest> request) async {
    return getIngressRule(call, await request);
  }

  $async.Future<$15.FirewallRule> updateIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$10.UpdateIngressRuleRequest> request) async {
    return updateIngressRule(call, await request);
  }

  $async.Future<$1.Empty> deleteIngressRule_Pre($grpc.ServiceCall call,
      $async.Future<$10.DeleteIngressRuleRequest> request) async {
    return deleteIngressRule(call, await request);
  }

  $async.Future<$10.ListIngressRulesResponse> listIngressRules(
      $grpc.ServiceCall call, $10.ListIngressRulesRequest request);
  $async.Future<$10.BatchUpdateIngressRulesResponse> batchUpdateIngressRules(
      $grpc.ServiceCall call, $10.BatchUpdateIngressRulesRequest request);
  $async.Future<$15.FirewallRule> createIngressRule(
      $grpc.ServiceCall call, $10.CreateIngressRuleRequest request);
  $async.Future<$15.FirewallRule> getIngressRule(
      $grpc.ServiceCall call, $10.GetIngressRuleRequest request);
  $async.Future<$15.FirewallRule> updateIngressRule(
      $grpc.ServiceCall call, $10.UpdateIngressRuleRequest request);
  $async.Future<$1.Empty> deleteIngressRule(
      $grpc.ServiceCall call, $10.DeleteIngressRuleRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1.AuthorizedDomains')
class AuthorizedDomainsClient extends $grpc.Client {
  static final _$listAuthorizedDomains = $grpc.ClientMethod<
          $10.ListAuthorizedDomainsRequest, $10.ListAuthorizedDomainsResponse>(
      '/google.appengine.v1.AuthorizedDomains/ListAuthorizedDomains',
      ($10.ListAuthorizedDomainsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.ListAuthorizedDomainsResponse.fromBuffer(value));

  AuthorizedDomainsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.ListAuthorizedDomainsResponse> listAuthorizedDomains(
      $10.ListAuthorizedDomainsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAuthorizedDomains, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.AuthorizedDomains')
abstract class AuthorizedDomainsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.AuthorizedDomains';

  AuthorizedDomainsServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.ListAuthorizedDomainsRequest,
            $10.ListAuthorizedDomainsResponse>(
        'ListAuthorizedDomains',
        listAuthorizedDomains_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.ListAuthorizedDomainsRequest.fromBuffer(value),
        ($10.ListAuthorizedDomainsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.ListAuthorizedDomainsResponse> listAuthorizedDomains_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListAuthorizedDomainsRequest> request) async {
    return listAuthorizedDomains(call, await request);
  }

  $async.Future<$10.ListAuthorizedDomainsResponse> listAuthorizedDomains(
      $grpc.ServiceCall call, $10.ListAuthorizedDomainsRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1.AuthorizedCertificates')
class AuthorizedCertificatesClient extends $grpc.Client {
  static final _$listAuthorizedCertificates = $grpc.ClientMethod<
          $10.ListAuthorizedCertificatesRequest,
          $10.ListAuthorizedCertificatesResponse>(
      '/google.appengine.v1.AuthorizedCertificates/ListAuthorizedCertificates',
      ($10.ListAuthorizedCertificatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.ListAuthorizedCertificatesResponse.fromBuffer(value));
  static final _$getAuthorizedCertificate = $grpc.ClientMethod<
          $10.GetAuthorizedCertificateRequest, $16.AuthorizedCertificate>(
      '/google.appengine.v1.AuthorizedCertificates/GetAuthorizedCertificate',
      ($10.GetAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.AuthorizedCertificate.fromBuffer(value));
  static final _$createAuthorizedCertificate = $grpc.ClientMethod<
          $10.CreateAuthorizedCertificateRequest, $16.AuthorizedCertificate>(
      '/google.appengine.v1.AuthorizedCertificates/CreateAuthorizedCertificate',
      ($10.CreateAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.AuthorizedCertificate.fromBuffer(value));
  static final _$updateAuthorizedCertificate = $grpc.ClientMethod<
          $10.UpdateAuthorizedCertificateRequest, $16.AuthorizedCertificate>(
      '/google.appengine.v1.AuthorizedCertificates/UpdateAuthorizedCertificate',
      ($10.UpdateAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.AuthorizedCertificate.fromBuffer(value));
  static final _$deleteAuthorizedCertificate = $grpc.ClientMethod<
          $10.DeleteAuthorizedCertificateRequest, $1.Empty>(
      '/google.appengine.v1.AuthorizedCertificates/DeleteAuthorizedCertificate',
      ($10.DeleteAuthorizedCertificateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  AuthorizedCertificatesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.ListAuthorizedCertificatesResponse>
      listAuthorizedCertificates($10.ListAuthorizedCertificatesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAuthorizedCertificates, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.AuthorizedCertificate> getAuthorizedCertificate(
      $10.GetAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAuthorizedCertificate, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.AuthorizedCertificate> createAuthorizedCertificate(
      $10.CreateAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAuthorizedCertificate, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.AuthorizedCertificate> updateAuthorizedCertificate(
      $10.UpdateAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAuthorizedCertificate, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteAuthorizedCertificate(
      $10.DeleteAuthorizedCertificateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAuthorizedCertificate, request,
        options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.AuthorizedCertificates')
abstract class AuthorizedCertificatesServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.AuthorizedCertificates';

  AuthorizedCertificatesServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.ListAuthorizedCertificatesRequest,
            $10.ListAuthorizedCertificatesResponse>(
        'ListAuthorizedCertificates',
        listAuthorizedCertificates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.ListAuthorizedCertificatesRequest.fromBuffer(value),
        ($10.ListAuthorizedCertificatesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetAuthorizedCertificateRequest,
            $16.AuthorizedCertificate>(
        'GetAuthorizedCertificate',
        getAuthorizedCertificate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetAuthorizedCertificateRequest.fromBuffer(value),
        ($16.AuthorizedCertificate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.CreateAuthorizedCertificateRequest,
            $16.AuthorizedCertificate>(
        'CreateAuthorizedCertificate',
        createAuthorizedCertificate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CreateAuthorizedCertificateRequest.fromBuffer(value),
        ($16.AuthorizedCertificate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.UpdateAuthorizedCertificateRequest,
            $16.AuthorizedCertificate>(
        'UpdateAuthorizedCertificate',
        updateAuthorizedCertificate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.UpdateAuthorizedCertificateRequest.fromBuffer(value),
        ($16.AuthorizedCertificate value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.DeleteAuthorizedCertificateRequest, $1.Empty>(
            'DeleteAuthorizedCertificate',
            deleteAuthorizedCertificate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.DeleteAuthorizedCertificateRequest.fromBuffer(value),
            ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$10.ListAuthorizedCertificatesResponse>
      listAuthorizedCertificates_Pre($grpc.ServiceCall call,
          $async.Future<$10.ListAuthorizedCertificatesRequest> request) async {
    return listAuthorizedCertificates(call, await request);
  }

  $async.Future<$16.AuthorizedCertificate> getAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetAuthorizedCertificateRequest> request) async {
    return getAuthorizedCertificate(call, await request);
  }

  $async.Future<$16.AuthorizedCertificate> createAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.CreateAuthorizedCertificateRequest> request) async {
    return createAuthorizedCertificate(call, await request);
  }

  $async.Future<$16.AuthorizedCertificate> updateAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.UpdateAuthorizedCertificateRequest> request) async {
    return updateAuthorizedCertificate(call, await request);
  }

  $async.Future<$1.Empty> deleteAuthorizedCertificate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.DeleteAuthorizedCertificateRequest> request) async {
    return deleteAuthorizedCertificate(call, await request);
  }

  $async.Future<$10.ListAuthorizedCertificatesResponse>
      listAuthorizedCertificates($grpc.ServiceCall call,
          $10.ListAuthorizedCertificatesRequest request);
  $async.Future<$16.AuthorizedCertificate> getAuthorizedCertificate(
      $grpc.ServiceCall call, $10.GetAuthorizedCertificateRequest request);
  $async.Future<$16.AuthorizedCertificate> createAuthorizedCertificate(
      $grpc.ServiceCall call, $10.CreateAuthorizedCertificateRequest request);
  $async.Future<$16.AuthorizedCertificate> updateAuthorizedCertificate(
      $grpc.ServiceCall call, $10.UpdateAuthorizedCertificateRequest request);
  $async.Future<$1.Empty> deleteAuthorizedCertificate(
      $grpc.ServiceCall call, $10.DeleteAuthorizedCertificateRequest request);
}

@$pb.GrpcServiceName('google.appengine.v1.DomainMappings')
class DomainMappingsClient extends $grpc.Client {
  static final _$listDomainMappings = $grpc.ClientMethod<
          $10.ListDomainMappingsRequest, $10.ListDomainMappingsResponse>(
      '/google.appengine.v1.DomainMappings/ListDomainMappings',
      ($10.ListDomainMappingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.ListDomainMappingsResponse.fromBuffer(value));
  static final _$getDomainMapping =
      $grpc.ClientMethod<$10.GetDomainMappingRequest, $17.DomainMapping>(
          '/google.appengine.v1.DomainMappings/GetDomainMapping',
          ($10.GetDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $17.DomainMapping.fromBuffer(value));
  static final _$createDomainMapping =
      $grpc.ClientMethod<$10.CreateDomainMappingRequest, $0.Operation>(
          '/google.appengine.v1.DomainMappings/CreateDomainMapping',
          ($10.CreateDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateDomainMapping =
      $grpc.ClientMethod<$10.UpdateDomainMappingRequest, $0.Operation>(
          '/google.appengine.v1.DomainMappings/UpdateDomainMapping',
          ($10.UpdateDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteDomainMapping =
      $grpc.ClientMethod<$10.DeleteDomainMappingRequest, $0.Operation>(
          '/google.appengine.v1.DomainMappings/DeleteDomainMapping',
          ($10.DeleteDomainMappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  DomainMappingsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.ListDomainMappingsResponse> listDomainMappings(
      $10.ListDomainMappingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listDomainMappings, request, options: options);
  }

  $grpc.ResponseFuture<$17.DomainMapping> getDomainMapping(
      $10.GetDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDomainMapping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createDomainMapping(
      $10.CreateDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDomainMapping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateDomainMapping(
      $10.UpdateDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDomainMapping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteDomainMapping(
      $10.DeleteDomainMappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDomainMapping, request, options: options);
  }
}

@$pb.GrpcServiceName('google.appengine.v1.DomainMappings')
abstract class DomainMappingsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.appengine.v1.DomainMappings';

  DomainMappingsServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.ListDomainMappingsRequest,
            $10.ListDomainMappingsResponse>(
        'ListDomainMappings',
        listDomainMappings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.ListDomainMappingsRequest.fromBuffer(value),
        ($10.ListDomainMappingsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.GetDomainMappingRequest, $17.DomainMapping>(
            'GetDomainMapping',
            getDomainMapping_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.GetDomainMappingRequest.fromBuffer(value),
            ($17.DomainMapping value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.CreateDomainMappingRequest, $0.Operation>(
            'CreateDomainMapping',
            createDomainMapping_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.CreateDomainMappingRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.UpdateDomainMappingRequest, $0.Operation>(
            'UpdateDomainMapping',
            updateDomainMapping_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.UpdateDomainMappingRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.DeleteDomainMappingRequest, $0.Operation>(
            'DeleteDomainMapping',
            deleteDomainMapping_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.DeleteDomainMappingRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$10.ListDomainMappingsResponse> listDomainMappings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListDomainMappingsRequest> request) async {
    return listDomainMappings(call, await request);
  }

  $async.Future<$17.DomainMapping> getDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$10.GetDomainMappingRequest> request) async {
    return getDomainMapping(call, await request);
  }

  $async.Future<$0.Operation> createDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$10.CreateDomainMappingRequest> request) async {
    return createDomainMapping(call, await request);
  }

  $async.Future<$0.Operation> updateDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$10.UpdateDomainMappingRequest> request) async {
    return updateDomainMapping(call, await request);
  }

  $async.Future<$0.Operation> deleteDomainMapping_Pre($grpc.ServiceCall call,
      $async.Future<$10.DeleteDomainMappingRequest> request) async {
    return deleteDomainMapping(call, await request);
  }

  $async.Future<$10.ListDomainMappingsResponse> listDomainMappings(
      $grpc.ServiceCall call, $10.ListDomainMappingsRequest request);
  $async.Future<$17.DomainMapping> getDomainMapping(
      $grpc.ServiceCall call, $10.GetDomainMappingRequest request);
  $async.Future<$0.Operation> createDomainMapping(
      $grpc.ServiceCall call, $10.CreateDomainMappingRequest request);
  $async.Future<$0.Operation> updateDomainMapping(
      $grpc.ServiceCall call, $10.UpdateDomainMappingRequest request);
  $async.Future<$0.Operation> deleteDomainMapping(
      $grpc.ServiceCall call, $10.DeleteDomainMappingRequest request);
}
