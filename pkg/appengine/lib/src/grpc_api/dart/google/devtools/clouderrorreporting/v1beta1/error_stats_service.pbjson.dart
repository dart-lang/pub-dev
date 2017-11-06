///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_error_stats_service_pbjson;

import '../../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import 'common.pbjson.dart';

const TimedCountAlignment$json = const {
  '1': 'TimedCountAlignment',
  '2': const [
    const {'1': 'ERROR_COUNT_ALIGNMENT_UNSPECIFIED', '2': 0},
    const {'1': 'ALIGNMENT_EQUAL_ROUNDED', '2': 1},
    const {'1': 'ALIGNMENT_EQUAL_AT_END', '2': 2},
  ],
};

const ErrorGroupOrder$json = const {
  '1': 'ErrorGroupOrder',
  '2': const [
    const {'1': 'GROUP_ORDER_UNSPECIFIED', '2': 0},
    const {'1': 'COUNT_DESC', '2': 1},
    const {'1': 'LAST_SEEN_DESC', '2': 2},
    const {'1': 'CREATED_DESC', '2': 3},
    const {'1': 'AFFECTED_USERS_DESC', '2': 4},
  ],
};

const ListGroupStatsRequest$json = const {
  '1': 'ListGroupStatsRequest',
  '2': const [
    const {'1': 'project_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'group_id', '3': 2, '4': 3, '5': 9},
    const {'1': 'service_filter', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ServiceContextFilter'},
    const {'1': 'time_range', '3': 5, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.QueryTimeRange'},
    const {'1': 'timed_count_duration', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'alignment', '3': 7, '4': 1, '5': 14, '6': '.google.devtools.clouderrorreporting.v1beta1.TimedCountAlignment'},
    const {'1': 'alignment_time', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'order', '3': 9, '4': 1, '5': 14, '6': '.google.devtools.clouderrorreporting.v1beta1.ErrorGroupOrder'},
    const {'1': 'page_size', '3': 11, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 12, '4': 1, '5': 9},
  ],
};

const ListGroupStatsResponse$json = const {
  '1': 'ListGroupStatsResponse',
  '2': const [
    const {'1': 'error_group_stats', '3': 1, '4': 3, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ErrorGroupStats'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'time_range_begin', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const ErrorGroupStats$json = const {
  '1': 'ErrorGroupStats',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ErrorGroup'},
    const {'1': 'count', '3': 2, '4': 1, '5': 3},
    const {'1': 'affected_users_count', '3': 3, '4': 1, '5': 3},
    const {'1': 'timed_counts', '3': 4, '4': 3, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.TimedCount'},
    const {'1': 'first_seen_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'last_seen_time', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'affected_services', '3': 7, '4': 3, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ServiceContext'},
    const {'1': 'num_affected_services', '3': 8, '4': 1, '5': 5},
    const {'1': 'representative', '3': 9, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ErrorEvent'},
  ],
};

const TimedCount$json = const {
  '1': 'TimedCount',
  '2': const [
    const {'1': 'count', '3': 1, '4': 1, '5': 3},
    const {'1': 'start_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const ListEventsRequest$json = const {
  '1': 'ListEventsRequest',
  '2': const [
    const {'1': 'project_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'service_filter', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ServiceContextFilter'},
    const {'1': 'time_range', '3': 4, '4': 1, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.QueryTimeRange'},
    const {'1': 'page_size', '3': 6, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 7, '4': 1, '5': 9},
  ],
};

const ListEventsResponse$json = const {
  '1': 'ListEventsResponse',
  '2': const [
    const {'1': 'error_events', '3': 1, '4': 3, '5': 11, '6': '.google.devtools.clouderrorreporting.v1beta1.ErrorEvent'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'time_range_begin', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const QueryTimeRange$json = const {
  '1': 'QueryTimeRange',
  '2': const [
    const {'1': 'period', '3': 1, '4': 1, '5': 14, '6': '.google.devtools.clouderrorreporting.v1beta1.QueryTimeRange.Period'},
  ],
  '4': const [QueryTimeRange_Period$json],
};

const QueryTimeRange_Period$json = const {
  '1': 'Period',
  '2': const [
    const {'1': 'PERIOD_UNSPECIFIED', '2': 0},
    const {'1': 'PERIOD_1_HOUR', '2': 1},
    const {'1': 'PERIOD_6_HOURS', '2': 2},
    const {'1': 'PERIOD_1_DAY', '2': 3},
    const {'1': 'PERIOD_1_WEEK', '2': 4},
    const {'1': 'PERIOD_30_DAYS', '2': 5},
  ],
};

const ServiceContextFilter$json = const {
  '1': 'ServiceContextFilter',
  '2': const [
    const {'1': 'service', '3': 2, '4': 1, '5': 9},
    const {'1': 'version', '3': 3, '4': 1, '5': 9},
    const {'1': 'resource_type', '3': 4, '4': 1, '5': 9},
  ],
};

const DeleteEventsRequest$json = const {
  '1': 'DeleteEventsRequest',
  '2': const [
    const {'1': 'project_name', '3': 1, '4': 1, '5': 9},
  ],
};

const DeleteEventsResponse$json = const {
  '1': 'DeleteEventsResponse',
};

const ErrorStatsService$json = const {
  '1': 'ErrorStatsService',
  '2': const [
    const {'1': 'ListGroupStats', '2': '.google.devtools.clouderrorreporting.v1beta1.ListGroupStatsRequest', '3': '.google.devtools.clouderrorreporting.v1beta1.ListGroupStatsResponse', '4': const {}},
    const {'1': 'ListEvents', '2': '.google.devtools.clouderrorreporting.v1beta1.ListEventsRequest', '3': '.google.devtools.clouderrorreporting.v1beta1.ListEventsResponse', '4': const {}},
    const {'1': 'DeleteEvents', '2': '.google.devtools.clouderrorreporting.v1beta1.DeleteEventsRequest', '3': '.google.devtools.clouderrorreporting.v1beta1.DeleteEventsResponse', '4': const {}},
  ],
};

const ErrorStatsService$messageJson = const {
  '.google.devtools.clouderrorreporting.v1beta1.ListGroupStatsRequest': ListGroupStatsRequest$json,
  '.google.devtools.clouderrorreporting.v1beta1.ServiceContextFilter': ServiceContextFilter$json,
  '.google.devtools.clouderrorreporting.v1beta1.QueryTimeRange': QueryTimeRange$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.devtools.clouderrorreporting.v1beta1.ListGroupStatsResponse': ListGroupStatsResponse$json,
  '.google.devtools.clouderrorreporting.v1beta1.ErrorGroupStats': ErrorGroupStats$json,
  '.google.devtools.clouderrorreporting.v1beta1.ErrorGroup': ErrorGroup$json,
  '.google.devtools.clouderrorreporting.v1beta1.TrackingIssue': TrackingIssue$json,
  '.google.devtools.clouderrorreporting.v1beta1.TimedCount': TimedCount$json,
  '.google.devtools.clouderrorreporting.v1beta1.ServiceContext': ServiceContext$json,
  '.google.devtools.clouderrorreporting.v1beta1.ErrorEvent': ErrorEvent$json,
  '.google.devtools.clouderrorreporting.v1beta1.ErrorContext': ErrorContext$json,
  '.google.devtools.clouderrorreporting.v1beta1.HttpRequestContext': HttpRequestContext$json,
  '.google.devtools.clouderrorreporting.v1beta1.SourceLocation': SourceLocation$json,
  '.google.devtools.clouderrorreporting.v1beta1.ListEventsRequest': ListEventsRequest$json,
  '.google.devtools.clouderrorreporting.v1beta1.ListEventsResponse': ListEventsResponse$json,
  '.google.devtools.clouderrorreporting.v1beta1.DeleteEventsRequest': DeleteEventsRequest$json,
  '.google.devtools.clouderrorreporting.v1beta1.DeleteEventsResponse': DeleteEventsResponse$json,
};

