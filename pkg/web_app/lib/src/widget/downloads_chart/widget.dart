// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/download_counts_data.dart';
import 'package:web/web.dart';

void create(HTMLElement element, Map<String, String> options) {
  final dataPoints = options['points'];
  if (dataPoints == null) {
    throw UnsupportedError('data-downloads-chart-points required');
  }

  final svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
  element.append(svg);
  final data = WeeklyVersionDownloadCounts.fromJson((utf8.decoder
      .fuse(json.decoder)
      .convert(base64Decode(dataPoints)) as Map<String, dynamic>));
  drawChart(svg, data);
}

void drawChart(Element svg, WeeklyVersionDownloadCounts data) {}
