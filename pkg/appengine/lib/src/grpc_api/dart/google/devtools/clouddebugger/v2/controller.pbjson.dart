///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_controller_pbjson;

import 'data.pbjson.dart';
import '../../source/v1/source_context.pbjson.dart' as google$devtools$source$v1;
import '../../../protobuf/wrappers.pbjson.dart' as google$protobuf;
import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;

const RegisterDebuggeeRequest$json = const {
  '1': 'RegisterDebuggeeRequest',
  '2': const [
    const {'1': 'debuggee', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.Debuggee'},
  ],
};

const RegisterDebuggeeResponse$json = const {
  '1': 'RegisterDebuggeeResponse',
  '2': const [
    const {'1': 'debuggee', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.Debuggee'},
  ],
};

const ListActiveBreakpointsRequest$json = const {
  '1': 'ListActiveBreakpointsRequest',
  '2': const [
    const {'1': 'debuggee_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'wait_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'success_on_timeout', '3': 3, '4': 1, '5': 8},
  ],
};

const ListActiveBreakpointsResponse$json = const {
  '1': 'ListActiveBreakpointsResponse',
  '2': const [
    const {'1': 'breakpoints', '3': 1, '4': 3, '5': 11, '6': '.google.devtools.clouddebugger.v2.Breakpoint'},
    const {'1': 'next_wait_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'wait_expired', '3': 3, '4': 1, '5': 8},
  ],
};

const UpdateActiveBreakpointRequest$json = const {
  '1': 'UpdateActiveBreakpointRequest',
  '2': const [
    const {'1': 'debuggee_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'breakpoint', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.clouddebugger.v2.Breakpoint'},
  ],
};

const UpdateActiveBreakpointResponse$json = const {
  '1': 'UpdateActiveBreakpointResponse',
};

const Controller2$json = const {
  '1': 'Controller2',
  '2': const [
    const {'1': 'RegisterDebuggee', '2': '.google.devtools.clouddebugger.v2.RegisterDebuggeeRequest', '3': '.google.devtools.clouddebugger.v2.RegisterDebuggeeResponse', '4': const {}},
    const {'1': 'ListActiveBreakpoints', '2': '.google.devtools.clouddebugger.v2.ListActiveBreakpointsRequest', '3': '.google.devtools.clouddebugger.v2.ListActiveBreakpointsResponse', '4': const {}},
    const {'1': 'UpdateActiveBreakpoint', '2': '.google.devtools.clouddebugger.v2.UpdateActiveBreakpointRequest', '3': '.google.devtools.clouddebugger.v2.UpdateActiveBreakpointResponse', '4': const {}},
  ],
};

const Controller2$messageJson = const {
  '.google.devtools.clouddebugger.v2.RegisterDebuggeeRequest': RegisterDebuggeeRequest$json,
  '.google.devtools.clouddebugger.v2.Debuggee': Debuggee$json,
  '.google.devtools.clouddebugger.v2.StatusMessage': StatusMessage$json,
  '.google.devtools.clouddebugger.v2.FormatMessage': FormatMessage$json,
  '.google.devtools.source.v1.SourceContext': google$devtools$source$v1.SourceContext$json,
  '.google.devtools.source.v1.CloudRepoSourceContext': google$devtools$source$v1.CloudRepoSourceContext$json,
  '.google.devtools.source.v1.RepoId': google$devtools$source$v1.RepoId$json,
  '.google.devtools.source.v1.ProjectRepoId': google$devtools$source$v1.ProjectRepoId$json,
  '.google.devtools.source.v1.AliasContext': google$devtools$source$v1.AliasContext$json,
  '.google.devtools.source.v1.CloudWorkspaceSourceContext': google$devtools$source$v1.CloudWorkspaceSourceContext$json,
  '.google.devtools.source.v1.CloudWorkspaceId': google$devtools$source$v1.CloudWorkspaceId$json,
  '.google.devtools.source.v1.GerritSourceContext': google$devtools$source$v1.GerritSourceContext$json,
  '.google.devtools.source.v1.GitSourceContext': google$devtools$source$v1.GitSourceContext$json,
  '.google.devtools.clouddebugger.v2.Debuggee.LabelsEntry': Debuggee_LabelsEntry$json,
  '.google.devtools.source.v1.ExtendedSourceContext': google$devtools$source$v1.ExtendedSourceContext$json,
  '.google.devtools.source.v1.ExtendedSourceContext.LabelsEntry': google$devtools$source$v1.ExtendedSourceContext_LabelsEntry$json,
  '.google.devtools.clouddebugger.v2.RegisterDebuggeeResponse': RegisterDebuggeeResponse$json,
  '.google.devtools.clouddebugger.v2.ListActiveBreakpointsRequest': ListActiveBreakpointsRequest$json,
  '.google.devtools.clouddebugger.v2.ListActiveBreakpointsResponse': ListActiveBreakpointsResponse$json,
  '.google.devtools.clouddebugger.v2.Breakpoint': Breakpoint$json,
  '.google.devtools.clouddebugger.v2.SourceLocation': SourceLocation$json,
  '.google.devtools.clouddebugger.v2.StackFrame': StackFrame$json,
  '.google.devtools.clouddebugger.v2.Variable': Variable$json,
  '.google.protobuf.Int32Value': google$protobuf.Int32Value$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.devtools.clouddebugger.v2.Breakpoint.LabelsEntry': Breakpoint_LabelsEntry$json,
  '.google.devtools.clouddebugger.v2.UpdateActiveBreakpointRequest': UpdateActiveBreakpointRequest$json,
  '.google.devtools.clouddebugger.v2.UpdateActiveBreakpointResponse': UpdateActiveBreakpointResponse$json,
};

