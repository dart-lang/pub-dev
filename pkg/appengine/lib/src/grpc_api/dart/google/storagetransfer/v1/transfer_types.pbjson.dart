///
//  Generated code. Do not modify.
///
library google.storagetransfer.v1_transfer_types_pbjson;

const GoogleServiceAccount$json = const {
  '1': 'GoogleServiceAccount',
  '2': const [
    const {'1': 'account_email', '3': 1, '4': 1, '5': 9},
  ],
};

const AwsAccessKey$json = const {
  '1': 'AwsAccessKey',
  '2': const [
    const {'1': 'access_key_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'secret_access_key', '3': 2, '4': 1, '5': 9},
  ],
};

const ObjectConditions$json = const {
  '1': 'ObjectConditions',
  '2': const [
    const {'1': 'min_time_elapsed_since_last_modification', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'max_time_elapsed_since_last_modification', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'include_prefixes', '3': 3, '4': 3, '5': 9},
    const {'1': 'exclude_prefixes', '3': 4, '4': 3, '5': 9},
  ],
};

const GcsData$json = const {
  '1': 'GcsData',
  '2': const [
    const {'1': 'bucket_name', '3': 1, '4': 1, '5': 9},
  ],
};

const AwsS3Data$json = const {
  '1': 'AwsS3Data',
  '2': const [
    const {'1': 'bucket_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'aws_access_key', '3': 2, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.AwsAccessKey'},
  ],
};

const HttpData$json = const {
  '1': 'HttpData',
  '2': const [
    const {'1': 'list_url', '3': 1, '4': 1, '5': 9},
  ],
};

const TransferOptions$json = const {
  '1': 'TransferOptions',
  '2': const [
    const {'1': 'overwrite_objects_already_existing_in_sink', '3': 1, '4': 1, '5': 8},
    const {'1': 'delete_objects_unique_in_sink', '3': 2, '4': 1, '5': 8},
    const {'1': 'delete_objects_from_source_after_transfer', '3': 3, '4': 1, '5': 8},
  ],
};

const TransferSpec$json = const {
  '1': 'TransferSpec',
  '2': const [
    const {'1': 'gcs_data_source', '3': 1, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.GcsData'},
    const {'1': 'aws_s3_data_source', '3': 2, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.AwsS3Data'},
    const {'1': 'http_data_source', '3': 3, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.HttpData'},
    const {'1': 'gcs_data_sink', '3': 4, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.GcsData'},
    const {'1': 'object_conditions', '3': 5, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.ObjectConditions'},
    const {'1': 'transfer_options', '3': 6, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.TransferOptions'},
  ],
};

const Schedule$json = const {
  '1': 'Schedule',
  '2': const [
    const {'1': 'schedule_start_date', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date'},
    const {'1': 'schedule_end_date', '3': 2, '4': 1, '5': 11, '6': '.google.type.Date'},
    const {'1': 'start_time_of_day', '3': 3, '4': 1, '5': 11, '6': '.google.type.TimeOfDay'},
  ],
};

const TransferJob$json = const {
  '1': 'TransferJob',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
    const {'1': 'project_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'transfer_spec', '3': 4, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.TransferSpec'},
    const {'1': 'schedule', '3': 5, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.Schedule'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.google.storagetransfer.v1.TransferJob.Status'},
    const {'1': 'creation_time', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'last_modification_time', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'deletion_time', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
  '4': const [TransferJob_Status$json],
};

const TransferJob_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'ENABLED', '2': 1},
    const {'1': 'DISABLED', '2': 2},
    const {'1': 'DELETED', '2': 3},
  ],
};

const ErrorLogEntry$json = const {
  '1': 'ErrorLogEntry',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9},
    const {'1': 'error_details', '3': 3, '4': 3, '5': 9},
  ],
};

const ErrorSummary$json = const {
  '1': 'ErrorSummary',
  '2': const [
    const {'1': 'error_code', '3': 1, '4': 1, '5': 14, '6': '.google.rpc.Code'},
    const {'1': 'error_count', '3': 2, '4': 1, '5': 3},
    const {'1': 'error_log_entries', '3': 3, '4': 3, '5': 11, '6': '.google.storagetransfer.v1.ErrorLogEntry'},
  ],
};

const TransferCounters$json = const {
  '1': 'TransferCounters',
  '2': const [
    const {'1': 'objects_found_from_source', '3': 1, '4': 1, '5': 3},
    const {'1': 'bytes_found_from_source', '3': 2, '4': 1, '5': 3},
    const {'1': 'objects_found_only_from_sink', '3': 3, '4': 1, '5': 3},
    const {'1': 'bytes_found_only_from_sink', '3': 4, '4': 1, '5': 3},
    const {'1': 'objects_from_source_skipped_by_sync', '3': 5, '4': 1, '5': 3},
    const {'1': 'bytes_from_source_skipped_by_sync', '3': 6, '4': 1, '5': 3},
    const {'1': 'objects_copied_to_sink', '3': 7, '4': 1, '5': 3},
    const {'1': 'bytes_copied_to_sink', '3': 8, '4': 1, '5': 3},
    const {'1': 'objects_deleted_from_source', '3': 9, '4': 1, '5': 3},
    const {'1': 'bytes_deleted_from_source', '3': 10, '4': 1, '5': 3},
    const {'1': 'objects_deleted_from_sink', '3': 11, '4': 1, '5': 3},
    const {'1': 'bytes_deleted_from_sink', '3': 12, '4': 1, '5': 3},
    const {'1': 'objects_from_source_failed', '3': 13, '4': 1, '5': 3},
    const {'1': 'bytes_from_source_failed', '3': 14, '4': 1, '5': 3},
    const {'1': 'objects_failed_to_delete_from_sink', '3': 15, '4': 1, '5': 3},
    const {'1': 'bytes_failed_to_delete_from_sink', '3': 16, '4': 1, '5': 3},
  ],
};

const TransferOperation$json = const {
  '1': 'TransferOperation',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'project_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'transfer_spec', '3': 3, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.TransferSpec'},
    const {'1': 'start_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.google.storagetransfer.v1.TransferOperation.Status'},
    const {'1': 'counters', '3': 7, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.TransferCounters'},
    const {'1': 'error_breakdowns', '3': 8, '4': 3, '5': 11, '6': '.google.storagetransfer.v1.ErrorSummary'},
    const {'1': 'transfer_job_name', '3': 9, '4': 1, '5': 9},
  ],
  '4': const [TransferOperation_Status$json],
};

const TransferOperation_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'IN_PROGRESS', '2': 1},
    const {'1': 'PAUSED', '2': 2},
    const {'1': 'SUCCESS', '2': 3},
    const {'1': 'FAILED', '2': 4},
    const {'1': 'ABORTED', '2': 5},
  ],
};

