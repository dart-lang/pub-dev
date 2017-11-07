# 1.3.2

* Fix a checked-mode error in `VersionRange.difference()`.

# 1.3.1

* Fix a new strong mode error.

# 1.3.0

* Make the `VersionUnion` class public. This was previously used internally to
  implement `new VersionConstraint.unionOf()` and `VersionConstraint.union()`.
  Now it's public so you can use it too.

* Added `VersionConstraint.difference()`. This returns a constraint matching all
  versions matched by one constraint but not another.

* Make `VersionRange` implement `Comparable<VersionRange>`. Ranges are ordered
  first by lower bound, then by upper bound.

# 1.2.4

* Fix all remaining strong mode warnings.

# 1.2.3

* Addressed three strong mode warnings.

# 1.2.2

* Make the package analyze under strong mode and compile with the DDC (Dart Dev
  Compiler). Fix two issues with a private subclass of `VersionConstraint`
  having different types for overridden methods.

# 1.2.1

* Allow version ranges like `>=1.2.3-dev.1 <1.2.3` to match pre-release versions
  of `1.2.3`. Previously, these didn't match, since the pre-release versions had
  the same major, minor, and patch numbers as the max; now an exception has been
  added if they also have the same major, minor, and patch numbers as the min
  *and* the min is also a pre-release version.

# 1.2.0

* Add a `VersionConstraint.union()` method and a `new
  VersionConstraint.unionOf()` constructor. These each return a constraint that
  matches multiple existing constraints.

* Add a `VersionConstraint.allowsAll()` method, which returns whether one
  constraint is a superset of another.

* Add a `VersionConstraint.allowsAny()` method, which returns whether one
  constraint overlaps another.

* `Version` now implements `VersionRange`.

# 1.1.0

* Add support for the `^` operator for compatible versions according to pub's
  notion of compatibility. `^1.2.3` is equivalent to `>=1.2.3 <2.0.0`; `^0.1.2`
  is equivalent to `>=0.1.2 <0.2.0`.

* Add `Version.nextBreaking`, which returns the next version that introduces
  breaking changes after a given version.

* Add `new VersionConstraint.compatibleWith()`, which returns a range covering
  all versions compatible with a given version.

* Add a custom `VersionRange.hashCode` to make it properly hashable.

# 1.0.0

* Initial release.
