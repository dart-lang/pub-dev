# 1.0.8

* Support v1 of `pkg/args`.

# 1.0.7

* Format multiline strings as block arguments (#570).
* Fix call to analyzer API.
* Support assert in initializer list experimental syntax (#522).

# 1.0.6

* Support URIs in part-of directives (#615).

# 1.0.5

* Support the latest version of `pkg/analyzer`.

# 1.0.4

* Ensure formatter throws an exception instead of introducing non-whitespace
  changes. This sanity check ensures the formatter does not erase user code
  when the formatter itself contains a bug.
* Preserve type arguments in generic typedefs (#619).
* Preserve type arguments in function expression invocations (#621).

# 1.0.3

* Preserve type arguments in generic function-typed parameters (#613).

# 1.0.2

* Support new generic function typedef syntax (#563).

# 1.0.1

* Ensure space between `-` and `--` (#170).
* Preserve a blank line between enum cases (#606).

# 1.0.0

* Handle mixed block and arrow bodied function arguments uniformly (#500).
* Don't add a spurious space after "native" (#541).
* Handle parenthesized and immediately invoked functions in argument lists
  like other function literals (#566).
* Preserve a blank line between an annotation and the first directive (#571).
* Fix splitting in generic methods with `=>` bodies (#584).
* Allow splitting between a parameter name and type (#585).
* Don't split after `<` when a collection is in statement position (#589).
* Force a split if the cascade target has non-obvious precedence (#590).
* Split more often if a cascade target contains a split (#591).
* Correctly report unchanged formatting when reading from stdin.

# 0.2.16

* Don't discard type arguments on method calls with closure arguments (#582).

# 0.2.15

* Support `covariant` modifier on methods.

# 0.2.14

* Update to analyzer 0.29.3. This should make dart_style a little more resilient
  to breaking changes in analyzer that add support for new syntax that
  dart_style can't format yet.

# 0.2.13

* Support generic method *parameters* as well as arguments.

# 0.2.12

* Add support for assert() in constructor initializers.
* Correctly indent the right-hand side of `is` and `as` expressions.
* Avoid splitting in index operators when possible.
* Support generic methods (#556).

# 0.2.11+1

* Fix test to not depend on analyzer error message.

# 0.2.11

* Widen dependency on analyzer to allow 0.29.x.

# 0.2.10

* Handle metadata annotations before parameters with trailing commas (#520).
* Always split enum declarations if they end in a trailing comma (#529).
* Add `--set-exit-if-changed` to set the exit code on a change (#365).

# 0.2.9

* Require analyzer 0.27.4, which makes trailing commas on by default.

# 0.2.8

* Format parameter lists with trailing commas like argument lists (#447).

# 0.2.7

* Make it strong mode clean.
* Put labels on their own line (#43).
* Gracefully handle IO errors when failing to overwrite a file (#473).
* Add a blank line after local functions, to match top level ones (#488).
* Improve indentation in non-block-bodied control flow statements (#494).
* Better indentation on very long return types (#503).
* When calling from JS, guess at which error to show when the code cannot be
  parsed (#504).
* Force a conditional operator to split if the condition does (#506).
* Preserve trailing commas in argument and parameter lists (#509).
* Split arguments preceded by comments (#511).
* Remove newlines after script tags (#513).
* Split before a single named argument if the argument itself splits (#514).
* Indent initializers in multiple variable declarations.
* Avoid passing an invalid Windows file URI to analyzer.
* Always split comma-separated sequences that contain a trailing comma.

# 0.2.6

* Support deploying an npm package exporting a formatCode method.

# 0.2.4

* Better handling for long collections with comments (#484).

# 0.2.3

* Support messages in assert() (#411).
* Don't put spaces around magic generic method annotation comments (#477).
* Always put member metadata annotations on their own line (#483).
* Indent functions in named argument lists with non-functions (#478).
* Force the parameter list to split if a split occurs inside a function-typed
  parameter.
* Don't force a split for before a single named argument if the argument itself
  splits.

# 0.2.2

* Upgrade to analyzer 0.27.0.
* Format configured imports and exports.

# 0.2.1

* `--version` command line argument (#240).
* Split the first `.` in a method chain if the target splits (#255).
* Don't collapse states that differ by unbound rule constraints (#424).
* Better handling for functions in method chains (#367, #398).
* Better handling of large parameter metadata annotations (#387, #444).
* Smarter splitting around collections in named parameters (#394).
* Split calls if properties in a chain split (#399).
* Don't allow splitting inside empty functions (#404).
* Consider a rule live if it constrains a rule in the overflow line (#407).
* Allow splitting in prefix expressions (#410).
* Correctly constrain collections in argument lists (#420, #463, #465).
* Better indentation of collection literals (#421, #469).
* Only show a hidden directory once in the output (#428).
* Allow splitting between type and variable name (#429, #439, #454).
* Better indentation for binary operators in `=>` bodies (#434.
* Tweak splitting around assignment (#436, #437).
* Indent multi-line collections in default values (#441).
* Don't drop metadata on part directives (#443).
* Handle `if` statements without curly bodies better (#448).
* Handle loop statements without curly bodies better (#449).
* Allow splitting before `get` and `set` (#462).
* Add `--indent` to specify leading indent (#464).
* Ensure collection elements line split separately (#474).
* Allow redirecting constructors to wrap (#475).
* Handle index expressions in the middle of call chains.
* Optimize splitting lines with many rules.

# 0.2.0

* Treat functions nested inside function calls like block arguments (#366).

# 0.2.0-rc.4

* Smarter indentation for function arguments (#369).

# 0.2.0-rc.3

* Optimize splitting complex lines (#391).

# 0.2.0-rc.2

* Allow splitting between adjacent strings (#201).
* Force multi-line comments to the next line (#241).
* Better splitting in metadata annotations in parameter lists (#247).
* New optimized line splitter (#360, #380).
* Allow splitting after argument name (#368).
* Parsing a statement fails if there is unconsumed input (#372).
* Don't force `for` fully split if initializers or updaters do (#375, #377).
* Split before `deferred` (#381).
* Allow splitting on `as` and `is` expressions (#384).
* Support null-aware operators (`?.`, `??`, and `??=`) (#385).
* Allow splitting before default parameter values (#389).

# 0.2.0-rc.1

* **BREAKING:** The `indent` argument to `new DartFormatter()` is now a number
  of *spaces*, not *indentation levels*.

* This version introduces a new n-way constraint system replacing the previous
  binary constraints. It's mostly an internal change, but allows us to fix a
  number of bugs that the old solver couldn't express solutions to.

  In particular, it forces argument and parameter lists to go one-per-line if
  they don't all fit in two lines. And it allows function and collection
  literals inside expressions to indent like expressions in some contexts.
  (#78, #97, #101, #123, #139, #141, #142, #143, et. al.)

* Indent cascades more deeply when the receiver is a method call (#137).
* Preserve newlines in collections containing line comments (#139).
* Allow multiple variable declarations on one line if they fit (#155).
* Prefer splitting at "." on non-identifier method targets (#161).
* Enforce a blank line before and after classes (#168).
* More precisely control newlines between declarations (#173).
* Preserve mandatory newlines in inline block comments (#178).
* Splitting inside type parameter and type argument lists (#184).
* Nest blocks deeper inside a wrapped conditional operator (#186).
* Split named arguments if the positional arguments split (#189).
* Re-indent line doc comments even if they are flush left (#192).
* Nest cascades like expressions (#200, #203, #205, #221, #236).
* Prefer splitting after `=>` over other options (#217).
* Nested non-empty collections force surrounding ones to split (#223).
* Allow splitting inside with and implements clauses (#228, #259).
* Allow splitting after `=` in a constructor initializer (#242).
* If a `=>` function's parameters split, split after the `=>` too (#250).
* Allow splitting between successive index operators (#256).
* Correctly indent wrapped constructor initializers (#257).
* Set failure exit code for malformed input when reading from stdin (#359).
* Do not nest blocks inside single-argument function and method calls.
* Do nest blocks inside `=>` functions.

# 0.1.8+2

* Allow using analyzer 0.26.0-alpha.0.

# 0.1.8+1

* Use the new `test` package runner internally.

# 0.1.8

* Update to latest `analyzer` and `args` packages.
* Allow cascades with repeated method names to be one line.

# 0.1.7

* Update to latest analyzer (#177).
* Don't discard annotations on initializing formals (#197).
* Optimize formatting deeply nested expressions (#108).
* Discard unused nesting level to improve performance (#108).
* Discard unused spans to improve performance (#108).
* Harden splits that contain too much nesting (#108).
* Try to avoid splitting single-element lists (#211).
* Avoid splitting when the first argument is a function expression (#211).

# 0.1.6

* Allow passing in selection to preserve through command line (#194).

# 0.1.5+1, 0.1.5+2, 0.1.5+3

* Fix test files to work in main Dart repo test runner.

# 0.1.5

* Change executable name from `dartformat` to `dartfmt`.

# 0.1.4

* Don't mangle comma after function-typed initializing formal (#156).
* Add `--dry-run` option to show files that need formatting (#67).
* Try to avoid splitting in before index argument (#158, #160).
* Support `await for` statements (#154).
* Don't delete commas between enum values with doc comments (#171).
* Put a space between nested unary `-` calls (#170).
* Allow `-t` flag to preserve compatibility with old formatter (#166).
* Support `--machine` flag for machine-readable output (#164).
* If no paths are provided, read source from stdin (#165).

# 0.1.3

* Split different operators with the same precedence equally (#130).
* No spaces for empty for loop clauses (#132).
* Don't touch files whose contents did not change (#127).
* Skip formatting files in hidden directories (#125).
* Don't include trailing whitespace when preserving selection (#124).
* Force constructor initialization lists to their own line if the parameter
  list is split across multiple lines (#151).
* Allow splitting in index operator calls (#140).
* Handle sync* and async* syntax (#151).
* Indent the parameter list more if the body is a wrapped "=>" (#144).

# 0.1.2

* Move split conditional operators to the beginning of the next line.

# 0.1.1

* Support formatting enums (#120).
* Handle Windows line endings in multiline strings (#126).
* Increase nesting for conditional operators (#122).
