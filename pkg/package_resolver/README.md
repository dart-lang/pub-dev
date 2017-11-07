A package that defines a common class, [`PackageResolver`][PackageResolver], for
defining how to resolve `package:` URIs. This class may be based on the current
isolate's package resolution strategy, but it may also be explicitly defined by
the user—for example, you could create a resolver that represents the strategy
used to compile a `.dart.js` file.

[PackageResolver]: https://www.dartdocs.org/documentation/package_resolver/latest/package_resolver/PackageResolver-class.html

The Dart VM provides two mutually exclusive means of resolving `package:` URIs:
a **package spec** and a **package root**.

* A package spec usually comes in the form of a `.packages` file on the
  filesystem. It defines an individual root URL for each package name, so that
  `package:$name/$path` resolves to `$root/$path`.

* A package root is a single URL that acts as the base for all `package:` URIs,
  so that `package:$name/$path` resolves to `$base/$name/$path`.

This normalizes access to these resolution schemes, and makes it easy for code
to resolve package URIs no matter where the resolution information comes from.
