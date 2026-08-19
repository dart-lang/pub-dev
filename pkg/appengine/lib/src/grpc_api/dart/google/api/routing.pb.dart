//
//  Generated code. Do not modify.
//  source: google/api/routing.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  Specifies the routing information that should be sent along with the request
///  in the form of routing header.
///  **NOTE:** All service configuration rules follow the "last one wins" order.
///
///  The examples below will apply to an RPC which has the following request type:
///
///  Message Definition:
///
///      message Request {
///        // The name of the Table
///        // Values can be of the following formats:
///        // - `projects/<project>/tables/<table>`
///        // - `projects/<project>/instances/<instance>/tables/<table>`
///        // - `region/<region>/zones/<zone>/tables/<table>`
///        string table_name = 1;
///
///        // This value specifies routing for replication.
///        // It can be in the following formats:
///        // - `profiles/<profile_id>`
///        // - a legacy `profile_id` that can be any string
///        string app_profile_id = 2;
///      }
///
///  Example message:
///
///      {
///        table_name: projects/proj_foo/instances/instance_bar/table/table_baz,
///        app_profile_id: profiles/prof_qux
///      }
///
///  The routing header consists of one or multiple key-value pairs. Every key
///  and value must be percent-encoded, and joined together in the format of
///  `key1=value1&key2=value2`.
///  In the examples below I am skipping the percent-encoding for readablity.
///
///  Example 1
///
///  Extracting a field from the request to put into the routing header
///  unchanged, with the key equal to the field name.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // Take the `app_profile_id`.
///        routing_parameters {
///          field: "app_profile_id"
///        }
///      };
///
///  result:
///
///      x-goog-request-params: app_profile_id=profiles/prof_qux
///
///  Example 2
///
///  Extracting a field from the request to put into the routing header
///  unchanged, with the key different from the field name.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // Take the `app_profile_id`, but name it `routing_id` in the header.
///        routing_parameters {
///          field: "app_profile_id"
///          path_template: "{routing_id=**}"
///        }
///      };
///
///  result:
///
///      x-goog-request-params: routing_id=profiles/prof_qux
///
///  Example 3
///
///  Extracting a field from the request to put into the routing
///  header, while matching a path template syntax on the field's value.
///
///  NB: it is more useful to send nothing than to send garbage for the purpose
///  of dynamic routing, since garbage pollutes cache. Thus the matching.
///
///  Sub-example 3a
///
///  The field matches the template.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // Take the `table_name`, if it's well-formed (with project-based
///        // syntax).
///        routing_parameters {
///          field: "table_name"
///          path_template: "{table_name=projects/*/instances/*/**}"
///        }
///      };
///
///  result:
///
///      x-goog-request-params:
///      table_name=projects/proj_foo/instances/instance_bar/table/table_baz
///
///  Sub-example 3b
///
///  The field does not match the template.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // Take the `table_name`, if it's well-formed (with region-based
///        // syntax).
///        routing_parameters {
///          field: "table_name"
///          path_template: "{table_name=regions/*/zones/*/**}"
///        }
///      };
///
///  result:
///
///      <no routing header will be sent>
///
///  Sub-example 3c
///
///  Multiple alternative conflictingly named path templates are
///  specified. The one that matches is used to construct the header.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // Take the `table_name`, if it's well-formed, whether
///        // using the region- or projects-based syntax.
///
///        routing_parameters {
///          field: "table_name"
///          path_template: "{table_name=regions/*/zones/*/**}"
///        }
///        routing_parameters {
///          field: "table_name"
///          path_template: "{table_name=projects/*/instances/*/**}"
///        }
///      };
///
///  result:
///
///      x-goog-request-params:
///      table_name=projects/proj_foo/instances/instance_bar/table/table_baz
///
///  Example 4
///
///  Extracting a single routing header key-value pair by matching a
///  template syntax on (a part of) a single request field.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // Take just the project id from the `table_name` field.
///        routing_parameters {
///          field: "table_name"
///          path_template: "{routing_id=projects/*}/**"
///        }
///      };
///
///  result:
///
///      x-goog-request-params: routing_id=projects/proj_foo
///
///  Example 5
///
///  Extracting a single routing header key-value pair by matching
///  several conflictingly named path templates on (parts of) a single request
///  field. The last template to match "wins" the conflict.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // If the `table_name` does not have instances information,
///        // take just the project id for routing.
///        // Otherwise take project + instance.
///
///        routing_parameters {
///          field: "table_name"
///          path_template: "{routing_id=projects/*}/**"
///        }
///        routing_parameters {
///          field: "table_name"
///          path_template: "{routing_id=projects/*/instances/*}/**"
///        }
///      };
///
///  result:
///
///      x-goog-request-params:
///      routing_id=projects/proj_foo/instances/instance_bar
///
///  Example 6
///
///  Extracting multiple routing header key-value pairs by matching
///  several non-conflicting path templates on (parts of) a single request field.
///
///  Sub-example 6a
///
///  Make the templates strict, so that if the `table_name` does not
///  have an instance information, nothing is sent.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // The routing code needs two keys instead of one composite
///        // but works only for the tables with the "project-instance" name
///        // syntax.
///
///        routing_parameters {
///          field: "table_name"
///          path_template: "{project_id=projects/*}/instances/*/**"
///        }
///        routing_parameters {
///          field: "table_name"
///          path_template: "projects/*/{instance_id=instances/*}/**"
///        }
///      };
///
///  result:
///
///      x-goog-request-params:
///      project_id=projects/proj_foo&instance_id=instances/instance_bar
///
///  Sub-example 6b
///
///  Make the templates loose, so that if the `table_name` does not
///  have an instance information, just the project id part is sent.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // The routing code wants two keys instead of one composite
///        // but will work with just the `project_id` for tables without
///        // an instance in the `table_name`.
///
///        routing_parameters {
///          field: "table_name"
///          path_template: "{project_id=projects/*}/**"
///        }
///        routing_parameters {
///          field: "table_name"
///          path_template: "projects/*/{instance_id=instances/*}/**"
///        }
///      };
///
///  result (is the same as 6a for our example message because it has the instance
///  information):
///
///      x-goog-request-params:
///      project_id=projects/proj_foo&instance_id=instances/instance_bar
///
///  Example 7
///
///  Extracting multiple routing header key-value pairs by matching
///  several path templates on multiple request fields.
///
///  NB: note that here there is no way to specify sending nothing if one of the
///  fields does not match its template. E.g. if the `table_name` is in the wrong
///  format, the `project_id` will not be sent, but the `routing_id` will be.
///  The backend routing code has to be aware of that and be prepared to not
///  receive a full complement of keys if it expects multiple.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // The routing needs both `project_id` and `routing_id`
///        // (from the `app_profile_id` field) for routing.
///
///        routing_parameters {
///          field: "table_name"
///          path_template: "{project_id=projects/*}/**"
///        }
///        routing_parameters {
///          field: "app_profile_id"
///          path_template: "{routing_id=**}"
///        }
///      };
///
///  result:
///
///      x-goog-request-params:
///      project_id=projects/proj_foo&routing_id=profiles/prof_qux
///
///  Example 8
///
///  Extracting a single routing header key-value pair by matching
///  several conflictingly named path templates on several request fields. The
///  last template to match "wins" the conflict.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // The `routing_id` can be a project id or a region id depending on
///        // the table name format, but only if the `app_profile_id` is not set.
///        // If `app_profile_id` is set it should be used instead.
///
///        routing_parameters {
///          field: "table_name"
///          path_template: "{routing_id=projects/*}/**"
///        }
///        routing_parameters {
///           field: "table_name"
///           path_template: "{routing_id=regions/*}/**"
///        }
///        routing_parameters {
///          field: "app_profile_id"
///          path_template: "{routing_id=**}"
///        }
///      };
///
///  result:
///
///      x-goog-request-params: routing_id=profiles/prof_qux
///
///  Example 9
///
///  Bringing it all together.
///
///  annotation:
///
///      option (google.api.routing) = {
///        // For routing both `table_location` and a `routing_id` are needed.
///        //
///        // table_location can be either an instance id or a region+zone id.
///        //
///        // For `routing_id`, take the value of `app_profile_id`
///        // - If it's in the format `profiles/<profile_id>`, send
///        // just the `<profile_id>` part.
///        // - If it's any other literal, send it as is.
///        // If the `app_profile_id` is empty, and the `table_name` starts with
///        // the project_id, send that instead.
///
///        routing_parameters {
///          field: "table_name"
///          path_template: "projects/*/{table_location=instances/*}/tables/*"
///        }
///        routing_parameters {
///          field: "table_name"
///          path_template: "{table_location=regions/*/zones/*}/tables/*"
///        }
///        routing_parameters {
///          field: "table_name"
///          path_template: "{routing_id=projects/*}/**"
///        }
///        routing_parameters {
///          field: "app_profile_id"
///          path_template: "{routing_id=**}"
///        }
///        routing_parameters {
///          field: "app_profile_id"
///          path_template: "profiles/{routing_id=*}"
///        }
///      };
///
///  result:
///
///      x-goog-request-params:
///      table_location=instances/instance_bar&routing_id=prof_qux
class RoutingRule extends $pb.GeneratedMessage {
  factory RoutingRule({
    $core.Iterable<RoutingParameter>? routingParameters,
  }) {
    final $result = create();
    if (routingParameters != null) {
      $result.routingParameters.addAll(routingParameters);
    }
    return $result;
  }
  RoutingRule._() : super();
  factory RoutingRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RoutingRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoutingRule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<RoutingParameter>(
        2, _omitFieldNames ? '' : 'routingParameters', $pb.PbFieldType.PM,
        subBuilder: RoutingParameter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RoutingRule clone() => RoutingRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RoutingRule copyWith(void Function(RoutingRule) updates) =>
      super.copyWith((message) => updates(message as RoutingRule))
          as RoutingRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoutingRule create() => RoutingRule._();
  RoutingRule createEmptyInstance() => create();
  static $pb.PbList<RoutingRule> createRepeated() => $pb.PbList<RoutingRule>();
  @$core.pragma('dart2js:noInline')
  static RoutingRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RoutingRule>(create);
  static RoutingRule? _defaultInstance;

  /// A collection of Routing Parameter specifications.
  /// **NOTE:** If multiple Routing Parameters describe the same key
  /// (via the `path_template` field or via the `field` field when
  /// `path_template` is not provided), "last one wins" rule
  /// determines which Parameter gets used.
  /// See the examples for more details.
  @$pb.TagNumber(2)
  $core.List<RoutingParameter> get routingParameters => $_getList(0);
}

/// A projection from an input message to the GRPC or REST header.
class RoutingParameter extends $pb.GeneratedMessage {
  factory RoutingParameter({
    $core.String? field_1,
    $core.String? pathTemplate,
  }) {
    final $result = create();
    if (field_1 != null) {
      $result.field_1 = field_1;
    }
    if (pathTemplate != null) {
      $result.pathTemplate = pathTemplate;
    }
    return $result;
  }
  RoutingParameter._() : super();
  factory RoutingParameter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RoutingParameter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoutingParameter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..aOS(2, _omitFieldNames ? '' : 'pathTemplate')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RoutingParameter clone() => RoutingParameter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RoutingParameter copyWith(void Function(RoutingParameter) updates) =>
      super.copyWith((message) => updates(message as RoutingParameter))
          as RoutingParameter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoutingParameter create() => RoutingParameter._();
  RoutingParameter createEmptyInstance() => create();
  static $pb.PbList<RoutingParameter> createRepeated() =>
      $pb.PbList<RoutingParameter>();
  @$core.pragma('dart2js:noInline')
  static RoutingParameter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RoutingParameter>(create);
  static RoutingParameter? _defaultInstance;

  /// A request field to extract the header key-value pair from.
  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => clearField(1);

  ///  A pattern matching the key-value field. Optional.
  ///  If not specified, the whole field specified in the `field` field will be
  ///  taken as value, and its name used as key. If specified, it MUST contain
  ///  exactly one named segment (along with any number of unnamed segments) The
  ///  pattern will be matched over the field specified in the `field` field, then
  ///  if the match is successful:
  ///  - the name of the single named segment will be used as a header name,
  ///  - the match value of the segment will be used as a header value;
  ///  if the match is NOT successful, nothing will be sent.
  ///
  ///  Example:
  ///
  ///                -- This is a field in the request message
  ///               |   that the header value will be extracted from.
  ///               |
  ///               |                     -- This is the key name in the
  ///               |                    |   routing header.
  ///               V                    |
  ///      field: "table_name"           v
  ///      path_template: "projects/*/{table_location=instances/*}/tables/*"
  ///                                                 ^            ^
  ///                                                 |            |
  ///        In the {} brackets is the pattern that --             |
  ///        specifies what to extract from the                    |
  ///        field as a value to be sent.                          |
  ///                                                              |
  ///       The string in the field must match the whole pattern --
  ///       before brackets, inside brackets, after brackets.
  ///
  ///  When looking at this specific example, we can see that:
  ///  - A key-value pair with the key `table_location`
  ///    and the value matching `instances/*` should be added
  ///    to the x-goog-request-params routing header.
  ///  - The value is extracted from the request message's `table_name` field
  ///    if it matches the full pattern specified:
  ///    `projects/*/instances/*/tables/*`.
  ///
  ///  **NB:** If the `path_template` field is not provided, the key name is
  ///  equal to the field name, and the whole field should be sent as a value.
  ///  This makes the pattern for the field and the value functionally equivalent
  ///  to `**`, and the configuration
  ///
  ///      {
  ///        field: "table_name"
  ///      }
  ///
  ///  is a functionally equivalent shorthand to:
  ///
  ///      {
  ///        field: "table_name"
  ///        path_template: "{table_name=**}"
  ///      }
  ///
  ///  See Example 1 for more details.
  @$pb.TagNumber(2)
  $core.String get pathTemplate => $_getSZ(1);
  @$pb.TagNumber(2)
  set pathTemplate($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPathTemplate() => $_has(1);
  @$pb.TagNumber(2)
  void clearPathTemplate() => clearField(2);
}

class Routing {
  static final routing = $pb.Extension<RoutingRule>(
      _omitMessageNames ? '' : 'google.protobuf.MethodOptions',
      _omitFieldNames ? '' : 'routing',
      72295729,
      $pb.PbFieldType.OM,
      defaultOrMaker: RoutingRule.getDefault,
      subBuilder: RoutingRule.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(routing);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
