///
//  Generated code. Do not modify.
///
library google.genomics.v1alpha2_pipelines_pbjson;

import '../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../rpc/status.pbjson.dart' as google$rpc;
import '../../protobuf/empty.pbjson.dart' as google$protobuf;
import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;

const ComputeEngine$json = const {
  '1': 'ComputeEngine',
  '2': const [
    const {'1': 'instance_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'machine_type', '3': 3, '4': 1, '5': 9},
    const {'1': 'disk_names', '3': 4, '4': 3, '5': 9},
  ],
};

const RuntimeMetadata$json = const {
  '1': 'RuntimeMetadata',
  '2': const [
    const {'1': 'compute_engine', '3': 1, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.ComputeEngine'},
  ],
};

const Pipeline$json = const {
  '1': 'Pipeline',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'name', '3': 2, '4': 1, '5': 9},
    const {'1': 'description', '3': 3, '4': 1, '5': 9},
    const {'1': 'input_parameters', '3': 8, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.PipelineParameter'},
    const {'1': 'output_parameters', '3': 9, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.PipelineParameter'},
    const {'1': 'docker', '3': 5, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.DockerExecutor'},
    const {'1': 'resources', '3': 6, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.PipelineResources'},
    const {'1': 'pipeline_id', '3': 7, '4': 1, '5': 9},
  ],
};

const CreatePipelineRequest$json = const {
  '1': 'CreatePipelineRequest',
  '2': const [
    const {'1': 'pipeline', '3': 1, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.Pipeline'},
  ],
};

const RunPipelineArgs$json = const {
  '1': 'RunPipelineArgs',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'inputs', '3': 2, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.RunPipelineArgs.InputsEntry'},
    const {'1': 'outputs', '3': 3, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.RunPipelineArgs.OutputsEntry'},
    const {'1': 'service_account', '3': 4, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.ServiceAccount'},
    const {'1': 'client_id', '3': 5, '4': 1, '5': 9},
    const {'1': 'resources', '3': 6, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.PipelineResources'},
    const {'1': 'logging', '3': 7, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.LoggingOptions'},
    const {'1': 'keep_vm_alive_on_failure_duration', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'labels', '3': 9, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.RunPipelineArgs.LabelsEntry'},
  ],
  '3': const [RunPipelineArgs_InputsEntry$json, RunPipelineArgs_OutputsEntry$json, RunPipelineArgs_LabelsEntry$json],
};

const RunPipelineArgs_InputsEntry$json = const {
  '1': 'InputsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const RunPipelineArgs_OutputsEntry$json = const {
  '1': 'OutputsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const RunPipelineArgs_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const RunPipelineRequest$json = const {
  '1': 'RunPipelineRequest',
  '2': const [
    const {'1': 'pipeline_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'ephemeral_pipeline', '3': 2, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.Pipeline'},
    const {'1': 'pipeline_args', '3': 3, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.RunPipelineArgs'},
  ],
};

const GetPipelineRequest$json = const {
  '1': 'GetPipelineRequest',
  '2': const [
    const {'1': 'pipeline_id', '3': 1, '4': 1, '5': 9},
  ],
};

const ListPipelinesRequest$json = const {
  '1': 'ListPipelinesRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'name_prefix', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9},
  ],
};

const ListPipelinesResponse$json = const {
  '1': 'ListPipelinesResponse',
  '2': const [
    const {'1': 'pipelines', '3': 1, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.Pipeline'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const DeletePipelineRequest$json = const {
  '1': 'DeletePipelineRequest',
  '2': const [
    const {'1': 'pipeline_id', '3': 1, '4': 1, '5': 9},
  ],
};

const GetControllerConfigRequest$json = const {
  '1': 'GetControllerConfigRequest',
  '2': const [
    const {'1': 'operation_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'validation_token', '3': 2, '4': 1, '5': 4},
  ],
};

const ControllerConfig$json = const {
  '1': 'ControllerConfig',
  '2': const [
    const {'1': 'image', '3': 1, '4': 1, '5': 9},
    const {'1': 'cmd', '3': 2, '4': 1, '5': 9},
    const {'1': 'gcs_log_path', '3': 3, '4': 1, '5': 9},
    const {'1': 'machine_type', '3': 4, '4': 1, '5': 9},
    const {'1': 'vars', '3': 5, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.ControllerConfig.VarsEntry'},
    const {'1': 'disks', '3': 6, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.ControllerConfig.DisksEntry'},
    const {'1': 'gcs_sources', '3': 7, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.ControllerConfig.GcsSourcesEntry'},
    const {'1': 'gcs_sinks', '3': 8, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.ControllerConfig.GcsSinksEntry'},
  ],
  '3': const [ControllerConfig_RepeatedString$json, ControllerConfig_VarsEntry$json, ControllerConfig_DisksEntry$json, ControllerConfig_GcsSourcesEntry$json, ControllerConfig_GcsSinksEntry$json],
};

const ControllerConfig_RepeatedString$json = const {
  '1': 'RepeatedString',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 9},
  ],
};

const ControllerConfig_VarsEntry$json = const {
  '1': 'VarsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const ControllerConfig_DisksEntry$json = const {
  '1': 'DisksEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const ControllerConfig_GcsSourcesEntry$json = const {
  '1': 'GcsSourcesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.ControllerConfig.RepeatedString'},
  ],
  '7': const {},
};

const ControllerConfig_GcsSinksEntry$json = const {
  '1': 'GcsSinksEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.ControllerConfig.RepeatedString'},
  ],
  '7': const {},
};

const TimestampEvent$json = const {
  '1': 'TimestampEvent',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const SetOperationStatusRequest$json = const {
  '1': 'SetOperationStatusRequest',
  '2': const [
    const {'1': 'operation_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'timestamp_events', '3': 2, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.TimestampEvent'},
    const {'1': 'error_code', '3': 3, '4': 1, '5': 14, '6': '.google.rpc.Code'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9},
    const {'1': 'validation_token', '3': 5, '4': 1, '5': 4},
  ],
};

const ServiceAccount$json = const {
  '1': 'ServiceAccount',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9},
    const {'1': 'scopes', '3': 2, '4': 3, '5': 9},
  ],
};

const LoggingOptions$json = const {
  '1': 'LoggingOptions',
  '2': const [
    const {'1': 'gcs_path', '3': 1, '4': 1, '5': 9},
  ],
};

const PipelineResources$json = const {
  '1': 'PipelineResources',
  '2': const [
    const {'1': 'minimum_cpu_cores', '3': 1, '4': 1, '5': 5},
    const {'1': 'preemptible', '3': 2, '4': 1, '5': 8},
    const {'1': 'minimum_ram_gb', '3': 3, '4': 1, '5': 1},
    const {'1': 'disks', '3': 4, '4': 3, '5': 11, '6': '.google.genomics.v1alpha2.PipelineResources.Disk'},
    const {'1': 'zones', '3': 5, '4': 3, '5': 9},
    const {'1': 'boot_disk_size_gb', '3': 6, '4': 1, '5': 5},
    const {'1': 'no_address', '3': 7, '4': 1, '5': 8},
  ],
  '3': const [PipelineResources_Disk$json],
};

const PipelineResources_Disk$json = const {
  '1': 'Disk',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.google.genomics.v1alpha2.PipelineResources.Disk.Type'},
    const {'1': 'size_gb', '3': 3, '4': 1, '5': 5},
    const {'1': 'source', '3': 4, '4': 1, '5': 9},
    const {'1': 'auto_delete', '3': 6, '4': 1, '5': 8},
    const {'1': 'mount_point', '3': 8, '4': 1, '5': 9},
  ],
  '4': const [PipelineResources_Disk_Type$json],
};

const PipelineResources_Disk_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'PERSISTENT_HDD', '2': 1},
    const {'1': 'PERSISTENT_SSD', '2': 2},
    const {'1': 'LOCAL_SSD', '2': 3},
  ],
};

const PipelineParameter$json = const {
  '1': 'PipelineParameter',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
    const {'1': 'default_value', '3': 5, '4': 1, '5': 9},
    const {'1': 'local_copy', '3': 6, '4': 1, '5': 11, '6': '.google.genomics.v1alpha2.PipelineParameter.LocalCopy'},
  ],
  '3': const [PipelineParameter_LocalCopy$json],
};

const PipelineParameter_LocalCopy$json = const {
  '1': 'LocalCopy',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9},
    const {'1': 'disk', '3': 2, '4': 1, '5': 9},
  ],
};

const DockerExecutor$json = const {
  '1': 'DockerExecutor',
  '2': const [
    const {'1': 'image_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'cmd', '3': 2, '4': 1, '5': 9},
  ],
};

const PipelinesV1Alpha2$json = const {
  '1': 'PipelinesV1Alpha2',
  '2': const [
    const {'1': 'CreatePipeline', '2': '.google.genomics.v1alpha2.CreatePipelineRequest', '3': '.google.genomics.v1alpha2.Pipeline', '4': const {}},
    const {'1': 'RunPipeline', '2': '.google.genomics.v1alpha2.RunPipelineRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'GetPipeline', '2': '.google.genomics.v1alpha2.GetPipelineRequest', '3': '.google.genomics.v1alpha2.Pipeline', '4': const {}},
    const {'1': 'ListPipelines', '2': '.google.genomics.v1alpha2.ListPipelinesRequest', '3': '.google.genomics.v1alpha2.ListPipelinesResponse', '4': const {}},
    const {'1': 'DeletePipeline', '2': '.google.genomics.v1alpha2.DeletePipelineRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'GetControllerConfig', '2': '.google.genomics.v1alpha2.GetControllerConfigRequest', '3': '.google.genomics.v1alpha2.ControllerConfig', '4': const {}},
    const {'1': 'SetOperationStatus', '2': '.google.genomics.v1alpha2.SetOperationStatusRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const PipelinesV1Alpha2$messageJson = const {
  '.google.genomics.v1alpha2.CreatePipelineRequest': CreatePipelineRequest$json,
  '.google.genomics.v1alpha2.Pipeline': Pipeline$json,
  '.google.genomics.v1alpha2.DockerExecutor': DockerExecutor$json,
  '.google.genomics.v1alpha2.PipelineResources': PipelineResources$json,
  '.google.genomics.v1alpha2.PipelineResources.Disk': PipelineResources_Disk$json,
  '.google.genomics.v1alpha2.PipelineParameter': PipelineParameter$json,
  '.google.genomics.v1alpha2.PipelineParameter.LocalCopy': PipelineParameter_LocalCopy$json,
  '.google.genomics.v1alpha2.RunPipelineRequest': RunPipelineRequest$json,
  '.google.genomics.v1alpha2.RunPipelineArgs': RunPipelineArgs$json,
  '.google.genomics.v1alpha2.RunPipelineArgs.InputsEntry': RunPipelineArgs_InputsEntry$json,
  '.google.genomics.v1alpha2.RunPipelineArgs.OutputsEntry': RunPipelineArgs_OutputsEntry$json,
  '.google.genomics.v1alpha2.ServiceAccount': ServiceAccount$json,
  '.google.genomics.v1alpha2.LoggingOptions': LoggingOptions$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.genomics.v1alpha2.RunPipelineArgs.LabelsEntry': RunPipelineArgs_LabelsEntry$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.genomics.v1alpha2.GetPipelineRequest': GetPipelineRequest$json,
  '.google.genomics.v1alpha2.ListPipelinesRequest': ListPipelinesRequest$json,
  '.google.genomics.v1alpha2.ListPipelinesResponse': ListPipelinesResponse$json,
  '.google.genomics.v1alpha2.DeletePipelineRequest': DeletePipelineRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.genomics.v1alpha2.GetControllerConfigRequest': GetControllerConfigRequest$json,
  '.google.genomics.v1alpha2.ControllerConfig': ControllerConfig$json,
  '.google.genomics.v1alpha2.ControllerConfig.VarsEntry': ControllerConfig_VarsEntry$json,
  '.google.genomics.v1alpha2.ControllerConfig.DisksEntry': ControllerConfig_DisksEntry$json,
  '.google.genomics.v1alpha2.ControllerConfig.GcsSourcesEntry': ControllerConfig_GcsSourcesEntry$json,
  '.google.genomics.v1alpha2.ControllerConfig.RepeatedString': ControllerConfig_RepeatedString$json,
  '.google.genomics.v1alpha2.ControllerConfig.GcsSinksEntry': ControllerConfig_GcsSinksEntry$json,
  '.google.genomics.v1alpha2.SetOperationStatusRequest': SetOperationStatusRequest$json,
  '.google.genomics.v1alpha2.TimestampEvent': TimestampEvent$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
};

