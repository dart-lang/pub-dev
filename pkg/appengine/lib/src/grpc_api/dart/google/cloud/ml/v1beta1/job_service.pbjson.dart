///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_job_service_pbjson;

import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../../protobuf/empty.pbjson.dart' as google$protobuf;

const TrainingInput$json = const {
  '1': 'TrainingInput',
  '2': const [
    const {'1': 'scale_tier', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.ml.v1beta1.TrainingInput.ScaleTier'},
    const {'1': 'master_type', '3': 2, '4': 1, '5': 9},
    const {'1': 'worker_type', '3': 3, '4': 1, '5': 9},
    const {'1': 'parameter_server_type', '3': 4, '4': 1, '5': 9},
    const {'1': 'worker_count', '3': 5, '4': 1, '5': 3},
    const {'1': 'parameter_server_count', '3': 6, '4': 1, '5': 3},
    const {'1': 'package_uris', '3': 7, '4': 3, '5': 9},
    const {'1': 'python_module', '3': 8, '4': 1, '5': 9},
    const {'1': 'args', '3': 10, '4': 3, '5': 9},
    const {'1': 'hyperparameters', '3': 12, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.HyperparameterSpec'},
    const {'1': 'region', '3': 14, '4': 1, '5': 9},
  ],
  '4': const [TrainingInput_ScaleTier$json],
};

const TrainingInput_ScaleTier$json = const {
  '1': 'ScaleTier',
  '2': const [
    const {'1': 'BASIC', '2': 0},
    const {'1': 'STANDARD_1', '2': 1},
    const {'1': 'PREMIUM_1', '2': 3},
    const {'1': 'CUSTOM', '2': 5},
  ],
};

const HyperparameterSpec$json = const {
  '1': 'HyperparameterSpec',
  '2': const [
    const {'1': 'goal', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.ml.v1beta1.HyperparameterSpec.GoalType'},
    const {'1': 'params', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.ml.v1beta1.ParameterSpec'},
    const {'1': 'max_trials', '3': 3, '4': 1, '5': 5},
    const {'1': 'max_parallel_trials', '3': 4, '4': 1, '5': 5},
  ],
  '4': const [HyperparameterSpec_GoalType$json],
};

const HyperparameterSpec_GoalType$json = const {
  '1': 'GoalType',
  '2': const [
    const {'1': 'GOAL_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'MAXIMIZE', '2': 1},
    const {'1': 'MINIMIZE', '2': 2},
  ],
};

const ParameterSpec$json = const {
  '1': 'ParameterSpec',
  '2': const [
    const {'1': 'parameter_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.google.cloud.ml.v1beta1.ParameterSpec.ParameterType'},
    const {'1': 'min_value', '3': 2, '4': 1, '5': 1},
    const {'1': 'max_value', '3': 3, '4': 1, '5': 1},
    const {'1': 'categorical_values', '3': 5, '4': 3, '5': 9},
    const {'1': 'discrete_values', '3': 6, '4': 3, '5': 1},
    const {'1': 'scale_type', '3': 7, '4': 1, '5': 14, '6': '.google.cloud.ml.v1beta1.ParameterSpec.ScaleType'},
  ],
  '4': const [ParameterSpec_ParameterType$json, ParameterSpec_ScaleType$json],
};

const ParameterSpec_ParameterType$json = const {
  '1': 'ParameterType',
  '2': const [
    const {'1': 'PARAMETER_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'DOUBLE', '2': 1},
    const {'1': 'INTEGER', '2': 2},
    const {'1': 'CATEGORICAL', '2': 3},
    const {'1': 'DISCRETE', '2': 4},
  ],
};

const ParameterSpec_ScaleType$json = const {
  '1': 'ScaleType',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'UNIT_LINEAR_SCALE', '2': 1},
    const {'1': 'UNIT_LOG_SCALE', '2': 2},
    const {'1': 'UNIT_REVERSE_LOG_SCALE', '2': 3},
  ],
};

const HyperparameterOutput$json = const {
  '1': 'HyperparameterOutput',
  '2': const [
    const {'1': 'trial_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'hyperparameters', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.ml.v1beta1.HyperparameterOutput.HyperparametersEntry'},
    const {'1': 'final_metric', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.HyperparameterOutput.HyperparameterMetric'},
    const {'1': 'all_metrics', '3': 4, '4': 3, '5': 11, '6': '.google.cloud.ml.v1beta1.HyperparameterOutput.HyperparameterMetric'},
  ],
  '3': const [HyperparameterOutput_HyperparameterMetric$json, HyperparameterOutput_HyperparametersEntry$json],
};

const HyperparameterOutput_HyperparameterMetric$json = const {
  '1': 'HyperparameterMetric',
  '2': const [
    const {'1': 'training_step', '3': 1, '4': 1, '5': 3},
    const {'1': 'objective_value', '3': 2, '4': 1, '5': 1},
  ],
};

const HyperparameterOutput_HyperparametersEntry$json = const {
  '1': 'HyperparametersEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const TrainingOutput$json = const {
  '1': 'TrainingOutput',
  '2': const [
    const {'1': 'completed_trial_count', '3': 1, '4': 1, '5': 3},
    const {'1': 'trials', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.ml.v1beta1.HyperparameterOutput'},
  ],
};

const PredictionInput$json = const {
  '1': 'PredictionInput',
  '2': const [
    const {'1': 'model_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'version_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'data_format', '3': 3, '4': 1, '5': 14, '6': '.google.cloud.ml.v1beta1.PredictionInput.DataFormat'},
    const {'1': 'input_paths', '3': 4, '4': 3, '5': 9},
    const {'1': 'output_path', '3': 5, '4': 1, '5': 9},
    const {'1': 'max_worker_count', '3': 6, '4': 1, '5': 3},
    const {'1': 'region', '3': 7, '4': 1, '5': 9},
  ],
  '4': const [PredictionInput_DataFormat$json],
};

const PredictionInput_DataFormat$json = const {
  '1': 'DataFormat',
  '2': const [
    const {'1': 'DATA_FORMAT_UNSPECIFIED', '2': 0},
    const {'1': 'TEXT', '2': 1},
    const {'1': 'TF_RECORD', '2': 2},
    const {'1': 'TF_RECORD_GZIP', '2': 3},
  ],
};

const PredictionOutput$json = const {
  '1': 'PredictionOutput',
  '2': const [
    const {'1': 'output_path', '3': 1, '4': 1, '5': 9},
    const {'1': 'prediction_count', '3': 2, '4': 1, '5': 3},
    const {'1': 'error_count', '3': 3, '4': 1, '5': 3},
  ],
};

const Job$json = const {
  '1': 'Job',
  '2': const [
    const {'1': 'job_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'training_input', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.TrainingInput'},
    const {'1': 'prediction_input', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.PredictionInput'},
    const {'1': 'create_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'start_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'state', '3': 7, '4': 1, '5': 14, '6': '.google.cloud.ml.v1beta1.Job.State'},
    const {'1': 'error_message', '3': 8, '4': 1, '5': 9},
    const {'1': 'training_output', '3': 9, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.TrainingOutput'},
    const {'1': 'prediction_output', '3': 10, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.PredictionOutput'},
  ],
  '4': const [Job_State$json],
};

const Job_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'STATE_UNSPECIFIED', '2': 0},
    const {'1': 'QUEUED', '2': 1},
    const {'1': 'PREPARING', '2': 2},
    const {'1': 'RUNNING', '2': 3},
    const {'1': 'SUCCEEDED', '2': 4},
    const {'1': 'FAILED', '2': 5},
    const {'1': 'CANCELLING', '2': 6},
    const {'1': 'CANCELLED', '2': 7},
  ],
};

const CreateJobRequest$json = const {
  '1': 'CreateJobRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'job', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.Job'},
  ],
};

const ListJobsRequest$json = const {
  '1': 'ListJobsRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'filter', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 5, '4': 1, '5': 5},
  ],
};

const ListJobsResponse$json = const {
  '1': 'ListJobsResponse',
  '2': const [
    const {'1': 'jobs', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.ml.v1beta1.Job'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetJobRequest$json = const {
  '1': 'GetJobRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const CancelJobRequest$json = const {
  '1': 'CancelJobRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const JobService$json = const {
  '1': 'JobService',
  '2': const [
    const {'1': 'CreateJob', '2': '.google.cloud.ml.v1beta1.CreateJobRequest', '3': '.google.cloud.ml.v1beta1.Job', '4': const {}},
    const {'1': 'ListJobs', '2': '.google.cloud.ml.v1beta1.ListJobsRequest', '3': '.google.cloud.ml.v1beta1.ListJobsResponse', '4': const {}},
    const {'1': 'GetJob', '2': '.google.cloud.ml.v1beta1.GetJobRequest', '3': '.google.cloud.ml.v1beta1.Job', '4': const {}},
    const {'1': 'CancelJob', '2': '.google.cloud.ml.v1beta1.CancelJobRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const JobService$messageJson = const {
  '.google.cloud.ml.v1beta1.CreateJobRequest': CreateJobRequest$json,
  '.google.cloud.ml.v1beta1.Job': Job$json,
  '.google.cloud.ml.v1beta1.TrainingInput': TrainingInput$json,
  '.google.cloud.ml.v1beta1.HyperparameterSpec': HyperparameterSpec$json,
  '.google.cloud.ml.v1beta1.ParameterSpec': ParameterSpec$json,
  '.google.cloud.ml.v1beta1.PredictionInput': PredictionInput$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.cloud.ml.v1beta1.TrainingOutput': TrainingOutput$json,
  '.google.cloud.ml.v1beta1.HyperparameterOutput': HyperparameterOutput$json,
  '.google.cloud.ml.v1beta1.HyperparameterOutput.HyperparametersEntry': HyperparameterOutput_HyperparametersEntry$json,
  '.google.cloud.ml.v1beta1.HyperparameterOutput.HyperparameterMetric': HyperparameterOutput_HyperparameterMetric$json,
  '.google.cloud.ml.v1beta1.PredictionOutput': PredictionOutput$json,
  '.google.cloud.ml.v1beta1.ListJobsRequest': ListJobsRequest$json,
  '.google.cloud.ml.v1beta1.ListJobsResponse': ListJobsResponse$json,
  '.google.cloud.ml.v1beta1.GetJobRequest': GetJobRequest$json,
  '.google.cloud.ml.v1beta1.CancelJobRequest': CancelJobRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
};

