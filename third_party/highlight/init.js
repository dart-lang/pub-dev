hljs.configure({
  // The list of languages that may be used in the auto-detection.
  // NOTE: always derive this list from the `readme.md`.
  languages: [
    'bash',
    'c',
    'css',
    'dart',
    'diff',
    'java',
    'javascript',
    'json',
    'kotlin',
    // removal reason: https://github.com/highlightjs/highlight.js/issues/4279#issuecomment-3126165923
    // 'markdown',
    'objectivec',
    'plaintext',
    'shell',
    'swift',
    'xml',
    'yaml',
  ]
});
hljs.highlightAll();
