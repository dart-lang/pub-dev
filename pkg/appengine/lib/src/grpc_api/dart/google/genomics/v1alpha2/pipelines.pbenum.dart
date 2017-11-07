///
//  Generated code. Do not modify.
///
library google.genomics.v1alpha2_pipelines_pbenum;

import 'package:protobuf/protobuf.dart';

class PipelineResources_Disk_Type extends ProtobufEnum {
  static const PipelineResources_Disk_Type TYPE_UNSPECIFIED = const PipelineResources_Disk_Type._(0, 'TYPE_UNSPECIFIED');
  static const PipelineResources_Disk_Type PERSISTENT_HDD = const PipelineResources_Disk_Type._(1, 'PERSISTENT_HDD');
  static const PipelineResources_Disk_Type PERSISTENT_SSD = const PipelineResources_Disk_Type._(2, 'PERSISTENT_SSD');
  static const PipelineResources_Disk_Type LOCAL_SSD = const PipelineResources_Disk_Type._(3, 'LOCAL_SSD');

  static const List<PipelineResources_Disk_Type> values = const <PipelineResources_Disk_Type> [
    TYPE_UNSPECIFIED,
    PERSISTENT_HDD,
    PERSISTENT_SSD,
    LOCAL_SSD,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PipelineResources_Disk_Type valueOf(int value) => _byValue[value] as PipelineResources_Disk_Type;
  static void $checkItem(PipelineResources_Disk_Type v) {
    if (v is !PipelineResources_Disk_Type) checkItemFailed(v, 'PipelineResources_Disk_Type');
  }

  const PipelineResources_Disk_Type._(int v, String n) : super(v, n);
}

