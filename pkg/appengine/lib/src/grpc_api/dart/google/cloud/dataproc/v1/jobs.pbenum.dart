///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_jobs_pbenum;

import 'package:protobuf/protobuf.dart';

class LoggingConfig_Level extends ProtobufEnum {
  static const LoggingConfig_Level LEVEL_UNSPECIFIED = const LoggingConfig_Level._(0, 'LEVEL_UNSPECIFIED');
  static const LoggingConfig_Level ALL = const LoggingConfig_Level._(1, 'ALL');
  static const LoggingConfig_Level TRACE = const LoggingConfig_Level._(2, 'TRACE');
  static const LoggingConfig_Level DEBUG = const LoggingConfig_Level._(3, 'DEBUG');
  static const LoggingConfig_Level INFO = const LoggingConfig_Level._(4, 'INFO');
  static const LoggingConfig_Level WARN = const LoggingConfig_Level._(5, 'WARN');
  static const LoggingConfig_Level ERROR = const LoggingConfig_Level._(6, 'ERROR');
  static const LoggingConfig_Level FATAL = const LoggingConfig_Level._(7, 'FATAL');
  static const LoggingConfig_Level OFF = const LoggingConfig_Level._(8, 'OFF');

  static const List<LoggingConfig_Level> values = const <LoggingConfig_Level> [
    LEVEL_UNSPECIFIED,
    ALL,
    TRACE,
    DEBUG,
    INFO,
    WARN,
    ERROR,
    FATAL,
    OFF,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static LoggingConfig_Level valueOf(int value) => _byValue[value] as LoggingConfig_Level;
  static void $checkItem(LoggingConfig_Level v) {
    if (v is !LoggingConfig_Level) checkItemFailed(v, 'LoggingConfig_Level');
  }

  const LoggingConfig_Level._(int v, String n) : super(v, n);
}

class JobStatus_State extends ProtobufEnum {
  static const JobStatus_State STATE_UNSPECIFIED = const JobStatus_State._(0, 'STATE_UNSPECIFIED');
  static const JobStatus_State PENDING = const JobStatus_State._(1, 'PENDING');
  static const JobStatus_State SETUP_DONE = const JobStatus_State._(8, 'SETUP_DONE');
  static const JobStatus_State RUNNING = const JobStatus_State._(2, 'RUNNING');
  static const JobStatus_State CANCEL_PENDING = const JobStatus_State._(3, 'CANCEL_PENDING');
  static const JobStatus_State CANCEL_STARTED = const JobStatus_State._(7, 'CANCEL_STARTED');
  static const JobStatus_State CANCELLED = const JobStatus_State._(4, 'CANCELLED');
  static const JobStatus_State DONE = const JobStatus_State._(5, 'DONE');
  static const JobStatus_State ERROR = const JobStatus_State._(6, 'ERROR');

  static const List<JobStatus_State> values = const <JobStatus_State> [
    STATE_UNSPECIFIED,
    PENDING,
    SETUP_DONE,
    RUNNING,
    CANCEL_PENDING,
    CANCEL_STARTED,
    CANCELLED,
    DONE,
    ERROR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static JobStatus_State valueOf(int value) => _byValue[value] as JobStatus_State;
  static void $checkItem(JobStatus_State v) {
    if (v is !JobStatus_State) checkItemFailed(v, 'JobStatus_State');
  }

  const JobStatus_State._(int v, String n) : super(v, n);
}

class ListJobsRequest_JobStateMatcher extends ProtobufEnum {
  static const ListJobsRequest_JobStateMatcher ALL = const ListJobsRequest_JobStateMatcher._(0, 'ALL');
  static const ListJobsRequest_JobStateMatcher ACTIVE = const ListJobsRequest_JobStateMatcher._(1, 'ACTIVE');
  static const ListJobsRequest_JobStateMatcher NON_ACTIVE = const ListJobsRequest_JobStateMatcher._(2, 'NON_ACTIVE');

  static const List<ListJobsRequest_JobStateMatcher> values = const <ListJobsRequest_JobStateMatcher> [
    ALL,
    ACTIVE,
    NON_ACTIVE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ListJobsRequest_JobStateMatcher valueOf(int value) => _byValue[value] as ListJobsRequest_JobStateMatcher;
  static void $checkItem(ListJobsRequest_JobStateMatcher v) {
    if (v is !ListJobsRequest_JobStateMatcher) checkItemFailed(v, 'ListJobsRequest_JobStateMatcher');
  }

  const ListJobsRequest_JobStateMatcher._(int v, String n) : super(v, n);
}

