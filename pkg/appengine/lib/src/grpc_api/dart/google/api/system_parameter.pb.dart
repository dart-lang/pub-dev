//
//  Generated code. Do not modify.
//  source: google/api/system_parameter.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  ### System parameter configuration
///
///  A system parameter is a special kind of parameter defined by the API
///  system, not by an individual API. It is typically mapped to an HTTP header
///  and/or a URL query parameter. This configuration specifies which methods
///  change the names of the system parameters.
class SystemParameters extends $pb.GeneratedMessage {
  factory SystemParameters({
    $core.Iterable<SystemParameterRule>? rules,
  }) {
    final $result = create();
    if (rules != null) {
      $result.rules.addAll(rules);
    }
    return $result;
  }
  SystemParameters._() : super();
  factory SystemParameters.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SystemParameters.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SystemParameters',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<SystemParameterRule>(
        1, _omitFieldNames ? '' : 'rules', $pb.PbFieldType.PM,
        subBuilder: SystemParameterRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SystemParameters clone() => SystemParameters()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SystemParameters copyWith(void Function(SystemParameters) updates) =>
      super.copyWith((message) => updates(message as SystemParameters))
          as SystemParameters;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemParameters create() => SystemParameters._();
  SystemParameters createEmptyInstance() => create();
  static $pb.PbList<SystemParameters> createRepeated() =>
      $pb.PbList<SystemParameters>();
  @$core.pragma('dart2js:noInline')
  static SystemParameters getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SystemParameters>(create);
  static SystemParameters? _defaultInstance;

  ///  Define system parameters.
  ///
  ///  The parameters defined here will override the default parameters
  ///  implemented by the system. If this field is missing from the service
  ///  config, default system parameters will be used. Default system parameters
  ///  and names is implementation-dependent.
  ///
  ///  Example: define api key for all methods
  ///
  ///      system_parameters
  ///        rules:
  ///          - selector: "*"
  ///            parameters:
  ///              - name: api_key
  ///                url_query_parameter: api_key
  ///
  ///
  ///  Example: define 2 api key names for a specific method.
  ///
  ///      system_parameters
  ///        rules:
  ///          - selector: "/ListShelves"
  ///            parameters:
  ///              - name: api_key
  ///                http_header: Api-Key1
  ///              - name: api_key
  ///                http_header: Api-Key2
  ///
  ///  **NOTE:** All service configuration rules follow "last one wins" order.
  @$pb.TagNumber(1)
  $core.List<SystemParameterRule> get rules => $_getList(0);
}

/// Define a system parameter rule mapping system parameter definitions to
/// methods.
class SystemParameterRule extends $pb.GeneratedMessage {
  factory SystemParameterRule({
    $core.String? selector,
    $core.Iterable<SystemParameter>? parameters,
  }) {
    final $result = create();
    if (selector != null) {
      $result.selector = selector;
    }
    if (parameters != null) {
      $result.parameters.addAll(parameters);
    }
    return $result;
  }
  SystemParameterRule._() : super();
  factory SystemParameterRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SystemParameterRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SystemParameterRule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'selector')
    ..pc<SystemParameter>(
        2, _omitFieldNames ? '' : 'parameters', $pb.PbFieldType.PM,
        subBuilder: SystemParameter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SystemParameterRule clone() => SystemParameterRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SystemParameterRule copyWith(void Function(SystemParameterRule) updates) =>
      super.copyWith((message) => updates(message as SystemParameterRule))
          as SystemParameterRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemParameterRule create() => SystemParameterRule._();
  SystemParameterRule createEmptyInstance() => create();
  static $pb.PbList<SystemParameterRule> createRepeated() =>
      $pb.PbList<SystemParameterRule>();
  @$core.pragma('dart2js:noInline')
  static SystemParameterRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SystemParameterRule>(create);
  static SystemParameterRule? _defaultInstance;

  ///  Selects the methods to which this rule applies. Use '*' to indicate all
  ///  methods in all APIs.
  ///
  ///  Refer to [selector][google.api.DocumentationRule.selector] for syntax
  ///  details.
  @$pb.TagNumber(1)
  $core.String get selector => $_getSZ(0);
  @$pb.TagNumber(1)
  set selector($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);

  /// Define parameters. Multiple names may be defined for a parameter.
  /// For a given method call, only one of them should be used. If multiple
  /// names are used the behavior is implementation-dependent.
  /// If none of the specified names are present the behavior is
  /// parameter-dependent.
  @$pb.TagNumber(2)
  $core.List<SystemParameter> get parameters => $_getList(1);
}

/// Define a parameter's name and location. The parameter may be passed as either
/// an HTTP header or a URL query parameter, and if both are passed the behavior
/// is implementation-dependent.
class SystemParameter extends $pb.GeneratedMessage {
  factory SystemParameter({
    $core.String? name,
    $core.String? httpHeader,
    $core.String? urlQueryParameter,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (httpHeader != null) {
      $result.httpHeader = httpHeader;
    }
    if (urlQueryParameter != null) {
      $result.urlQueryParameter = urlQueryParameter;
    }
    return $result;
  }
  SystemParameter._() : super();
  factory SystemParameter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SystemParameter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SystemParameter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'httpHeader')
    ..aOS(3, _omitFieldNames ? '' : 'urlQueryParameter')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SystemParameter clone() => SystemParameter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SystemParameter copyWith(void Function(SystemParameter) updates) =>
      super.copyWith((message) => updates(message as SystemParameter))
          as SystemParameter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemParameter create() => SystemParameter._();
  SystemParameter createEmptyInstance() => create();
  static $pb.PbList<SystemParameter> createRepeated() =>
      $pb.PbList<SystemParameter>();
  @$core.pragma('dart2js:noInline')
  static SystemParameter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SystemParameter>(create);
  static SystemParameter? _defaultInstance;

  /// Define the name of the parameter, such as "api_key" . It is case sensitive.
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

  /// Define the HTTP header name to use for the parameter. It is case
  /// insensitive.
  @$pb.TagNumber(2)
  $core.String get httpHeader => $_getSZ(1);
  @$pb.TagNumber(2)
  set httpHeader($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasHttpHeader() => $_has(1);
  @$pb.TagNumber(2)
  void clearHttpHeader() => clearField(2);

  /// Define the URL query parameter name to use for the parameter. It is case
  /// sensitive.
  @$pb.TagNumber(3)
  $core.String get urlQueryParameter => $_getSZ(2);
  @$pb.TagNumber(3)
  set urlQueryParameter($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUrlQueryParameter() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrlQueryParameter() => clearField(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
