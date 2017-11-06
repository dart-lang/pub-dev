///
//  Generated code. Do not modify.
///
library google.api_documentation_pbjson;

const Documentation$json = const {
  '1': 'Documentation',
  '2': const [
    const {'1': 'summary', '3': 1, '4': 1, '5': 9},
    const {'1': 'pages', '3': 5, '4': 3, '5': 11, '6': '.google.api.Page'},
    const {'1': 'rules', '3': 3, '4': 3, '5': 11, '6': '.google.api.DocumentationRule'},
    const {'1': 'documentation_root_url', '3': 4, '4': 1, '5': 9},
    const {'1': 'overview', '3': 2, '4': 1, '5': 9},
  ],
};

const DocumentationRule$json = const {
  '1': 'DocumentationRule',
  '2': const [
    const {'1': 'selector', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
    const {'1': 'deprecation_description', '3': 3, '4': 1, '5': 9},
  ],
};

const Page$json = const {
  '1': 'Page',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'content', '3': 2, '4': 1, '5': 9},
    const {'1': 'subpages', '3': 3, '4': 3, '5': 11, '6': '.google.api.Page'},
  ],
};

