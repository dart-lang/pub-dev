///
//  Generated code. Do not modify.
///
library google.devtools.cloudbuild.v1_cloudbuild_pbjson;

import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../rpc/status.pbjson.dart' as google$rpc;
import '../../../protobuf/empty.pbjson.dart' as google$protobuf;

const StorageSource$json = const {
  '1': 'StorageSource',
  '2': const [
    const {'1': 'bucket', '3': 1, '4': 1, '5': 9},
    const {'1': 'object', '3': 2, '4': 1, '5': 9},
    const {'1': 'generation', '3': 3, '4': 1, '5': 3},
  ],
};

const RepoSource$json = const {
  '1': 'RepoSource',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'repo_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'branch_name', '3': 3, '4': 1, '5': 9},
    const {'1': 'tag_name', '3': 4, '4': 1, '5': 9},
    const {'1': 'commit_sha', '3': 5, '4': 1, '5': 9},
  ],
};

const Source$json = const {
  '1': 'Source',
  '2': const [
    const {'1': 'storage_source', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.StorageSource'},
    const {'1': 'repo_source', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.RepoSource'},
  ],
};

const BuiltImage$json = const {
  '1': 'BuiltImage',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'digest', '3': 3, '4': 1, '5': 9},
  ],
};

const BuildStep$json = const {
  '1': 'BuildStep',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'env', '3': 2, '4': 3, '5': 9},
    const {'1': 'args', '3': 3, '4': 3, '5': 9},
    const {'1': 'dir', '3': 4, '4': 1, '5': 9},
    const {'1': 'id', '3': 5, '4': 1, '5': 9},
    const {'1': 'wait_for', '3': 6, '4': 3, '5': 9},
    const {'1': 'entrypoint', '3': 7, '4': 1, '5': 9},
  ],
};

const Results$json = const {
  '1': 'Results',
  '2': const [
    const {'1': 'images', '3': 2, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.BuiltImage'},
    const {'1': 'build_step_images', '3': 3, '4': 3, '5': 9},
  ],
};

const Build$json = const {
  '1': 'Build',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'project_id', '3': 16, '4': 1, '5': 9},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.google.devtools.cloudbuild.v1.Build.Status'},
    const {'1': 'status_detail', '3': 24, '4': 1, '5': 9},
    const {'1': 'source', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.Source'},
    const {'1': 'steps', '3': 11, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.BuildStep'},
    const {'1': 'results', '3': 10, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.Results'},
    const {'1': 'create_time', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'start_time', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'finish_time', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'timeout', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'images', '3': 13, '4': 3, '5': 9},
    const {'1': 'logs_bucket', '3': 19, '4': 1, '5': 9},
    const {'1': 'source_provenance', '3': 21, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.SourceProvenance'},
    const {'1': 'build_trigger_id', '3': 22, '4': 1, '5': 9},
    const {'1': 'options', '3': 23, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.BuildOptions'},
    const {'1': 'log_url', '3': 25, '4': 1, '5': 9},
    const {'1': 'substitutions', '3': 29, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.Build.SubstitutionsEntry'},
  ],
  '3': const [Build_SubstitutionsEntry$json],
  '4': const [Build_Status$json],
};

const Build_SubstitutionsEntry$json = const {
  '1': 'SubstitutionsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const Build_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNKNOWN', '2': 0},
    const {'1': 'QUEUED', '2': 1},
    const {'1': 'WORKING', '2': 2},
    const {'1': 'SUCCESS', '2': 3},
    const {'1': 'FAILURE', '2': 4},
    const {'1': 'INTERNAL_ERROR', '2': 5},
    const {'1': 'TIMEOUT', '2': 6},
    const {'1': 'CANCELLED', '2': 7},
  ],
};

const BuildOperationMetadata$json = const {
  '1': 'BuildOperationMetadata',
  '2': const [
    const {'1': 'build', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.Build'},
  ],
};

const SourceProvenance$json = const {
  '1': 'SourceProvenance',
  '2': const [
    const {'1': 'resolved_storage_source', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.StorageSource'},
    const {'1': 'resolved_repo_source', '3': 6, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.RepoSource'},
    const {'1': 'file_hashes', '3': 4, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.SourceProvenance.FileHashesEntry'},
  ],
  '3': const [SourceProvenance_FileHashesEntry$json],
};

const SourceProvenance_FileHashesEntry$json = const {
  '1': 'FileHashesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.FileHashes'},
  ],
  '7': const {},
};

const FileHashes$json = const {
  '1': 'FileHashes',
  '2': const [
    const {'1': 'file_hash', '3': 1, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.Hash'},
  ],
};

const Hash$json = const {
  '1': 'Hash',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.google.devtools.cloudbuild.v1.Hash.HashType'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12},
  ],
  '4': const [Hash_HashType$json],
};

const Hash_HashType$json = const {
  '1': 'HashType',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'SHA256', '2': 1},
  ],
};

const CreateBuildRequest$json = const {
  '1': 'CreateBuildRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'build', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.Build'},
  ],
};

const GetBuildRequest$json = const {
  '1': 'GetBuildRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
  ],
};

const ListBuildsRequest$json = const {
  '1': 'ListBuildsRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
    const {'1': 'filter', '3': 8, '4': 1, '5': 9},
  ],
};

const ListBuildsResponse$json = const {
  '1': 'ListBuildsResponse',
  '2': const [
    const {'1': 'builds', '3': 1, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.Build'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const CancelBuildRequest$json = const {
  '1': 'CancelBuildRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
  ],
};

const BuildTrigger$json = const {
  '1': 'BuildTrigger',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 10, '4': 1, '5': 9},
    const {'1': 'trigger_template', '3': 7, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.RepoSource'},
    const {'1': 'build', '3': 4, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.Build'},
    const {'1': 'filename', '3': 8, '4': 1, '5': 9},
    const {'1': 'create_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'disabled', '3': 9, '4': 1, '5': 8},
    const {'1': 'substitutions', '3': 11, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.BuildTrigger.SubstitutionsEntry'},
  ],
  '3': const [BuildTrigger_SubstitutionsEntry$json],
};

const BuildTrigger_SubstitutionsEntry$json = const {
  '1': 'SubstitutionsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const CreateBuildTriggerRequest$json = const {
  '1': 'CreateBuildTriggerRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'trigger', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.BuildTrigger'},
  ],
};

const GetBuildTriggerRequest$json = const {
  '1': 'GetBuildTriggerRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'trigger_id', '3': 2, '4': 1, '5': 9},
  ],
};

const ListBuildTriggersRequest$json = const {
  '1': 'ListBuildTriggersRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
  ],
};

const ListBuildTriggersResponse$json = const {
  '1': 'ListBuildTriggersResponse',
  '2': const [
    const {'1': 'triggers', '3': 1, '4': 3, '5': 11, '6': '.google.devtools.cloudbuild.v1.BuildTrigger'},
  ],
};

const DeleteBuildTriggerRequest$json = const {
  '1': 'DeleteBuildTriggerRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'trigger_id', '3': 2, '4': 1, '5': 9},
  ],
};

const UpdateBuildTriggerRequest$json = const {
  '1': 'UpdateBuildTriggerRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'trigger_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'trigger', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.cloudbuild.v1.BuildTrigger'},
  ],
};

const BuildOptions$json = const {
  '1': 'BuildOptions',
  '2': const [
    const {'1': 'source_provenance_hash', '3': 1, '4': 3, '5': 14, '6': '.google.devtools.cloudbuild.v1.Hash.HashType'},
    const {'1': 'requested_verify_option', '3': 2, '4': 1, '5': 14, '6': '.google.devtools.cloudbuild.v1.BuildOptions.VerifyOption'},
  ],
  '4': const [BuildOptions_VerifyOption$json],
};

const BuildOptions_VerifyOption$json = const {
  '1': 'VerifyOption',
  '2': const [
    const {'1': 'NOT_VERIFIED', '2': 0},
    const {'1': 'VERIFIED', '2': 1},
  ],
};

const CloudBuild$json = const {
  '1': 'CloudBuild',
  '2': const [
    const {'1': 'CreateBuild', '2': '.google.devtools.cloudbuild.v1.CreateBuildRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'GetBuild', '2': '.google.devtools.cloudbuild.v1.GetBuildRequest', '3': '.google.devtools.cloudbuild.v1.Build', '4': const {}},
    const {'1': 'ListBuilds', '2': '.google.devtools.cloudbuild.v1.ListBuildsRequest', '3': '.google.devtools.cloudbuild.v1.ListBuildsResponse', '4': const {}},
    const {'1': 'CancelBuild', '2': '.google.devtools.cloudbuild.v1.CancelBuildRequest', '3': '.google.devtools.cloudbuild.v1.Build', '4': const {}},
    const {'1': 'CreateBuildTrigger', '2': '.google.devtools.cloudbuild.v1.CreateBuildTriggerRequest', '3': '.google.devtools.cloudbuild.v1.BuildTrigger', '4': const {}},
    const {'1': 'GetBuildTrigger', '2': '.google.devtools.cloudbuild.v1.GetBuildTriggerRequest', '3': '.google.devtools.cloudbuild.v1.BuildTrigger', '4': const {}},
    const {'1': 'ListBuildTriggers', '2': '.google.devtools.cloudbuild.v1.ListBuildTriggersRequest', '3': '.google.devtools.cloudbuild.v1.ListBuildTriggersResponse', '4': const {}},
    const {'1': 'DeleteBuildTrigger', '2': '.google.devtools.cloudbuild.v1.DeleteBuildTriggerRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'UpdateBuildTrigger', '2': '.google.devtools.cloudbuild.v1.UpdateBuildTriggerRequest', '3': '.google.devtools.cloudbuild.v1.BuildTrigger', '4': const {}},
  ],
};

const CloudBuild$messageJson = const {
  '.google.devtools.cloudbuild.v1.CreateBuildRequest': CreateBuildRequest$json,
  '.google.devtools.cloudbuild.v1.Build': Build$json,
  '.google.devtools.cloudbuild.v1.Source': Source$json,
  '.google.devtools.cloudbuild.v1.StorageSource': StorageSource$json,
  '.google.devtools.cloudbuild.v1.RepoSource': RepoSource$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.devtools.cloudbuild.v1.Results': Results$json,
  '.google.devtools.cloudbuild.v1.BuiltImage': BuiltImage$json,
  '.google.devtools.cloudbuild.v1.BuildStep': BuildStep$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.devtools.cloudbuild.v1.SourceProvenance': SourceProvenance$json,
  '.google.devtools.cloudbuild.v1.SourceProvenance.FileHashesEntry': SourceProvenance_FileHashesEntry$json,
  '.google.devtools.cloudbuild.v1.FileHashes': FileHashes$json,
  '.google.devtools.cloudbuild.v1.Hash': Hash$json,
  '.google.devtools.cloudbuild.v1.BuildOptions': BuildOptions$json,
  '.google.devtools.cloudbuild.v1.Build.SubstitutionsEntry': Build_SubstitutionsEntry$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.devtools.cloudbuild.v1.GetBuildRequest': GetBuildRequest$json,
  '.google.devtools.cloudbuild.v1.ListBuildsRequest': ListBuildsRequest$json,
  '.google.devtools.cloudbuild.v1.ListBuildsResponse': ListBuildsResponse$json,
  '.google.devtools.cloudbuild.v1.CancelBuildRequest': CancelBuildRequest$json,
  '.google.devtools.cloudbuild.v1.CreateBuildTriggerRequest': CreateBuildTriggerRequest$json,
  '.google.devtools.cloudbuild.v1.BuildTrigger': BuildTrigger$json,
  '.google.devtools.cloudbuild.v1.BuildTrigger.SubstitutionsEntry': BuildTrigger_SubstitutionsEntry$json,
  '.google.devtools.cloudbuild.v1.GetBuildTriggerRequest': GetBuildTriggerRequest$json,
  '.google.devtools.cloudbuild.v1.ListBuildTriggersRequest': ListBuildTriggersRequest$json,
  '.google.devtools.cloudbuild.v1.ListBuildTriggersResponse': ListBuildTriggersResponse$json,
  '.google.devtools.cloudbuild.v1.DeleteBuildTriggerRequest': DeleteBuildTriggerRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.devtools.cloudbuild.v1.UpdateBuildTriggerRequest': UpdateBuildTriggerRequest$json,
};

