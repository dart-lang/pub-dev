library pub_dartlang_org.shared.mock_scores;

import 'package:json_serializable/annotations.dart';

part 'mock_scores.g.dart';

// TODO: remove after proper score handling is implemented
@JsonLiteral('mock_scores.json', asConst: true)
Map<String, num> get mockScores => _$mockScoresJsonLiteral;
