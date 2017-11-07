## 0.13.2

 * Support the latest release of `pkg/csslib`.

## 0.13.1
 * Update Set.difference to take a Set<Object>.

## 0.13.0

 * **BREAKING** Fix all [strong mode][] errors and warnings.
   This involved adding more precise types on some public APIs, which is why it
   may break users.

[strong mode]: https://github.com/dart-lang/dev_compiler/blob/master/STRONG_MODE.md

#### Pub version 0.12.2+2
  * Support `csslib` versions `0.13.x`.
  
#### Pub version 0.12.2+1
  * Exclude `.packages` file from the published package.

#### Pub version 0.12.2
  * Added `Element.endSourceSpan`, containing the span of a closing tag.

#### Pub version 0.12.0+1
  * Support `csslib` version `0.12.0`.

#### Rename to package:html 0.12.0
  * package has been renamed to `html`

#### Pub version 0.12.0
  * switch from `source_maps`' `Span` class to `source_span`'s
    `SourceSpan` class.

#### Pub version 0.11.0+2
  * expand the version constraint for csslib.

#### Pub version 0.10.0+1
  * use a more recent source_maps version.

#### Pub version 0.10.0
  * fix how document fragments are added in NodeList.add/addAll/insertAll.

#### Pub version 0.9.2-dev
  * add Node.text, Node.append, Document.documentElement
  * add Text.data, deprecate Node.value and Text.value.
  * deprecate Node.$dom_nodeType
  * added querySelector/querySelectorAll, deprecated query/queryAll.
    This matches the current APIs in dart:html.
