///
//  Generated code. Do not modify.
///
library google.appengine.v1_service_pbjson;

const Service$json = const {
  '1': 'Service',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
    const {'1': 'split', '3': 3, '4': 1, '5': 11, '6': '.google.appengine.v1.TrafficSplit'},
  ],
};

const TrafficSplit$json = const {
  '1': 'TrafficSplit',
  '2': const [
    const {'1': 'shard_by', '3': 1, '4': 1, '5': 14, '6': '.google.appengine.v1.TrafficSplit.ShardBy'},
    const {'1': 'allocations', '3': 2, '4': 3, '5': 11, '6': '.google.appengine.v1.TrafficSplit.AllocationsEntry'},
  ],
  '3': const [TrafficSplit_AllocationsEntry$json],
  '4': const [TrafficSplit_ShardBy$json],
};

const TrafficSplit_AllocationsEntry$json = const {
  '1': 'AllocationsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 1},
  ],
  '7': const {},
};

const TrafficSplit_ShardBy$json = const {
  '1': 'ShardBy',
  '2': const [
    const {'1': 'UNSPECIFIED', '2': 0},
    const {'1': 'COOKIE', '2': 1},
    const {'1': 'IP', '2': 2},
  ],
};

