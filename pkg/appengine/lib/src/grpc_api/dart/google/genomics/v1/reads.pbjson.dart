///
//  Generated code. Do not modify.
///
library google.genomics.v1_reads_pbjson;

import 'readalignment.pbjson.dart';
import 'position.pbjson.dart';
import 'cigar.pbjson.dart';
import '../../protobuf/struct.pbjson.dart' as google$protobuf;
import '../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../rpc/status.pbjson.dart' as google$rpc;
import 'readgroupset.pbjson.dart';
import 'readgroup.pbjson.dart';
import '../../protobuf/field_mask.pbjson.dart' as google$protobuf;
import '../../protobuf/empty.pbjson.dart' as google$protobuf;
import 'range.pbjson.dart';

const SearchReadGroupSetsRequest$json = const {
  '1': 'SearchReadGroupSetsRequest',
  '2': const [
    const {'1': 'dataset_ids', '3': 1, '4': 3, '5': 9},
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5},
  ],
};

const SearchReadGroupSetsResponse$json = const {
  '1': 'SearchReadGroupSetsResponse',
  '2': const [
    const {'1': 'read_group_sets', '3': 1, '4': 3, '5': 11, '6': '.google.genomics.v1.ReadGroupSet'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const ImportReadGroupSetsRequest$json = const {
  '1': 'ImportReadGroupSetsRequest',
  '2': const [
    const {'1': 'dataset_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'reference_set_id', '3': 4, '4': 1, '5': 9},
    const {'1': 'source_uris', '3': 2, '4': 3, '5': 9},
    const {'1': 'partition_strategy', '3': 5, '4': 1, '5': 14, '6': '.google.genomics.v1.ImportReadGroupSetsRequest.PartitionStrategy'},
  ],
  '4': const [ImportReadGroupSetsRequest_PartitionStrategy$json],
};

const ImportReadGroupSetsRequest_PartitionStrategy$json = const {
  '1': 'PartitionStrategy',
  '2': const [
    const {'1': 'PARTITION_STRATEGY_UNSPECIFIED', '2': 0},
    const {'1': 'PER_FILE_PER_SAMPLE', '2': 1},
    const {'1': 'MERGE_ALL', '2': 2},
  ],
};

const ImportReadGroupSetsResponse$json = const {
  '1': 'ImportReadGroupSetsResponse',
  '2': const [
    const {'1': 'read_group_set_ids', '3': 1, '4': 3, '5': 9},
  ],
};

const ExportReadGroupSetRequest$json = const {
  '1': 'ExportReadGroupSetRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'export_uri', '3': 2, '4': 1, '5': 9},
    const {'1': 'read_group_set_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'reference_names', '3': 4, '4': 3, '5': 9},
  ],
};

const UpdateReadGroupSetRequest$json = const {
  '1': 'UpdateReadGroupSetRequest',
  '2': const [
    const {'1': 'read_group_set_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'read_group_set', '3': 2, '4': 1, '5': 11, '6': '.google.genomics.v1.ReadGroupSet'},
    const {'1': 'update_mask', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask'},
  ],
};

const DeleteReadGroupSetRequest$json = const {
  '1': 'DeleteReadGroupSetRequest',
  '2': const [
    const {'1': 'read_group_set_id', '3': 1, '4': 1, '5': 9},
  ],
};

const GetReadGroupSetRequest$json = const {
  '1': 'GetReadGroupSetRequest',
  '2': const [
    const {'1': 'read_group_set_id', '3': 1, '4': 1, '5': 9},
  ],
};

const ListCoverageBucketsRequest$json = const {
  '1': 'ListCoverageBucketsRequest',
  '2': const [
    const {'1': 'read_group_set_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'reference_name', '3': 3, '4': 1, '5': 9},
    const {'1': 'start', '3': 4, '4': 1, '5': 3},
    const {'1': 'end', '3': 5, '4': 1, '5': 3},
    const {'1': 'target_bucket_width', '3': 6, '4': 1, '5': 3},
    const {'1': 'page_token', '3': 7, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 8, '4': 1, '5': 5},
  ],
};

const CoverageBucket$json = const {
  '1': 'CoverageBucket',
  '2': const [
    const {'1': 'range', '3': 1, '4': 1, '5': 11, '6': '.google.genomics.v1.Range'},
    const {'1': 'mean_coverage', '3': 2, '4': 1, '5': 2},
  ],
};

const ListCoverageBucketsResponse$json = const {
  '1': 'ListCoverageBucketsResponse',
  '2': const [
    const {'1': 'bucket_width', '3': 1, '4': 1, '5': 3},
    const {'1': 'coverage_buckets', '3': 2, '4': 3, '5': 11, '6': '.google.genomics.v1.CoverageBucket'},
    const {'1': 'next_page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const SearchReadsRequest$json = const {
  '1': 'SearchReadsRequest',
  '2': const [
    const {'1': 'read_group_set_ids', '3': 1, '4': 3, '5': 9},
    const {'1': 'read_group_ids', '3': 5, '4': 3, '5': 9},
    const {'1': 'reference_name', '3': 7, '4': 1, '5': 9},
    const {'1': 'start', '3': 8, '4': 1, '5': 3},
    const {'1': 'end', '3': 9, '4': 1, '5': 3},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5},
  ],
};

const SearchReadsResponse$json = const {
  '1': 'SearchReadsResponse',
  '2': const [
    const {'1': 'alignments', '3': 1, '4': 3, '5': 11, '6': '.google.genomics.v1.Read'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const StreamReadsRequest$json = const {
  '1': 'StreamReadsRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'read_group_set_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'reference_name', '3': 3, '4': 1, '5': 9},
    const {'1': 'start', '3': 4, '4': 1, '5': 3},
    const {'1': 'end', '3': 5, '4': 1, '5': 3},
    const {'1': 'shard', '3': 6, '4': 1, '5': 5},
    const {'1': 'total_shards', '3': 7, '4': 1, '5': 5},
  ],
};

const StreamReadsResponse$json = const {
  '1': 'StreamReadsResponse',
  '2': const [
    const {'1': 'alignments', '3': 1, '4': 3, '5': 11, '6': '.google.genomics.v1.Read'},
  ],
};

const StreamingReadService$json = const {
  '1': 'StreamingReadService',
  '2': const [
    const {'1': 'StreamReads', '2': '.google.genomics.v1.StreamReadsRequest', '3': '.google.genomics.v1.StreamReadsResponse', '4': const {}},
  ],
};

const StreamingReadService$messageJson = const {
  '.google.genomics.v1.StreamReadsRequest': StreamReadsRequest$json,
  '.google.genomics.v1.StreamReadsResponse': StreamReadsResponse$json,
  '.google.genomics.v1.Read': Read$json,
  '.google.genomics.v1.LinearAlignment': LinearAlignment$json,
  '.google.genomics.v1.Position': Position$json,
  '.google.genomics.v1.CigarUnit': CigarUnit$json,
  '.google.genomics.v1.Read.InfoEntry': Read_InfoEntry$json,
  '.google.protobuf.ListValue': google$protobuf.ListValue$json,
  '.google.protobuf.Value': google$protobuf.Value$json,
  '.google.protobuf.Struct': google$protobuf.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': google$protobuf.Struct_FieldsEntry$json,
};

const ReadServiceV1$json = const {
  '1': 'ReadServiceV1',
  '2': const [
    const {'1': 'ImportReadGroupSets', '2': '.google.genomics.v1.ImportReadGroupSetsRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'ExportReadGroupSet', '2': '.google.genomics.v1.ExportReadGroupSetRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'SearchReadGroupSets', '2': '.google.genomics.v1.SearchReadGroupSetsRequest', '3': '.google.genomics.v1.SearchReadGroupSetsResponse', '4': const {}},
    const {'1': 'UpdateReadGroupSet', '2': '.google.genomics.v1.UpdateReadGroupSetRequest', '3': '.google.genomics.v1.ReadGroupSet', '4': const {}},
    const {'1': 'DeleteReadGroupSet', '2': '.google.genomics.v1.DeleteReadGroupSetRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'GetReadGroupSet', '2': '.google.genomics.v1.GetReadGroupSetRequest', '3': '.google.genomics.v1.ReadGroupSet', '4': const {}},
    const {'1': 'ListCoverageBuckets', '2': '.google.genomics.v1.ListCoverageBucketsRequest', '3': '.google.genomics.v1.ListCoverageBucketsResponse', '4': const {}},
    const {'1': 'SearchReads', '2': '.google.genomics.v1.SearchReadsRequest', '3': '.google.genomics.v1.SearchReadsResponse', '4': const {}},
  ],
};

const ReadServiceV1$messageJson = const {
  '.google.genomics.v1.ImportReadGroupSetsRequest': ImportReadGroupSetsRequest$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.genomics.v1.ExportReadGroupSetRequest': ExportReadGroupSetRequest$json,
  '.google.genomics.v1.SearchReadGroupSetsRequest': SearchReadGroupSetsRequest$json,
  '.google.genomics.v1.SearchReadGroupSetsResponse': SearchReadGroupSetsResponse$json,
  '.google.genomics.v1.ReadGroupSet': ReadGroupSet$json,
  '.google.genomics.v1.ReadGroup': ReadGroup$json,
  '.google.genomics.v1.ReadGroup.Experiment': ReadGroup_Experiment$json,
  '.google.genomics.v1.ReadGroup.Program': ReadGroup_Program$json,
  '.google.genomics.v1.ReadGroup.InfoEntry': ReadGroup_InfoEntry$json,
  '.google.protobuf.ListValue': google$protobuf.ListValue$json,
  '.google.protobuf.Value': google$protobuf.Value$json,
  '.google.protobuf.Struct': google$protobuf.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': google$protobuf.Struct_FieldsEntry$json,
  '.google.genomics.v1.ReadGroupSet.InfoEntry': ReadGroupSet_InfoEntry$json,
  '.google.genomics.v1.UpdateReadGroupSetRequest': UpdateReadGroupSetRequest$json,
  '.google.protobuf.FieldMask': google$protobuf.FieldMask$json,
  '.google.genomics.v1.DeleteReadGroupSetRequest': DeleteReadGroupSetRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.genomics.v1.GetReadGroupSetRequest': GetReadGroupSetRequest$json,
  '.google.genomics.v1.ListCoverageBucketsRequest': ListCoverageBucketsRequest$json,
  '.google.genomics.v1.ListCoverageBucketsResponse': ListCoverageBucketsResponse$json,
  '.google.genomics.v1.CoverageBucket': CoverageBucket$json,
  '.google.genomics.v1.Range': Range$json,
  '.google.genomics.v1.SearchReadsRequest': SearchReadsRequest$json,
  '.google.genomics.v1.SearchReadsResponse': SearchReadsResponse$json,
  '.google.genomics.v1.Read': Read$json,
  '.google.genomics.v1.LinearAlignment': LinearAlignment$json,
  '.google.genomics.v1.Position': Position$json,
  '.google.genomics.v1.CigarUnit': CigarUnit$json,
  '.google.genomics.v1.Read.InfoEntry': Read_InfoEntry$json,
};

