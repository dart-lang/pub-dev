//
//  Generated code. Do not modify.
//  source: google/appengine/v1/instance.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/timestamp.pb.dart' as $50;
import 'instance.pbenum.dart';

export 'instance.pbenum.dart';

/// Wrapper for LivenessState enum.
class Instance_Liveness extends $pb.GeneratedMessage {
  factory Instance_Liveness() => create();
  Instance_Liveness._() : super();
  factory Instance_Liveness.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Instance_Liveness.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Instance.Liveness',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.appengine.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Instance_Liveness clone() => Instance_Liveness()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Instance_Liveness copyWith(void Function(Instance_Liveness) updates) =>
      super.copyWith((message) => updates(message as Instance_Liveness))
          as Instance_Liveness;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Instance_Liveness create() => Instance_Liveness._();
  Instance_Liveness createEmptyInstance() => create();
  static $pb.PbList<Instance_Liveness> createRepeated() =>
      $pb.PbList<Instance_Liveness>();
  @$core.pragma('dart2js:noInline')
  static Instance_Liveness getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Instance_Liveness>(create);
  static Instance_Liveness? _defaultInstance;
}

/// An Instance resource is the computing unit that App Engine uses to
/// automatically scale an application.
class Instance extends $pb.GeneratedMessage {
  factory Instance({
    $core.String? name,
    $core.String? id,
    $core.String? appEngineRelease,
    Instance_Availability? availability,
    $core.String? vmName,
    $core.String? vmZoneName,
    $core.String? vmId,
    $50.Timestamp? startTime,
    $core.int? requests,
    $core.int? errors,
    $core.double? qps,
    $core.int? averageLatency,
    $fixnum.Int64? memoryUsage,
    $core.String? vmStatus,
    $core.bool? vmDebugEnabled,
    $core.String? vmIp,
    Instance_Liveness_LivenessState? vmLiveness,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (id != null) {
      $result.id = id;
    }
    if (appEngineRelease != null) {
      $result.appEngineRelease = appEngineRelease;
    }
    if (availability != null) {
      $result.availability = availability;
    }
    if (vmName != null) {
      $result.vmName = vmName;
    }
    if (vmZoneName != null) {
      $result.vmZoneName = vmZoneName;
    }
    if (vmId != null) {
      $result.vmId = vmId;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (requests != null) {
      $result.requests = requests;
    }
    if (errors != null) {
      $result.errors = errors;
    }
    if (qps != null) {
      $result.qps = qps;
    }
    if (averageLatency != null) {
      $result.averageLatency = averageLatency;
    }
    if (memoryUsage != null) {
      $result.memoryUsage = memoryUsage;
    }
    if (vmStatus != null) {
      $result.vmStatus = vmStatus;
    }
    if (vmDebugEnabled != null) {
      $result.vmDebugEnabled = vmDebugEnabled;
    }
    if (vmIp != null) {
      $result.vmIp = vmIp;
    }
    if (vmLiveness != null) {
      $result.vmLiveness = vmLiveness;
    }
    return $result;
  }
  Instance._() : super();
  factory Instance.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Instance.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Instance',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.appengine.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOS(3, _omitFieldNames ? '' : 'appEngineRelease')
    ..e<Instance_Availability>(
        4, _omitFieldNames ? '' : 'availability', $pb.PbFieldType.OE,
        defaultOrMaker: Instance_Availability.UNSPECIFIED,
        valueOf: Instance_Availability.valueOf,
        enumValues: Instance_Availability.values)
    ..aOS(5, _omitFieldNames ? '' : 'vmName')
    ..aOS(6, _omitFieldNames ? '' : 'vmZoneName')
    ..aOS(7, _omitFieldNames ? '' : 'vmId')
    ..aOM<$50.Timestamp>(8, _omitFieldNames ? '' : 'startTime',
        subBuilder: $50.Timestamp.create)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'requests', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'errors', $pb.PbFieldType.O3)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'qps', $pb.PbFieldType.OF)
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'averageLatency', $pb.PbFieldType.O3)
    ..aInt64(13, _omitFieldNames ? '' : 'memoryUsage')
    ..aOS(14, _omitFieldNames ? '' : 'vmStatus')
    ..aOB(15, _omitFieldNames ? '' : 'vmDebugEnabled')
    ..aOS(16, _omitFieldNames ? '' : 'vmIp')
    ..e<Instance_Liveness_LivenessState>(
        17, _omitFieldNames ? '' : 'vmLiveness', $pb.PbFieldType.OE,
        defaultOrMaker:
            Instance_Liveness_LivenessState.LIVENESS_STATE_UNSPECIFIED,
        valueOf: Instance_Liveness_LivenessState.valueOf,
        enumValues: Instance_Liveness_LivenessState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Instance clone() => Instance()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Instance copyWith(void Function(Instance) updates) =>
      super.copyWith((message) => updates(message as Instance)) as Instance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Instance create() => Instance._();
  Instance createEmptyInstance() => create();
  static $pb.PbList<Instance> createRepeated() => $pb.PbList<Instance>();
  @$core.pragma('dart2js:noInline')
  static Instance getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Instance>(create);
  static Instance? _defaultInstance;

  /// Output only. Full path to the Instance resource in the API.
  /// Example: `apps/myapp/services/default/versions/v1/instances/instance-1`.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// Output only. Relative name of the instance within the version.
  /// Example: `instance-1`.
  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  /// Output only. App Engine release this instance is running on.
  @$pb.TagNumber(3)
  $core.String get appEngineRelease => $_getSZ(2);
  @$pb.TagNumber(3)
  set appEngineRelease($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAppEngineRelease() => $_has(2);
  @$pb.TagNumber(3)
  void clearAppEngineRelease() => clearField(3);

  /// Output only. Availability of the instance.
  @$pb.TagNumber(4)
  Instance_Availability get availability => $_getN(3);
  @$pb.TagNumber(4)
  set availability(Instance_Availability v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAvailability() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailability() => clearField(4);

  /// Output only. Name of the virtual machine where this instance lives. Only applicable
  /// for instances in App Engine flexible environment.
  @$pb.TagNumber(5)
  $core.String get vmName => $_getSZ(4);
  @$pb.TagNumber(5)
  set vmName($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasVmName() => $_has(4);
  @$pb.TagNumber(5)
  void clearVmName() => clearField(5);

  /// Output only. Zone where the virtual machine is located. Only applicable for instances
  /// in App Engine flexible environment.
  @$pb.TagNumber(6)
  $core.String get vmZoneName => $_getSZ(5);
  @$pb.TagNumber(6)
  set vmZoneName($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasVmZoneName() => $_has(5);
  @$pb.TagNumber(6)
  void clearVmZoneName() => clearField(6);

  /// Output only. Virtual machine ID of this instance. Only applicable for instances in
  /// App Engine flexible environment.
  @$pb.TagNumber(7)
  $core.String get vmId => $_getSZ(6);
  @$pb.TagNumber(7)
  set vmId($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasVmId() => $_has(6);
  @$pb.TagNumber(7)
  void clearVmId() => clearField(7);

  ///  Output only. Time that this instance was started.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(8)
  $50.Timestamp get startTime => $_getN(7);
  @$pb.TagNumber(8)
  set startTime($50.Timestamp v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasStartTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearStartTime() => clearField(8);
  @$pb.TagNumber(8)
  $50.Timestamp ensureStartTime() => $_ensure(7);

  /// Output only. Number of requests since this instance was started.
  @$pb.TagNumber(9)
  $core.int get requests => $_getIZ(8);
  @$pb.TagNumber(9)
  set requests($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasRequests() => $_has(8);
  @$pb.TagNumber(9)
  void clearRequests() => clearField(9);

  /// Output only. Number of errors since this instance was started.
  @$pb.TagNumber(10)
  $core.int get errors => $_getIZ(9);
  @$pb.TagNumber(10)
  set errors($core.int v) {
    $_setSignedInt32(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasErrors() => $_has(9);
  @$pb.TagNumber(10)
  void clearErrors() => clearField(10);

  /// Output only. Average queries per second (QPS) over the last minute.
  @$pb.TagNumber(11)
  $core.double get qps => $_getN(10);
  @$pb.TagNumber(11)
  set qps($core.double v) {
    $_setFloat(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasQps() => $_has(10);
  @$pb.TagNumber(11)
  void clearQps() => clearField(11);

  /// Output only. Average latency (ms) over the last minute.
  @$pb.TagNumber(12)
  $core.int get averageLatency => $_getIZ(11);
  @$pb.TagNumber(12)
  set averageLatency($core.int v) {
    $_setSignedInt32(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasAverageLatency() => $_has(11);
  @$pb.TagNumber(12)
  void clearAverageLatency() => clearField(12);

  /// Output only. Total memory in use (bytes).
  @$pb.TagNumber(13)
  $fixnum.Int64 get memoryUsage => $_getI64(12);
  @$pb.TagNumber(13)
  set memoryUsage($fixnum.Int64 v) {
    $_setInt64(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasMemoryUsage() => $_has(12);
  @$pb.TagNumber(13)
  void clearMemoryUsage() => clearField(13);

  /// Output only. Status of the virtual machine where this instance lives. Only applicable
  /// for instances in App Engine flexible environment.
  @$pb.TagNumber(14)
  $core.String get vmStatus => $_getSZ(13);
  @$pb.TagNumber(14)
  set vmStatus($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasVmStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearVmStatus() => clearField(14);

  /// Output only. Whether this instance is in debug mode. Only applicable for instances in
  /// App Engine flexible environment.
  @$pb.TagNumber(15)
  $core.bool get vmDebugEnabled => $_getBF(14);
  @$pb.TagNumber(15)
  set vmDebugEnabled($core.bool v) {
    $_setBool(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasVmDebugEnabled() => $_has(14);
  @$pb.TagNumber(15)
  void clearVmDebugEnabled() => clearField(15);

  /// Output only. The IP address of this instance. Only applicable for instances in App
  /// Engine flexible environment.
  @$pb.TagNumber(16)
  $core.String get vmIp => $_getSZ(15);
  @$pb.TagNumber(16)
  set vmIp($core.String v) {
    $_setString(15, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasVmIp() => $_has(15);
  @$pb.TagNumber(16)
  void clearVmIp() => clearField(16);

  /// Output only. The liveness health check of this instance. Only applicable for instances
  /// in App Engine flexible environment.
  @$pb.TagNumber(17)
  Instance_Liveness_LivenessState get vmLiveness => $_getN(16);
  @$pb.TagNumber(17)
  set vmLiveness(Instance_Liveness_LivenessState v) {
    setField(17, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasVmLiveness() => $_has(16);
  @$pb.TagNumber(17)
  void clearVmLiveness() => clearField(17);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
