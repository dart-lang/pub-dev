// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'utils.dart';
import 'version.dart';
import 'version_constraint.dart';
import 'version_union.dart';

/// Constrains versions to a fall within a given range.
///
/// If there is a minimum, then this only allows versions that are at that
/// minimum or greater. If there is a maximum, then only versions less than
/// that are allowed. In other words, this allows `>= min, < max`.
///
/// Version ranges are ordered first by their lower bounds, then by their upper
/// bounds. For example, `>=1.0.0 <2.0.0` is before `>=1.5.0 <2.0.0` is before
/// `>=1.5.0 <3.0.0`.
class VersionRange implements Comparable<VersionRange>, VersionConstraint {
  /// The minimum end of the range.
  ///
  /// If [includeMin] is `true`, this will be the minimum allowed version.
  /// Otherwise, it will be the highest version below the range that is not
  /// allowed.
  ///
  /// This may be `null` in which case the range has no minimum end and allows
  /// any version less than the maximum.
  final Version min;

  /// The maximum end of the range.
  ///
  /// If [includeMax] is `true`, this will be the maximum allowed version.
  /// Otherwise, it will be the lowest version above the range that is not
  /// allowed.
  ///
  /// This may be `null` in which case the range has no maximum end and allows
  /// any version greater than the minimum.
  final Version max;

  /// If `true` then [min] is allowed by the range.
  final bool includeMin;

  /// If `true`, then [max] is allowed by the range.
  final bool includeMax;

  /// Creates a new version range from [min] to [max], either inclusive or
  /// exclusive.
  ///
  /// If it is an error if [min] is greater than [max].
  ///
  /// Either [max] or [min] may be omitted to not clamp the range at that end.
  /// If both are omitted, the range allows all versions.
  ///
  /// If [includeMin] is `true`, then the minimum end of the range is inclusive.
  /// Likewise, passing [includeMax] as `true` makes the upper end inclusive.
  VersionRange({this.min, this.max,
      this.includeMin: false, this.includeMax: false}) {
    if (min != null && max != null && min > max) {
      throw new ArgumentError(
          'Minimum version ("$min") must be less than maximum ("$max").');
    }
  }

  bool operator ==(other) {
    if (other is! VersionRange) return false;

    return min == other.min &&
           max == other.max &&
           includeMin == other.includeMin &&
           includeMax == other.includeMax;
  }

  int get hashCode => min.hashCode ^ (max.hashCode * 3) ^
      (includeMin.hashCode * 5) ^ (includeMax.hashCode * 7);

  bool get isEmpty => false;

  bool get isAny => min == null && max == null;

  /// Tests if [other] falls within this version range.
  bool allows(Version other) {
    if (min != null) {
      if (other < min) return false;
      if (!includeMin && other == min) return false;
    }

    if (max != null) {
      if (other > max) return false;
      if (!includeMax && other == max) return false;


      // Disallow pre-release versions that have the same major, minor, and
      // patch version as the max, but only if neither the max nor the min is a
      // pre-release of that version. This ensures that "^1.2.3" doesn't include
      // "2.0.0-pre", while also allowing both ">=2.0.0-pre.2 <2.0.0" and
      // ">=1.2.3 <2.0.0-pre.7" to match "2.0.0-pre.5".
      //
      // It's worth noting that this is different than [NPM's semantics][]. NPM
      // disallows **all** pre-release versions unless their major, minor, and
      // patch numbers match those of a prerelease min or max. This ensures that
      // no prerelease versions will ever be selected if the user doesn't
      // explicitly allow them.
      //
      // [NPM's semantics]: https://www.npmjs.org/doc/misc/semver.html#prerelease-tags
      //
      // Instead, we ensure that release versions will always be preferred over
      // prerelease versions by ordering the release versions first in
      // [Version.prioritize]. This means that constraints like "any" or
      // ">1.2.3" can still match prerelease versions if they're the only things
      // available.
      var maxIsReleaseOfOther = !includeMax &&
          !max.isPreRelease && other.isPreRelease &&
          _equalsWithoutPreRelease(other, max);
      var minIsPreReleaseOfOther = min != null && min.isPreRelease &&
          _equalsWithoutPreRelease(other, min);
      if (maxIsReleaseOfOther && !minIsPreReleaseOfOther) return false;
    }

    return true;
  }

  bool _equalsWithoutPreRelease(Version version1, Version version2) =>
      version1.major == version2.major &&
          version1.minor == version2.minor &&
          version1.patch == version2.patch;

  bool allowsAll(VersionConstraint other) {
    if (other.isEmpty) return true;
    if (other is Version) return allows(other);

    if (other is VersionUnion) {
      return other.ranges.every((constraint) => allowsAll(constraint));
    }

    if (other is VersionRange) {
      if (min != null) {
        if (other.min == null) return false;
        if (min > other.min) return false;
        if (min == other.min && !includeMin && other.includeMin) return false;
      }

      if (max != null) {
        if (other.max == null) return false;
        if (max < other.max) return false;
        if (max == other.max && !includeMax && other.includeMax) return false;
      }

      return true;
    }

    throw new ArgumentError('Unknown VersionConstraint type $other.');
  }

  bool allowsAny(VersionConstraint other) {
    if (other.isEmpty) return false;
    if (other is Version) return allows(other);

    if (other is VersionUnion) {
      return other.ranges.any((constraint) => allowsAny(constraint));
    }

    if (other is VersionRange) {
      return !strictlyLower(other, this) && !strictlyHigher(other, this);
    }

    throw new ArgumentError('Unknown VersionConstraint type $other.');
  }

  VersionConstraint intersect(VersionConstraint other) {
    if (other.isEmpty) return other;
    if (other is VersionUnion) return other.intersect(this);

    // A range and a Version just yields the version if it's in the range.
    if (other is Version) {
      return allows(other) ? other : VersionConstraint.empty;
    }

    if (other is VersionRange) {
      // Intersect the two ranges.
      var intersectMin = min;
      var intersectIncludeMin = includeMin;
      var intersectMax = max;
      var intersectIncludeMax = includeMax;

      if (other.min == null) {
        // Do nothing.
      } else if (intersectMin == null || intersectMin < other.min) {
        intersectMin = other.min;
        intersectIncludeMin = other.includeMin;
      } else if (intersectMin == other.min && !other.includeMin) {
        // The edges are the same, but one is exclusive, make it exclusive.
        intersectIncludeMin = false;
      }

      if (other.max == null) {
        // Do nothing.
      } else if (intersectMax == null || intersectMax > other.max) {
        intersectMax = other.max;
        intersectIncludeMax = other.includeMax;
      } else if (intersectMax == other.max && !other.includeMax) {
        // The edges are the same, but one is exclusive, make it exclusive.
        intersectIncludeMax = false;
      }

      if (intersectMin == null && intersectMax == null) {
        // Open range.
        return new VersionRange();
      }

      // If the range is just a single version.
      if (intersectMin == intersectMax) {
        // If both ends are inclusive, allow that version.
        if (intersectIncludeMin && intersectIncludeMax) return intersectMin;

        // Otherwise, no versions.
        return VersionConstraint.empty;
      }

      if (intersectMin != null && intersectMax != null &&
          intersectMin > intersectMax) {
        // Non-overlapping ranges, so empty.
        return VersionConstraint.empty;
      }

      // If we got here, there is an actual range.
      return new VersionRange(min: intersectMin, max: intersectMax,
          includeMin: intersectIncludeMin, includeMax: intersectIncludeMax);
    }

    throw new ArgumentError('Unknown VersionConstraint type $other.');
  }

  VersionConstraint union(VersionConstraint other) {
    if (other is Version) {
      if (allows(other)) return this;

      if (other == min) {
        return new VersionRange(
            min: this.min, max: this.max,
            includeMin: true, includeMax: this.includeMax);
      }

      if (other == max) {
        return new VersionRange(
            min: this.min, max: this.max,
            includeMin: this.includeMin, includeMax: true);
      }

      return new VersionConstraint.unionOf([this, other]);
    }

    if (other is VersionRange) {
      // If the two ranges don't overlap, we won't be able to create a single
      // VersionRange for both of them.
      var edgesTouch = (max == other.min && (includeMax || other.includeMin)) ||
          (min == other.max && (includeMin || other.includeMax));
      if (!edgesTouch && !allowsAny(other)) {
        return new VersionConstraint.unionOf([this, other]);
      }

      var unionMin = min;
      var unionIncludeMin = includeMin;
      var unionMax = max;
      var unionIncludeMax = includeMax;

      if (unionMin == null) {
        // Do nothing.
      } else if (other.min == null || other.min < min) {
        unionMin = other.min;
        unionIncludeMin = other.includeMin;
      } else if (min == other.min && other.includeMin) {
        // If the edges are the same but one is inclusive, make it inclusive.
        unionIncludeMin = true;
      }

      if (unionMax == null) {
        // Do nothing.
      } else if (other.max == null || other.max > max) {
        unionMax = other.max;
        unionIncludeMax = other.includeMax;
      } else if (max == other.max && other.includeMax) {
        // If the edges are the same but one is inclusive, make it inclusive.
        unionIncludeMax = true;
      }

      return new VersionRange(min: unionMin, max: unionMax,
          includeMin: unionIncludeMin, includeMax: unionIncludeMax);
    }

    return new VersionConstraint.unionOf([this, other]);
  }

  VersionConstraint difference(VersionConstraint other) {
    if (other.isEmpty) return this;

    if (other is Version) {
      if (!allows(other)) return this;

      if (other == min) {
        if (!includeMin) return this;
        return new VersionRange(
            min: min, max: max,
            includeMin: false, includeMax: includeMax);
      }

      if (other == max) {
        if (!includeMax) return this;
        return new VersionRange(
            min: min, max: max,
            includeMin: includeMin, includeMax: false);
      }

      return new VersionUnion.fromRanges([
        new VersionRange(
            min: min, max: other,
            includeMin: includeMin, includeMax: false),
        new VersionRange(
            min: other, max: max,
            includeMin: false, includeMax: includeMax)
      ]);
    } else if (other is VersionRange) {
      if (!allowsAny(other)) return this;

      VersionRange before;
      if (!allowsLower(this, other)) {
        before = null;
      } else if (min == other.min) {
        assert(includeMin && !other.includeMin);
        assert(min != null);
        before = min;
      } else {
        before = new VersionRange(
            min: min, max: other.min,
            includeMin: includeMin, includeMax: !other.includeMin);
      }

      VersionRange after;
      if (!allowsHigher(this, other)) {
        after = null;
      } else if (max == other.max) {
        assert(includeMax && !other.includeMax);
        assert(max != null);
        after = max;
      } else {
        after = new VersionRange(
            min: other.max, max: max,
            includeMin: !other.includeMax, includeMax: includeMax);
      }

      if (before == null && after == null) return VersionConstraint.empty;
      if (before == null) return after;
      if (after == null) return before;
      return new VersionUnion.fromRanges([before, after]);
    } else if (other is VersionUnion) {
      var ranges = <VersionRange>[];
      var current = this;

      for (var range in other.ranges) {
        // Skip any ranges that are strictly lower than [current].
        if (strictlyLower(range, current)) continue;

        // If we reach a range strictly higher than [current], no more ranges
        // will be relevant so we can bail early.
        if (strictlyHigher(range, current)) break;

        var difference = current.difference(range);
        if (difference is VersionUnion) {
          // If [range] split [current] in half, we only need to continue
          // checking future ranges against the latter half.
          assert(difference.ranges.length == 2);
          ranges.add(difference.ranges.first);
          current = difference.ranges.last;
        } else {
          current = difference as VersionRange;
        }
      }

      if (ranges.isEmpty) return current;
      return new VersionUnion.fromRanges(ranges..add(current));
    }

    throw new ArgumentError('Unknown VersionConstraint type $other.');
  }

  int compareTo(VersionRange other) {
    if (min == null) {
      if (other.min == null) return _compareMax(other);
      return -1;
    } else if (other.min == null) {
      return 1;
    }

    var result = min.compareTo(other.min);
    if (result != 0) return result;
    if (includeMin != other.includeMin) return includeMin ? -1 : 1;

    return _compareMax(other);
  }

  /// Compares the maximum values of [this] and [other].
  int _compareMax(VersionRange other) {
    if (max == null) {
      if (other.max == null) return 0;
      return 1;
    } else if (other.max == null) {
      return -1;
    }

    var result = max.compareTo(other.max);
    if (result != 0) return result;
    if (includeMax != other.includeMax) return includeMax ? 1 : -1;
    return 0;
  }

  String toString() {
    var buffer = new StringBuffer();

    if (min != null) {
      buffer.write(includeMin ? '>=' : '>');
      buffer.write(min);
    }

    if (max != null) {
      if (min != null) buffer.write(' ');
      buffer.write(includeMax ? '<=' : '<');
      buffer.write(max);
    }

    if (min == null && max == null) buffer.write('any');
    return buffer.toString();
  }
}
