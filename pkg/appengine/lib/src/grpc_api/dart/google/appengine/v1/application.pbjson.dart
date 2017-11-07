///
//  Generated code. Do not modify.
///
library google.appengine.v1_application_pbjson;

const Application$json = const {
  '1': 'Application',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
    const {'1': 'dispatch_rules', '3': 3, '4': 3, '5': 11, '6': '.google.appengine.v1.UrlDispatchRule'},
    const {'1': 'auth_domain', '3': 6, '4': 1, '5': 9},
    const {'1': 'location_id', '3': 7, '4': 1, '5': 9},
    const {'1': 'code_bucket', '3': 8, '4': 1, '5': 9},
    const {'1': 'default_cookie_expiration', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'default_hostname', '3': 11, '4': 1, '5': 9},
    const {'1': 'default_bucket', '3': 12, '4': 1, '5': 9},
  ],
};

const UrlDispatchRule$json = const {
  '1': 'UrlDispatchRule',
  '2': const [
    const {'1': 'domain', '3': 1, '4': 1, '5': 9},
    const {'1': 'path', '3': 2, '4': 1, '5': 9},
    const {'1': 'service', '3': 3, '4': 1, '5': 9},
  ],
};

