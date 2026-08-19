//
//  Generated code. Do not modify.
//  source: google/api/resource.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'resource.pbenum.dart';

export 'resource.pbenum.dart';

///  A simple descriptor of a resource type.
///
///  ResourceDescriptor annotates a resource message (either by means of a
///  protobuf annotation or use in the service config), and associates the
///  resource's schema, the resource type, and the pattern of the resource name.
///
///  Example:
///
///      message Topic {
///        // Indicates this message defines a resource schema.
///        // Declares the resource type in the format of {service}/{kind}.
///        // For Kubernetes resources, the format is {api group}/{kind}.
///        option (google.api.resource) = {
///          type: "pubsub.googleapis.com/Topic"
///          pattern: "projects/{project}/topics/{topic}"
///        };
///      }
///
///  The ResourceDescriptor Yaml config will look like:
///
///      resources:
///      - type: "pubsub.googleapis.com/Topic"
///        pattern: "projects/{project}/topics/{topic}"
///
///  Sometimes, resources have multiple patterns, typically because they can
///  live under multiple parents.
///
///  Example:
///
///      message LogEntry {
///        option (google.api.resource) = {
///          type: "logging.googleapis.com/LogEntry"
///          pattern: "projects/{project}/logs/{log}"
///          pattern: "folders/{folder}/logs/{log}"
///          pattern: "organizations/{organization}/logs/{log}"
///          pattern: "billingAccounts/{billing_account}/logs/{log}"
///        };
///      }
///
///  The ResourceDescriptor Yaml config will look like:
///
///      resources:
///      - type: 'logging.googleapis.com/LogEntry'
///        pattern: "projects/{project}/logs/{log}"
///        pattern: "folders/{folder}/logs/{log}"
///        pattern: "organizations/{organization}/logs/{log}"
///        pattern: "billingAccounts/{billing_account}/logs/{log}"
class ResourceDescriptor extends $pb.GeneratedMessage {
  factory ResourceDescriptor({
    $core.String? type,
    $core.Iterable<$core.String>? pattern,
    $core.String? nameField,
    ResourceDescriptor_History? history,
    $core.String? plural,
    $core.String? singular,
    $core.Iterable<ResourceDescriptor_Style>? style,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (pattern != null) {
      $result.pattern.addAll(pattern);
    }
    if (nameField != null) {
      $result.nameField = nameField;
    }
    if (history != null) {
      $result.history = history;
    }
    if (plural != null) {
      $result.plural = plural;
    }
    if (singular != null) {
      $result.singular = singular;
    }
    if (style != null) {
      $result.style.addAll(style);
    }
    return $result;
  }
  ResourceDescriptor._() : super();
  factory ResourceDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResourceDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResourceDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..pPS(2, _omitFieldNames ? '' : 'pattern')
    ..aOS(3, _omitFieldNames ? '' : 'nameField')
    ..e<ResourceDescriptor_History>(
        4, _omitFieldNames ? '' : 'history', $pb.PbFieldType.OE,
        defaultOrMaker: ResourceDescriptor_History.HISTORY_UNSPECIFIED,
        valueOf: ResourceDescriptor_History.valueOf,
        enumValues: ResourceDescriptor_History.values)
    ..aOS(5, _omitFieldNames ? '' : 'plural')
    ..aOS(6, _omitFieldNames ? '' : 'singular')
    ..pc<ResourceDescriptor_Style>(
        10, _omitFieldNames ? '' : 'style', $pb.PbFieldType.KE,
        valueOf: ResourceDescriptor_Style.valueOf,
        enumValues: ResourceDescriptor_Style.values,
        defaultEnumValue: ResourceDescriptor_Style.STYLE_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResourceDescriptor clone() => ResourceDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResourceDescriptor copyWith(void Function(ResourceDescriptor) updates) =>
      super.copyWith((message) => updates(message as ResourceDescriptor))
          as ResourceDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResourceDescriptor create() => ResourceDescriptor._();
  ResourceDescriptor createEmptyInstance() => create();
  static $pb.PbList<ResourceDescriptor> createRepeated() =>
      $pb.PbList<ResourceDescriptor>();
  @$core.pragma('dart2js:noInline')
  static ResourceDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResourceDescriptor>(create);
  static ResourceDescriptor? _defaultInstance;

  ///  The resource type. It must be in the format of
  ///  {service_name}/{resource_type_kind}. The `resource_type_kind` must be
  ///  singular and must not include version numbers.
  ///
  ///  Example: `storage.googleapis.com/Bucket`
  ///
  ///  The value of the resource_type_kind must follow the regular expression
  ///  /[A-Za-z][a-zA-Z0-9]+/. It should start with an upper case character and
  ///  should use PascalCase (UpperCamelCase). The maximum number of
  ///  characters allowed for the `resource_type_kind` is 100.
  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  ///  Optional. The relative resource name pattern associated with this resource
  ///  type. The DNS prefix of the full resource name shouldn't be specified here.
  ///
  ///  The path pattern must follow the syntax, which aligns with HTTP binding
  ///  syntax:
  ///
  ///      Template = Segment { "/" Segment } ;
  ///      Segment = LITERAL | Variable ;
  ///      Variable = "{" LITERAL "}" ;
  ///
  ///  Examples:
  ///
  ///      - "projects/{project}/topics/{topic}"
  ///      - "projects/{project}/knowledgeBases/{knowledge_base}"
  ///
  ///  The components in braces correspond to the IDs for each resource in the
  ///  hierarchy. It is expected that, if multiple patterns are provided,
  ///  the same component name (e.g. "project") refers to IDs of the same
  ///  type of resource.
  @$pb.TagNumber(2)
  $core.List<$core.String> get pattern => $_getList(1);

  /// Optional. The field on the resource that designates the resource name
  /// field. If omitted, this is assumed to be "name".
  @$pb.TagNumber(3)
  $core.String get nameField => $_getSZ(2);
  @$pb.TagNumber(3)
  set nameField($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNameField() => $_has(2);
  @$pb.TagNumber(3)
  void clearNameField() => clearField(3);

  ///  Optional. The historical or future-looking state of the resource pattern.
  ///
  ///  Example:
  ///
  ///      // The InspectTemplate message originally only supported resource
  ///      // names with organization, and project was added later.
  ///      message InspectTemplate {
  ///        option (google.api.resource) = {
  ///          type: "dlp.googleapis.com/InspectTemplate"
  ///          pattern:
  ///          "organizations/{organization}/inspectTemplates/{inspect_template}"
  ///          pattern: "projects/{project}/inspectTemplates/{inspect_template}"
  ///          history: ORIGINALLY_SINGLE_PATTERN
  ///        };
  ///      }
  @$pb.TagNumber(4)
  ResourceDescriptor_History get history => $_getN(3);
  @$pb.TagNumber(4)
  set history(ResourceDescriptor_History v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasHistory() => $_has(3);
  @$pb.TagNumber(4)
  void clearHistory() => clearField(4);

  ///  The plural name used in the resource name and permission names, such as
  ///  'projects' for the resource name of 'projects/{project}' and the permission
  ///  name of 'cloudresourcemanager.googleapis.com/projects.get'. One exception
  ///  to this is for Nested Collections that have stuttering names, as defined
  ///  in [AIP-122](https://google.aip.dev/122#nested-collections), where the
  ///  collection ID in the resource name pattern does not necessarily directly
  ///  match the `plural` value.
  ///
  ///  It is the same concept of the `plural` field in k8s CRD spec
  ///  https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/
  ///
  ///  Note: The plural form is required even for singleton resources. See
  ///  https://aip.dev/156
  @$pb.TagNumber(5)
  $core.String get plural => $_getSZ(4);
  @$pb.TagNumber(5)
  set plural($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPlural() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlural() => clearField(5);

  /// The same concept of the `singular` field in k8s CRD spec
  /// https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/
  /// Such as "project" for the `resourcemanager.googleapis.com/Project` type.
  @$pb.TagNumber(6)
  $core.String get singular => $_getSZ(5);
  @$pb.TagNumber(6)
  set singular($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSingular() => $_has(5);
  @$pb.TagNumber(6)
  void clearSingular() => clearField(6);

  /// Style flag(s) for this resource.
  /// These indicate that a resource is expected to conform to a given
  /// style. See the specific style flags for additional information.
  @$pb.TagNumber(10)
  $core.List<ResourceDescriptor_Style> get style => $_getList(6);
}

/// Defines a proto annotation that describes a string field that refers to
/// an API resource.
class ResourceReference extends $pb.GeneratedMessage {
  factory ResourceReference({
    $core.String? type,
    $core.String? childType,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (childType != null) {
      $result.childType = childType;
    }
    return $result;
  }
  ResourceReference._() : super();
  factory ResourceReference.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResourceReference.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResourceReference',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'childType')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResourceReference clone() => ResourceReference()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResourceReference copyWith(void Function(ResourceReference) updates) =>
      super.copyWith((message) => updates(message as ResourceReference))
          as ResourceReference;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResourceReference create() => ResourceReference._();
  ResourceReference createEmptyInstance() => create();
  static $pb.PbList<ResourceReference> createRepeated() =>
      $pb.PbList<ResourceReference>();
  @$core.pragma('dart2js:noInline')
  static ResourceReference getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResourceReference>(create);
  static ResourceReference? _defaultInstance;

  ///  The resource type that the annotated field references.
  ///
  ///  Example:
  ///
  ///      message Subscription {
  ///        string topic = 2 [(google.api.resource_reference) = {
  ///          type: "pubsub.googleapis.com/Topic"
  ///        }];
  ///      }
  ///
  ///  Occasionally, a field may reference an arbitrary resource. In this case,
  ///  APIs use the special value * in their resource reference.
  ///
  ///  Example:
  ///
  ///      message GetIamPolicyRequest {
  ///        string resource = 2 [(google.api.resource_reference) = {
  ///          type: "*"
  ///        }];
  ///      }
  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  ///  The resource type of a child collection that the annotated field
  ///  references. This is useful for annotating the `parent` field that
  ///  doesn't have a fixed resource type.
  ///
  ///  Example:
  ///
  ///      message ListLogEntriesRequest {
  ///        string parent = 1 [(google.api.resource_reference) = {
  ///          child_type: "logging.googleapis.com/LogEntry"
  ///        };
  ///      }
  @$pb.TagNumber(2)
  $core.String get childType => $_getSZ(1);
  @$pb.TagNumber(2)
  set childType($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasChildType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChildType() => clearField(2);
}

class Resource {
  static final resourceReference = $pb.Extension<ResourceReference>(
      _omitMessageNames ? '' : 'google.protobuf.FieldOptions',
      _omitFieldNames ? '' : 'resourceReference',
      1055,
      $pb.PbFieldType.OM,
      defaultOrMaker: ResourceReference.getDefault,
      subBuilder: ResourceReference.create);
  static final resourceDefinition = $pb.Extension<ResourceDescriptor>.repeated(
      _omitMessageNames ? '' : 'google.protobuf.FileOptions',
      _omitFieldNames ? '' : 'resourceDefinition',
      1053,
      $pb.PbFieldType.PM,
      check: $pb.getCheckFunction($pb.PbFieldType.PM),
      subBuilder: ResourceDescriptor.create);
  static final resource = $pb.Extension<ResourceDescriptor>(
      _omitMessageNames ? '' : 'google.protobuf.MessageOptions',
      _omitFieldNames ? '' : 'resource',
      1053,
      $pb.PbFieldType.OM,
      defaultOrMaker: ResourceDescriptor.getDefault,
      subBuilder: ResourceDescriptor.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(resourceReference);
    registry.add(resourceDefinition);
    registry.add(resource);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
