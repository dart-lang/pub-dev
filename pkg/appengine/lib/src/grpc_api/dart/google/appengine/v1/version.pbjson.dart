///
//  Generated code. Do not modify.
///
library google.appengine.v1_version_pbjson;

const InboundServiceType$json = const {
  '1': 'InboundServiceType',
  '2': const [
    const {'1': 'INBOUND_SERVICE_UNSPECIFIED', '2': 0},
    const {'1': 'INBOUND_SERVICE_MAIL', '2': 1},
    const {'1': 'INBOUND_SERVICE_MAIL_BOUNCE', '2': 2},
    const {'1': 'INBOUND_SERVICE_XMPP_ERROR', '2': 3},
    const {'1': 'INBOUND_SERVICE_XMPP_MESSAGE', '2': 4},
    const {'1': 'INBOUND_SERVICE_XMPP_SUBSCRIBE', '2': 5},
    const {'1': 'INBOUND_SERVICE_XMPP_PRESENCE', '2': 6},
    const {'1': 'INBOUND_SERVICE_CHANNEL_PRESENCE', '2': 7},
    const {'1': 'INBOUND_SERVICE_WARMUP', '2': 9},
  ],
};

const ServingStatus$json = const {
  '1': 'ServingStatus',
  '2': const [
    const {'1': 'SERVING_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'SERVING', '2': 1},
    const {'1': 'STOPPED', '2': 2},
  ],
};

const Version$json = const {
  '1': 'Version',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
    const {'1': 'automatic_scaling', '3': 3, '4': 1, '5': 11, '6': '.google.appengine.v1.AutomaticScaling'},
    const {'1': 'basic_scaling', '3': 4, '4': 1, '5': 11, '6': '.google.appengine.v1.BasicScaling'},
    const {'1': 'manual_scaling', '3': 5, '4': 1, '5': 11, '6': '.google.appengine.v1.ManualScaling'},
    const {'1': 'inbound_services', '3': 6, '4': 3, '5': 14, '6': '.google.appengine.v1.InboundServiceType'},
    const {'1': 'instance_class', '3': 7, '4': 1, '5': 9},
    const {'1': 'network', '3': 8, '4': 1, '5': 11, '6': '.google.appengine.v1.Network'},
    const {'1': 'resources', '3': 9, '4': 1, '5': 11, '6': '.google.appengine.v1.Resources'},
    const {'1': 'runtime', '3': 10, '4': 1, '5': 9},
    const {'1': 'threadsafe', '3': 11, '4': 1, '5': 8},
    const {'1': 'vm', '3': 12, '4': 1, '5': 8},
    const {'1': 'beta_settings', '3': 13, '4': 3, '5': 11, '6': '.google.appengine.v1.Version.BetaSettingsEntry'},
    const {'1': 'env', '3': 14, '4': 1, '5': 9},
    const {'1': 'serving_status', '3': 15, '4': 1, '5': 14, '6': '.google.appengine.v1.ServingStatus'},
    const {'1': 'created_by', '3': 16, '4': 1, '5': 9},
    const {'1': 'create_time', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'disk_usage_bytes', '3': 18, '4': 1, '5': 3},
    const {'1': 'handlers', '3': 100, '4': 3, '5': 11, '6': '.google.appengine.v1.UrlMap'},
    const {'1': 'error_handlers', '3': 101, '4': 3, '5': 11, '6': '.google.appengine.v1.ErrorHandler'},
    const {'1': 'libraries', '3': 102, '4': 3, '5': 11, '6': '.google.appengine.v1.Library'},
    const {'1': 'api_config', '3': 103, '4': 1, '5': 11, '6': '.google.appengine.v1.ApiConfigHandler'},
    const {'1': 'env_variables', '3': 104, '4': 3, '5': 11, '6': '.google.appengine.v1.Version.EnvVariablesEntry'},
    const {'1': 'default_expiration', '3': 105, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'health_check', '3': 106, '4': 1, '5': 11, '6': '.google.appengine.v1.HealthCheck'},
    const {'1': 'nobuild_files_regex', '3': 107, '4': 1, '5': 9},
    const {'1': 'deployment', '3': 108, '4': 1, '5': 11, '6': '.google.appengine.v1.Deployment'},
    const {'1': 'version_url', '3': 109, '4': 1, '5': 9},
  ],
  '3': const [Version_BetaSettingsEntry$json, Version_EnvVariablesEntry$json],
};

const Version_BetaSettingsEntry$json = const {
  '1': 'BetaSettingsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const Version_EnvVariablesEntry$json = const {
  '1': 'EnvVariablesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const AutomaticScaling$json = const {
  '1': 'AutomaticScaling',
  '2': const [
    const {'1': 'cool_down_period', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'cpu_utilization', '3': 2, '4': 1, '5': 11, '6': '.google.appengine.v1.CpuUtilization'},
    const {'1': 'max_concurrent_requests', '3': 3, '4': 1, '5': 5},
    const {'1': 'max_idle_instances', '3': 4, '4': 1, '5': 5},
    const {'1': 'max_total_instances', '3': 5, '4': 1, '5': 5},
    const {'1': 'max_pending_latency', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'min_idle_instances', '3': 7, '4': 1, '5': 5},
    const {'1': 'min_total_instances', '3': 8, '4': 1, '5': 5},
    const {'1': 'min_pending_latency', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'request_utilization', '3': 10, '4': 1, '5': 11, '6': '.google.appengine.v1.RequestUtilization'},
    const {'1': 'disk_utilization', '3': 11, '4': 1, '5': 11, '6': '.google.appengine.v1.DiskUtilization'},
    const {'1': 'network_utilization', '3': 12, '4': 1, '5': 11, '6': '.google.appengine.v1.NetworkUtilization'},
  ],
};

const BasicScaling$json = const {
  '1': 'BasicScaling',
  '2': const [
    const {'1': 'idle_timeout', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'max_instances', '3': 2, '4': 1, '5': 5},
  ],
};

const ManualScaling$json = const {
  '1': 'ManualScaling',
  '2': const [
    const {'1': 'instances', '3': 1, '4': 1, '5': 5},
  ],
};

const CpuUtilization$json = const {
  '1': 'CpuUtilization',
  '2': const [
    const {'1': 'aggregation_window_length', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'target_utilization', '3': 2, '4': 1, '5': 1},
  ],
};

const RequestUtilization$json = const {
  '1': 'RequestUtilization',
  '2': const [
    const {'1': 'target_request_count_per_second', '3': 1, '4': 1, '5': 5},
    const {'1': 'target_concurrent_requests', '3': 2, '4': 1, '5': 5},
  ],
};

const DiskUtilization$json = const {
  '1': 'DiskUtilization',
  '2': const [
    const {'1': 'target_write_bytes_per_second', '3': 14, '4': 1, '5': 5},
    const {'1': 'target_write_ops_per_second', '3': 15, '4': 1, '5': 5},
    const {'1': 'target_read_bytes_per_second', '3': 16, '4': 1, '5': 5},
    const {'1': 'target_read_ops_per_second', '3': 17, '4': 1, '5': 5},
  ],
};

const NetworkUtilization$json = const {
  '1': 'NetworkUtilization',
  '2': const [
    const {'1': 'target_sent_bytes_per_second', '3': 1, '4': 1, '5': 5},
    const {'1': 'target_sent_packets_per_second', '3': 11, '4': 1, '5': 5},
    const {'1': 'target_received_bytes_per_second', '3': 12, '4': 1, '5': 5},
    const {'1': 'target_received_packets_per_second', '3': 13, '4': 1, '5': 5},
  ],
};

const Network$json = const {
  '1': 'Network',
  '2': const [
    const {'1': 'forwarded_ports', '3': 1, '4': 3, '5': 9},
    const {'1': 'instance_tag', '3': 2, '4': 1, '5': 9},
    const {'1': 'name', '3': 3, '4': 1, '5': 9},
  ],
};

const Resources$json = const {
  '1': 'Resources',
  '2': const [
    const {'1': 'cpu', '3': 1, '4': 1, '5': 1},
    const {'1': 'disk_gb', '3': 2, '4': 1, '5': 1},
    const {'1': 'memory_gb', '3': 3, '4': 1, '5': 1},
  ],
};

