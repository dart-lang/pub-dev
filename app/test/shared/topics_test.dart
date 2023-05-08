// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:convert';

import 'package:gcloud/storage.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/count_topics.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/test_services.dart';

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
}
