## 0.13.7

* Add explicit support for forwarding the value returned by `Command.run()` to
  `CommandRunner.run()`. This worked unintentionally prior to 0.13.6+1.

* Add type arguments to `CommandRunner` and `Command` to indicate the return
  values of the `run()` functions.

## 0.13.6+1

* When a `CommandRunner` is passed `--help` before any commands, it now prints
  the usage of the chosen command.

## 0.13.6

* `ArgParser.parse()` now throws an `ArgParserException`, which implements
  `FormatException` and has a field that lists the commands that were parsed.

* If `CommandRunner.run()` encounters a parse error for a subcommand, it now
  prints the subcommand's usage rather than the global usage.

## 0.13.5

* Allow `CommandRunner.argParser` and `Command.argParser` to be overridden in
  strong mode.

## 0.13.4+2

* Fix a minor documentation error.

## 0.13.4+1

* Ensure that multiple-value arguments produce reified `List<String>`s.

## 0.13.4

* By default, only the first line of a command's description is included in its
  parent runner's usage string. This returns to the default behavior from
  before 0.13.3+1.

* A `Command.summary` getter has been added to explicitly control the summary
  that appears in the parent runner's usage string. This getter defaults to the
  first line of the description, but can be overridden if the user wants a
  multi-line summary.

## 0.13.3+6

* README fixes.

## 0.13.3+5

* Make strong mode clean.

## 0.13.3+4

* Use the proper `usage` getter in the README.

## 0.13.3+3

* Add an explicit default value for the `allowTrailingOptions` parameter to `new
  ArgParser()`. This doesn't change the behavior at all; the option already
  defaulted to `false`, and passing in `null` still works.

## 0.13.3+2

* Documentation fixes.

## 0.13.3+1

* Print all lines of multi-line command descriptions.

## 0.13.2

* Allow option values that look like options. This more closely matches the
  behavior of [`getopt`][getopt], the *de facto* standard for option parsing.

[getopt]: http://man7.org/linux/man-pages/man3/getopt.3.html

## 0.13.1

* Add `ArgParser.addSeparator()`. Separators allow users to group their options
  in the usage text.

## 0.13.0

* **Breaking change**: An option that allows multiple values will now
  automatically split apart comma-separated values. This can be controlled with
  the `splitCommas` option.

## 0.12.2+6

* Remove the dependency on the `collection` package.

## 0.12.2+5

* Add syntax highlighting to the README.

## 0.12.2+4

* Add an example of using command-line arguments to the README.

## 0.12.2+3

* Fixed implementation of ArgResults.options to really use Iterable<String>
  instead of Iterable<dynamic> cast to Iterable<String>.

## 0.12.2+2

* Updated dependency constraint on `unittest`.

* Formatted source code.

* Fixed use of deprecated API in example.

## 0.12.2+1

* Fix the built-in `help` command for `CommandRunner`.

## 0.12.2

* Add `CommandRunner` and `Command` classes which make it easy to build a
  command-based command-line application.

* Add an `ArgResults.arguments` field, which contains the original argument list.

## 0.12.1

* Replace `ArgParser.getUsage()` with `ArgParser.usage`, a getter.
  `ArgParser.getUsage()` is now deprecated, to be removed in args version 1.0.0.

## 0.12.0+2

* Widen the version constraint on the `collection` package.

## 0.12.0+1

* Remove the documentation link from the pubspec so this is linked to
  pub.dartlang.org by default.

## 0.12.0

* Removed public constructors for `ArgResults` and `Option`.

* `ArgResults.wasParsed()` can be used to determine if an option was actually
  parsed or the default value is being returned.

* Replaced `isFlag` and `allowMultiple` fields in the `Option` class with a
  three-value `OptionType` enum.

* Options may define `valueHelp` which will then be shown in the usage.

## 0.11.0

* Move handling trailing options from `ArgParser.parse()` into `ArgParser`
  itself. This lets subcommands have different behavior for how they handle
  trailing options.

## 0.10.0+2

* Usage ignores hidden options when determining column widths.
