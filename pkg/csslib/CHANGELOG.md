## 0.14.1

* Deprecated `package:csslib/css.dart`.
  Use `parser.dart` and `visitor.dart` instead.

## 0.14.0

### New features

* Supports nested at-rules.
* Supports nested HTML comments in CSS comments and vice-versa.

### Breaking changes

* The `List<RuleSet> rulesets` field on `MediaDirective`, `HostDirective`, and
  `StyletDirective` has been replaced by `List<TreeNode> rules` to allow nested
  at-rules in addition to rulesets.

## 0.13.6

* Adds support for `@viewport`.
* Adds support for `-webkit-calc()` and `-moz-calc()`.
* Adds support for querying media features without specifying an expression. For
  example: `@media (transform-3d) { ... }`.
* Prevents exception being thrown for invalid dimension terms, and instead
  issues an error.

## 0.13.5

* Adds support for `@-moz-document`.
* Adds support for `@supports`.

## 0.13.4

* Parses CSS 2.1 pseudo-elements as pseudo-elements instead of pseudo-classes.
* Supports signed decimal numbers with no integer part.
* Fixes parsing hexadecimal numbers when followed by an identifier.
* Fixes parsing strings which contain unicode-range character sequences.

## 0.13.3+1

* Fixes analyzer error.

## 0.13.3

* Adds support for shadow host selectors `:host()` and `:host-context()`.
* Adds support for shadow-piercing descendant combinator `>>>` and its alias
  `/deep/` for backwards compatibility.
* Adds support for non-functional IE filter properties (i.e. `filter: FlipH`).
* Fixes emitted CSS for `@page` directive when body includes declarations and
  page-margin boxes.
* Exports `Message` from `parser.dart` so it's no longer necessary to import
  `src/messages.dart` to use the parser API.

## 0.13.2+2

* Fix static warnings.

## 0.13.2+1

* Fix new strong mode error.

## 0.13.2

* Relax type of TreeNode.visit, to allow returning values from visitors.

## 0.13.1

* Fix two checked mode bugs introduced in 0.13.0.

## 0.13.0

 * **BREAKING** Fix all [strong mode][] errors and warnings.
   This involved adding more precise on some public APIs, which
   is why it may break users.

[strong mode]: https://github.com/dart-lang/dev_compiler/blob/master/STRONG_MODE.md

## 0.12.2

 * Fix to handle calc functions however, the expressions are treated as a
   LiteralTerm and not fully parsed into the AST.

## 0.12.1

 * Fix to handling of escapes in strings.

## 0.12.0+1

* Allow the lastest version of `logging` package.

## 0.12.0

* Top-level methods in `parser.dart` now take `PreprocessorOptions` instead of
  `List<String>`.

* `PreprocessorOptions.inputFile` is now final.

## 0.11.0+4

* Cleanup some ambiguous and some incorrect type signatures.

## 0.11.0+3

* Improve the speed and memory efficiency of parsing.

## 0.11.0+2

* Fix another test that was failing on IE10.

## 0.11.0+1

* Fix a test that was failing on IE10.

## 0.11.0

* Switch from `source_maps`' `Span` class to `source_span`'s `SourceSpan` class.
