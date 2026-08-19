//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/datastore_admin.proto
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

import '../../../longrunning/operations.pb.dart' as $0;
import 'datastore_admin.pb.dart' as $23;
import 'index.pb.dart' as $24;

export 'datastore_admin.pb.dart';

@$pb.GrpcServiceName('google.datastore.admin.v1.DatastoreAdmin')
class DatastoreAdminClient extends $grpc.Client {
  static final _$exportEntities =
      $grpc.ClientMethod<$23.ExportEntitiesRequest, $0.Operation>(
          '/google.datastore.admin.v1.DatastoreAdmin/ExportEntities',
          ($23.ExportEntitiesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$importEntities =
      $grpc.ClientMethod<$23.ImportEntitiesRequest, $0.Operation>(
          '/google.datastore.admin.v1.DatastoreAdmin/ImportEntities',
          ($23.ImportEntitiesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$createIndex =
      $grpc.ClientMethod<$23.CreateIndexRequest, $0.Operation>(
          '/google.datastore.admin.v1.DatastoreAdmin/CreateIndex',
          ($23.CreateIndexRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteIndex =
      $grpc.ClientMethod<$23.DeleteIndexRequest, $0.Operation>(
          '/google.datastore.admin.v1.DatastoreAdmin/DeleteIndex',
          ($23.DeleteIndexRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$getIndex = $grpc.ClientMethod<$23.GetIndexRequest, $24.Index>(
      '/google.datastore.admin.v1.DatastoreAdmin/GetIndex',
      ($23.GetIndexRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $24.Index.fromBuffer(value));
  static final _$listIndexes =
      $grpc.ClientMethod<$23.ListIndexesRequest, $23.ListIndexesResponse>(
          '/google.datastore.admin.v1.DatastoreAdmin/ListIndexes',
          ($23.ListIndexesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.ListIndexesResponse.fromBuffer(value));

  DatastoreAdminClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Operation> exportEntities(
      $23.ExportEntitiesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$exportEntities, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> importEntities(
      $23.ImportEntitiesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$importEntities, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createIndex($23.CreateIndexRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIndex, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteIndex($23.DeleteIndexRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteIndex, request, options: options);
  }

  $grpc.ResponseFuture<$24.Index> getIndex($23.GetIndexRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIndex, request, options: options);
  }

  $grpc.ResponseFuture<$23.ListIndexesResponse> listIndexes(
      $23.ListIndexesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listIndexes, request, options: options);
  }
}

@$pb.GrpcServiceName('google.datastore.admin.v1.DatastoreAdmin')
abstract class DatastoreAdminServiceBase extends $grpc.Service {
  $core.String get $name => 'google.datastore.admin.v1.DatastoreAdmin';

  DatastoreAdminServiceBase() {
    $addMethod($grpc.ServiceMethod<$23.ExportEntitiesRequest, $0.Operation>(
        'ExportEntities',
        exportEntities_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.ExportEntitiesRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ImportEntitiesRequest, $0.Operation>(
        'ImportEntities',
        importEntities_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.ImportEntitiesRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.CreateIndexRequest, $0.Operation>(
        'CreateIndex',
        createIndex_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.CreateIndexRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.DeleteIndexRequest, $0.Operation>(
        'DeleteIndex',
        deleteIndex_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.DeleteIndexRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetIndexRequest, $24.Index>(
        'GetIndex',
        getIndex_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetIndexRequest.fromBuffer(value),
        ($24.Index value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.ListIndexesRequest, $23.ListIndexesResponse>(
            'ListIndexes',
            listIndexes_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.ListIndexesRequest.fromBuffer(value),
            ($23.ListIndexesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Operation> exportEntities_Pre($grpc.ServiceCall call,
      $async.Future<$23.ExportEntitiesRequest> request) async {
    return exportEntities(call, await request);
  }

  $async.Future<$0.Operation> importEntities_Pre($grpc.ServiceCall call,
      $async.Future<$23.ImportEntitiesRequest> request) async {
    return importEntities(call, await request);
  }

  $async.Future<$0.Operation> createIndex_Pre($grpc.ServiceCall call,
      $async.Future<$23.CreateIndexRequest> request) async {
    return createIndex(call, await request);
  }

  $async.Future<$0.Operation> deleteIndex_Pre($grpc.ServiceCall call,
      $async.Future<$23.DeleteIndexRequest> request) async {
    return deleteIndex(call, await request);
  }

  $async.Future<$24.Index> getIndex_Pre($grpc.ServiceCall call,
      $async.Future<$23.GetIndexRequest> request) async {
    return getIndex(call, await request);
  }

  $async.Future<$23.ListIndexesResponse> listIndexes_Pre($grpc.ServiceCall call,
      $async.Future<$23.ListIndexesRequest> request) async {
    return listIndexes(call, await request);
  }

  $async.Future<$0.Operation> exportEntities(
      $grpc.ServiceCall call, $23.ExportEntitiesRequest request);
  $async.Future<$0.Operation> importEntities(
      $grpc.ServiceCall call, $23.ImportEntitiesRequest request);
  $async.Future<$0.Operation> createIndex(
      $grpc.ServiceCall call, $23.CreateIndexRequest request);
  $async.Future<$0.Operation> deleteIndex(
      $grpc.ServiceCall call, $23.DeleteIndexRequest request);
  $async.Future<$24.Index> getIndex(
      $grpc.ServiceCall call, $23.GetIndexRequest request);
  $async.Future<$23.ListIndexesResponse> listIndexes(
      $grpc.ServiceCall call, $23.ListIndexesRequest request);
}
