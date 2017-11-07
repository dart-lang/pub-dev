///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_data_pbjson;

const FormatMessage$json = const {
  '1': 'FormatMessage',
  '2': const [
    const {'1': 'format', '3': 1, '4': 1, '5': 9},
    const {'1': 'parameters', '3': 2, '4': 3, '5': 9},
  ],
};

const StatusMessage$json = const {
  '1': 'StatusMessage',
  '2': const [
    const {'1': 'is_error', '3': 1, '4': 1, '5': 8},
    const {'1': 'refers_to', '3': 2, '4': 1, '5': 14, '6': '.google.devtools.clouddebugger.v2.StatusMessage.Reference'},
    const {'1': 'description', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.FormatMessage'},
  ],
  '4': const [StatusMessage_Reference$json],
};

const StatusMessage_Reference$json = const {
  '1': 'Reference',
  '2': const [
    const {'1': 'UNSPECIFIED', '2': 0},
    const {'1': 'BREAKPOINT_SOURCE_LOCATION', '2': 3},
    const {'1': 'BREAKPOINT_CONDITION', '2': 4},
    const {'1': 'BREAKPOINT_EXPRESSION', '2': 7},
    const {'1': 'VARIABLE_NAME', '2': 5},
    const {'1': 'VARIABLE_VALUE', '2': 6},
  ],
};

const SourceLocation$json = const {
  '1': 'SourceLocation',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9},
    const {'1': 'line', '3': 2, '4': 1, '5': 5},
  ],
};

const Variable$json = const {
  '1': 'Variable',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
    const {'1': 'type', '3': 6, '4': 1, '5': 9},
    const {'1': 'members', '3': 3, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Variable'},
    const {'1': 'var_table_index', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Int32Value'},
    const {'1': 'status', '3': 5, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.StatusMessage'},
  ],
};

const StackFrame$json = const {
  '1': 'StackFrame',
  '2': const [
    const {'1': 'function', '3': 1, '4': 1, '5': 9},
    const {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.SourceLocation'},
    const {'1': 'arguments', '3': 3, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Variable'},
    const {'1': 'locals', '3': 4, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Variable'},
  ],
};

const Breakpoint$json = const {
  '1': 'Breakpoint',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'action', '3': 13, '4': 1, '5': 14, '6': '.google.devtools.clouddebugger.v2.Breakpoint.Action'},
    const {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.SourceLocation'},
    const {'1': 'condition', '3': 3, '4': 1, '5': 9},
    const {'1': 'expressions', '3': 4, '4': 3, '5': 9},
    const {'1': 'log_message_format', '3': 14, '4': 1, '5': 9},
    const {'1': 'log_level', '3': 15, '4': 1, '5': 14, '6': '.google.devtools.clouddebugger.v2.Breakpoint.LogLevel'},
    const {'1': 'is_final_state', '3': 5, '4': 1, '5': 8},
    const {'1': 'create_time', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'final_time', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'user_email', '3': 16, '4': 1, '5': 9},
    const {'1': 'status', '3': 10, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.StatusMessage'},
    const {'1': 'stack_frames', '3': 7, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.StackFrame'},
    const {'1': 'evaluated_expressions', '3': 8, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Variable'},
    const {'1': 'variable_table', '3': 9, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Variable'},
    const {'1': 'labels', '3': 17, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Breakpoint.LabelsEntry'},
  ],
  '3': const [Breakpoint_LabelsEntry$json],
  '4': const [Breakpoint_Action$json, Breakpoint_LogLevel$json],
};

const Breakpoint_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const Breakpoint_Action$json = const {
  '1': 'Action',
  '2': const [
    const {'1': 'CAPTURE', '2': 0},
    const {'1': 'LOG', '2': 1},
  ],
};

const Breakpoint_LogLevel$json = const {
  '1': 'LogLevel',
  '2': const [
    const {'1': 'INFO', '2': 0},
    const {'1': 'WARNING', '2': 1},
    const {'1': 'ERROR', '2': 2},
  ],
};

const Debuggee$json = const {
  '1': 'Debuggee',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'project', '3': 2, '4': 1, '5': 9},
    const {'1': 'uniquifier', '3': 3, '4': 1, '5': 9},
    const {'1': 'description', '3': 4, '4': 1, '5': 9},
    const {'1': 'is_inactive', '3': 5, '4': 1, '5': 8},
    const {'1': 'agent_version', '3': 6, '4': 1, '5': 9},
    const {'1': 'is_disabled', '3': 7, '4': 1, '5': 8},
    const {'1': 'status', '3': 8, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.StatusMessage'},
    const {'1': 'source_contexts', '3': 9, '4': 3, '5': 11, '6': '.google.devtools.source.v1.SourceContext'},
    const {'1': 'ext_source_contexts', '3': 13, '4': 3, '5': 11, '6': '.google.devtools.source.v1.ExtendedSourceContext'},
    const {'1': 'labels', '3': 11, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Debuggee.LabelsEntry'},
  ],
  '3': const [Debuggee_LabelsEntry$json],
};

const Debuggee_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

