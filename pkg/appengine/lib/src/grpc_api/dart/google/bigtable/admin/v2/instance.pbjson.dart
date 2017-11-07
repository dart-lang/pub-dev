///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_instance_pbjson;

const Instance$json = const {
  '1': 'Instance',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'state', '3': 3, '4': 1, '5': 14, '6': '.google.bigtable.admin.v2.Instance.State'},
    const {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.google.bigtable.admin.v2.Instance.Type'},
  ],
  '4': const [Instance_State$json, Instance_Type$json],
};

const Instance_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'STATE_NOT_KNOWN', '2': 0},
    const {'1': 'READY', '2': 1},
    const {'1': 'CREATING', '2': 2},
  ],
};

const Instance_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'PRODUCTION', '2': 1},
  ],
};

const Cluster$json = const {
  '1': 'Cluster',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'location', '3': 2, '4': 1, '5': 9},
    const {'1': 'state', '3': 3, '4': 1, '5': 14, '6': '.google.bigtable.admin.v2.Cluster.State'},
    const {'1': 'serve_nodes', '3': 4, '4': 1, '5': 5},
    const {'1': 'default_storage_type', '3': 5, '4': 1, '5': 14, '6': '.google.bigtable.admin.v2.StorageType'},
  ],
  '4': const [Cluster_State$json],
};

const Cluster_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'STATE_NOT_KNOWN', '2': 0},
    const {'1': 'READY', '2': 1},
    const {'1': 'CREATING', '2': 2},
    const {'1': 'RESIZING', '2': 3},
    const {'1': 'DISABLED', '2': 4},
  ],
};

