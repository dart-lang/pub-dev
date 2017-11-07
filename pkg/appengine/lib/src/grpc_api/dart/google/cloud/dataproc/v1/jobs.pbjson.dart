///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_jobs_pbjson;

import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../../protobuf/empty.pbjson.dart' as google$protobuf;

const LoggingConfig$json = const {
  '1': 'LoggingConfig',
  '2': const [
    const {'1': 'driver_log_levels', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.LoggingConfig.DriverLogLevelsEntry'},
  ],
  '3': const [LoggingConfig_DriverLogLevelsEntry$json],
  '4': const [LoggingConfig_Level$json],
};

const LoggingConfig_DriverLogLevelsEntry$json = const {
  '1': 'DriverLogLevelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.dataproc.v1.LoggingConfig.Level'},
  ],
  '7': const {},
};

const LoggingConfig_Level$json = const {
  '1': 'Level',
  '2': const [
    const {'1': 'LEVEL_UNSPECIFIED', '2': 0},
    const {'1': 'ALL', '2': 1},
    const {'1': 'TRACE', '2': 2},
    const {'1': 'DEBUG', '2': 3},
    const {'1': 'INFO', '2': 4},
    const {'1': 'WARN', '2': 5},
    const {'1': 'ERROR', '2': 6},
    const {'1': 'FATAL', '2': 7},
    const {'1': 'OFF', '2': 8},
  ],
};

const HadoopJob$json = const {
  '1': 'HadoopJob',
  '2': const [
    const {'1': 'main_jar_file_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'main_class', '3': 2, '4': 1, '5': 9},
    const {'1': 'args', '3': 3, '4': 3, '5': 9},
    const {'1': 'jar_file_uris', '3': 4, '4': 3, '5': 9},
    const {'1': 'file_uris', '3': 5, '4': 3, '5': 9},
    const {'1': 'archive_uris', '3': 6, '4': 3, '5': 9},
    const {'1': 'properties', '3': 7, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.HadoopJob.PropertiesEntry'},
    const {'1': 'logging_config', '3': 8, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.LoggingConfig'},
  ],
  '3': const [HadoopJob_PropertiesEntry$json],
};

const HadoopJob_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const SparkJob$json = const {
  '1': 'SparkJob',
  '2': const [
    const {'1': 'main_jar_file_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'main_class', '3': 2, '4': 1, '5': 9},
    const {'1': 'args', '3': 3, '4': 3, '5': 9},
    const {'1': 'jar_file_uris', '3': 4, '4': 3, '5': 9},
    const {'1': 'file_uris', '3': 5, '4': 3, '5': 9},
    const {'1': 'archive_uris', '3': 6, '4': 3, '5': 9},
    const {'1': 'properties', '3': 7, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.SparkJob.PropertiesEntry'},
    const {'1': 'logging_config', '3': 8, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.LoggingConfig'},
  ],
  '3': const [SparkJob_PropertiesEntry$json],
};

const SparkJob_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const PySparkJob$json = const {
  '1': 'PySparkJob',
  '2': const [
    const {'1': 'main_python_file_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'args', '3': 2, '4': 3, '5': 9},
    const {'1': 'python_file_uris', '3': 3, '4': 3, '5': 9},
    const {'1': 'jar_file_uris', '3': 4, '4': 3, '5': 9},
    const {'1': 'file_uris', '3': 5, '4': 3, '5': 9},
    const {'1': 'archive_uris', '3': 6, '4': 3, '5': 9},
    const {'1': 'properties', '3': 7, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.PySparkJob.PropertiesEntry'},
    const {'1': 'logging_config', '3': 8, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.LoggingConfig'},
  ],
  '3': const [PySparkJob_PropertiesEntry$json],
};

const PySparkJob_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const QueryList$json = const {
  '1': 'QueryList',
  '2': const [
    const {'1': 'queries', '3': 1, '4': 3, '5': 9},
  ],
};

const HiveJob$json = const {
  '1': 'HiveJob',
  '2': const [
    const {'1': 'query_file_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'query_list', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.QueryList'},
    const {'1': 'continue_on_failure', '3': 3, '4': 1, '5': 8},
    const {'1': 'script_variables', '3': 4, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.HiveJob.ScriptVariablesEntry'},
    const {'1': 'properties', '3': 5, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.HiveJob.PropertiesEntry'},
    const {'1': 'jar_file_uris', '3': 6, '4': 3, '5': 9},
  ],
  '3': const [HiveJob_ScriptVariablesEntry$json, HiveJob_PropertiesEntry$json],
};

const HiveJob_ScriptVariablesEntry$json = const {
  '1': 'ScriptVariablesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const HiveJob_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const SparkSqlJob$json = const {
  '1': 'SparkSqlJob',
  '2': const [
    const {'1': 'query_file_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'query_list', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.QueryList'},
    const {'1': 'script_variables', '3': 3, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.SparkSqlJob.ScriptVariablesEntry'},
    const {'1': 'properties', '3': 4, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.SparkSqlJob.PropertiesEntry'},
    const {'1': 'jar_file_uris', '3': 56, '4': 3, '5': 9},
    const {'1': 'logging_config', '3': 6, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.LoggingConfig'},
  ],
  '3': const [SparkSqlJob_ScriptVariablesEntry$json, SparkSqlJob_PropertiesEntry$json],
};

const SparkSqlJob_ScriptVariablesEntry$json = const {
  '1': 'ScriptVariablesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const SparkSqlJob_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const PigJob$json = const {
  '1': 'PigJob',
  '2': const [
    const {'1': 'query_file_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'query_list', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.QueryList'},
    const {'1': 'continue_on_failure', '3': 3, '4': 1, '5': 8},
    const {'1': 'script_variables', '3': 4, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.PigJob.ScriptVariablesEntry'},
    const {'1': 'properties', '3': 5, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.PigJob.PropertiesEntry'},
    const {'1': 'jar_file_uris', '3': 6, '4': 3, '5': 9},
    const {'1': 'logging_config', '3': 7, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.LoggingConfig'},
  ],
  '3': const [PigJob_ScriptVariablesEntry$json, PigJob_PropertiesEntry$json],
};

const PigJob_ScriptVariablesEntry$json = const {
  '1': 'ScriptVariablesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const PigJob_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const JobPlacement$json = const {
  '1': 'JobPlacement',
  '2': const [
    const {'1': 'cluster_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'cluster_uuid', '3': 2, '4': 1, '5': 9},
  ],
};

const JobStatus$json = const {
  '1': 'JobStatus',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.dataproc.v1.JobStatus.State'},
    const {'1': 'details', '3': 2, '4': 1, '5': 9},
    const {'1': 'state_start_time', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
  '4': const [JobStatus_State$json],
};

const JobStatus_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'STATE_UNSPECIFIED', '2': 0},
    const {'1': 'PENDING', '2': 1},
    const {'1': 'SETUP_DONE', '2': 8},
    const {'1': 'RUNNING', '2': 2},
    const {'1': 'CANCEL_PENDING', '2': 3},
    const {'1': 'CANCEL_STARTED', '2': 7},
    const {'1': 'CANCELLED', '2': 4},
    const {'1': 'DONE', '2': 5},
    const {'1': 'ERROR', '2': 6},
  ],
};

const JobReference$json = const {
  '1': 'JobReference',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'job_id', '3': 2, '4': 1, '5': 9},
  ],
};

const Job$json = const {
  '1': 'Job',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.JobReference'},
    const {'1': 'placement', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.JobPlacement'},
    const {'1': 'hadoop_job', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.HadoopJob'},
    const {'1': 'spark_job', '3': 4, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.SparkJob'},
    const {'1': 'pyspark_job', '3': 5, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.PySparkJob'},
    const {'1': 'hive_job', '3': 6, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.HiveJob'},
    const {'1': 'pig_job', '3': 7, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.PigJob'},
    const {'1': 'spark_sql_job', '3': 12, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.SparkSqlJob'},
    const {'1': 'status', '3': 8, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.JobStatus'},
    const {'1': 'status_history', '3': 13, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.JobStatus'},
    const {'1': 'driver_output_resource_uri', '3': 17, '4': 1, '5': 9},
    const {'1': 'driver_control_files_uri', '3': 15, '4': 1, '5': 9},
  ],
};

const SubmitJobRequest$json = const {
  '1': 'SubmitJobRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'job', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.Job'},
  ],
};

const GetJobRequest$json = const {
  '1': 'GetJobRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'job_id', '3': 2, '4': 1, '5': 9},
  ],
};

const ListJobsRequest$json = const {
  '1': 'ListJobsRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 6, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
    const {'1': 'cluster_name', '3': 4, '4': 1, '5': 9},
    const {'1': 'job_state_matcher', '3': 5, '4': 1, '5': 14, '6': '.google.cloud.dataproc.v1.ListJobsRequest.JobStateMatcher'},
  ],
  '4': const [ListJobsRequest_JobStateMatcher$json],
};

const ListJobsRequest_JobStateMatcher$json = const {
  '1': 'JobStateMatcher',
  '2': const [
    const {'1': 'ALL', '2': 0},
    const {'1': 'ACTIVE', '2': 1},
    const {'1': 'NON_ACTIVE', '2': 2},
  ],
};

const ListJobsResponse$json = const {
  '1': 'ListJobsResponse',
  '2': const [
    const {'1': 'jobs', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.Job'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const CancelJobRequest$json = const {
  '1': 'CancelJobRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'job_id', '3': 2, '4': 1, '5': 9},
  ],
};

const DeleteJobRequest$json = const {
  '1': 'DeleteJobRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'job_id', '3': 2, '4': 1, '5': 9},
  ],
};

const JobController$json = const {
  '1': 'JobController',
  '2': const [
    const {'1': 'SubmitJob', '2': '.google.cloud.dataproc.v1.SubmitJobRequest', '3': '.google.cloud.dataproc.v1.Job', '4': const {}},
    const {'1': 'GetJob', '2': '.google.cloud.dataproc.v1.GetJobRequest', '3': '.google.cloud.dataproc.v1.Job', '4': const {}},
    const {'1': 'ListJobs', '2': '.google.cloud.dataproc.v1.ListJobsRequest', '3': '.google.cloud.dataproc.v1.ListJobsResponse', '4': const {}},
    const {'1': 'CancelJob', '2': '.google.cloud.dataproc.v1.CancelJobRequest', '3': '.google.cloud.dataproc.v1.Job', '4': const {}},
    const {'1': 'DeleteJob', '2': '.google.cloud.dataproc.v1.DeleteJobRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const JobController$messageJson = const {
  '.google.cloud.dataproc.v1.SubmitJobRequest': SubmitJobRequest$json,
  '.google.cloud.dataproc.v1.Job': Job$json,
  '.google.cloud.dataproc.v1.JobReference': JobReference$json,
  '.google.cloud.dataproc.v1.JobPlacement': JobPlacement$json,
  '.google.cloud.dataproc.v1.HadoopJob': HadoopJob$json,
  '.google.cloud.dataproc.v1.HadoopJob.PropertiesEntry': HadoopJob_PropertiesEntry$json,
  '.google.cloud.dataproc.v1.LoggingConfig': LoggingConfig$json,
  '.google.cloud.dataproc.v1.LoggingConfig.DriverLogLevelsEntry': LoggingConfig_DriverLogLevelsEntry$json,
  '.google.cloud.dataproc.v1.SparkJob': SparkJob$json,
  '.google.cloud.dataproc.v1.SparkJob.PropertiesEntry': SparkJob_PropertiesEntry$json,
  '.google.cloud.dataproc.v1.PySparkJob': PySparkJob$json,
  '.google.cloud.dataproc.v1.PySparkJob.PropertiesEntry': PySparkJob_PropertiesEntry$json,
  '.google.cloud.dataproc.v1.HiveJob': HiveJob$json,
  '.google.cloud.dataproc.v1.QueryList': QueryList$json,
  '.google.cloud.dataproc.v1.HiveJob.ScriptVariablesEntry': HiveJob_ScriptVariablesEntry$json,
  '.google.cloud.dataproc.v1.HiveJob.PropertiesEntry': HiveJob_PropertiesEntry$json,
  '.google.cloud.dataproc.v1.PigJob': PigJob$json,
  '.google.cloud.dataproc.v1.PigJob.ScriptVariablesEntry': PigJob_ScriptVariablesEntry$json,
  '.google.cloud.dataproc.v1.PigJob.PropertiesEntry': PigJob_PropertiesEntry$json,
  '.google.cloud.dataproc.v1.JobStatus': JobStatus$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.cloud.dataproc.v1.SparkSqlJob': SparkSqlJob$json,
  '.google.cloud.dataproc.v1.SparkSqlJob.ScriptVariablesEntry': SparkSqlJob_ScriptVariablesEntry$json,
  '.google.cloud.dataproc.v1.SparkSqlJob.PropertiesEntry': SparkSqlJob_PropertiesEntry$json,
  '.google.cloud.dataproc.v1.GetJobRequest': GetJobRequest$json,
  '.google.cloud.dataproc.v1.ListJobsRequest': ListJobsRequest$json,
  '.google.cloud.dataproc.v1.ListJobsResponse': ListJobsResponse$json,
  '.google.cloud.dataproc.v1.CancelJobRequest': CancelJobRequest$json,
  '.google.cloud.dataproc.v1.DeleteJobRequest': DeleteJobRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
};

