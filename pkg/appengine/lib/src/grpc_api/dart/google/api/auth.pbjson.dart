///
//  Generated code. Do not modify.
///
library google.api_auth_pbjson;

const Authentication$json = const {
  '1': 'Authentication',
  '2': const [
    const {'1': 'rules', '3': 3, '4': 3, '5': 11, '6': '.google.api.AuthenticationRule'},
    const {'1': 'providers', '3': 4, '4': 3, '5': 11, '6': '.google.api.AuthProvider'},
  ],
};

const AuthenticationRule$json = const {
  '1': 'AuthenticationRule',
  '2': const [
    const {'1': 'selector', '3': 1, '4': 1, '5': 9},
    const {'1': 'oauth', '3': 2, '4': 1, '5': 11, '6': '.google.api.OAuthRequirements'},
    const {'1': 'allow_without_credential', '3': 5, '4': 1, '5': 8},
    const {'1': 'requirements', '3': 7, '4': 3, '5': 11, '6': '.google.api.AuthRequirement'},
  ],
};

const AuthProvider$json = const {
  '1': 'AuthProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'issuer', '3': 2, '4': 1, '5': 9},
    const {'1': 'jwks_uri', '3': 3, '4': 1, '5': 9},
    const {'1': 'audiences', '3': 4, '4': 1, '5': 9},
  ],
};

const OAuthRequirements$json = const {
  '1': 'OAuthRequirements',
  '2': const [
    const {'1': 'canonical_scopes', '3': 1, '4': 1, '5': 9},
  ],
};

const AuthRequirement$json = const {
  '1': 'AuthRequirement',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'audiences', '3': 2, '4': 1, '5': 9},
  ],
};

