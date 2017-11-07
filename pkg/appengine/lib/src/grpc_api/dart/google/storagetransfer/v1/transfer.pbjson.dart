///
//  Generated code. Do not modify.
///
library google.storagetransfer.v1_transfer_pbjson;

import 'transfer_types.pbjson.dart';
import '../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../type/date.pbjson.dart' as google$type;
import '../../type/timeofday.pbjson.dart' as google$type;
import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../protobuf/field_mask.pbjson.dart' as google$protobuf;
import '../../protobuf/empty.pbjson.dart' as google$protobuf;

const GetGoogleServiceAccountRequest$json = const {
  '1': 'GetGoogleServiceAccountRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateTransferJobRequest$json = const {
  '1': 'CreateTransferJobRequest',
  '2': const [
    const {'1': 'transfer_job', '3': 1, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.TransferJob'},
  ],
};

const UpdateTransferJobRequest$json = const {
  '1': 'UpdateTransferJobRequest',
  '2': const [
    const {'1': 'job_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'project_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'transfer_job', '3': 3, '4': 1, '5': 11, '6': '.google.storagetransfer.v1.TransferJob'},
    const {'1': 'update_transfer_job_field_mask', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask'},
  ],
};

const GetTransferJobRequest$json = const {
  '1': 'GetTransferJobRequest',
  '2': const [
    const {'1': 'job_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'project_id', '3': 2, '4': 1, '5': 9},
  ],
};

const ListTransferJobsRequest$json = const {
  '1': 'ListTransferJobsRequest',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 5, '4': 1, '5': 9},
  ],
};

const ListTransferJobsResponse$json = const {
  '1': 'ListTransferJobsResponse',
  '2': const [
    const {'1': 'transfer_jobs', '3': 1, '4': 3, '5': 11, '6': '.google.storagetransfer.v1.TransferJob'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const PauseTransferOperationRequest$json = const {
  '1': 'PauseTransferOperationRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ResumeTransferOperationRequest$json = const {
  '1': 'ResumeTransferOperationRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const StorageTransferService$json = const {
  '1': 'StorageTransferService',
  '2': const [
    const {'1': 'GetGoogleServiceAccount', '2': '.google.storagetransfer.v1.GetGoogleServiceAccountRequest', '3': '.google.storagetransfer.v1.GoogleServiceAccount', '4': const {}},
    const {'1': 'CreateTransferJob', '2': '.google.storagetransfer.v1.CreateTransferJobRequest', '3': '.google.storagetransfer.v1.TransferJob', '4': const {}},
    const {'1': 'UpdateTransferJob', '2': '.google.storagetransfer.v1.UpdateTransferJobRequest', '3': '.google.storagetransfer.v1.TransferJob', '4': const {}},
    const {'1': 'GetTransferJob', '2': '.google.storagetransfer.v1.GetTransferJobRequest', '3': '.google.storagetransfer.v1.TransferJob', '4': const {}},
    const {'1': 'ListTransferJobs', '2': '.google.storagetransfer.v1.ListTransferJobsRequest', '3': '.google.storagetransfer.v1.ListTransferJobsResponse', '4': const {}},
    const {'1': 'PauseTransferOperation', '2': '.google.storagetransfer.v1.PauseTransferOperationRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ResumeTransferOperation', '2': '.google.storagetransfer.v1.ResumeTransferOperationRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const StorageTransferService$messageJson = const {
  '.google.storagetransfer.v1.GetGoogleServiceAccountRequest': GetGoogleServiceAccountRequest$json,
  '.google.storagetransfer.v1.GoogleServiceAccount': GoogleServiceAccount$json,
  '.google.storagetransfer.v1.CreateTransferJobRequest': CreateTransferJobRequest$json,
  '.google.storagetransfer.v1.TransferJob': TransferJob$json,
  '.google.storagetransfer.v1.TransferSpec': TransferSpec$json,
  '.google.storagetransfer.v1.GcsData': GcsData$json,
  '.google.storagetransfer.v1.AwsS3Data': AwsS3Data$json,
  '.google.storagetransfer.v1.AwsAccessKey': AwsAccessKey$json,
  '.google.storagetransfer.v1.HttpData': HttpData$json,
  '.google.storagetransfer.v1.ObjectConditions': ObjectConditions$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.storagetransfer.v1.TransferOptions': TransferOptions$json,
  '.google.storagetransfer.v1.Schedule': Schedule$json,
  '.google.type.Date': google$type.Date$json,
  '.google.type.TimeOfDay': google$type.TimeOfDay$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.storagetransfer.v1.UpdateTransferJobRequest': UpdateTransferJobRequest$json,
  '.google.protobuf.FieldMask': google$protobuf.FieldMask$json,
  '.google.storagetransfer.v1.GetTransferJobRequest': GetTransferJobRequest$json,
  '.google.storagetransfer.v1.ListTransferJobsRequest': ListTransferJobsRequest$json,
  '.google.storagetransfer.v1.ListTransferJobsResponse': ListTransferJobsResponse$json,
  '.google.storagetransfer.v1.PauseTransferOperationRequest': PauseTransferOperationRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.storagetransfer.v1.ResumeTransferOperationRequest': ResumeTransferOperationRequest$json,
};

