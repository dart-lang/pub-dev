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

const lineColorClasses = [
  'downloads-chart-line-color-blue',
  'downloads-chart-line-color-red',
  'downloads-chart-line-color-green',
  'downloads-chart-line-color-purple',
  'downloads-chart-line-color-orange',
  'downloads-chart-line-color-turquoise',
];

const legendColorClasses = [
  'downloads-chart-legend-color-blue',
  'downloads-chart-legend-color-red',
  'downloads-chart-legend-color-green',
  'downloads-chart-legend-color-purple',
  'downloads-chart-legend-color-orange',
  'downloads-chart-legend-color-turquoise',
];

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
  final majorRanges =
      data.majorRangeWeeklyDownloads.map((e) => e.versionRange).toList();

  drawChart(svg, majorRanges, majorDisplayLists, data.newestDate);
}

void drawChart(Element svg, List<String> ranges, List<List<int>> values,
    DateTime newestDate,
    {bool stacked = false}) {
  final width = 775; // TODO(zarah): make this width dynamic
  final topPadding = 30;
  final leftPadding = 30;
  final rightPadding = 70; // make extra room for labels on y-axis
  final drawingWidth = width - leftPadding - rightPadding;
  final chartheight = 420;

  DateTime computeDateForWeekNumber(
      DateTime newestDate, int totalWeeks, int weekNumber) {
    return newestDate.copyWith(
        day: newestDate.day - 7 * (totalWeeks - weekNumber - 1));
  }

  // Computes max value on y-axis such that we get a nice division for the
  // interval length between the numbers shown by the tics on the y axis.
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
    // This should not happen!
    return (maxDownloads, firstDiv);
  }

  final (maxY, interval) = computeMaxYAndInterval(values);
  final firstDate = computeDateForWeekNumber(newestDate, values.length, 0);

  (double, double) computeCoordinates(DateTime date, int downloads) {
    final xAxisSpan = newestDate.difference(firstDate);
    final duration = date.difference(firstDate);
    final x = leftPadding +
        drawingWidth * duration.inMilliseconds / xAxisSpan.inMilliseconds;
    final y = topPadding + (chartheight - chartheight * (downloads / maxY));
    return (x, y);
  }

  final chart = SVGGElement();
  svg.append(chart);

  // Axis and tics

  final (xZero, yZero) = computeCoordinates(firstDate, 0);
  final (xMax, yMax) = computeCoordinates(newestDate, maxY);
  final lineThickness = 1;
  final padding = 8;
  final ticLength = 10;
  final ticLabelYCoor = yZero + ticLength + 2 * padding;

  final xaxis = SVGPathElement();
  xaxis.setAttribute('class', 'downloads-chart-x-axis');
  // We add half of the line thickness at both ends of the x-axis so that it
  // covers the vertical tics at the end.
  xaxis.setAttribute('d',
      'M${xZero - (lineThickness / 2)} $yZero L${xMax + (lineThickness / 2)} $yZero');
  chart.append(xaxis);

  var firstTicLabel = SVGTextElement();
  for (int week = 0; week < values.length; week += 4) {
    final date = computeDateForWeekNumber(newestDate, values.length, week);
    final (x, y) = computeCoordinates(date, 0);

    final tic = SVGPathElement();
    tic.setAttribute('class', 'downloads-chart-x-axis');
    tic.setAttribute('d', 'M$x $y l0 $ticLength');
    chart.append(tic);

    final ticLabel = SVGTextElement();
    chart.append(ticLabel);
    ticLabel.setAttribute(
        'class', 'downloads-chart-tic-label  downloads-chart-tic-label-x');
    ticLabel.text = formatAbbrMonthDay(date);
    ticLabel.setAttribute('y', '$ticLabelYCoor');
    ticLabel.setAttribute('x', '$x');

    if (week == 0) {
      firstTicLabel = ticLabel;
    }
  }

  for (int i = 0; i <= maxY / interval; i++) {
    final (x, y) = computeCoordinates(firstDate, i * interval);

    final ticLabel = SVGTextElement();
    ticLabel.setAttribute(
        'class', 'downloads-chart-tic-label  downloads-chart-tic-label-y');
    ticLabel.text =
        '${compactFormat(i * interval).value}${compactFormat(i * interval).suffix}';
    ticLabel.setAttribute('x', '${xMax + padding}');
    ticLabel.setAttribute('y', '$y');
    chart.append(ticLabel);

    if (i == 0) {
      // No long tic in the bottom, we have the x-axis here.
      continue;
    }

    final longTic = SVGPathElement();
    longTic.setAttribute('class', 'downloads-chart-frame');
    longTic.setAttribute('d',
        'M${xZero - (lineThickness / 2)} $y L${xMax - (lineThickness / 2)} $y');
    chart.append(longTic);
  }

  // We use the clipPath to cut the ends of the chart lines so that we don't
  // draw outside the frame of the chart.
  final clipPath = SVGClipPathElement();
  clipPath.setAttribute('id', 'clipRect');
  final clipRect = SVGRectElement();
  clipRect.setAttribute('y', '$yMax');
  clipRect.setAttribute('height', '${chartheight - (lineThickness / 2)}');
  clipRect.setAttribute('x', '${xZero - (lineThickness / 2)}');
  clipRect.setAttribute('width', '${drawingWidth + lineThickness}');
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

  double legendXCoor = xZero - firstTicLabel.getBBox().width / 2;
  double legendYCoor =
      ticLabelYCoor + firstTicLabel.getBBox().height + 2 * padding;
  final legendWidth = 20;
  final legendHeight = 8;

  for (int j = 0; j < lines.length; j++) {
    final path = SVGPathElement();
    path.setAttribute('class', '${lineColorClasses[j]} downloads-chart-line ');
    // We assign colors in revers order so that main colors are chosen first for
    // the newest versions.
    path.setAttribute('d', '${lines[lines.length - 1 - j]}');
    path.setAttribute('clip-path', 'url(#clipRect)');
    chart.append(path);

    final legend = SVGRectElement();
    chart.append(legend);
    legend.setAttribute(
        'class', 'downloads-chart-legend ${legendColorClasses[j]}');
    legend.setAttribute('height', '$legendHeight');
    legend.setAttribute('width', '$legendWidth');

    final legendLabel = SVGTextElement();
    chart.append(legendLabel);
    legendLabel.setAttribute(
        'class', 'downloads-chart-tic-label downloads-chart-tic-label-y');
    legendLabel.text = ranges[j];

    if (legendXCoor + padding + legendWidth + legendLabel.getBBox().width >
        xMax) {
      // There is no room for the legend and label.
      // Make a new line and update legendXCoor and legendYCoor accordingly.

      legendXCoor = xZero - firstTicLabel.getBBox().width / 2;
      legendYCoor += 2 * padding + legendHeight;
    }

    legend.setAttribute('x', '$legendXCoor');
    legend.setAttribute('y', '$legendYCoor');
    legendLabel.setAttribute('y', '${legendYCoor + legendHeight / 2}');
    legendLabel.setAttribute('x', '${legendXCoor + padding + legendWidth}');

    // Update x coordinate for next legend
    legendXCoor +=
        legendWidth + padding + legendLabel.getBBox().width + 2 * padding;
  }

  final height = legendYCoor + 3 * padding;
  final frame = SVGRectElement();
  chart.append(frame);
  frame.setAttribute('height', '$height');
  frame.setAttribute('width', '$width');
  frame.setAttribute('rx', '15');
  frame.setAttribute('ry', '15');
  frame.setAttribute('class', 'downloads-chart-frame');
}
