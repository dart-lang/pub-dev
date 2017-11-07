///
//  Generated code. Do not modify.
///
library google.appengine.v1_instance_pbjson;

const Instance$json = const {
  '1': 'Instance',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
    const {'1': 'app_engine_release', '3': 3, '4': 1, '5': 9},
    const {'1': 'availability', '3': 4, '4': 1, '5': 14, '6': '.google.appengine.v1.Instance.Availability'},
    const {'1': 'vm_name', '3': 5, '4': 1, '5': 9},
    const {'1': 'vm_zone_name', '3': 6, '4': 1, '5': 9},
    const {'1': 'vm_id', '3': 7, '4': 1, '5': 9},
    const {'1': 'start_time', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'requests', '3': 9, '4': 1, '5': 5},
    const {'1': 'errors', '3': 10, '4': 1, '5': 5},
    const {'1': 'qps', '3': 11, '4': 1, '5': 2},
    const {'1': 'average_latency', '3': 12, '4': 1, '5': 5},
    const {'1': 'memory_usage', '3': 13, '4': 1, '5': 3},
    const {'1': 'vm_status', '3': 14, '4': 1, '5': 9},
    const {'1': 'vm_debug_enabled', '3': 15, '4': 1, '5': 8},
  ],
  '4': const [Instance_Availability$json],
};

const Instance_Availability$json = const {
  '1': 'Availability',
  '2': const [
    const {'1': 'UNSPECIFIED', '2': 0},
    const {'1': 'RESIDENT', '2': 1},
    const {'1': 'DYNAMIC', '2': 2},
  ],
};

