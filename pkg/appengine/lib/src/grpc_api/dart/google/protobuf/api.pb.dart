//
//  Generated code. Do not modify.
//  source: google/protobuf/api.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'source_context.pb.dart' as $82;
import 'type.pb.dart' as $83;
import 'type.pbenum.dart' as $83;

///  Api is a light-weight descriptor for an API Interface.
///
///  Interfaces are also described as "protocol buffer services" in some contexts,
///  such as by the "service" keyword in a .proto file, but they are different
///  from API Services, which represent a concrete implementation of an interface
///  as opposed to simply a description of methods and bindings. They are also
///  sometimes simply referred to as "APIs" in other contexts, such as the name of
///  this message itself. See https://cloud.google.com/apis/design/glossary for
///  detailed terminology.
class Api extends $pb.GeneratedMessage {
  factory Api({
    $core.String? name,
    $core.Iterable<Method>? methods,
    $core.Iterable<$83.Option>? options,
    $core.String? version,
    $82.SourceContext? sourceContext,
    $core.Iterable<Mixin>? mixins,
    $83.Syntax? syntax,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (methods != null) {
      $result.methods.addAll(methods);
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (version != null) {
      $result.version = version;
    }
    if (sourceContext != null) {
      $result.sourceContext = sourceContext;
    }
    if (mixins != null) {
      $result.mixins.addAll(mixins);
    }
    if (syntax != null) {
      $result.syntax = syntax;
    }
    return $result;
  }
  Api._() : super();
  factory Api.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Api.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Api',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<Method>(2, _omitFieldNames ? '' : 'methods', $pb.PbFieldType.PM,
        subBuilder: Method.create)
    ..pc<$83.Option>(3, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM,
        subBuilder: $83.Option.create)
    ..aOS(4, _omitFieldNames ? '' : 'version')
    ..aOM<$82.SourceContext>(5, _omitFieldNames ? '' : 'sourceContext',
        subBuilder: $82.SourceContext.create)
    ..pc<Mixin>(6, _omitFieldNames ? '' : 'mixins', $pb.PbFieldType.PM,
        subBuilder: Mixin.create)
    ..e<$83.Syntax>(7, _omitFieldNames ? '' : 'syntax', $pb.PbFieldType.OE,
        defaultOrMaker: $83.Syntax.SYNTAX_PROTO2,
        valueOf: $83.Syntax.valueOf,
        enumValues: $83.Syntax.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Api clone() => Api()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Api copyWith(void Function(Api) updates) =>
      super.copyWith((message) => updates(message as Api)) as Api;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Api create() => Api._();
  Api createEmptyInstance() => create();
  static $pb.PbList<Api> createRepeated() => $pb.PbList<Api>();
  @$core.pragma('dart2js:noInline')
  static Api getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Api>(create);
  static Api? _defaultInstance;

  /// The fully qualified name of this interface, including package name
  /// followed by the interface's simple name.
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

  /// The methods of this interface, in unspecified order.
  @$pb.TagNumber(2)
  $core.List<Method> get methods => $_getList(1);

  /// Any metadata attached to the interface.
  @$pb.TagNumber(3)
  $core.List<$83.Option> get options => $_getList(2);

  ///  A version string for this interface. If specified, must have the form
  ///  `major-version.minor-version`, as in `1.10`. If the minor version is
  ///  omitted, it defaults to zero. If the entire version field is empty, the
  ///  major version is derived from the package name, as outlined below. If the
  ///  field is not empty, the version in the package name will be verified to be
  ///  consistent with what is provided here.
  ///
  ///  The versioning schema uses [semantic
  ///  versioning](http://semver.org) where the major version number
  ///  indicates a breaking change and the minor version an additive,
  ///  non-breaking change. Both version numbers are signals to users
  ///  what to expect from different versions, and should be carefully
  ///  chosen based on the product plan.
  ///
  ///  The major version is also reflected in the package name of the
  ///  interface, which must end in `v<major-version>`, as in
  ///  `google.feature.v1`. For major versions 0 and 1, the suffix can
  ///  be omitted. Zero major versions must only be used for
  ///  experimental, non-GA interfaces.
  @$pb.TagNumber(4)
  $core.String get version => $_getSZ(3);
  @$pb.TagNumber(4)
  set version($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => clearField(4);

  /// Source context for the protocol buffer service represented by this
  /// message.
  @$pb.TagNumber(5)
  $82.SourceContext get sourceContext => $_getN(4);
  @$pb.TagNumber(5)
  set sourceContext($82.SourceContext v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSourceContext() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceContext() => clearField(5);
  @$pb.TagNumber(5)
  $82.SourceContext ensureSourceContext() => $_ensure(4);

  /// Included interfaces. See [Mixin][].
  @$pb.TagNumber(6)
  $core.List<Mixin> get mixins => $_getList(5);

  /// The source syntax of the service.
  @$pb.TagNumber(7)
  $83.Syntax get syntax => $_getN(6);
  @$pb.TagNumber(7)
  set syntax($83.Syntax v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasSyntax() => $_has(6);
  @$pb.TagNumber(7)
  void clearSyntax() => clearField(7);
}

/// Method represents a method of an API interface.
class Method extends $pb.GeneratedMessage {
  factory Method({
    $core.String? name,
    $core.String? requestTypeUrl,
    $core.bool? requestStreaming,
    $core.String? responseTypeUrl,
    $core.bool? responseStreaming,
    $core.Iterable<$83.Option>? options,
    $83.Syntax? syntax,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (requestTypeUrl != null) {
      $result.requestTypeUrl = requestTypeUrl;
    }
    if (requestStreaming != null) {
      $result.requestStreaming = requestStreaming;
    }
    if (responseTypeUrl != null) {
      $result.responseTypeUrl = responseTypeUrl;
    }
    if (responseStreaming != null) {
      $result.responseStreaming = responseStreaming;
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (syntax != null) {
      $result.syntax = syntax;
    }
    return $result;
  }
  Method._() : super();
  factory Method.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Method.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Method',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'requestTypeUrl')
    ..aOB(3, _omitFieldNames ? '' : 'requestStreaming')
    ..aOS(4, _omitFieldNames ? '' : 'responseTypeUrl')
    ..aOB(5, _omitFieldNames ? '' : 'responseStreaming')
    ..pc<$83.Option>(6, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM,
        subBuilder: $83.Option.create)
    ..e<$83.Syntax>(7, _omitFieldNames ? '' : 'syntax', $pb.PbFieldType.OE,
        defaultOrMaker: $83.Syntax.SYNTAX_PROTO2,
        valueOf: $83.Syntax.valueOf,
        enumValues: $83.Syntax.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Method clone() => Method()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Method copyWith(void Function(Method) updates) =>
      super.copyWith((message) => updates(message as Method)) as Method;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Method create() => Method._();
  Method createEmptyInstance() => create();
  static $pb.PbList<Method> createRepeated() => $pb.PbList<Method>();
  @$core.pragma('dart2js:noInline')
  static Method getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Method>(create);
  static Method? _defaultInstance;

  /// The simple name of this method.
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

  /// A URL of the input message type.
  @$pb.TagNumber(2)
  $core.String get requestTypeUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set requestTypeUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRequestTypeUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestTypeUrl() => clearField(2);

  /// If true, the request is streamed.
  @$pb.TagNumber(3)
  $core.bool get requestStreaming => $_getBF(2);
  @$pb.TagNumber(3)
  set requestStreaming($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRequestStreaming() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestStreaming() => clearField(3);

  /// The URL of the output message type.
  @$pb.TagNumber(4)
  $core.String get responseTypeUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set responseTypeUrl($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasResponseTypeUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseTypeUrl() => clearField(4);

  /// If true, the response is streamed.
  @$pb.TagNumber(5)
  $core.bool get responseStreaming => $_getBF(4);
  @$pb.TagNumber(5)
  set responseStreaming($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasResponseStreaming() => $_has(4);
  @$pb.TagNumber(5)
  void clearResponseStreaming() => clearField(5);

  /// Any metadata attached to the method.
  @$pb.TagNumber(6)
  $core.List<$83.Option> get options => $_getList(5);

  /// The source syntax of this method.
  @$pb.TagNumber(7)
  $83.Syntax get syntax => $_getN(6);
  @$pb.TagNumber(7)
  set syntax($83.Syntax v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasSyntax() => $_has(6);
  @$pb.TagNumber(7)
  void clearSyntax() => clearField(7);
}

///  Declares an API Interface to be included in this interface. The including
///  interface must redeclare all the methods from the included interface, but
///  documentation and options are inherited as follows:
///
///  - If after comment and whitespace stripping, the documentation
///    string of the redeclared method is empty, it will be inherited
///    from the original method.
///
///  - Each annotation belonging to the service config (http,
///    visibility) which is not set in the redeclared method will be
///    inherited.
///
///  - If an http annotation is inherited, the path pattern will be
///    modified as follows. Any version prefix will be replaced by the
///    version of the including interface plus the [root][] path if
///    specified.
///
///  Example of a simple mixin:
///
///      package google.acl.v1;
///      service AccessControl {
///        // Get the underlying ACL object.
///        rpc GetAcl(GetAclRequest) returns (Acl) {
///          option (google.api.http).get = "/v1/{resource=**}:getAcl";
///        }
///      }
///
///      package google.storage.v2;
///      service Storage {
///        rpc GetAcl(GetAclRequest) returns (Acl);
///
///        // Get a data record.
///        rpc GetData(GetDataRequest) returns (Data) {
///          option (google.api.http).get = "/v2/{resource=**}";
///        }
///      }
///
///  Example of a mixin configuration:
///
///      apis:
///      - name: google.storage.v2.Storage
///        mixins:
///        - name: google.acl.v1.AccessControl
///
///  The mixin construct implies that all methods in `AccessControl` are
///  also declared with same name and request/response types in
///  `Storage`. A documentation generator or annotation processor will
///  see the effective `Storage.GetAcl` method after inherting
///  documentation and annotations as follows:
///
///      service Storage {
///        // Get the underlying ACL object.
///        rpc GetAcl(GetAclRequest) returns (Acl) {
///          option (google.api.http).get = "/v2/{resource=**}:getAcl";
///        }
///        ...
///      }
///
///  Note how the version in the path pattern changed from `v1` to `v2`.
///
///  If the `root` field in the mixin is specified, it should be a
///  relative path under which inherited HTTP paths are placed. Example:
///
///      apis:
///      - name: google.storage.v2.Storage
///        mixins:
///        - name: google.acl.v1.AccessControl
///          root: acls
///
///  This implies the following inherited HTTP annotation:
///
///      service Storage {
///        // Get the underlying ACL object.
///        rpc GetAcl(GetAclRequest) returns (Acl) {
///          option (google.api.http).get = "/v2/acls/{resource=**}:getAcl";
///        }
///        ...
///      }
class Mixin extends $pb.GeneratedMessage {
  factory Mixin({
    $core.String? name,
    $core.String? root,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (root != null) {
      $result.root = root;
    }
    return $result;
  }
  Mixin._() : super();
  factory Mixin.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Mixin.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Mixin',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'root')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Mixin clone() => Mixin()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Mixin copyWith(void Function(Mixin) updates) =>
      super.copyWith((message) => updates(message as Mixin)) as Mixin;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mixin create() => Mixin._();
  Mixin createEmptyInstance() => create();
  static $pb.PbList<Mixin> createRepeated() => $pb.PbList<Mixin>();
  @$core.pragma('dart2js:noInline')
  static Mixin getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mixin>(create);
  static Mixin? _defaultInstance;

  /// The fully qualified name of the interface which is included.
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

  /// If non-empty specifies a path under which inherited HTTP paths
  /// are rooted.
  @$pb.TagNumber(2)
  $core.String get root => $_getSZ(1);
  @$pb.TagNumber(2)
  set root($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRoot() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoot() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
