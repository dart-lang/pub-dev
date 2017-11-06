///
//  Generated code. Do not modify.
///
library google.genomics.v1_variants_pbenum;

import 'package:protobuf/protobuf.dart';

class InfoMergeOperation extends ProtobufEnum {
  static const InfoMergeOperation INFO_MERGE_OPERATION_UNSPECIFIED = const InfoMergeOperation._(0, 'INFO_MERGE_OPERATION_UNSPECIFIED');
  static const InfoMergeOperation IGNORE_NEW = const InfoMergeOperation._(1, 'IGNORE_NEW');
  static const InfoMergeOperation MOVE_TO_CALLS = const InfoMergeOperation._(2, 'MOVE_TO_CALLS');

  static const List<InfoMergeOperation> values = const <InfoMergeOperation> [
    INFO_MERGE_OPERATION_UNSPECIFIED,
    IGNORE_NEW,
    MOVE_TO_CALLS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static InfoMergeOperation valueOf(int value) => _byValue[value] as InfoMergeOperation;
  static void $checkItem(InfoMergeOperation v) {
    if (v is !InfoMergeOperation) checkItemFailed(v, 'InfoMergeOperation');
  }

  const InfoMergeOperation._(int v, String n) : super(v, n);
}

class VariantSetMetadata_Type extends ProtobufEnum {
  static const VariantSetMetadata_Type TYPE_UNSPECIFIED = const VariantSetMetadata_Type._(0, 'TYPE_UNSPECIFIED');
  static const VariantSetMetadata_Type INTEGER = const VariantSetMetadata_Type._(1, 'INTEGER');
  static const VariantSetMetadata_Type FLOAT = const VariantSetMetadata_Type._(2, 'FLOAT');
  static const VariantSetMetadata_Type FLAG = const VariantSetMetadata_Type._(3, 'FLAG');
  static const VariantSetMetadata_Type CHARACTER = const VariantSetMetadata_Type._(4, 'CHARACTER');
  static const VariantSetMetadata_Type STRING = const VariantSetMetadata_Type._(5, 'STRING');

  static const List<VariantSetMetadata_Type> values = const <VariantSetMetadata_Type> [
    TYPE_UNSPECIFIED,
    INTEGER,
    FLOAT,
    FLAG,
    CHARACTER,
    STRING,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static VariantSetMetadata_Type valueOf(int value) => _byValue[value] as VariantSetMetadata_Type;
  static void $checkItem(VariantSetMetadata_Type v) {
    if (v is !VariantSetMetadata_Type) checkItemFailed(v, 'VariantSetMetadata_Type');
  }

  const VariantSetMetadata_Type._(int v, String n) : super(v, n);
}

class ImportVariantsRequest_Format extends ProtobufEnum {
  static const ImportVariantsRequest_Format FORMAT_UNSPECIFIED = const ImportVariantsRequest_Format._(0, 'FORMAT_UNSPECIFIED');
  static const ImportVariantsRequest_Format FORMAT_VCF = const ImportVariantsRequest_Format._(1, 'FORMAT_VCF');
  static const ImportVariantsRequest_Format FORMAT_COMPLETE_GENOMICS = const ImportVariantsRequest_Format._(2, 'FORMAT_COMPLETE_GENOMICS');

  static const List<ImportVariantsRequest_Format> values = const <ImportVariantsRequest_Format> [
    FORMAT_UNSPECIFIED,
    FORMAT_VCF,
    FORMAT_COMPLETE_GENOMICS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ImportVariantsRequest_Format valueOf(int value) => _byValue[value] as ImportVariantsRequest_Format;
  static void $checkItem(ImportVariantsRequest_Format v) {
    if (v is !ImportVariantsRequest_Format) checkItemFailed(v, 'ImportVariantsRequest_Format');
  }

  const ImportVariantsRequest_Format._(int v, String n) : super(v, n);
}

class ExportVariantSetRequest_Format extends ProtobufEnum {
  static const ExportVariantSetRequest_Format FORMAT_UNSPECIFIED = const ExportVariantSetRequest_Format._(0, 'FORMAT_UNSPECIFIED');
  static const ExportVariantSetRequest_Format FORMAT_BIGQUERY = const ExportVariantSetRequest_Format._(1, 'FORMAT_BIGQUERY');

  static const List<ExportVariantSetRequest_Format> values = const <ExportVariantSetRequest_Format> [
    FORMAT_UNSPECIFIED,
    FORMAT_BIGQUERY,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ExportVariantSetRequest_Format valueOf(int value) => _byValue[value] as ExportVariantSetRequest_Format;
  static void $checkItem(ExportVariantSetRequest_Format v) {
    if (v is !ExportVariantSetRequest_Format) checkItemFailed(v, 'ExportVariantSetRequest_Format');
  }

  const ExportVariantSetRequest_Format._(int v, String n) : super(v, n);
}

