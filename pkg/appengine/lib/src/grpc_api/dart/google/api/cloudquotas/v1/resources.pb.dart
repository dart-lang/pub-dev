//
//  Generated code. Do not modify.
//  source: google/api/cloudquotas/v1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/timestamp.pb.dart' as $50;
import '../../../protobuf/wrappers.pb.dart' as $73;
import 'resources.pbenum.dart';

export 'resources.pbenum.dart';

/// QuotaInfo represents information about a particular quota for a given
/// project, folder or organization.
class QuotaInfo extends $pb.GeneratedMessage {
  factory QuotaInfo({
    $core.String? name,
    $core.String? quotaId,
    $core.String? metric,
    $core.String? service,
    $core.bool? isPrecise,
    $core.String? refreshInterval,
    QuotaInfo_ContainerType? containerType,
    $core.Iterable<$core.String>? dimensions,
    $core.String? metricDisplayName,
    $core.String? quotaDisplayName,
    $core.String? metricUnit,
    QuotaIncreaseEligibility? quotaIncreaseEligibility,
    $core.bool? isFixed,
    $core.Iterable<DimensionsInfo>? dimensionsInfos,
    $core.bool? isConcurrent,
    $core.String? serviceRequestQuotaUri,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (quotaId != null) {
      $result.quotaId = quotaId;
    }
    if (metric != null) {
      $result.metric = metric;
    }
    if (service != null) {
      $result.service = service;
    }
    if (isPrecise != null) {
      $result.isPrecise = isPrecise;
    }
    if (refreshInterval != null) {
      $result.refreshInterval = refreshInterval;
    }
    if (containerType != null) {
      $result.containerType = containerType;
    }
    if (dimensions != null) {
      $result.dimensions.addAll(dimensions);
    }
    if (metricDisplayName != null) {
      $result.metricDisplayName = metricDisplayName;
    }
    if (quotaDisplayName != null) {
      $result.quotaDisplayName = quotaDisplayName;
    }
    if (metricUnit != null) {
      $result.metricUnit = metricUnit;
    }
    if (quotaIncreaseEligibility != null) {
      $result.quotaIncreaseEligibility = quotaIncreaseEligibility;
    }
    if (isFixed != null) {
      $result.isFixed = isFixed;
    }
    if (dimensionsInfos != null) {
      $result.dimensionsInfos.addAll(dimensionsInfos);
    }
    if (isConcurrent != null) {
      $result.isConcurrent = isConcurrent;
    }
    if (serviceRequestQuotaUri != null) {
      $result.serviceRequestQuotaUri = serviceRequestQuotaUri;
    }
    return $result;
  }
  QuotaInfo._() : super();
  factory QuotaInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'quotaId')
    ..aOS(3, _omitFieldNames ? '' : 'metric')
    ..aOS(4, _omitFieldNames ? '' : 'service')
    ..aOB(5, _omitFieldNames ? '' : 'isPrecise')
    ..aOS(6, _omitFieldNames ? '' : 'refreshInterval')
    ..e<QuotaInfo_ContainerType>(
        7, _omitFieldNames ? '' : 'containerType', $pb.PbFieldType.OE,
        defaultOrMaker: QuotaInfo_ContainerType.CONTAINER_TYPE_UNSPECIFIED,
        valueOf: QuotaInfo_ContainerType.valueOf,
        enumValues: QuotaInfo_ContainerType.values)
    ..pPS(8, _omitFieldNames ? '' : 'dimensions')
    ..aOS(9, _omitFieldNames ? '' : 'metricDisplayName')
    ..aOS(10, _omitFieldNames ? '' : 'quotaDisplayName')
    ..aOS(11, _omitFieldNames ? '' : 'metricUnit')
    ..aOM<QuotaIncreaseEligibility>(
        12, _omitFieldNames ? '' : 'quotaIncreaseEligibility',
        subBuilder: QuotaIncreaseEligibility.create)
    ..aOB(13, _omitFieldNames ? '' : 'isFixed')
    ..pc<DimensionsInfo>(
        14, _omitFieldNames ? '' : 'dimensionsInfos', $pb.PbFieldType.PM,
        subBuilder: DimensionsInfo.create)
    ..aOB(15, _omitFieldNames ? '' : 'isConcurrent')
    ..aOS(17, _omitFieldNames ? '' : 'serviceRequestQuotaUri')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaInfo clone() => QuotaInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaInfo copyWith(void Function(QuotaInfo) updates) =>
      super.copyWith((message) => updates(message as QuotaInfo)) as QuotaInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaInfo create() => QuotaInfo._();
  QuotaInfo createEmptyInstance() => create();
  static $pb.PbList<QuotaInfo> createRepeated() => $pb.PbList<QuotaInfo>();
  @$core.pragma('dart2js:noInline')
  static QuotaInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuotaInfo>(create);
  static QuotaInfo? _defaultInstance;

  /// Resource name of this QuotaInfo.
  /// The ID component following "locations/" must be "global".
  /// Example:
  /// `projects/123/locations/global/services/compute.googleapis.com/quotaInfos/CpusPerProjectPerRegion`
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

  /// The id of the quota, which is unquie within the service.
  /// Example: `CpusPerProjectPerRegion`
  @$pb.TagNumber(2)
  $core.String get quotaId => $_getSZ(1);
  @$pb.TagNumber(2)
  set quotaId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuotaId() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuotaId() => clearField(2);

  /// The metric of the quota. It specifies the resources consumption the quota
  /// is defined for.
  /// Example: `compute.googleapis.com/cpus`
  @$pb.TagNumber(3)
  $core.String get metric => $_getSZ(2);
  @$pb.TagNumber(3)
  set metric($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMetric() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetric() => clearField(3);

  /// The name of the service in which the quota is defined.
  /// Example: `compute.googleapis.com`
  @$pb.TagNumber(4)
  $core.String get service => $_getSZ(3);
  @$pb.TagNumber(4)
  set service($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasService() => $_has(3);
  @$pb.TagNumber(4)
  void clearService() => clearField(4);

  /// Whether this is a precise quota. A precise quota is tracked with absolute
  /// precision. In contrast, an imprecise quota is not tracked with precision.
  @$pb.TagNumber(5)
  $core.bool get isPrecise => $_getBF(4);
  @$pb.TagNumber(5)
  set isPrecise($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasIsPrecise() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPrecise() => clearField(5);

  /// The reset time interval for the quota. Refresh interval applies to rate
  /// quota only.
  /// Example: "minute" for per minute, "day" for per day, or "10 seconds" for
  /// every 10 seconds.
  @$pb.TagNumber(6)
  $core.String get refreshInterval => $_getSZ(5);
  @$pb.TagNumber(6)
  set refreshInterval($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasRefreshInterval() => $_has(5);
  @$pb.TagNumber(6)
  void clearRefreshInterval() => clearField(6);

  /// The container type of the QuotaInfo.
  @$pb.TagNumber(7)
  QuotaInfo_ContainerType get containerType => $_getN(6);
  @$pb.TagNumber(7)
  set containerType(QuotaInfo_ContainerType v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasContainerType() => $_has(6);
  @$pb.TagNumber(7)
  void clearContainerType() => clearField(7);

  /// The dimensions the quota is defined on.
  @$pb.TagNumber(8)
  $core.List<$core.String> get dimensions => $_getList(7);

  /// The display name of the quota metric
  @$pb.TagNumber(9)
  $core.String get metricDisplayName => $_getSZ(8);
  @$pb.TagNumber(9)
  set metricDisplayName($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasMetricDisplayName() => $_has(8);
  @$pb.TagNumber(9)
  void clearMetricDisplayName() => clearField(9);

  /// The display name of the quota.
  @$pb.TagNumber(10)
  $core.String get quotaDisplayName => $_getSZ(9);
  @$pb.TagNumber(10)
  set quotaDisplayName($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasQuotaDisplayName() => $_has(9);
  @$pb.TagNumber(10)
  void clearQuotaDisplayName() => clearField(10);

  /// The unit in which the metric value is reported, e.g., "MByte".
  @$pb.TagNumber(11)
  $core.String get metricUnit => $_getSZ(10);
  @$pb.TagNumber(11)
  set metricUnit($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasMetricUnit() => $_has(10);
  @$pb.TagNumber(11)
  void clearMetricUnit() => clearField(11);

  /// Whether it is eligible to request a higher quota value for this quota.
  @$pb.TagNumber(12)
  QuotaIncreaseEligibility get quotaIncreaseEligibility => $_getN(11);
  @$pb.TagNumber(12)
  set quotaIncreaseEligibility(QuotaIncreaseEligibility v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasQuotaIncreaseEligibility() => $_has(11);
  @$pb.TagNumber(12)
  void clearQuotaIncreaseEligibility() => clearField(12);
  @$pb.TagNumber(12)
  QuotaIncreaseEligibility ensureQuotaIncreaseEligibility() => $_ensure(11);

  /// Whether the quota value is fixed or adjustable
  @$pb.TagNumber(13)
  $core.bool get isFixed => $_getBF(12);
  @$pb.TagNumber(13)
  set isFixed($core.bool v) {
    $_setBool(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasIsFixed() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsFixed() => clearField(13);

  /// The collection of dimensions info ordered by their dimensions from more
  /// specific ones to less specific ones.
  @$pb.TagNumber(14)
  $core.List<DimensionsInfo> get dimensionsInfos => $_getList(13);

  /// Whether the quota is a concurrent quota. Concurrent quotas are enforced
  /// on the total number of concurrent operations in flight at any given time.
  @$pb.TagNumber(15)
  $core.bool get isConcurrent => $_getBF(14);
  @$pb.TagNumber(15)
  set isConcurrent($core.bool v) {
    $_setBool(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasIsConcurrent() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsConcurrent() => clearField(15);

  /// URI to the page where users can request more quota for the cloud
  /// service—for example,
  /// https://console.cloud.google.com/iam-admin/quotas.
  @$pb.TagNumber(17)
  $core.String get serviceRequestQuotaUri => $_getSZ(15);
  @$pb.TagNumber(17)
  set serviceRequestQuotaUri($core.String v) {
    $_setString(15, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasServiceRequestQuotaUri() => $_has(15);
  @$pb.TagNumber(17)
  void clearServiceRequestQuotaUri() => clearField(17);
}

/// Eligibility information regarding requesting increase adjustment of a quota.
class QuotaIncreaseEligibility extends $pb.GeneratedMessage {
  factory QuotaIncreaseEligibility({
    $core.bool? isEligible,
    QuotaIncreaseEligibility_IneligibilityReason? ineligibilityReason,
  }) {
    final $result = create();
    if (isEligible != null) {
      $result.isEligible = isEligible;
    }
    if (ineligibilityReason != null) {
      $result.ineligibilityReason = ineligibilityReason;
    }
    return $result;
  }
  QuotaIncreaseEligibility._() : super();
  factory QuotaIncreaseEligibility.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaIncreaseEligibility.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaIncreaseEligibility',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isEligible')
    ..e<QuotaIncreaseEligibility_IneligibilityReason>(
        2, _omitFieldNames ? '' : 'ineligibilityReason', $pb.PbFieldType.OE,
        defaultOrMaker: QuotaIncreaseEligibility_IneligibilityReason
            .INELIGIBILITY_REASON_UNSPECIFIED,
        valueOf: QuotaIncreaseEligibility_IneligibilityReason.valueOf,
        enumValues: QuotaIncreaseEligibility_IneligibilityReason.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaIncreaseEligibility clone() =>
      QuotaIncreaseEligibility()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaIncreaseEligibility copyWith(
          void Function(QuotaIncreaseEligibility) updates) =>
      super.copyWith((message) => updates(message as QuotaIncreaseEligibility))
          as QuotaIncreaseEligibility;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaIncreaseEligibility create() => QuotaIncreaseEligibility._();
  QuotaIncreaseEligibility createEmptyInstance() => create();
  static $pb.PbList<QuotaIncreaseEligibility> createRepeated() =>
      $pb.PbList<QuotaIncreaseEligibility>();
  @$core.pragma('dart2js:noInline')
  static QuotaIncreaseEligibility getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaIncreaseEligibility>(create);
  static QuotaIncreaseEligibility? _defaultInstance;

  /// Whether a higher quota value can be requested for the quota.
  @$pb.TagNumber(1)
  $core.bool get isEligible => $_getBF(0);
  @$pb.TagNumber(1)
  set isEligible($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIsEligible() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsEligible() => clearField(1);

  /// The reason of why it is ineligible to request increased value of the quota.
  /// If the is_eligible field is true, it defaults to
  /// INELIGIBILITY_REASON_UNSPECIFIED.
  @$pb.TagNumber(2)
  QuotaIncreaseEligibility_IneligibilityReason get ineligibilityReason =>
      $_getN(1);
  @$pb.TagNumber(2)
  set ineligibilityReason(QuotaIncreaseEligibility_IneligibilityReason v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIneligibilityReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearIneligibilityReason() => clearField(2);
}

/// QuotaPreference represents the preferred quota configuration specified for
/// a project, folder or organization. There is only one QuotaPreference
/// resource for a quota value targeting a unique set of dimensions.
class QuotaPreference extends $pb.GeneratedMessage {
  factory QuotaPreference({
    $core.String? name,
    $core.Map<$core.String, $core.String>? dimensions,
    QuotaConfig? quotaConfig,
    $core.String? etag,
    $50.Timestamp? createTime,
    $50.Timestamp? updateTime,
    $core.String? service,
    $core.String? quotaId,
    $core.bool? reconciling,
    $core.String? justification,
    $core.String? contactEmail,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (dimensions != null) {
      $result.dimensions.addAll(dimensions);
    }
    if (quotaConfig != null) {
      $result.quotaConfig = quotaConfig;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (service != null) {
      $result.service = service;
    }
    if (quotaId != null) {
      $result.quotaId = quotaId;
    }
    if (reconciling != null) {
      $result.reconciling = reconciling;
    }
    if (justification != null) {
      $result.justification = justification;
    }
    if (contactEmail != null) {
      $result.contactEmail = contactEmail;
    }
    return $result;
  }
  QuotaPreference._() : super();
  factory QuotaPreference.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaPreference.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaPreference',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'dimensions',
        entryClassName: 'QuotaPreference.DimensionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.cloudquotas.v1'))
    ..aOM<QuotaConfig>(3, _omitFieldNames ? '' : 'quotaConfig',
        subBuilder: QuotaConfig.create)
    ..aOS(4, _omitFieldNames ? '' : 'etag')
    ..aOM<$50.Timestamp>(5, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(6, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $50.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'service')
    ..aOS(8, _omitFieldNames ? '' : 'quotaId')
    ..aOB(10, _omitFieldNames ? '' : 'reconciling')
    ..aOS(11, _omitFieldNames ? '' : 'justification')
    ..aOS(12, _omitFieldNames ? '' : 'contactEmail')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaPreference clone() => QuotaPreference()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaPreference copyWith(void Function(QuotaPreference) updates) =>
      super.copyWith((message) => updates(message as QuotaPreference))
          as QuotaPreference;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaPreference create() => QuotaPreference._();
  QuotaPreference createEmptyInstance() => create();
  static $pb.PbList<QuotaPreference> createRepeated() =>
      $pb.PbList<QuotaPreference>();
  @$core.pragma('dart2js:noInline')
  static QuotaPreference getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaPreference>(create);
  static QuotaPreference? _defaultInstance;

  /// Required except in the CREATE requests.
  /// The resource name of the quota preference.
  /// The ID component following "locations/" must be "global".
  /// Example:
  /// `projects/123/locations/global/quotaPreferences/my-config-for-us-east1`
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

  ///  Immutable. The dimensions that this quota preference applies to. The key of
  ///  the map entry is the name of a dimension, such as "region", "zone",
  ///  "network_id", and the value of the map entry is the dimension value.
  ///
  ///  If a dimension is missing from the map of dimensions, the quota preference
  ///  applies to all the dimension values except for those that have other quota
  ///  preferences configured for the specific value.
  ///
  ///  NOTE: QuotaPreferences can only be applied across all values of "user" and
  ///  "resource" dimension. Do not set values for "user" or "resource" in the
  ///  dimension map.
  ///
  ///  Example: {"provider", "Foo Inc"} where "provider" is a service specific
  ///  dimension.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get dimensions => $_getMap(1);

  /// Required. Preferred quota configuration.
  @$pb.TagNumber(3)
  QuotaConfig get quotaConfig => $_getN(2);
  @$pb.TagNumber(3)
  set quotaConfig(QuotaConfig v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasQuotaConfig() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuotaConfig() => clearField(3);
  @$pb.TagNumber(3)
  QuotaConfig ensureQuotaConfig() => $_ensure(2);

  /// Optional. The current etag of the quota preference. If an etag is provided
  /// on update and does not match the current server's etag of the quota
  /// preference, the request will be blocked and an ABORTED error will be
  /// returned. See https://google.aip.dev/134#etags for more details on etags.
  @$pb.TagNumber(4)
  $core.String get etag => $_getSZ(3);
  @$pb.TagNumber(4)
  set etag($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEtag() => $_has(3);
  @$pb.TagNumber(4)
  void clearEtag() => clearField(4);

  /// Output only. Create time stamp
  @$pb.TagNumber(5)
  $50.Timestamp get createTime => $_getN(4);
  @$pb.TagNumber(5)
  set createTime($50.Timestamp v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCreateTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreateTime() => clearField(5);
  @$pb.TagNumber(5)
  $50.Timestamp ensureCreateTime() => $_ensure(4);

  /// Output only. Update time stamp
  @$pb.TagNumber(6)
  $50.Timestamp get updateTime => $_getN(5);
  @$pb.TagNumber(6)
  set updateTime($50.Timestamp v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUpdateTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdateTime() => clearField(6);
  @$pb.TagNumber(6)
  $50.Timestamp ensureUpdateTime() => $_ensure(5);

  /// Required. The name of the service to which the quota preference is applied.
  @$pb.TagNumber(7)
  $core.String get service => $_getSZ(6);
  @$pb.TagNumber(7)
  set service($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasService() => $_has(6);
  @$pb.TagNumber(7)
  void clearService() => clearField(7);

  /// Required. The id of the quota to which the quota preference is applied. A
  /// quota name is unique in the service. Example: `CpusPerProjectPerRegion`
  @$pb.TagNumber(8)
  $core.String get quotaId => $_getSZ(7);
  @$pb.TagNumber(8)
  set quotaId($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasQuotaId() => $_has(7);
  @$pb.TagNumber(8)
  void clearQuotaId() => clearField(8);

  /// Output only. Is the quota preference pending Google Cloud approval and
  /// fulfillment.
  @$pb.TagNumber(10)
  $core.bool get reconciling => $_getBF(8);
  @$pb.TagNumber(10)
  set reconciling($core.bool v) {
    $_setBool(8, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasReconciling() => $_has(8);
  @$pb.TagNumber(10)
  void clearReconciling() => clearField(10);

  /// The reason / justification for this quota preference.
  @$pb.TagNumber(11)
  $core.String get justification => $_getSZ(9);
  @$pb.TagNumber(11)
  set justification($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasJustification() => $_has(9);
  @$pb.TagNumber(11)
  void clearJustification() => clearField(11);

  ///  Input only. An email address that can be used to contact the the user, in
  ///  case Google Cloud needs more information to make a decision before
  ///  additional quota can be granted.
  ///
  ///  When requesting a quota increase, the email address is required.
  ///  When requesting a quota decrease, the email address is optional.
  ///  For example, the email address is optional when the
  ///  `QuotaConfig.preferred_value` is smaller than the
  ///  `QuotaDetails.reset_value`.
  @$pb.TagNumber(12)
  $core.String get contactEmail => $_getSZ(10);
  @$pb.TagNumber(12)
  set contactEmail($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasContactEmail() => $_has(10);
  @$pb.TagNumber(12)
  void clearContactEmail() => clearField(12);
}

/// The preferred quota configuration.
class QuotaConfig extends $pb.GeneratedMessage {
  factory QuotaConfig({
    $fixnum.Int64? preferredValue,
    $core.String? stateDetail,
    $73.Int64Value? grantedValue,
    $core.String? traceId,
    $core.Map<$core.String, $core.String>? annotations,
    QuotaConfig_Origin? requestOrigin,
  }) {
    final $result = create();
    if (preferredValue != null) {
      $result.preferredValue = preferredValue;
    }
    if (stateDetail != null) {
      $result.stateDetail = stateDetail;
    }
    if (grantedValue != null) {
      $result.grantedValue = grantedValue;
    }
    if (traceId != null) {
      $result.traceId = traceId;
    }
    if (annotations != null) {
      $result.annotations.addAll(annotations);
    }
    if (requestOrigin != null) {
      $result.requestOrigin = requestOrigin;
    }
    return $result;
  }
  QuotaConfig._() : super();
  factory QuotaConfig.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaConfig.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaConfig',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'preferredValue')
    ..aOS(2, _omitFieldNames ? '' : 'stateDetail')
    ..aOM<$73.Int64Value>(3, _omitFieldNames ? '' : 'grantedValue',
        subBuilder: $73.Int64Value.create)
    ..aOS(4, _omitFieldNames ? '' : 'traceId')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'annotations',
        entryClassName: 'QuotaConfig.AnnotationsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.cloudquotas.v1'))
    ..e<QuotaConfig_Origin>(
        6, _omitFieldNames ? '' : 'requestOrigin', $pb.PbFieldType.OE,
        defaultOrMaker: QuotaConfig_Origin.ORIGIN_UNSPECIFIED,
        valueOf: QuotaConfig_Origin.valueOf,
        enumValues: QuotaConfig_Origin.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaConfig clone() => QuotaConfig()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaConfig copyWith(void Function(QuotaConfig) updates) =>
      super.copyWith((message) => updates(message as QuotaConfig))
          as QuotaConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaConfig create() => QuotaConfig._();
  QuotaConfig createEmptyInstance() => create();
  static $pb.PbList<QuotaConfig> createRepeated() => $pb.PbList<QuotaConfig>();
  @$core.pragma('dart2js:noInline')
  static QuotaConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaConfig>(create);
  static QuotaConfig? _defaultInstance;

  /// Required. The preferred value. Must be greater than or equal to -1. If set
  /// to -1, it means the value is "unlimited".
  @$pb.TagNumber(1)
  $fixnum.Int64 get preferredValue => $_getI64(0);
  @$pb.TagNumber(1)
  set preferredValue($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPreferredValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreferredValue() => clearField(1);

  /// Output only. Optional details about the state of this quota preference.
  @$pb.TagNumber(2)
  $core.String get stateDetail => $_getSZ(1);
  @$pb.TagNumber(2)
  set stateDetail($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStateDetail() => $_has(1);
  @$pb.TagNumber(2)
  void clearStateDetail() => clearField(2);

  /// Output only. Granted quota value.
  @$pb.TagNumber(3)
  $73.Int64Value get grantedValue => $_getN(2);
  @$pb.TagNumber(3)
  set grantedValue($73.Int64Value v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasGrantedValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrantedValue() => clearField(3);
  @$pb.TagNumber(3)
  $73.Int64Value ensureGrantedValue() => $_ensure(2);

  /// Output only. The trace id that the Google Cloud uses to provision the
  /// requested quota. This trace id may be used by the client to contact Cloud
  /// support to track the state of a quota preference request. The trace id is
  /// only produced for increase requests and is unique for each request. The
  /// quota decrease requests do not have a trace id.
  @$pb.TagNumber(4)
  $core.String get traceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set traceId($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTraceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTraceId() => clearField(4);

  /// Optional. The annotations map for clients to store small amounts of
  /// arbitrary data. Do not put PII or other sensitive information here. See
  /// https://google.aip.dev/128#annotations
  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get annotations => $_getMap(4);

  /// Output only. The origin of the quota preference request.
  @$pb.TagNumber(6)
  QuotaConfig_Origin get requestOrigin => $_getN(5);
  @$pb.TagNumber(6)
  set requestOrigin(QuotaConfig_Origin v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasRequestOrigin() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequestOrigin() => clearField(6);
}

/// The detailed quota information such as effective quota value for a
/// combination of dimensions.
class DimensionsInfo extends $pb.GeneratedMessage {
  factory DimensionsInfo({
    $core.Map<$core.String, $core.String>? dimensions,
    QuotaDetails? details,
    $core.Iterable<$core.String>? applicableLocations,
  }) {
    final $result = create();
    if (dimensions != null) {
      $result.dimensions.addAll(dimensions);
    }
    if (details != null) {
      $result.details = details;
    }
    if (applicableLocations != null) {
      $result.applicableLocations.addAll(applicableLocations);
    }
    return $result;
  }
  DimensionsInfo._() : super();
  factory DimensionsInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DimensionsInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DimensionsInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'dimensions',
        entryClassName: 'DimensionsInfo.DimensionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.cloudquotas.v1'))
    ..aOM<QuotaDetails>(2, _omitFieldNames ? '' : 'details',
        subBuilder: QuotaDetails.create)
    ..pPS(3, _omitFieldNames ? '' : 'applicableLocations')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DimensionsInfo clone() => DimensionsInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DimensionsInfo copyWith(void Function(DimensionsInfo) updates) =>
      super.copyWith((message) => updates(message as DimensionsInfo))
          as DimensionsInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DimensionsInfo create() => DimensionsInfo._();
  DimensionsInfo createEmptyInstance() => create();
  static $pb.PbList<DimensionsInfo> createRepeated() =>
      $pb.PbList<DimensionsInfo>();
  @$core.pragma('dart2js:noInline')
  static DimensionsInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DimensionsInfo>(create);
  static DimensionsInfo? _defaultInstance;

  /// The map of dimensions for this dimensions info. The key of a map entry
  /// is "region", "zone" or the name of a service specific dimension, and the
  /// value of a map entry is the value of the dimension.  If a dimension does
  /// not appear in the map of dimensions, the dimensions info applies to all
  /// the dimension values except for those that have another DimenisonInfo
  /// instance configured for the specific value.
  /// Example: {"provider" : "Foo Inc"} where "provider" is a service specific
  /// dimension of a quota.
  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get dimensions => $_getMap(0);

  /// Quota details for the specified dimensions.
  @$pb.TagNumber(2)
  QuotaDetails get details => $_getN(1);
  @$pb.TagNumber(2)
  set details(QuotaDetails v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDetails() => $_has(1);
  @$pb.TagNumber(2)
  void clearDetails() => clearField(2);
  @$pb.TagNumber(2)
  QuotaDetails ensureDetails() => $_ensure(1);

  /// The applicable regions or zones of this dimensions info. The field will be
  /// set to ['global'] for quotas that are not per region or per zone.
  /// Otherwise, it will be set to the list of locations this dimension info is
  /// applicable to.
  @$pb.TagNumber(3)
  $core.List<$core.String> get applicableLocations => $_getList(2);
}

/// The quota details for a map of dimensions.
class QuotaDetails extends $pb.GeneratedMessage {
  factory QuotaDetails({
    $fixnum.Int64? value,
    RolloutInfo? rolloutInfo,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (rolloutInfo != null) {
      $result.rolloutInfo = rolloutInfo;
    }
    return $result;
  }
  QuotaDetails._() : super();
  factory QuotaDetails.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaDetails.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaDetails',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'value')
    ..aOM<RolloutInfo>(3, _omitFieldNames ? '' : 'rolloutInfo',
        subBuilder: RolloutInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaDetails clone() => QuotaDetails()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaDetails copyWith(void Function(QuotaDetails) updates) =>
      super.copyWith((message) => updates(message as QuotaDetails))
          as QuotaDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaDetails create() => QuotaDetails._();
  QuotaDetails createEmptyInstance() => create();
  static $pb.PbList<QuotaDetails> createRepeated() =>
      $pb.PbList<QuotaDetails>();
  @$core.pragma('dart2js:noInline')
  static QuotaDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaDetails>(create);
  static QuotaDetails? _defaultInstance;

  /// The value currently in effect and being enforced.
  @$pb.TagNumber(1)
  $fixnum.Int64 get value => $_getI64(0);
  @$pb.TagNumber(1)
  set value($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  /// Rollout information of this quota.
  /// This field is present only if the effective limit will change due to the
  /// ongoing rollout of the service config.
  @$pb.TagNumber(3)
  RolloutInfo get rolloutInfo => $_getN(1);
  @$pb.TagNumber(3)
  set rolloutInfo(RolloutInfo v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRolloutInfo() => $_has(1);
  @$pb.TagNumber(3)
  void clearRolloutInfo() => clearField(3);
  @$pb.TagNumber(3)
  RolloutInfo ensureRolloutInfo() => $_ensure(1);
}

/// [Output only] Rollout information of a quota.
class RolloutInfo extends $pb.GeneratedMessage {
  factory RolloutInfo({
    $core.bool? ongoingRollout,
  }) {
    final $result = create();
    if (ongoingRollout != null) {
      $result.ongoingRollout = ongoingRollout;
    }
    return $result;
  }
  RolloutInfo._() : super();
  factory RolloutInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RolloutInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RolloutInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ongoingRollout')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RolloutInfo clone() => RolloutInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RolloutInfo copyWith(void Function(RolloutInfo) updates) =>
      super.copyWith((message) => updates(message as RolloutInfo))
          as RolloutInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RolloutInfo create() => RolloutInfo._();
  RolloutInfo createEmptyInstance() => create();
  static $pb.PbList<RolloutInfo> createRepeated() => $pb.PbList<RolloutInfo>();
  @$core.pragma('dart2js:noInline')
  static RolloutInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RolloutInfo>(create);
  static RolloutInfo? _defaultInstance;

  /// Whether there is an ongoing rollout for a quota or not.
  @$pb.TagNumber(1)
  $core.bool get ongoingRollout => $_getBF(0);
  @$pb.TagNumber(1)
  set ongoingRollout($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOngoingRollout() => $_has(0);
  @$pb.TagNumber(1)
  void clearOngoingRollout() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
