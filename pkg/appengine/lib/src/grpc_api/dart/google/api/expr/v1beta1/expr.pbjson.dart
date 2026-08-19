//
//  Generated code. Do not modify.
//  source: google/api/expr/v1beta1/expr.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use parsedExprDescriptor instead')
const ParsedExpr$json = {
  '1': 'ParsedExpr',
  '2': [
    {
      '1': 'expr',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'expr'
    },
    {
      '1': 'source_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.SourceInfo',
      '10': 'sourceInfo'
    },
    {'1': 'syntax_version', '3': 4, '4': 1, '5': 9, '10': 'syntaxVersion'},
  ],
};

/// Descriptor for `ParsedExpr`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parsedExprDescriptor = $convert.base64Decode(
    'CgpQYXJzZWRFeHByEjEKBGV4cHIYAiABKAsyHS5nb29nbGUuYXBpLmV4cHIudjFiZXRhMS5FeH'
    'ByUgRleHByEkQKC3NvdXJjZV9pbmZvGAMgASgLMiMuZ29vZ2xlLmFwaS5leHByLnYxYmV0YTEu'
    'U291cmNlSW5mb1IKc291cmNlSW5mbxIlCg5zeW50YXhfdmVyc2lvbhgEIAEoCVINc3ludGF4Vm'
    'Vyc2lvbg==');

@$core.Deprecated('Use exprDescriptor instead')
const Expr$json = {
  '1': 'Expr',
  '2': [
    {'1': 'id', '3': 2, '4': 1, '5': 5, '10': 'id'},
    {
      '1': 'literal_expr',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Literal',
      '9': 0,
      '10': 'literalExpr'
    },
    {
      '1': 'ident_expr',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr.Ident',
      '9': 0,
      '10': 'identExpr'
    },
    {
      '1': 'select_expr',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr.Select',
      '9': 0,
      '10': 'selectExpr'
    },
    {
      '1': 'call_expr',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr.Call',
      '9': 0,
      '10': 'callExpr'
    },
    {
      '1': 'list_expr',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr.CreateList',
      '9': 0,
      '10': 'listExpr'
    },
    {
      '1': 'struct_expr',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr.CreateStruct',
      '9': 0,
      '10': 'structExpr'
    },
    {
      '1': 'comprehension_expr',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr.Comprehension',
      '9': 0,
      '10': 'comprehensionExpr'
    },
  ],
  '3': [
    Expr_Ident$json,
    Expr_Select$json,
    Expr_Call$json,
    Expr_CreateList$json,
    Expr_CreateStruct$json,
    Expr_Comprehension$json
  ],
  '8': [
    {'1': 'expr_kind'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Ident$json = {
  '1': 'Ident',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Select$json = {
  '1': 'Select',
  '2': [
    {
      '1': 'operand',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'operand'
    },
    {'1': 'field', '3': 2, '4': 1, '5': 9, '10': 'field'},
    {'1': 'test_only', '3': 3, '4': 1, '5': 8, '10': 'testOnly'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Call$json = {
  '1': 'Call',
  '2': [
    {
      '1': 'target',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'target'
    },
    {'1': 'function', '3': 2, '4': 1, '5': 9, '10': 'function'},
    {
      '1': 'args',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'args'
    },
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_CreateList$json = {
  '1': 'CreateList',
  '2': [
    {
      '1': 'elements',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'elements'
    },
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_CreateStruct$json = {
  '1': 'CreateStruct',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'entries',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr.CreateStruct.Entry',
      '10': 'entries'
    },
  ],
  '3': [Expr_CreateStruct_Entry$json],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_CreateStruct_Entry$json = {
  '1': 'Entry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'field_key', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'fieldKey'},
    {
      '1': 'map_key',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '9': 0,
      '10': 'mapKey'
    },
    {
      '1': 'value',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'value'
    },
  ],
  '8': [
    {'1': 'key_kind'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Comprehension$json = {
  '1': 'Comprehension',
  '2': [
    {'1': 'iter_var', '3': 1, '4': 1, '5': 9, '10': 'iterVar'},
    {
      '1': 'iter_range',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'iterRange'
    },
    {'1': 'accu_var', '3': 3, '4': 1, '5': 9, '10': 'accuVar'},
    {
      '1': 'accu_init',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'accuInit'
    },
    {
      '1': 'loop_condition',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'loopCondition'
    },
    {
      '1': 'loop_step',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'loopStep'
    },
    {
      '1': 'result',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1beta1.Expr',
      '10': 'result'
    },
  ],
};

/// Descriptor for `Expr`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exprDescriptor = $convert.base64Decode(
    'CgRFeHByEg4KAmlkGAIgASgFUgJpZBJFCgxsaXRlcmFsX2V4cHIYAyABKAsyIC5nb29nbGUuYX'
    'BpLmV4cHIudjFiZXRhMS5MaXRlcmFsSABSC2xpdGVyYWxFeHByEkQKCmlkZW50X2V4cHIYBCAB'
    'KAsyIy5nb29nbGUuYXBpLmV4cHIudjFiZXRhMS5FeHByLklkZW50SABSCWlkZW50RXhwchJHCg'
    'tzZWxlY3RfZXhwchgFIAEoCzIkLmdvb2dsZS5hcGkuZXhwci52MWJldGExLkV4cHIuU2VsZWN0'
    'SABSCnNlbGVjdEV4cHISQQoJY2FsbF9leHByGAYgASgLMiIuZ29vZ2xlLmFwaS5leHByLnYxYm'
    'V0YTEuRXhwci5DYWxsSABSCGNhbGxFeHByEkcKCWxpc3RfZXhwchgHIAEoCzIoLmdvb2dsZS5h'
    'cGkuZXhwci52MWJldGExLkV4cHIuQ3JlYXRlTGlzdEgAUghsaXN0RXhwchJNCgtzdHJ1Y3RfZX'
    'hwchgIIAEoCzIqLmdvb2dsZS5hcGkuZXhwci52MWJldGExLkV4cHIuQ3JlYXRlU3RydWN0SABS'
    'CnN0cnVjdEV4cHISXAoSY29tcHJlaGVuc2lvbl9leHByGAkgASgLMisuZ29vZ2xlLmFwaS5leH'
    'ByLnYxYmV0YTEuRXhwci5Db21wcmVoZW5zaW9uSABSEWNvbXByZWhlbnNpb25FeHByGhsKBUlk'
    'ZW50EhIKBG5hbWUYASABKAlSBG5hbWUadAoGU2VsZWN0EjcKB29wZXJhbmQYASABKAsyHS5nb2'
    '9nbGUuYXBpLmV4cHIudjFiZXRhMS5FeHByUgdvcGVyYW5kEhQKBWZpZWxkGAIgASgJUgVmaWVs'
    'ZBIbCgl0ZXN0X29ubHkYAyABKAhSCHRlc3RPbmx5GowBCgRDYWxsEjUKBnRhcmdldBgBIAEoCz'
    'IdLmdvb2dsZS5hcGkuZXhwci52MWJldGExLkV4cHJSBnRhcmdldBIaCghmdW5jdGlvbhgCIAEo'
    'CVIIZnVuY3Rpb24SMQoEYXJncxgDIAMoCzIdLmdvb2dsZS5hcGkuZXhwci52MWJldGExLkV4cH'
    'JSBGFyZ3MaRwoKQ3JlYXRlTGlzdBI5CghlbGVtZW50cxgBIAMoCzIdLmdvb2dsZS5hcGkuZXhw'
    'ci52MWJldGExLkV4cHJSCGVsZW1lbnRzGqICCgxDcmVhdGVTdHJ1Y3QSEgoEdHlwZRgBIAEoCV'
    'IEdHlwZRJKCgdlbnRyaWVzGAIgAygLMjAuZ29vZ2xlLmFwaS5leHByLnYxYmV0YTEuRXhwci5D'
    'cmVhdGVTdHJ1Y3QuRW50cnlSB2VudHJpZXMasQEKBUVudHJ5Eg4KAmlkGAEgASgFUgJpZBIdCg'
    'lmaWVsZF9rZXkYAiABKAlIAFIIZmllbGRLZXkSOAoHbWFwX2tleRgDIAEoCzIdLmdvb2dsZS5h'
    'cGkuZXhwci52MWJldGExLkV4cHJIAFIGbWFwS2V5EjMKBXZhbHVlGAQgASgLMh0uZ29vZ2xlLm'
    'FwaS5leHByLnYxYmV0YTEuRXhwclIFdmFsdWVCCgoIa2V5X2tpbmQa+AIKDUNvbXByZWhlbnNp'
    'b24SGQoIaXRlcl92YXIYASABKAlSB2l0ZXJWYXISPAoKaXRlcl9yYW5nZRgCIAEoCzIdLmdvb2'
    'dsZS5hcGkuZXhwci52MWJldGExLkV4cHJSCWl0ZXJSYW5nZRIZCghhY2N1X3ZhchgDIAEoCVIH'
    'YWNjdVZhchI6CglhY2N1X2luaXQYBCABKAsyHS5nb29nbGUuYXBpLmV4cHIudjFiZXRhMS5FeH'
    'ByUghhY2N1SW5pdBJECg5sb29wX2NvbmRpdGlvbhgFIAEoCzIdLmdvb2dsZS5hcGkuZXhwci52'
    'MWJldGExLkV4cHJSDWxvb3BDb25kaXRpb24SOgoJbG9vcF9zdGVwGAYgASgLMh0uZ29vZ2xlLm'
    'FwaS5leHByLnYxYmV0YTEuRXhwclIIbG9vcFN0ZXASNQoGcmVzdWx0GAcgASgLMh0uZ29vZ2xl'
    'LmFwaS5leHByLnYxYmV0YTEuRXhwclIGcmVzdWx0QgsKCWV4cHJfa2luZA==');

@$core.Deprecated('Use literalDescriptor instead')
const Literal$json = {
  '1': 'Literal',
  '2': [
    {
      '1': 'null_value',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '9': 0,
      '10': 'nullValue'
    },
    {'1': 'bool_value', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {'1': 'int64_value', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'int64Value'},
    {'1': 'uint64_value', '3': 4, '4': 1, '5': 4, '9': 0, '10': 'uint64Value'},
    {'1': 'double_value', '3': 5, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {'1': 'string_value', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'bytes_value', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'bytesValue'},
  ],
  '8': [
    {'1': 'constant_kind'},
  ],
};

/// Descriptor for `Literal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List literalDescriptor = $convert.base64Decode(
    'CgdMaXRlcmFsEjsKCm51bGxfdmFsdWUYASABKA4yGi5nb29nbGUucHJvdG9idWYuTnVsbFZhbH'
    'VlSABSCW51bGxWYWx1ZRIfCgpib29sX3ZhbHVlGAIgASgISABSCWJvb2xWYWx1ZRIhCgtpbnQ2'
    'NF92YWx1ZRgDIAEoA0gAUgppbnQ2NFZhbHVlEiMKDHVpbnQ2NF92YWx1ZRgEIAEoBEgAUgt1aW'
    '50NjRWYWx1ZRIjCgxkb3VibGVfdmFsdWUYBSABKAFIAFILZG91YmxlVmFsdWUSIwoMc3RyaW5n'
    'X3ZhbHVlGAYgASgJSABSC3N0cmluZ1ZhbHVlEiEKC2J5dGVzX3ZhbHVlGAcgASgMSABSCmJ5dG'
    'VzVmFsdWVCDwoNY29uc3RhbnRfa2luZA==');
