// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

void main() {
  group('Score', () {
    void percentScorePenalty(
        Coverage c, double percent, double score, double penalty) {
      expect(c.percent, closeTo(percent, 0.001));
      expect(c.score, closeTo(score, 0.001));
      expect(c.penalty, closeTo(penalty, 0.001));
    }

    test('no data', () {
      percentScorePenalty(Coverage(total: 0, documented: 0), 1.0, 1.0, 0.0);
    });

    test('full coverage', () {
      percentScorePenalty(Coverage(total: 10, documented: 10), 1.0, 1.0, 0.0);
    });

    test('half coverage', () {
      percentScorePenalty(Coverage(total: 10, documented: 5), 0.5, 0.875, 0.0);
    });

    test('20% coverage', () {
      percentScorePenalty(Coverage(total: 10, documented: 2), 0.2, 0.488, 0.0);
    });

    test('10% coverage', () {
      percentScorePenalty(Coverage(total: 10, documented: 1), 0.1, 0.271, 0.0);
    });

    test('5% coverage', () {
      percentScorePenalty(
          Coverage(total: 100, documented: 5), 0.05, 0.143, 0.0);
    });

    test('4% coverage', () {
      percentScorePenalty(
          Coverage(total: 100, documented: 4), 0.04, 0.115, 0.0);
    });

    test('3% coverage', () {
      percentScorePenalty(
          Coverage(total: 100, documented: 3), 0.03, 0.087, 0.127);
    });

    test('2% coverage', () {
      percentScorePenalty(
          Coverage(total: 100, documented: 2), 0.02, 0.059, 0.412);
    });

    test('1% coverage', () {
      percentScorePenalty(
          Coverage(total: 100, documented: 1), 0.01, 0.030, 0.703);
    });

    test('0.5% coverage', () {
      percentScorePenalty(
          Coverage(total: 1000, documented: 5), 0.005, 0.0149, 0.851);
    });

    test('0% coverage', () {
      percentScorePenalty(Coverage(total: 100, documented: 0), 0.0, 0.0, 1.0);
    });
  });
}
