///
//  Generated code. Do not modify.
///
library google.api_monitored_resource_pbjson;

const MonitoredResourceDescriptor$json = const {
  '1': 'MonitoredResourceDescriptor',
  '2': const [
    const {'1': 'name', '3': 5, '4': 1, '5': 9},
    const {'1': 'type', '3': 1, '4': 1, '5': 9},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'description', '3': 3, '4': 1, '5': 9},
    const {'1': 'labels', '3': 4, '4': 3, '5': 11, '6': '.google.api.LabelDescriptor'},
  ],
};

const MonitoredResource$json = const {
  '1': 'MonitoredResource',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9},
    const {'1': 'labels', '3': 2, '4': 3, '5': 11, '6': '.google.api.MonitoredResource.LabelsEntry'},
  ],
  '3': const [MonitoredResource_LabelsEntry$json],
};

const MonitoredResource_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

