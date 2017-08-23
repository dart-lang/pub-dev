// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.shared.mock_scores;

import 'package:json_serializable/annotations.dart';

part 'mock_scores.g.dart';

// TODO: remove after proper score handling is implemented
@JsonLiteral('mock_scores.json', asConst: true)
Map<String, num> get mockScores => _$mockScoresJsonLiteral;
