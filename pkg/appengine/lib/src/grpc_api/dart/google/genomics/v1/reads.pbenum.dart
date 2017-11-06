///
//  Generated code. Do not modify.
///
library google.genomics.v1_reads_pbenum;

import 'package:protobuf/protobuf.dart';

class ImportReadGroupSetsRequest_PartitionStrategy extends ProtobufEnum {
  static const ImportReadGroupSetsRequest_PartitionStrategy PARTITION_STRATEGY_UNSPECIFIED = const ImportReadGroupSetsRequest_PartitionStrategy._(0, 'PARTITION_STRATEGY_UNSPECIFIED');
  static const ImportReadGroupSetsRequest_PartitionStrategy PER_FILE_PER_SAMPLE = const ImportReadGroupSetsRequest_PartitionStrategy._(1, 'PER_FILE_PER_SAMPLE');
  static const ImportReadGroupSetsRequest_PartitionStrategy MERGE_ALL = const ImportReadGroupSetsRequest_PartitionStrategy._(2, 'MERGE_ALL');

  static const List<ImportReadGroupSetsRequest_PartitionStrategy> values = const <ImportReadGroupSetsRequest_PartitionStrategy> [
    PARTITION_STRATEGY_UNSPECIFIED,
    PER_FILE_PER_SAMPLE,
    MERGE_ALL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ImportReadGroupSetsRequest_PartitionStrategy valueOf(int value) => _byValue[value] as ImportReadGroupSetsRequest_PartitionStrategy;
  static void $checkItem(ImportReadGroupSetsRequest_PartitionStrategy v) {
    if (v is !ImportReadGroupSetsRequest_PartitionStrategy) checkItemFailed(v, 'ImportReadGroupSetsRequest_PartitionStrategy');
  }

  const ImportReadGroupSetsRequest_PartitionStrategy._(int v, String n) : super(v, n);
}

