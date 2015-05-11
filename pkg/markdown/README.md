A portable markdown library written in Dart. It can parse markdown into
html on both the client and server.

Usage
-----

```dart
import 'package:markdown/markdown.dart';

void main() {
  print(markdownToHtml('Hello *Markdown*'));
  //=> <p>Hello <em>Markdown</em></p>
}
```

You can create and use your own syntaxes.

```dart
import 'package:markdown/markdown.dart';

void main() {
  var syntaxes = [new TextSyntax('nyan', sub: '~=[,,_,,]:3')];
  print(markdownToHtml('nyan', inlineSyntaxes: syntaxes));
  //=> <p>~=[,,_,,]:3</p>
}
```
