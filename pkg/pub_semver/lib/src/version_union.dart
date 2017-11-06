// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'utils.dart';
import 'version.dart';
import 'version_constraint.dart';
import 'version_range.dart';

/// A version constraint representing a union of multiple disjoint version
/// ranges.
///
/// An instance of this will only be created if the version can't be represented
/// as a non-compound value.
class VersionUnion implements VersionConstraint {
  /// The constraints that compose this union.
  ///
  /// This list has two invariants:
  ///
  /// * Its contents are sorted using the standard ordering of [VersionRange]s.
  /// * Its contents are disjoint and non-adjacent. In other words, for any two
  ///   constraints next to each other in the list, there's some version between
  ///   those constraints that they don't match.
  final List<VersionRange> ranges;

  bool get isEmpty => false;

  bool get isAny => false;

  /// Creates a union from a list of ranges with no pre-processing.
  ///
  /// It's up to the caller to ensure that the invariants described in [ranges]
  /// are maintained. They are not verified by this constructor. To
  /// automatically ensure that they're maintained, use [new
  /// VersionConstraint.unionOf] instead.
  VersionUnion.fromRanges(this.ranges);

  bool allows(Version version) =>
      ranges.any((constraint) => constraint.allows(version));

  bool allowsAll(VersionConstraint other) {
    var ourRanges = ranges.iterator;
    var theirRanges = _rangesFor(other).iterator;

    // Because both lists of ranges are ordered by minimum version, we can
    // safely move through them linearly here.
    ourRanges.moveNext();
    theirRanges.moveNext();
    while (ourRanges.current != null && theirRanges.current != null) {
      if (ourRanges.current.allowsAll(theirRanges.current)) {
        theirRanges.moveNext();
      } else {
        ourRanges.moveNext();
      }
    }

    // If our ranges have allowed all of their ranges, we'll have consumed all
    // of them.
    return theirRanges.current == null;
  }

  bool allowsAny(VersionConstraint other) {
    var ourRanges = ranges.iterator;
    var theirRanges = _rangesFor(other).iterator;

    // Because both lists of ranges are ordered by minimum version, we can
    // safely move through them linearly here.
    ourRanges.moveNext();
    theirRanges.moveNext();
    while (ourRanges.current != null && theirRanges.current != null) {
      if (ourRanges.current.allowsAny(theirRanges.current)) {
        return true;
      }

      // Move the constraint with the lower max value forward. This ensures that
      // we keep both lists in sync as much as possible.
      if (allowsHigher(theirRanges.current, ourRanges.current)) {
        ourRanges.moveNext();
      } else {
        theirRanges.moveNext();
      }
    }

    return false;
  }

  VersionConstraint intersect(VersionConstraint other) {
    var ourRanges = ranges.iterator;
    var theirRanges = _rangesFor(other).iterator;

    // Because both lists of ranges are ordered by minimum version, we can
    // safely move through them linearly here.
    var newRanges = <VersionRange>[];
    ourRanges.moveNext();
    theirRanges.moveNext();
    while (ourRanges.current != null && theirRanges.current != null) {
      var intersection = ourRanges.current
          .intersect(theirRanges.current);

      if (!intersection.isEmpty) newRanges.add(intersection);

      // Move the constraint with the lower max value forward. This ensures that
      // we keep both lists in sync as much as possible, and that large ranges
      // have a chance to match multiple small ranges that they contain.
      if (allowsHigher(theirRanges.current, ourRanges.current)) {
        ourRanges.moveNext();
      } else {
        theirRanges.moveNext();
      }
    }

    if (newRanges.isEmpty) return VersionConstraint.empty;
    if (newRanges.length == 1) return newRanges.single;

    return new VersionUnion.fromRanges(newRanges);
  }

  VersionConstraint difference(VersionConstraint other) {
    var ourRanges = ranges.iterator;
    var theirRanges = _rangesFor(other).iterator;

    var newRanges = <VersionRange>[];
    ourRanges.moveNext();
    theirRanges.moveNext();
    var current = ourRanges.current;

    theirNextRange() {
      if (theirRanges.moveNext()) return true;

      // If there are no more of their ranges, none of the rest of our ranges
      // need to be subtracted so we can add them as-is.
      newRanges.add(current);
      while (ourRanges.moveNext()) {
        newRanges.add(ourRanges.current);
      }
      return false;
    }

    ourNextRange({bool includeCurrent: true}) {
      if (includeCurrent) newRanges.add(current);
      if (!ourRanges.moveNext()) return false;
      current = ourRanges.current;
      return true;
    }

    while (true) {
      // If the current ranges are disjoint, move the lowest one forward.
      if (strictlyLower(theirRanges.current, current)) {
        if (!theirNextRange()) break;
        continue;
      }

      if (strictlyHigher(theirRanges.current, current)) {
        if (!ourNextRange()) break;
        continue;
      }

      // If we're here, we know [theirRanges.current] overlaps [current].
      var difference = current.difference(theirRanges.current);
      if (difference is VersionUnion) {
        // If their range split [current] in half, we only need to continue
        // checking future ranges against the latter half.
        assert(difference.ranges.length == 2);
        newRanges.add(difference.ranges.first);
        current = difference.ranges.last;

        // Since their range split [current], it definitely doesn't allow higher
        // versions, so we should move their ranges forward.
        if (!theirNextRange()) break;
      } else if (difference.isEmpty) {
        if (!ourNextRange(includeCurrent: false)) break;
      } else {
        current = difference as VersionRange;

        // Move the constraint with the lower max value forward. This ensures
        // that we keep both lists in sync as much as possible, and that large
        // ranges have a chance to subtract or be subtracted by multiple small
        // ranges that they contain.
        if (allowsHigher(current, theirRanges.current)) {
          if (!theirNextRange()) break;
        } else {
          if (!ourNextRange()) break;
        }
      }
    }

    if (newRanges.isEmpty) return VersionConstraint.empty;
    if (newRanges.length == 1) return newRanges.single;
    return new VersionUnion.fromRanges(newRanges);
  }

  /// Returns [constraint] as a list of ranges.
  ///
  /// This is used to normalize ranges of various types.
  List<VersionRange> _rangesFor(VersionConstraint constraint) {
    if (constraint.isEmpty) return [];
    if (constraint is VersionUnion) return constraint.ranges;
    if (constraint is VersionRange) return [constraint];
    throw new ArgumentError('Unknown VersionConstraint type $constraint.');
  }

  VersionConstraint union(VersionConstraint other) =>
      new VersionConstraint.unionOf([this, other]);

  bool operator ==(other) {
    if (other is! VersionUnion) return false;
    return const ListEquality().equals(ranges, other.ranges);
  }

  int get hashCode => const ListEquality().hash(ranges);

  String toString() => ranges.join(" or ");
}
