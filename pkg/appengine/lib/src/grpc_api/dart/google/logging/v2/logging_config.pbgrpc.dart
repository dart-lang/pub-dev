//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging_config.proto
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
import 'logging_config.pb.dart' as $19;

export 'logging_config.pb.dart';

@$pb.GrpcServiceName('google.logging.v2.ConfigServiceV2')
class ConfigServiceV2Client extends $grpc.Client {
  static final _$listBuckets =
      $grpc.ClientMethod<$19.ListBucketsRequest, $19.ListBucketsResponse>(
          '/google.logging.v2.ConfigServiceV2/ListBuckets',
          ($19.ListBucketsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.ListBucketsResponse.fromBuffer(value));
  static final _$getBucket =
      $grpc.ClientMethod<$19.GetBucketRequest, $19.LogBucket>(
          '/google.logging.v2.ConfigServiceV2/GetBucket',
          ($19.GetBucketRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogBucket.fromBuffer(value));
  static final _$createBucketAsync =
      $grpc.ClientMethod<$19.CreateBucketRequest, $0.Operation>(
          '/google.logging.v2.ConfigServiceV2/CreateBucketAsync',
          ($19.CreateBucketRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateBucketAsync =
      $grpc.ClientMethod<$19.UpdateBucketRequest, $0.Operation>(
          '/google.logging.v2.ConfigServiceV2/UpdateBucketAsync',
          ($19.UpdateBucketRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$createBucket =
      $grpc.ClientMethod<$19.CreateBucketRequest, $19.LogBucket>(
          '/google.logging.v2.ConfigServiceV2/CreateBucket',
          ($19.CreateBucketRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogBucket.fromBuffer(value));
  static final _$updateBucket =
      $grpc.ClientMethod<$19.UpdateBucketRequest, $19.LogBucket>(
          '/google.logging.v2.ConfigServiceV2/UpdateBucket',
          ($19.UpdateBucketRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogBucket.fromBuffer(value));
  static final _$deleteBucket =
      $grpc.ClientMethod<$19.DeleteBucketRequest, $1.Empty>(
          '/google.logging.v2.ConfigServiceV2/DeleteBucket',
          ($19.DeleteBucketRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$undeleteBucket =
      $grpc.ClientMethod<$19.UndeleteBucketRequest, $1.Empty>(
          '/google.logging.v2.ConfigServiceV2/UndeleteBucket',
          ($19.UndeleteBucketRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$listViews =
      $grpc.ClientMethod<$19.ListViewsRequest, $19.ListViewsResponse>(
          '/google.logging.v2.ConfigServiceV2/ListViews',
          ($19.ListViewsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.ListViewsResponse.fromBuffer(value));
  static final _$getView = $grpc.ClientMethod<$19.GetViewRequest, $19.LogView>(
      '/google.logging.v2.ConfigServiceV2/GetView',
      ($19.GetViewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $19.LogView.fromBuffer(value));
  static final _$createView =
      $grpc.ClientMethod<$19.CreateViewRequest, $19.LogView>(
          '/google.logging.v2.ConfigServiceV2/CreateView',
          ($19.CreateViewRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogView.fromBuffer(value));
  static final _$updateView =
      $grpc.ClientMethod<$19.UpdateViewRequest, $19.LogView>(
          '/google.logging.v2.ConfigServiceV2/UpdateView',
          ($19.UpdateViewRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogView.fromBuffer(value));
  static final _$deleteView =
      $grpc.ClientMethod<$19.DeleteViewRequest, $1.Empty>(
          '/google.logging.v2.ConfigServiceV2/DeleteView',
          ($19.DeleteViewRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$listSinks =
      $grpc.ClientMethod<$19.ListSinksRequest, $19.ListSinksResponse>(
          '/google.logging.v2.ConfigServiceV2/ListSinks',
          ($19.ListSinksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.ListSinksResponse.fromBuffer(value));
  static final _$getSink = $grpc.ClientMethod<$19.GetSinkRequest, $19.LogSink>(
      '/google.logging.v2.ConfigServiceV2/GetSink',
      ($19.GetSinkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $19.LogSink.fromBuffer(value));
  static final _$createSink =
      $grpc.ClientMethod<$19.CreateSinkRequest, $19.LogSink>(
          '/google.logging.v2.ConfigServiceV2/CreateSink',
          ($19.CreateSinkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogSink.fromBuffer(value));
  static final _$updateSink =
      $grpc.ClientMethod<$19.UpdateSinkRequest, $19.LogSink>(
          '/google.logging.v2.ConfigServiceV2/UpdateSink',
          ($19.UpdateSinkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogSink.fromBuffer(value));
  static final _$deleteSink =
      $grpc.ClientMethod<$19.DeleteSinkRequest, $1.Empty>(
          '/google.logging.v2.ConfigServiceV2/DeleteSink',
          ($19.DeleteSinkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$createLink =
      $grpc.ClientMethod<$19.CreateLinkRequest, $0.Operation>(
          '/google.logging.v2.ConfigServiceV2/CreateLink',
          ($19.CreateLinkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteLink =
      $grpc.ClientMethod<$19.DeleteLinkRequest, $0.Operation>(
          '/google.logging.v2.ConfigServiceV2/DeleteLink',
          ($19.DeleteLinkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listLinks =
      $grpc.ClientMethod<$19.ListLinksRequest, $19.ListLinksResponse>(
          '/google.logging.v2.ConfigServiceV2/ListLinks',
          ($19.ListLinksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.ListLinksResponse.fromBuffer(value));
  static final _$getLink = $grpc.ClientMethod<$19.GetLinkRequest, $19.Link>(
      '/google.logging.v2.ConfigServiceV2/GetLink',
      ($19.GetLinkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $19.Link.fromBuffer(value));
  static final _$listExclusions =
      $grpc.ClientMethod<$19.ListExclusionsRequest, $19.ListExclusionsResponse>(
          '/google.logging.v2.ConfigServiceV2/ListExclusions',
          ($19.ListExclusionsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.ListExclusionsResponse.fromBuffer(value));
  static final _$getExclusion =
      $grpc.ClientMethod<$19.GetExclusionRequest, $19.LogExclusion>(
          '/google.logging.v2.ConfigServiceV2/GetExclusion',
          ($19.GetExclusionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogExclusion.fromBuffer(value));
  static final _$createExclusion =
      $grpc.ClientMethod<$19.CreateExclusionRequest, $19.LogExclusion>(
          '/google.logging.v2.ConfigServiceV2/CreateExclusion',
          ($19.CreateExclusionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogExclusion.fromBuffer(value));
  static final _$updateExclusion =
      $grpc.ClientMethod<$19.UpdateExclusionRequest, $19.LogExclusion>(
          '/google.logging.v2.ConfigServiceV2/UpdateExclusion',
          ($19.UpdateExclusionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.LogExclusion.fromBuffer(value));
  static final _$deleteExclusion =
      $grpc.ClientMethod<$19.DeleteExclusionRequest, $1.Empty>(
          '/google.logging.v2.ConfigServiceV2/DeleteExclusion',
          ($19.DeleteExclusionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getCmekSettings =
      $grpc.ClientMethod<$19.GetCmekSettingsRequest, $19.CmekSettings>(
          '/google.logging.v2.ConfigServiceV2/GetCmekSettings',
          ($19.GetCmekSettingsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.CmekSettings.fromBuffer(value));
  static final _$updateCmekSettings =
      $grpc.ClientMethod<$19.UpdateCmekSettingsRequest, $19.CmekSettings>(
          '/google.logging.v2.ConfigServiceV2/UpdateCmekSettings',
          ($19.UpdateCmekSettingsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.CmekSettings.fromBuffer(value));
  static final _$getSettings =
      $grpc.ClientMethod<$19.GetSettingsRequest, $19.Settings>(
          '/google.logging.v2.ConfigServiceV2/GetSettings',
          ($19.GetSettingsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.Settings.fromBuffer(value));
  static final _$updateSettings =
      $grpc.ClientMethod<$19.UpdateSettingsRequest, $19.Settings>(
          '/google.logging.v2.ConfigServiceV2/UpdateSettings',
          ($19.UpdateSettingsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $19.Settings.fromBuffer(value));
  static final _$copyLogEntries =
      $grpc.ClientMethod<$19.CopyLogEntriesRequest, $0.Operation>(
          '/google.logging.v2.ConfigServiceV2/CopyLogEntries',
          ($19.CopyLogEntriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  ConfigServiceV2Client($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$19.ListBucketsResponse> listBuckets(
      $19.ListBucketsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listBuckets, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogBucket> getBucket($19.GetBucketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBucket, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createBucketAsync(
      $19.CreateBucketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBucketAsync, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateBucketAsync(
      $19.UpdateBucketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBucketAsync, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogBucket> createBucket(
      $19.CreateBucketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createBucket, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogBucket> updateBucket(
      $19.UpdateBucketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBucket, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteBucket($19.DeleteBucketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBucket, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> undeleteBucket(
      $19.UndeleteBucketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$undeleteBucket, request, options: options);
  }

  $grpc.ResponseFuture<$19.ListViewsResponse> listViews(
      $19.ListViewsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listViews, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogView> getView($19.GetViewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getView, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogView> createView($19.CreateViewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createView, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogView> updateView($19.UpdateViewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateView, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteView($19.DeleteViewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteView, request, options: options);
  }

  $grpc.ResponseFuture<$19.ListSinksResponse> listSinks(
      $19.ListSinksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSinks, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogSink> getSink($19.GetSinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSink, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogSink> createSink($19.CreateSinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSink, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogSink> updateSink($19.UpdateSinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSink, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteSink($19.DeleteSinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSink, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createLink($19.CreateLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLink, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteLink($19.DeleteLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteLink, request, options: options);
  }

  $grpc.ResponseFuture<$19.ListLinksResponse> listLinks(
      $19.ListLinksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listLinks, request, options: options);
  }

  $grpc.ResponseFuture<$19.Link> getLink($19.GetLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLink, request, options: options);
  }

  $grpc.ResponseFuture<$19.ListExclusionsResponse> listExclusions(
      $19.ListExclusionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listExclusions, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogExclusion> getExclusion(
      $19.GetExclusionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExclusion, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogExclusion> createExclusion(
      $19.CreateExclusionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createExclusion, request, options: options);
  }

  $grpc.ResponseFuture<$19.LogExclusion> updateExclusion(
      $19.UpdateExclusionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExclusion, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteExclusion(
      $19.DeleteExclusionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExclusion, request, options: options);
  }

  $grpc.ResponseFuture<$19.CmekSettings> getCmekSettings(
      $19.GetCmekSettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCmekSettings, request, options: options);
  }

  $grpc.ResponseFuture<$19.CmekSettings> updateCmekSettings(
      $19.UpdateCmekSettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCmekSettings, request, options: options);
  }

  $grpc.ResponseFuture<$19.Settings> getSettings($19.GetSettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSettings, request, options: options);
  }

  $grpc.ResponseFuture<$19.Settings> updateSettings(
      $19.UpdateSettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> copyLogEntries(
      $19.CopyLogEntriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$copyLogEntries, request, options: options);
  }
}

@$pb.GrpcServiceName('google.logging.v2.ConfigServiceV2')
abstract class ConfigServiceV2ServiceBase extends $grpc.Service {
  $core.String get $name => 'google.logging.v2.ConfigServiceV2';

  ConfigServiceV2ServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$19.ListBucketsRequest, $19.ListBucketsResponse>(
            'ListBuckets',
            listBuckets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.ListBucketsRequest.fromBuffer(value),
            ($19.ListBucketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetBucketRequest, $19.LogBucket>(
        'GetBucket',
        getBucket_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetBucketRequest.fromBuffer(value),
        ($19.LogBucket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateBucketRequest, $0.Operation>(
        'CreateBucketAsync',
        createBucketAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateBucketRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateBucketRequest, $0.Operation>(
        'UpdateBucketAsync',
        updateBucketAsync_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateBucketRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateBucketRequest, $19.LogBucket>(
        'CreateBucket',
        createBucket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateBucketRequest.fromBuffer(value),
        ($19.LogBucket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateBucketRequest, $19.LogBucket>(
        'UpdateBucket',
        updateBucket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateBucketRequest.fromBuffer(value),
        ($19.LogBucket value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteBucketRequest, $1.Empty>(
        'DeleteBucket',
        deleteBucket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteBucketRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UndeleteBucketRequest, $1.Empty>(
        'UndeleteBucket',
        undeleteBucket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UndeleteBucketRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ListViewsRequest, $19.ListViewsResponse>(
        'ListViews',
        listViews_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.ListViewsRequest.fromBuffer(value),
        ($19.ListViewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetViewRequest, $19.LogView>(
        'GetView',
        getView_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetViewRequest.fromBuffer(value),
        ($19.LogView value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateViewRequest, $19.LogView>(
        'CreateView',
        createView_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateViewRequest.fromBuffer(value),
        ($19.LogView value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateViewRequest, $19.LogView>(
        'UpdateView',
        updateView_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateViewRequest.fromBuffer(value),
        ($19.LogView value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteViewRequest, $1.Empty>(
        'DeleteView',
        deleteView_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteViewRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ListSinksRequest, $19.ListSinksResponse>(
        'ListSinks',
        listSinks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.ListSinksRequest.fromBuffer(value),
        ($19.ListSinksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetSinkRequest, $19.LogSink>(
        'GetSink',
        getSink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetSinkRequest.fromBuffer(value),
        ($19.LogSink value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateSinkRequest, $19.LogSink>(
        'CreateSink',
        createSink_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateSinkRequest.fromBuffer(value),
        ($19.LogSink value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateSinkRequest, $19.LogSink>(
        'UpdateSink',
        updateSink_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateSinkRequest.fromBuffer(value),
        ($19.LogSink value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteSinkRequest, $1.Empty>(
        'DeleteSink',
        deleteSink_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteSinkRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CreateLinkRequest, $0.Operation>(
        'CreateLink',
        createLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateLinkRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteLinkRequest, $0.Operation>(
        'DeleteLink',
        deleteLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteLinkRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ListLinksRequest, $19.ListLinksResponse>(
        'ListLinks',
        listLinks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.ListLinksRequest.fromBuffer(value),
        ($19.ListLinksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetLinkRequest, $19.Link>(
        'GetLink',
        getLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $19.GetLinkRequest.fromBuffer(value),
        ($19.Link value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.ListExclusionsRequest,
            $19.ListExclusionsResponse>(
        'ListExclusions',
        listExclusions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.ListExclusionsRequest.fromBuffer(value),
        ($19.ListExclusionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetExclusionRequest, $19.LogExclusion>(
        'GetExclusion',
        getExclusion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetExclusionRequest.fromBuffer(value),
        ($19.LogExclusion value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.CreateExclusionRequest, $19.LogExclusion>(
            'CreateExclusion',
            createExclusion_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.CreateExclusionRequest.fromBuffer(value),
            ($19.LogExclusion value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.UpdateExclusionRequest, $19.LogExclusion>(
            'UpdateExclusion',
            updateExclusion_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.UpdateExclusionRequest.fromBuffer(value),
            ($19.LogExclusion value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.DeleteExclusionRequest, $1.Empty>(
        'DeleteExclusion',
        deleteExclusion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.DeleteExclusionRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.GetCmekSettingsRequest, $19.CmekSettings>(
            'GetCmekSettings',
            getCmekSettings_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.GetCmekSettingsRequest.fromBuffer(value),
            ($19.CmekSettings value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$19.UpdateCmekSettingsRequest, $19.CmekSettings>(
            'UpdateCmekSettings',
            updateCmekSettings_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $19.UpdateCmekSettingsRequest.fromBuffer(value),
            ($19.CmekSettings value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetSettingsRequest, $19.Settings>(
        'GetSettings',
        getSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetSettingsRequest.fromBuffer(value),
        ($19.Settings value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateSettingsRequest, $19.Settings>(
        'UpdateSettings',
        updateSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateSettingsRequest.fromBuffer(value),
        ($19.Settings value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.CopyLogEntriesRequest, $0.Operation>(
        'CopyLogEntries',
        copyLogEntries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CopyLogEntriesRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$19.ListBucketsResponse> listBuckets_Pre($grpc.ServiceCall call,
      $async.Future<$19.ListBucketsRequest> request) async {
    return listBuckets(call, await request);
  }

  $async.Future<$19.LogBucket> getBucket_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetBucketRequest> request) async {
    return getBucket(call, await request);
  }

  $async.Future<$0.Operation> createBucketAsync_Pre($grpc.ServiceCall call,
      $async.Future<$19.CreateBucketRequest> request) async {
    return createBucketAsync(call, await request);
  }

  $async.Future<$0.Operation> updateBucketAsync_Pre($grpc.ServiceCall call,
      $async.Future<$19.UpdateBucketRequest> request) async {
    return updateBucketAsync(call, await request);
  }

  $async.Future<$19.LogBucket> createBucket_Pre($grpc.ServiceCall call,
      $async.Future<$19.CreateBucketRequest> request) async {
    return createBucket(call, await request);
  }

  $async.Future<$19.LogBucket> updateBucket_Pre($grpc.ServiceCall call,
      $async.Future<$19.UpdateBucketRequest> request) async {
    return updateBucket(call, await request);
  }

  $async.Future<$1.Empty> deleteBucket_Pre($grpc.ServiceCall call,
      $async.Future<$19.DeleteBucketRequest> request) async {
    return deleteBucket(call, await request);
  }

  $async.Future<$1.Empty> undeleteBucket_Pre($grpc.ServiceCall call,
      $async.Future<$19.UndeleteBucketRequest> request) async {
    return undeleteBucket(call, await request);
  }

  $async.Future<$19.ListViewsResponse> listViews_Pre($grpc.ServiceCall call,
      $async.Future<$19.ListViewsRequest> request) async {
    return listViews(call, await request);
  }

  $async.Future<$19.LogView> getView_Pre(
      $grpc.ServiceCall call, $async.Future<$19.GetViewRequest> request) async {
    return getView(call, await request);
  }

  $async.Future<$19.LogView> createView_Pre($grpc.ServiceCall call,
      $async.Future<$19.CreateViewRequest> request) async {
    return createView(call, await request);
  }

  $async.Future<$19.LogView> updateView_Pre($grpc.ServiceCall call,
      $async.Future<$19.UpdateViewRequest> request) async {
    return updateView(call, await request);
  }

  $async.Future<$1.Empty> deleteView_Pre($grpc.ServiceCall call,
      $async.Future<$19.DeleteViewRequest> request) async {
    return deleteView(call, await request);
  }

  $async.Future<$19.ListSinksResponse> listSinks_Pre($grpc.ServiceCall call,
      $async.Future<$19.ListSinksRequest> request) async {
    return listSinks(call, await request);
  }

  $async.Future<$19.LogSink> getSink_Pre(
      $grpc.ServiceCall call, $async.Future<$19.GetSinkRequest> request) async {
    return getSink(call, await request);
  }

  $async.Future<$19.LogSink> createSink_Pre($grpc.ServiceCall call,
      $async.Future<$19.CreateSinkRequest> request) async {
    return createSink(call, await request);
  }

  $async.Future<$19.LogSink> updateSink_Pre($grpc.ServiceCall call,
      $async.Future<$19.UpdateSinkRequest> request) async {
    return updateSink(call, await request);
  }

  $async.Future<$1.Empty> deleteSink_Pre($grpc.ServiceCall call,
      $async.Future<$19.DeleteSinkRequest> request) async {
    return deleteSink(call, await request);
  }

  $async.Future<$0.Operation> createLink_Pre($grpc.ServiceCall call,
      $async.Future<$19.CreateLinkRequest> request) async {
    return createLink(call, await request);
  }

  $async.Future<$0.Operation> deleteLink_Pre($grpc.ServiceCall call,
      $async.Future<$19.DeleteLinkRequest> request) async {
    return deleteLink(call, await request);
  }

  $async.Future<$19.ListLinksResponse> listLinks_Pre($grpc.ServiceCall call,
      $async.Future<$19.ListLinksRequest> request) async {
    return listLinks(call, await request);
  }

  $async.Future<$19.Link> getLink_Pre(
      $grpc.ServiceCall call, $async.Future<$19.GetLinkRequest> request) async {
    return getLink(call, await request);
  }

  $async.Future<$19.ListExclusionsResponse> listExclusions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.ListExclusionsRequest> request) async {
    return listExclusions(call, await request);
  }

  $async.Future<$19.LogExclusion> getExclusion_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetExclusionRequest> request) async {
    return getExclusion(call, await request);
  }

  $async.Future<$19.LogExclusion> createExclusion_Pre($grpc.ServiceCall call,
      $async.Future<$19.CreateExclusionRequest> request) async {
    return createExclusion(call, await request);
  }

  $async.Future<$19.LogExclusion> updateExclusion_Pre($grpc.ServiceCall call,
      $async.Future<$19.UpdateExclusionRequest> request) async {
    return updateExclusion(call, await request);
  }

  $async.Future<$1.Empty> deleteExclusion_Pre($grpc.ServiceCall call,
      $async.Future<$19.DeleteExclusionRequest> request) async {
    return deleteExclusion(call, await request);
  }

  $async.Future<$19.CmekSettings> getCmekSettings_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetCmekSettingsRequest> request) async {
    return getCmekSettings(call, await request);
  }

  $async.Future<$19.CmekSettings> updateCmekSettings_Pre($grpc.ServiceCall call,
      $async.Future<$19.UpdateCmekSettingsRequest> request) async {
    return updateCmekSettings(call, await request);
  }

  $async.Future<$19.Settings> getSettings_Pre($grpc.ServiceCall call,
      $async.Future<$19.GetSettingsRequest> request) async {
    return getSettings(call, await request);
  }

  $async.Future<$19.Settings> updateSettings_Pre($grpc.ServiceCall call,
      $async.Future<$19.UpdateSettingsRequest> request) async {
    return updateSettings(call, await request);
  }

  $async.Future<$0.Operation> copyLogEntries_Pre($grpc.ServiceCall call,
      $async.Future<$19.CopyLogEntriesRequest> request) async {
    return copyLogEntries(call, await request);
  }

  $async.Future<$19.ListBucketsResponse> listBuckets(
      $grpc.ServiceCall call, $19.ListBucketsRequest request);
  $async.Future<$19.LogBucket> getBucket(
      $grpc.ServiceCall call, $19.GetBucketRequest request);
  $async.Future<$0.Operation> createBucketAsync(
      $grpc.ServiceCall call, $19.CreateBucketRequest request);
  $async.Future<$0.Operation> updateBucketAsync(
      $grpc.ServiceCall call, $19.UpdateBucketRequest request);
  $async.Future<$19.LogBucket> createBucket(
      $grpc.ServiceCall call, $19.CreateBucketRequest request);
  $async.Future<$19.LogBucket> updateBucket(
      $grpc.ServiceCall call, $19.UpdateBucketRequest request);
  $async.Future<$1.Empty> deleteBucket(
      $grpc.ServiceCall call, $19.DeleteBucketRequest request);
  $async.Future<$1.Empty> undeleteBucket(
      $grpc.ServiceCall call, $19.UndeleteBucketRequest request);
  $async.Future<$19.ListViewsResponse> listViews(
      $grpc.ServiceCall call, $19.ListViewsRequest request);
  $async.Future<$19.LogView> getView(
      $grpc.ServiceCall call, $19.GetViewRequest request);
  $async.Future<$19.LogView> createView(
      $grpc.ServiceCall call, $19.CreateViewRequest request);
  $async.Future<$19.LogView> updateView(
      $grpc.ServiceCall call, $19.UpdateViewRequest request);
  $async.Future<$1.Empty> deleteView(
      $grpc.ServiceCall call, $19.DeleteViewRequest request);
  $async.Future<$19.ListSinksResponse> listSinks(
      $grpc.ServiceCall call, $19.ListSinksRequest request);
  $async.Future<$19.LogSink> getSink(
      $grpc.ServiceCall call, $19.GetSinkRequest request);
  $async.Future<$19.LogSink> createSink(
      $grpc.ServiceCall call, $19.CreateSinkRequest request);
  $async.Future<$19.LogSink> updateSink(
      $grpc.ServiceCall call, $19.UpdateSinkRequest request);
  $async.Future<$1.Empty> deleteSink(
      $grpc.ServiceCall call, $19.DeleteSinkRequest request);
  $async.Future<$0.Operation> createLink(
      $grpc.ServiceCall call, $19.CreateLinkRequest request);
  $async.Future<$0.Operation> deleteLink(
      $grpc.ServiceCall call, $19.DeleteLinkRequest request);
  $async.Future<$19.ListLinksResponse> listLinks(
      $grpc.ServiceCall call, $19.ListLinksRequest request);
  $async.Future<$19.Link> getLink(
      $grpc.ServiceCall call, $19.GetLinkRequest request);
  $async.Future<$19.ListExclusionsResponse> listExclusions(
      $grpc.ServiceCall call, $19.ListExclusionsRequest request);
  $async.Future<$19.LogExclusion> getExclusion(
      $grpc.ServiceCall call, $19.GetExclusionRequest request);
  $async.Future<$19.LogExclusion> createExclusion(
      $grpc.ServiceCall call, $19.CreateExclusionRequest request);
  $async.Future<$19.LogExclusion> updateExclusion(
      $grpc.ServiceCall call, $19.UpdateExclusionRequest request);
  $async.Future<$1.Empty> deleteExclusion(
      $grpc.ServiceCall call, $19.DeleteExclusionRequest request);
  $async.Future<$19.CmekSettings> getCmekSettings(
      $grpc.ServiceCall call, $19.GetCmekSettingsRequest request);
  $async.Future<$19.CmekSettings> updateCmekSettings(
      $grpc.ServiceCall call, $19.UpdateCmekSettingsRequest request);
  $async.Future<$19.Settings> getSettings(
      $grpc.ServiceCall call, $19.GetSettingsRequest request);
  $async.Future<$19.Settings> updateSettings(
      $grpc.ServiceCall call, $19.UpdateSettingsRequest request);
  $async.Future<$0.Operation> copyLogEntries(
      $grpc.ServiceCall call, $19.CopyLogEntriesRequest request);
}
