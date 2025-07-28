# highlight.js

1. Visit https://highlightjs.org/download/
2. Open the developer console.
3. Copy the below code block and execute.
4. Verify that the listed language are selected.
5. Download and extract assets.

```javascript
var selected = [
  'bash',
  'c',
  'css',
  'dart',
  'diff',
  'java',
  'javascript',
  'json',
  'kotlin',
  'markdown',
  'objectivec',
  'plaintext',
  'shell',
  'swift',
  'xml', // also includes html
  'yaml',
];
document.querySelectorAll('input[type=checkbox]').forEach(function (elem) {elem.checked = selected.includes(elem.value);});
```
