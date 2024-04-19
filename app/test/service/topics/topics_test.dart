// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:convert';

import 'package:gcloud/storage.dart';
import 'package:pub_dev/service/topics/count_topics.dart';
import 'package:pub_dev/service/topics/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../../frontend/handlers/_utils.dart';
import '../../shared/test_services.dart';

void main() {
  testWithProfile('succesful topics upload', fn: () async {
    await countTopics();

    final data = await storageService
        .bucket(activeConfiguration.reportsBucketName!)
        .read(topicsJsonFileName)
        .transform(utf8.decoder)
        .transform(json.decoder)
        .single;

    // The default test profile has 3 packages that all get tagged with
    // the topic 'chemical-element'.
    expect(data, {'chemical-element': 3});

    await expectHtmlResponse(
      await issueGet('/topics'),
      present: [
        'chemical-element',
      ],
    );
  });

  test('isValidTopicFormat', () {
    expect(isValidTopicFormat('widget'), isTrue);
    expect(isValidTopicFormat('abc'), isTrue);
    expect(isValidTopicFormat('foo-bar'), isTrue);
    expect(isValidTopicFormat('foo42'), isTrue);

    expect(isValidTopicFormat('-widget'), isFalse);
    expect(isValidTopicFormat('a'), isFalse);
    expect(isValidTopicFormat('foo-'), isFalse);
    expect(isValidTopicFormat('42bar'), isFalse);
  });

  test('validate doc/topics.yaml', () {
    // First we ensure that topics are loaded, this validates the file format!
    final topics = canonicalTopics.topics;

    // Check that we have some data.
    expect(topics, isNotEmpty);

    // Check if there are any duplicate topics!
    final duplicates = topics.map((e) => e.topic).toList().duplicates();
    if (duplicates.isNotEmpty) {
      fail(
        '"doc/topics.yaml" must not have duplicate entries, '
        'found: ${duplicates.join(', ')}',
      );
    }

    // Check if any canonical topics are aliases for other topics
    for (final topic in topics.map((e) => e.topic)) {
      if (topics.any((e) => e.aliases.contains(topic))) {
        fail('The canonical topic "$topic" is also listed in "aliases"!');
      }
    }

    // Check that each alias is only used once!
    for (final alias in topics.expand((e) => e.aliases)) {
      if (topics.where((e) => e.aliases.contains(alias)).length > 1) {
        fail('The alias "$alias" is listed in "aliases" for two topics!');
      }
    }
  });

  test('duplicates', () {
    expect([1, 2, 3, 4, 5, 1].duplicates(), contains(1));
    expect([1, 2, 3, 4, 5].duplicates(), isEmpty);
    expect([1, 2, 3, 4, 5, 5, 5].duplicates(), contains(5));
    expect([1, 2, 1, 3, 4, 5, 5, 5].duplicates(), contains(5));
    expect([5, 2, 1, 3, 4, 5, 5, 5].duplicates(), contains(5));
  });
}

extension<T> on List<T> {
  /// Return elements that appear more than once in this [List].
  Set<T> duplicates() {
    final duplicates = <T>{};
    final N = length;
    for (var i = 0; i < N; i++) {
      final candidate = this[i];
      for (var j = i + 1; j < N; j++) {
        if (candidate == this[j]) {
          duplicates.add(candidate);
          break;
        }
      }
    }
    return duplicates;
  }
}
