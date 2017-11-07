///
//  Generated code. Do not modify.
///
library google.tracing.v1_trace_pbjson;

const TraceId$json = const {
  '1': 'TraceId',
  '2': const [
    const {'1': 'hex_encoded', '3': 1, '4': 1, '5': 9},
  ],
};

const Module$json = const {
  '1': 'Module',
  '2': const [
    const {'1': 'module', '3': 1, '4': 1, '5': 9},
    const {'1': 'build_id', '3': 2, '4': 1, '5': 9},
  ],
};

const StackTrace$json = const {
  '1': 'StackTrace',
  '2': const [
    const {'1': 'stack_frame', '3': 1, '4': 3, '5': 11, '6': '.google.tracing.v1.StackTrace.StackFrame'},
    const {'1': 'stack_trace_hash_id', '3': 2, '4': 1, '5': 4},
  ],
  '3': const [StackTrace_StackFrame$json],
};

const StackTrace_StackFrame$json = const {
  '1': 'StackFrame',
  '2': const [
    const {'1': 'function_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'orig_function_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'file_name', '3': 3, '4': 1, '5': 9},
    const {'1': 'line_number', '3': 4, '4': 1, '5': 3},
    const {'1': 'column_number', '3': 5, '4': 1, '5': 3},
    const {'1': 'load_module', '3': 6, '4': 1, '5': 11, '6': '.google.tracing.v1.Module'},
    const {'1': 'source_version', '3': 7, '4': 1, '5': 9},
  ],
};

const LabelValue$json = const {
  '1': 'LabelValue',
  '2': const [
    const {'1': 'string_value', '3': 1, '4': 1, '5': 9},
    const {'1': 'int_value', '3': 2, '4': 1, '5': 3},
    const {'1': 'bool_value', '3': 3, '4': 1, '5': 8},
  ],
};

const Span$json = const {
  '1': 'Span',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 6},
    const {'1': 'name', '3': 2, '4': 1, '5': 9},
    const {'1': 'parent_id', '3': 3, '4': 1, '5': 6},
    const {'1': 'local_start_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'local_end_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'labels', '3': 6, '4': 3, '5': 11, '6': '.google.tracing.v1.Span.LabelsEntry'},
    const {'1': 'stack_trace', '3': 7, '4': 1, '5': 11, '6': '.google.tracing.v1.StackTrace'},
    const {'1': 'time_events', '3': 8, '4': 3, '5': 11, '6': '.google.tracing.v1.Span.TimeEvent'},
    const {'1': 'links', '3': 9, '4': 3, '5': 11, '6': '.google.tracing.v1.Span.Link'},
    const {'1': 'status', '3': 10, '4': 1, '5': 11, '6': '.google.rpc.Status'},
    const {'1': 'has_remote_parent', '3': 11, '4': 1, '5': 8},
  ],
  '3': const [Span_TimeEvent$json, Span_Link$json, Span_LabelsEntry$json],
};

const Span_TimeEvent$json = const {
  '1': 'TimeEvent',
  '2': const [
    const {'1': 'local_time', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'annotation', '3': 2, '4': 1, '5': 11, '6': '.google.tracing.v1.Span.TimeEvent.Annotation'},
    const {'1': 'network_event', '3': 3, '4': 1, '5': 11, '6': '.google.tracing.v1.Span.TimeEvent.NetworkEvent'},
  ],
  '3': const [Span_TimeEvent_Annotation$json, Span_TimeEvent_NetworkEvent$json],
};

const Span_TimeEvent_Annotation$json = const {
  '1': 'Annotation',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9},
    const {'1': 'labels', '3': 2, '4': 3, '5': 11, '6': '.google.tracing.v1.Span.TimeEvent.Annotation.LabelsEntry'},
  ],
  '3': const [Span_TimeEvent_Annotation_LabelsEntry$json],
};

const Span_TimeEvent_Annotation_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.tracing.v1.LabelValue'},
  ],
  '7': const {},
};

const Span_TimeEvent_NetworkEvent$json = const {
  '1': 'NetworkEvent',
  '2': const [
    const {'1': 'kernel_time', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.google.tracing.v1.Span.TimeEvent.NetworkEvent.Type'},
    const {'1': 'message_id', '3': 3, '4': 1, '5': 4},
    const {'1': 'message_size', '3': 4, '4': 1, '5': 4},
  ],
  '4': const [Span_TimeEvent_NetworkEvent_Type$json],
};

const Span_TimeEvent_NetworkEvent_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'UNSPECIFIED', '2': 0},
    const {'1': 'SENT', '2': 1},
    const {'1': 'RECV', '2': 2},
  ],
};

const Span_Link$json = const {
  '1': 'Link',
  '2': const [
    const {'1': 'trace_id', '3': 1, '4': 1, '5': 11, '6': '.google.tracing.v1.TraceId'},
    const {'1': 'span_id', '3': 2, '4': 1, '5': 6},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.google.tracing.v1.Span.Link.Type'},
  ],
  '4': const [Span_Link_Type$json],
};

const Span_Link_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'UNSPECIFIED', '2': 0},
    const {'1': 'CHILD', '2': 1},
    const {'1': 'PARENT', '2': 2},
  ],
};

const Span_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.tracing.v1.LabelValue'},
  ],
  '7': const {},
};

const Trace$json = const {
  '1': 'Trace',
  '2': const [
    const {'1': 'trace_id', '3': 1, '4': 1, '5': 11, '6': '.google.tracing.v1.TraceId'},
    const {'1': 'spans', '3': 2, '4': 3, '5': 11, '6': '.google.tracing.v1.Span'},
  ],
};

