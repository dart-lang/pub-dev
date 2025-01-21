// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:math' as math;

import 'package:_pub_shared/data/download_counts_data.dart';
import 'package:_pub_shared/format/date_format.dart';
import 'package:_pub_shared/format/number_format.dart';
import 'package:web/web.dart';

import 'computations.dart';

const colors = [
  'blue',
  'red',
  'green',
  'purple',
  'orange',
  'turquoise',
];

String strokeColorClass(int i) => 'downloads-chart-stroke-${colors[i]}';
String fillColorClass(int i) => 'downloads-chart-fill-${colors[i]}';

void create(HTMLElement element, Map<String, String> options) {
  final dataPoints = options['points'];
  if (dataPoints == null) {
    throw UnsupportedError('data-downloads-chart-points required');
  }

  final svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
  svg.setAttribute('height', '100%');
  svg.setAttribute('width', '100%');

  element.append(svg);
  final data = WeeklyVersionDownloadCounts.fromJson((utf8.decoder
      .fuse(json.decoder)
      .convert(base64Decode(dataPoints)) as Map<String, dynamic>));

  final weeksToDisplay = math.min(40, data.totalWeeklyDownloads.length);

  final majorDisplayLists = prepareWeekLists(
    data.totalWeeklyDownloads,
    data.majorRangeWeeklyDownloads,
    weeksToDisplay,
  );

  drawChart(svg, majorDisplayLists, data.newestDate);
}

void drawChart(
    Element svg,
    ({List<String> ranges, List<List<int>> weekLists}) displayLists,
    DateTime newestDate,
    {bool stacked = false}) {
  final ranges = displayLists.ranges;
  final values = displayLists.weekLists;

  if (values.isEmpty) return;

  final frameWidth =
      775; // TODO(zarah): Investigate if this width can be dynamic
  final topPadding = 30;
  final leftPadding = 30;
  final rightPadding = 70; // Make extra room for labels on y-axis
  final chartWidth = frameWidth - leftPadding - rightPadding;
  final chartheight = 420;

  DateTime computeDateForWeekNumber(
      DateTime newestDate, int totalWeeks, int weekNumber) {
    return newestDate.copyWith(
        day: newestDate.day - 7 * (totalWeeks - weekNumber - 1));
  }

  /// Computes max value on y-axis such that we get a nice division for the
  /// interval length between the numbers shown by the ticks on the y axis.
  (int maxY, int interval) computeMaxYAndInterval(List<List<int>> values) {
    final maxDownloads =
        values.fold<int>(1, (a, b) => math.max<int>(a, b.reduce(math.max)));
    final digits = maxDownloads.toString().length;
    final buffer = StringBuffer()..write('1');
    if (digits > 2) {
      buffer.writeAll(List<String>.filled(digits - 2, '0'));
    }
    final firstDiv = int.parse(buffer.toString());
    final candidates = [firstDiv, 2 * firstDiv, 5 * firstDiv, 10 * firstDiv];

    for (final d in candidates) {
      if (maxDownloads / d <= 10) {
        return ((maxDownloads / d).ceil() * d, d);
      }
    }
    // This should not happen! But we don't want to break if it does.
    return (maxDownloads, firstDiv);
  }

  final (maxY, interval) = computeMaxYAndInterval(values);
  final firstDate = computeDateForWeekNumber(newestDate, values.length, 0);
  final xAxisSpan = newestDate.difference(firstDate);

  (double, double) computeCoordinates(DateTime date, int downloads) {
    final duration = date.difference(firstDate);
    // We don't risk division by 0 here, since `xAxisSpan` is a non-zero duration.
    final x = leftPadding +
        chartWidth * duration.inMilliseconds / xAxisSpan.inMilliseconds;

    final y = topPadding + (chartheight - chartheight * (downloads / maxY));
    return (x, y);
  }

  final chart = SVGGElement();
  svg.append(chart);

  // Axis and ticks

  final (xZero, yZero) = computeCoordinates(firstDate, 0);
  final (xMax, yMax) = computeCoordinates(newestDate, maxY);
  final lineThickness = 1;
  final marginPadding = 8;
  final labelPadding = 16;
  final tickLength = 10;
  final tickLabelYCoordinate = yZero + tickLength + labelPadding;

  final xaxis = SVGPathElement();
  xaxis.setAttribute('class', 'downloads-chart-x-axis');
  // We add half of the line thickness at both ends of the x-axis so that it
  // covers the vertical ticks at the end.
  final xAxisStart = xZero - (lineThickness / 2);
  final xAxisEnd = xMax + (lineThickness / 2);
  xaxis.setAttribute('d', 'M$xAxisStart $yZero L$xAxisEnd $yZero');
  chart.append(xaxis);

  late SVGTextElement firstTickLabel;
  // Place a tick every 4 weeks
  for (int week = 0; week < values.length; week += 4) {
    final date = computeDateForWeekNumber(newestDate, values.length, week);
    final (x, y) = computeCoordinates(date, 0);

    final tick = SVGPathElement();
    tick.setAttribute('class', 'downloads-chart-x-axis');
    tick.setAttribute('d', 'M$x $y l0 $tickLength');
    chart.append(tick);

    final tickLabel = SVGTextElement();
    chart.append(tickLabel);
    tickLabel.setAttribute(
        'class', 'downloads-chart-tick-label  downloads-chart-tick-label-x');
    tickLabel.text = formatAbbrMonthDay(date);
    tickLabel.setAttribute('y', '$tickLabelYCoordinate');
    tickLabel.setAttribute('x', '$x');

    if (week == 0) {
      firstTickLabel = tickLabel;
    }
  }

  for (int i = 0; i <= maxY / interval; i++) {
    final (x, y) = computeCoordinates(firstDate, i * interval);

    final tickLabel = SVGTextElement();
    tickLabel.setAttribute(
        'class', 'downloads-chart-tick-label  downloads-chart-tick-label-y');
    tickLabel.text =
        '${compactFormat(i * interval).value}${compactFormat(i * interval).suffix}';
    tickLabel.setAttribute('x', '${xMax + marginPadding}');
    tickLabel.setAttribute('y', '$y');
    chart.append(tickLabel);

    if (i == 0) {
      // No long tick in the bottom, we have the x-axis here.
      continue;
    }

    final longTick = SVGPathElement();
    longTick.setAttribute('class', 'downloads-chart-frame');
    longTick.setAttribute('d', 'M$xAxisStart $y L$xAxisEnd $y');
    chart.append(longTick);
  }

  // We use the clipPath to cut the ends of the chart lines so that we don't
  // draw outside the frame of the chart.
  final clipPath = SVGClipPathElement();
  clipPath.setAttribute('id', 'clipRect');
  final clipRect = SVGRectElement();
  clipRect.setAttribute('y', '$yMax');
  clipRect.setAttribute('height', '${chartheight - (lineThickness / 2)}');
  clipRect.setAttribute('x', '$xZero');
  clipRect.setAttribute('width', '$chartWidth');
  clipPath.append(clipRect);
  chart.append(clipPath);

  // Chart lines and legends

  final lines = <StringBuffer>[];
  for (int versionRange = 0; versionRange < values[0].length; versionRange++) {
    final line = StringBuffer();
    var c = 'M';
    for (int week = 0; week < values.length; week++) {
      final (x, y) = computeCoordinates(
          computeDateForWeekNumber(newestDate, values.length, week),
          values[week][versionRange]);
      line.write(' $c$x $y');
      c = 'L';
    }
    lines.add(line);
  }

  double legendX = xZero;
  double legendY =
      tickLabelYCoordinate + firstTickLabel.getBBox().height + labelPadding;
  final legendWidth = 20;
  final legendHeight = 8;

  for (int i = 0; i < lines.length; i++) {
    final path = SVGPathElement();
    path.setAttribute('class', '${strokeColorClass(i)} downloads-chart-line ');
    // We assign colors in reverse order so that main colors are chosen first for
    // the newest versions.
    path.setAttribute('d', '${lines[lines.length - 1 - i]}');
    path.setAttribute('clip-path', 'url(#clipRect)');
    chart.append(path);

    final legend = SVGRectElement();
    chart.append(legend);
    legend.setAttribute('class',
        'downloads-chart-legend ${fillColorClass(i)} ${strokeColorClass(i)}');
    legend.setAttribute('height', '$legendHeight');
    legend.setAttribute('width', '$legendWidth');

    final legendLabel = SVGTextElement();
    chart.append(legendLabel);
    legendLabel.setAttribute('class', 'downloads-chart-tick-label');
    legendLabel.text = ranges[ranges.length - 1 - i];

    if (legendX + marginPadding + legendWidth + legendLabel.getBBox().width >
        xMax) {
      // There is no room for the legend and label.
      // Make a new line and update legendXCoor and legendYCoor accordingly.

      legendX = xZero;
      legendY += 2 * marginPadding + legendHeight;
    }

    legend.setAttribute('x', '$legendX');
    legend.setAttribute('y', '$legendY');
    legendLabel.setAttribute('y', '${legendY + legendHeight}');
    legendLabel.setAttribute('x', '${legendX + marginPadding + legendWidth}');

    // Update x coordinate for next legend
    legendX += legendWidth +
        marginPadding +
        legendLabel.getBBox().width +
        labelPadding;
  }

  final frameHeight = legendY + marginPadding + labelPadding;
  final frame = SVGRectElement()
    ..setAttribute('class', 'downloads-chart-frame')
    ..setAttribute('height', '$frameHeight')
    ..setAttribute('width', '$frameWidth')
    ..setAttribute('rx', '15')
    ..setAttribute('ry', '15');
  chart.append(frame);
}
