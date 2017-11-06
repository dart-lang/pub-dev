///
//  Generated code. Do not modify.
///
library google.api_http_pbjson;

const Http$json = const {
  '1': 'Http',
  '2': const [
    const {'1': 'rules', '3': 1, '4': 3, '5': 11, '6': '.google.api.HttpRule'},
  ],
};

const HttpRule$json = const {
  '1': 'HttpRule',
  '2': const [
    const {'1': 'selector', '3': 1, '4': 1, '5': 9},
    const {'1': 'get', '3': 2, '4': 1, '5': 9},
    const {'1': 'put', '3': 3, '4': 1, '5': 9},
    const {'1': 'post', '3': 4, '4': 1, '5': 9},
    const {'1': 'delete', '3': 5, '4': 1, '5': 9},
    const {'1': 'patch', '3': 6, '4': 1, '5': 9},
    const {'1': 'custom', '3': 8, '4': 1, '5': 11, '6': '.google.api.CustomHttpPattern'},
    const {'1': 'body', '3': 7, '4': 1, '5': 9},
    const {'1': 'additional_bindings', '3': 11, '4': 3, '5': 11, '6': '.google.api.HttpRule'},
  ],
};

const CustomHttpPattern$json = const {
  '1': 'CustomHttpPattern',
  '2': const [
    const {'1': 'kind', '3': 1, '4': 1, '5': 9},
    const {'1': 'path', '3': 2, '4': 1, '5': 9},
  ],
};

