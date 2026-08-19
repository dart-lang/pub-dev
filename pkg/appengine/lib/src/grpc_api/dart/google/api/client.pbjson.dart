//
//  Generated code. Do not modify.
//  source: google/api/client.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use clientLibraryOrganizationDescriptor instead')
const ClientLibraryOrganization$json = {
  '1': 'ClientLibraryOrganization',
  '2': [
    {'1': 'CLIENT_LIBRARY_ORGANIZATION_UNSPECIFIED', '2': 0},
    {'1': 'CLOUD', '2': 1},
    {'1': 'ADS', '2': 2},
    {'1': 'PHOTOS', '2': 3},
    {'1': 'STREET_VIEW', '2': 4},
    {'1': 'SHOPPING', '2': 5},
    {'1': 'GEO', '2': 6},
    {'1': 'GENERATIVE_AI', '2': 7},
  ],
};

/// Descriptor for `ClientLibraryOrganization`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List clientLibraryOrganizationDescriptor = $convert.base64Decode(
    'ChlDbGllbnRMaWJyYXJ5T3JnYW5pemF0aW9uEisKJ0NMSUVOVF9MSUJSQVJZX09SR0FOSVpBVE'
    'lPTl9VTlNQRUNJRklFRBAAEgkKBUNMT1VEEAESBwoDQURTEAISCgoGUEhPVE9TEAMSDwoLU1RS'
    'RUVUX1ZJRVcQBBIMCghTSE9QUElORxAFEgcKA0dFTxAGEhEKDUdFTkVSQVRJVkVfQUkQBw==');

@$core.Deprecated('Use clientLibraryDestinationDescriptor instead')
const ClientLibraryDestination$json = {
  '1': 'ClientLibraryDestination',
  '2': [
    {'1': 'CLIENT_LIBRARY_DESTINATION_UNSPECIFIED', '2': 0},
    {'1': 'GITHUB', '2': 10},
    {'1': 'PACKAGE_MANAGER', '2': 20},
  ],
};

/// Descriptor for `ClientLibraryDestination`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List clientLibraryDestinationDescriptor =
    $convert.base64Decode(
        'ChhDbGllbnRMaWJyYXJ5RGVzdGluYXRpb24SKgomQ0xJRU5UX0xJQlJBUllfREVTVElOQVRJT0'
        '5fVU5TUEVDSUZJRUQQABIKCgZHSVRIVUIQChITCg9QQUNLQUdFX01BTkFHRVIQFA==');

@$core.Deprecated('Use commonLanguageSettingsDescriptor instead')
const CommonLanguageSettings$json = {
  '1': 'CommonLanguageSettings',
  '2': [
    {
      '1': 'reference_docs_uri',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'referenceDocsUri',
    },
    {
      '1': 'destinations',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.google.api.ClientLibraryDestination',
      '10': 'destinations'
    },
  ],
};

/// Descriptor for `CommonLanguageSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonLanguageSettingsDescriptor = $convert.base64Decode(
    'ChZDb21tb25MYW5ndWFnZVNldHRpbmdzEjAKEnJlZmVyZW5jZV9kb2NzX3VyaRgBIAEoCUICGA'
    'FSEHJlZmVyZW5jZURvY3NVcmkSSAoMZGVzdGluYXRpb25zGAIgAygOMiQuZ29vZ2xlLmFwaS5D'
    'bGllbnRMaWJyYXJ5RGVzdGluYXRpb25SDGRlc3RpbmF0aW9ucw==');

@$core.Deprecated('Use clientLibrarySettingsDescriptor instead')
const ClientLibrarySettings$json = {
  '1': 'ClientLibrarySettings',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    {
      '1': 'launch_stage',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.api.LaunchStage',
      '10': 'launchStage'
    },
    {
      '1': 'rest_numeric_enums',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'restNumericEnums'
    },
    {
      '1': 'java_settings',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.api.JavaSettings',
      '10': 'javaSettings'
    },
    {
      '1': 'cpp_settings',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.google.api.CppSettings',
      '10': 'cppSettings'
    },
    {
      '1': 'php_settings',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.google.api.PhpSettings',
      '10': 'phpSettings'
    },
    {
      '1': 'python_settings',
      '3': 24,
      '4': 1,
      '5': 11,
      '6': '.google.api.PythonSettings',
      '10': 'pythonSettings'
    },
    {
      '1': 'node_settings',
      '3': 25,
      '4': 1,
      '5': 11,
      '6': '.google.api.NodeSettings',
      '10': 'nodeSettings'
    },
    {
      '1': 'dotnet_settings',
      '3': 26,
      '4': 1,
      '5': 11,
      '6': '.google.api.DotnetSettings',
      '10': 'dotnetSettings'
    },
    {
      '1': 'ruby_settings',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.google.api.RubySettings',
      '10': 'rubySettings'
    },
    {
      '1': 'go_settings',
      '3': 28,
      '4': 1,
      '5': 11,
      '6': '.google.api.GoSettings',
      '10': 'goSettings'
    },
  ],
};

/// Descriptor for `ClientLibrarySettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientLibrarySettingsDescriptor = $convert.base64Decode(
    'ChVDbGllbnRMaWJyYXJ5U2V0dGluZ3MSGAoHdmVyc2lvbhgBIAEoCVIHdmVyc2lvbhI6CgxsYX'
    'VuY2hfc3RhZ2UYAiABKA4yFy5nb29nbGUuYXBpLkxhdW5jaFN0YWdlUgtsYXVuY2hTdGFnZRIs'
    'ChJyZXN0X251bWVyaWNfZW51bXMYAyABKAhSEHJlc3ROdW1lcmljRW51bXMSPQoNamF2YV9zZX'
    'R0aW5ncxgVIAEoCzIYLmdvb2dsZS5hcGkuSmF2YVNldHRpbmdzUgxqYXZhU2V0dGluZ3MSOgoM'
    'Y3BwX3NldHRpbmdzGBYgASgLMhcuZ29vZ2xlLmFwaS5DcHBTZXR0aW5nc1ILY3BwU2V0dGluZ3'
    'MSOgoMcGhwX3NldHRpbmdzGBcgASgLMhcuZ29vZ2xlLmFwaS5QaHBTZXR0aW5nc1ILcGhwU2V0'
    'dGluZ3MSQwoPcHl0aG9uX3NldHRpbmdzGBggASgLMhouZ29vZ2xlLmFwaS5QeXRob25TZXR0aW'
    '5nc1IOcHl0aG9uU2V0dGluZ3MSPQoNbm9kZV9zZXR0aW5ncxgZIAEoCzIYLmdvb2dsZS5hcGku'
    'Tm9kZVNldHRpbmdzUgxub2RlU2V0dGluZ3MSQwoPZG90bmV0X3NldHRpbmdzGBogASgLMhouZ2'
    '9vZ2xlLmFwaS5Eb3RuZXRTZXR0aW5nc1IOZG90bmV0U2V0dGluZ3MSPQoNcnVieV9zZXR0aW5n'
    'cxgbIAEoCzIYLmdvb2dsZS5hcGkuUnVieVNldHRpbmdzUgxydWJ5U2V0dGluZ3MSNwoLZ29fc2'
    'V0dGluZ3MYHCABKAsyFi5nb29nbGUuYXBpLkdvU2V0dGluZ3NSCmdvU2V0dGluZ3M=');

@$core.Deprecated('Use publishingDescriptor instead')
const Publishing$json = {
  '1': 'Publishing',
  '2': [
    {
      '1': 'method_settings',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.MethodSettings',
      '10': 'methodSettings'
    },
    {'1': 'new_issue_uri', '3': 101, '4': 1, '5': 9, '10': 'newIssueUri'},
    {
      '1': 'documentation_uri',
      '3': 102,
      '4': 1,
      '5': 9,
      '10': 'documentationUri'
    },
    {'1': 'api_short_name', '3': 103, '4': 1, '5': 9, '10': 'apiShortName'},
    {'1': 'github_label', '3': 104, '4': 1, '5': 9, '10': 'githubLabel'},
    {
      '1': 'codeowner_github_teams',
      '3': 105,
      '4': 3,
      '5': 9,
      '10': 'codeownerGithubTeams'
    },
    {'1': 'doc_tag_prefix', '3': 106, '4': 1, '5': 9, '10': 'docTagPrefix'},
    {
      '1': 'organization',
      '3': 107,
      '4': 1,
      '5': 14,
      '6': '.google.api.ClientLibraryOrganization',
      '10': 'organization'
    },
    {
      '1': 'library_settings',
      '3': 109,
      '4': 3,
      '5': 11,
      '6': '.google.api.ClientLibrarySettings',
      '10': 'librarySettings'
    },
    {
      '1': 'proto_reference_documentation_uri',
      '3': 110,
      '4': 1,
      '5': 9,
      '10': 'protoReferenceDocumentationUri'
    },
    {
      '1': 'rest_reference_documentation_uri',
      '3': 111,
      '4': 1,
      '5': 9,
      '10': 'restReferenceDocumentationUri'
    },
  ],
};

/// Descriptor for `Publishing`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishingDescriptor = $convert.base64Decode(
    'CgpQdWJsaXNoaW5nEkMKD21ldGhvZF9zZXR0aW5ncxgCIAMoCzIaLmdvb2dsZS5hcGkuTWV0aG'
    '9kU2V0dGluZ3NSDm1ldGhvZFNldHRpbmdzEiIKDW5ld19pc3N1ZV91cmkYZSABKAlSC25ld0lz'
    'c3VlVXJpEisKEWRvY3VtZW50YXRpb25fdXJpGGYgASgJUhBkb2N1bWVudGF0aW9uVXJpEiQKDm'
    'FwaV9zaG9ydF9uYW1lGGcgASgJUgxhcGlTaG9ydE5hbWUSIQoMZ2l0aHViX2xhYmVsGGggASgJ'
    'UgtnaXRodWJMYWJlbBI0ChZjb2Rlb3duZXJfZ2l0aHViX3RlYW1zGGkgAygJUhRjb2Rlb3duZX'
    'JHaXRodWJUZWFtcxIkCg5kb2NfdGFnX3ByZWZpeBhqIAEoCVIMZG9jVGFnUHJlZml4EkkKDG9y'
    'Z2FuaXphdGlvbhhrIAEoDjIlLmdvb2dsZS5hcGkuQ2xpZW50TGlicmFyeU9yZ2FuaXphdGlvbl'
    'IMb3JnYW5pemF0aW9uEkwKEGxpYnJhcnlfc2V0dGluZ3MYbSADKAsyIS5nb29nbGUuYXBpLkNs'
    'aWVudExpYnJhcnlTZXR0aW5nc1IPbGlicmFyeVNldHRpbmdzEkkKIXByb3RvX3JlZmVyZW5jZV'
    '9kb2N1bWVudGF0aW9uX3VyaRhuIAEoCVIecHJvdG9SZWZlcmVuY2VEb2N1bWVudGF0aW9uVXJp'
    'EkcKIHJlc3RfcmVmZXJlbmNlX2RvY3VtZW50YXRpb25fdXJpGG8gASgJUh1yZXN0UmVmZXJlbm'
    'NlRG9jdW1lbnRhdGlvblVyaQ==');

@$core.Deprecated('Use javaSettingsDescriptor instead')
const JavaSettings$json = {
  '1': 'JavaSettings',
  '2': [
    {'1': 'library_package', '3': 1, '4': 1, '5': 9, '10': 'libraryPackage'},
    {
      '1': 'service_class_names',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.JavaSettings.ServiceClassNamesEntry',
      '10': 'serviceClassNames'
    },
    {
      '1': 'common',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
  ],
  '3': [JavaSettings_ServiceClassNamesEntry$json],
};

@$core.Deprecated('Use javaSettingsDescriptor instead')
const JavaSettings_ServiceClassNamesEntry$json = {
  '1': 'ServiceClassNamesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `JavaSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List javaSettingsDescriptor = $convert.base64Decode(
    'CgxKYXZhU2V0dGluZ3MSJwoPbGlicmFyeV9wYWNrYWdlGAEgASgJUg5saWJyYXJ5UGFja2FnZR'
    'JfChNzZXJ2aWNlX2NsYXNzX25hbWVzGAIgAygLMi8uZ29vZ2xlLmFwaS5KYXZhU2V0dGluZ3Mu'
    'U2VydmljZUNsYXNzTmFtZXNFbnRyeVIRc2VydmljZUNsYXNzTmFtZXMSOgoGY29tbW9uGAMgAS'
    'gLMiIuZ29vZ2xlLmFwaS5Db21tb25MYW5ndWFnZVNldHRpbmdzUgZjb21tb24aRAoWU2Vydmlj'
    'ZUNsYXNzTmFtZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdW'
    'U6AjgB');

@$core.Deprecated('Use cppSettingsDescriptor instead')
const CppSettings$json = {
  '1': 'CppSettings',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
  ],
};

/// Descriptor for `CppSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cppSettingsDescriptor = $convert.base64Decode(
    'CgtDcHBTZXR0aW5ncxI6CgZjb21tb24YASABKAsyIi5nb29nbGUuYXBpLkNvbW1vbkxhbmd1YW'
    'dlU2V0dGluZ3NSBmNvbW1vbg==');

@$core.Deprecated('Use phpSettingsDescriptor instead')
const PhpSettings$json = {
  '1': 'PhpSettings',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
  ],
};

/// Descriptor for `PhpSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List phpSettingsDescriptor = $convert.base64Decode(
    'CgtQaHBTZXR0aW5ncxI6CgZjb21tb24YASABKAsyIi5nb29nbGUuYXBpLkNvbW1vbkxhbmd1YW'
    'dlU2V0dGluZ3NSBmNvbW1vbg==');

@$core.Deprecated('Use pythonSettingsDescriptor instead')
const PythonSettings$json = {
  '1': 'PythonSettings',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
    {
      '1': 'experimental_features',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.PythonSettings.ExperimentalFeatures',
      '10': 'experimentalFeatures'
    },
  ],
  '3': [PythonSettings_ExperimentalFeatures$json],
};

@$core.Deprecated('Use pythonSettingsDescriptor instead')
const PythonSettings_ExperimentalFeatures$json = {
  '1': 'ExperimentalFeatures',
  '2': [
    {
      '1': 'rest_async_io_enabled',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'restAsyncIoEnabled'
    },
  ],
};

/// Descriptor for `PythonSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pythonSettingsDescriptor = $convert.base64Decode(
    'Cg5QeXRob25TZXR0aW5ncxI6CgZjb21tb24YASABKAsyIi5nb29nbGUuYXBpLkNvbW1vbkxhbm'
    'd1YWdlU2V0dGluZ3NSBmNvbW1vbhJkChVleHBlcmltZW50YWxfZmVhdHVyZXMYAiABKAsyLy5n'
    'b29nbGUuYXBpLlB5dGhvblNldHRpbmdzLkV4cGVyaW1lbnRhbEZlYXR1cmVzUhRleHBlcmltZW'
    '50YWxGZWF0dXJlcxpJChRFeHBlcmltZW50YWxGZWF0dXJlcxIxChVyZXN0X2FzeW5jX2lvX2Vu'
    'YWJsZWQYASABKAhSEnJlc3RBc3luY0lvRW5hYmxlZA==');

@$core.Deprecated('Use nodeSettingsDescriptor instead')
const NodeSettings$json = {
  '1': 'NodeSettings',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
  ],
};

/// Descriptor for `NodeSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeSettingsDescriptor = $convert.base64Decode(
    'CgxOb2RlU2V0dGluZ3MSOgoGY29tbW9uGAEgASgLMiIuZ29vZ2xlLmFwaS5Db21tb25MYW5ndW'
    'FnZVNldHRpbmdzUgZjb21tb24=');

@$core.Deprecated('Use dotnetSettingsDescriptor instead')
const DotnetSettings$json = {
  '1': 'DotnetSettings',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
    {
      '1': 'renamed_services',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.DotnetSettings.RenamedServicesEntry',
      '10': 'renamedServices'
    },
    {
      '1': 'renamed_resources',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.api.DotnetSettings.RenamedResourcesEntry',
      '10': 'renamedResources'
    },
    {
      '1': 'ignored_resources',
      '3': 4,
      '4': 3,
      '5': 9,
      '10': 'ignoredResources'
    },
    {
      '1': 'forced_namespace_aliases',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'forcedNamespaceAliases'
    },
    {
      '1': 'handwritten_signatures',
      '3': 6,
      '4': 3,
      '5': 9,
      '10': 'handwrittenSignatures'
    },
  ],
  '3': [
    DotnetSettings_RenamedServicesEntry$json,
    DotnetSettings_RenamedResourcesEntry$json
  ],
};

@$core.Deprecated('Use dotnetSettingsDescriptor instead')
const DotnetSettings_RenamedServicesEntry$json = {
  '1': 'RenamedServicesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use dotnetSettingsDescriptor instead')
const DotnetSettings_RenamedResourcesEntry$json = {
  '1': 'RenamedResourcesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DotnetSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dotnetSettingsDescriptor = $convert.base64Decode(
    'Cg5Eb3RuZXRTZXR0aW5ncxI6CgZjb21tb24YASABKAsyIi5nb29nbGUuYXBpLkNvbW1vbkxhbm'
    'd1YWdlU2V0dGluZ3NSBmNvbW1vbhJaChByZW5hbWVkX3NlcnZpY2VzGAIgAygLMi8uZ29vZ2xl'
    'LmFwaS5Eb3RuZXRTZXR0aW5ncy5SZW5hbWVkU2VydmljZXNFbnRyeVIPcmVuYW1lZFNlcnZpY2'
    'VzEl0KEXJlbmFtZWRfcmVzb3VyY2VzGAMgAygLMjAuZ29vZ2xlLmFwaS5Eb3RuZXRTZXR0aW5n'
    'cy5SZW5hbWVkUmVzb3VyY2VzRW50cnlSEHJlbmFtZWRSZXNvdXJjZXMSKwoRaWdub3JlZF9yZX'
    'NvdXJjZXMYBCADKAlSEGlnbm9yZWRSZXNvdXJjZXMSOAoYZm9yY2VkX25hbWVzcGFjZV9hbGlh'
    'c2VzGAUgAygJUhZmb3JjZWROYW1lc3BhY2VBbGlhc2VzEjUKFmhhbmR3cml0dGVuX3NpZ25hdH'
    'VyZXMYBiADKAlSFWhhbmR3cml0dGVuU2lnbmF0dXJlcxpCChRSZW5hbWVkU2VydmljZXNFbnRy'
    'eRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGkMKFVJlbmFtZW'
    'RSZXNvdXJjZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6'
    'AjgB');

@$core.Deprecated('Use rubySettingsDescriptor instead')
const RubySettings$json = {
  '1': 'RubySettings',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
  ],
};

/// Descriptor for `RubySettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rubySettingsDescriptor = $convert.base64Decode(
    'CgxSdWJ5U2V0dGluZ3MSOgoGY29tbW9uGAEgASgLMiIuZ29vZ2xlLmFwaS5Db21tb25MYW5ndW'
    'FnZVNldHRpbmdzUgZjb21tb24=');

@$core.Deprecated('Use goSettingsDescriptor instead')
const GoSettings$json = {
  '1': 'GoSettings',
  '2': [
    {
      '1': 'common',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.CommonLanguageSettings',
      '10': 'common'
    },
  ],
};

/// Descriptor for `GoSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List goSettingsDescriptor = $convert.base64Decode(
    'CgpHb1NldHRpbmdzEjoKBmNvbW1vbhgBIAEoCzIiLmdvb2dsZS5hcGkuQ29tbW9uTGFuZ3VhZ2'
    'VTZXR0aW5nc1IGY29tbW9u');

@$core.Deprecated('Use methodSettingsDescriptor instead')
const MethodSettings$json = {
  '1': 'MethodSettings',
  '2': [
    {'1': 'selector', '3': 1, '4': 1, '5': 9, '10': 'selector'},
    {
      '1': 'long_running',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.MethodSettings.LongRunning',
      '10': 'longRunning'
    },
    {
      '1': 'auto_populated_fields',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'autoPopulatedFields'
    },
  ],
  '3': [MethodSettings_LongRunning$json],
};

@$core.Deprecated('Use methodSettingsDescriptor instead')
const MethodSettings_LongRunning$json = {
  '1': 'LongRunning',
  '2': [
    {
      '1': 'initial_poll_delay',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'initialPollDelay'
    },
    {
      '1': 'poll_delay_multiplier',
      '3': 2,
      '4': 1,
      '5': 2,
      '10': 'pollDelayMultiplier'
    },
    {
      '1': 'max_poll_delay',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'maxPollDelay'
    },
    {
      '1': 'total_poll_timeout',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'totalPollTimeout'
    },
  ],
};

/// Descriptor for `MethodSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List methodSettingsDescriptor = $convert.base64Decode(
    'Cg5NZXRob2RTZXR0aW5ncxIaCghzZWxlY3RvchgBIAEoCVIIc2VsZWN0b3ISSQoMbG9uZ19ydW'
    '5uaW5nGAIgASgLMiYuZ29vZ2xlLmFwaS5NZXRob2RTZXR0aW5ncy5Mb25nUnVubmluZ1ILbG9u'
    'Z1J1bm5pbmcSMgoVYXV0b19wb3B1bGF0ZWRfZmllbGRzGAMgAygJUhNhdXRvUG9wdWxhdGVkRm'
    'llbGRzGpQCCgtMb25nUnVubmluZxJHChJpbml0aWFsX3BvbGxfZGVsYXkYASABKAsyGS5nb29n'
    'bGUucHJvdG9idWYuRHVyYXRpb25SEGluaXRpYWxQb2xsRGVsYXkSMgoVcG9sbF9kZWxheV9tdW'
    'x0aXBsaWVyGAIgASgCUhNwb2xsRGVsYXlNdWx0aXBsaWVyEj8KDm1heF9wb2xsX2RlbGF5GAMg'
    'ASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUgxtYXhQb2xsRGVsYXkSRwoSdG90YWxfcG'
    '9sbF90aW1lb3V0GAQgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUhB0b3RhbFBvbGxU'
    'aW1lb3V0');
