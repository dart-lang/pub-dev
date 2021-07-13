# highlight.js

1. Visit https://highlightjs.org/download/
2. Open the developer console.
3. Copy the below code block and execute.
4. Verify that the listed language are selected.
5. Download and extract assets.

```javascript
var selected = [
  'bash.js',
  'c.js',
  'css.js',
  'dart.js',
  'diff.js',
  'java.js',
  'javascript.js',
  'json.js',
  'kotlin.js',
  'markdown.js',
  'objectivec.js',
  'plaintext.js',
  'shell.js',
  'swift.js',
  'xml.js', // also includes html
  'yaml.js',
];
document.querySelectorAll('input[type=checkbox]').forEach(function (elem) {elem.checked = selected.includes(elem.name);});
```
