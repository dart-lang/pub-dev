//
//  Generated code. Do not modify.
//  source: google/api/launch_stage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use launchStageDescriptor instead')
const LaunchStage$json = {
  '1': 'LaunchStage',
  '2': [
    {'1': 'LAUNCH_STAGE_UNSPECIFIED', '2': 0},
    {'1': 'UNIMPLEMENTED', '2': 6},
    {'1': 'PRELAUNCH', '2': 7},
    {'1': 'EARLY_ACCESS', '2': 1},
    {'1': 'ALPHA', '2': 2},
    {'1': 'BETA', '2': 3},
    {'1': 'GA', '2': 4},
    {'1': 'DEPRECATED', '2': 5},
  ],
};

/// Descriptor for `LaunchStage`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List launchStageDescriptor = $convert.base64Decode(
    'CgtMYXVuY2hTdGFnZRIcChhMQVVOQ0hfU1RBR0VfVU5TUEVDSUZJRUQQABIRCg1VTklNUExFTU'
    'VOVEVEEAYSDQoJUFJFTEFVTkNIEAcSEAoMRUFSTFlfQUNDRVNTEAESCQoFQUxQSEEQAhIICgRC'
    'RVRBEAMSBgoCR0EQBBIOCgpERVBSRUNBVEVEEAU=');
