///
//  Generated code. Do not modify.
///
library google.api_consumer_pbjson;

const ProjectProperties$json = const {
  '1': 'ProjectProperties',
  '2': const [
    const {'1': 'properties', '3': 1, '4': 3, '5': 11, '6': '.google.api.Property'},
  ],
};

const Property$json = const {
  '1': 'Property',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.google.api.Property.PropertyType'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9},
  ],
  '4': const [Property_PropertyType$json],
};

const Property_PropertyType$json = const {
  '1': 'PropertyType',
  '2': const [
    const {'1': 'UNSPECIFIED', '2': 0},
    const {'1': 'INT64', '2': 1},
    const {'1': 'BOOL', '2': 2},
    const {'1': 'STRING', '2': 3},
    const {'1': 'DOUBLE', '2': 4},
  ],
};

