///
//  Generated code. Do not modify.
///
library google.api_system_parameter_pbjson;

const SystemParameters$json = const {
  '1': 'SystemParameters',
  '2': const [
    const {'1': 'rules', '3': 1, '4': 3, '5': 11, '6': '.google.api.SystemParameterRule'},
  ],
};

const SystemParameterRule$json = const {
  '1': 'SystemParameterRule',
  '2': const [
    const {'1': 'selector', '3': 1, '4': 1, '5': 9},
    const {'1': 'parameters', '3': 2, '4': 3, '5': 11, '6': '.google.api.SystemParameter'},
  ],
};

const SystemParameter$json = const {
  '1': 'SystemParameter',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'http_header', '3': 2, '4': 1, '5': 9},
    const {'1': 'url_query_parameter', '3': 3, '4': 1, '5': 9},
  ],
};

