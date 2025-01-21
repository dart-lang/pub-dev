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
  var dataPoints = options['points'];
  if (dataPoints == null) {
    throw UnsupportedError('data-downloads-chart-points required');
  }
  dataPoints = testString;

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

final testString =
    'eyJ0b3RhbFdlZWtseURvd25sb2FkcyI6WzY5MTE5Niw2MDM1NjgsMzUxNDM1LDM1MTYyNCw2MzY0MjUsNzAwNjY4LDY3NzYwOSw2NTcyOTQsNjcwNzU4LDY1NjM0Nyw2MzY5MDQsNjI2NTI3LDY0NjUzMCw2MzgzODMsNjMwNTc3LDU3MjkzOCw2MjUwODUsNTYzMzI0LDU4MDQ1OCw1NjY0MTMsNTc3MzA5LDU5NjY5Miw1NTU3MDcsNTcwNjA3LDU2NzExNSw1MzQ5NjksNTA2OTY4LDUxMDc2NCw0NTkxMjIsNTI5NDA1LDQ5MjEzNCw0OTQwNjksNDg0MjI5LDQ3NTk2OCw0ODc0NTksNTAxNzgwLDQ2MjU4Myw0MzM2NjgsNTE3MDAwLDU1NjgzOCw1MDM1NjMsNTIxMjgwLDQ4MjMzNyw1MzA4MzIsNTM5MDAyLDUyNjYwOSw1MTQzNzEsNDgwNTYxLDQzNzY1OCw0MzA0MDMsNDU0MzYxLDM1Nzk0OV0sIm1ham9yUmFuZ2VXZWVrbHlEb3dubG9hZHMiOlt7ImNvdW50cyI6WzE2MjEyMywxNDIxMTQsOTQyNTcsODk3NzQsMTM4NDgwLDE5NzExOCwyMTE5NTksMTg3MjUxLDE3NDA1MywxNzk4MzEsMTY1NDk0LDE2MTQ0MywxNTcxMTgsMTU3MTYzLDE3NjI0NiwxNTk0OTksMTcyODg0LDE1NTczMywxNjk3ODcsMTcyNzM3LDE3NDE1OSwxNzk5NDYsMTYxOTgwLDE3NDM5NCwxOTc4NTgsMTkxMTcyLDE4NTYwOSwxODQyNjcsMTcyMzQzLDIxOTM2MCwxOTYwMzYsMTkwNDAyLDE5NTc3MiwxOTMwNDEsMjA0NzIzLDIxNzY3OCwyMDYzMTEsMjAwMTEzLDIyODM5MSwyNTc5NDQsMjQzNjU1LDI3MzI4NSwyNTEzMzUsMjc4ODU1LDI4MDkwMywyNzAzNTcsMjc4NzY2LDI1OTI3NiwyNTE1NDUsMjQ1NzczLDI2MzE4MywxOTAwNzZdLCJ2ZXJzaW9uUmFuZ2UiOiI+PTQuMC4wLTAgPDUuMC4wIn0seyJjb3VudHMiOlsxNTYwNywxNTkxNyw5MDgzLDEwMTc1LDE3MjM2LDE2Nzg1LDE4OTQ1LDE5ODgxLDE5ODc5LDIxNTUxLDE5MTkyLDI4NjA5LDI1NzU5LDI2NTkwLDI3NjMzLDI4MjU1LDI5ODIwLDI4NDIyLDMwMDUzLDI5NDk0LDM0MTY3LDM1OTE1LDM1MzQ4LDM4NjE1LDQwMzI1LDM5MzczLDQxMDY5LDQzMzI0LDQyNDgwLDQ3NDA3LDUzNjczLDYxMTk1LDY0MDA4LDYzOTczLDY2NTYwLDczMTAwLDY3NDgyLDY3Nzk1LDkyMDc3LDEwMDU0NSwxMDY2MTMsMTIwNTI1LDEzMzE0OCwxNTcxMDUsMTYzMzIyLDE2NDI4NSwxNDg4OTEsMTQxNDQ5LDEwNzI3MCw5OTk5OSw5NzY2Niw3MDAwOF0sInZlcnNpb25SYW5nZSI6Ij49NS4wLjAtMCA8Ni4wLjAifSx7ImNvdW50cyI6WzM5OTg2LDQzNzE4LDE3Mzk0LDE1MTQxLDM4MTc2LDQxNTUyLDM3MTY1LDQ0MTU1LDUxMjc5LDU1OTg5LDUzMzcyLDUwNTY4LDUwMTA5LDUzNDUxLDQ4NzA3LDU0MjQ3LDYzNDg1LDU1NTk5LDU0NDA5LDU2MzMwLDU1NDU5LDU4NTAxLDUyMjExLDYwOTczLDUzNDA3LDU4ODkwLDUzMDA4LDYyNzUzLDQ2NDcxLDU3NjAzLDUwODM3LDU4NzE3LDU1MTA5LDUzMTYwLDUyMDkyLDUzNTQ2LDUyMzk2LDQ3MzU4LDYyNjQ5LDY0ODE2LDU4NjMwLDUxOTAzLDIxNTgwLDkyNTksMCwwLDAsMCwwLDAsMCwwXSwidmVyc2lvblJhbmdlIjoiPj02LjAuMC0wIDw3LjAuMCJ9LHsiY291bnRzIjpbODk2NywxMDMzNywzODY5LDQ5MjgsOTEzNywxMDIyNywxMjM4MCwxMjkxOSwxMjcwNywxMzU1OCwxNTEyNiwxNDY1MSwxNzM3MCwxNzM5NiwxNzI4OSwxODQwNSwyMzg3MSwxODc0NywxOTM4NywxNzI1NiwxOTI1OSwxOTMxNCwyMzUzMywyNDQ5NCwyMjEzOSwyNTUxMCwyNDQ3OSwyMjUwNSwyNzM1NiwyNjQyMiwyNjgzNywyODgxMywyNjk2MCwyODk0MCwzMjY2NCwzMTMwOCwzMjY0OCw0MTYxNSw1NzE2MSw0NzY1MiwyNjE0NiwwLDAsMCwwLDAsMCwwLDAsMCwwLDBdLCJ2ZXJzaW9uUmFuZ2UiOiI+PTcuMC4wLTAgPDguMC4wIn0seyJjb3VudHMiOls0MzkwNTEsMzY4MDgyLDIxMjU1MCwyMTg3NjcsNDEyNDE5LDQwNzgzNCwzNjk0NzEsMzcxODU5LDM5MDUyMCwzNjIxNDMsMzU2MDUzLDM0MDk2MiwzNjkwNjEsMzUxNjMzLDMyNzAwMywyNzg5MjksMzAzMDIwLDI3NTc1NywyNzMzMTUsMjU2OTA0LDI1MTkyNCwyNTc2NDUsMjQzODQyLDIyNzYxNywyMTE5MjcsMTc2NDk5LDE1OTc5NiwxNTI3MjksMTMxNjA4LDEzMzk5NSwxMjE4ODEsMTEyMzg2LDEwMDA5Niw5MDg2MSw4MTQyMyw3NTYzNyw1MjA5NCwzMDg1NiwxNTI1MiwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwXSwidmVyc2lvblJhbmdlIjoiPj04LjAuMC0wIDw5LjAuMCJ9XSwibWlub3JSYW5nZVdlZWtseURvd25sb2FkcyI6W3siY291bnRzIjpbMTU2MDcsMTU5MTcsOTA4MywxMDE3NSwxNzIzNiwxNjc4NSwxODk0NSwxOTg4MSwxOTg3OSwyMTU1MSwxOTE5MiwyODYwOSwyNTc1OSwyNjU5MCwyNzYzMywyODI1NSwyOTgyMCwyODQyMiwzMDA1MywyOTQ5NCwzNDE2NywzNTkxNSwzNTM0OCwzODYxNSw0MDMyNSwzOTM3Myw0MTA2OSw0MzMyNCw0MjQ4MCw0NzQwNyw1MzY3Myw2MTE5NSw2NDAwOCw2Mzk3Myw2NjU2MCw3MzEwMCw2NzQ4Miw2Nzc5NSw5MjA3NywxMDA1NDUsMTA2NjEzLDEyMDUyNSwxMzMxNDgsMTU3MTA1LDE2MzMyMiwxNjQyODUsMTQ4ODkxLDE0MTQ0OSwxMDcyNzAsOTk5OTksOTc2NjYsNzAwMDhdLCJ2ZXJzaW9uUmFuZ2UiOiI+PTUuMC4wLTAgPDUuMS4wIn0seyJjb3VudHMiOlszOTk4Niw0MzcxOCwxNzM5NCwxNTE0MSwzODE3Niw0MTU1MiwzNzE2NSw0NDE1NSw1MTI3OSw1NTk4OSw1MzM3Miw1MDU2OCw1MDEwOSw1MzQ1MSw0ODcwNyw1NDI0Nyw2MzQ4NSw1NTU5OSw1NDQwOSw1NjMzMCw1NTQ1OSw1ODUwMSw1MjIxMSw2MDk3Myw1MzQwNyw1ODg5MCw1MzAwOCw2Mjc1Myw0NjQ3MSw1NzYwMyw1MDgzNyw1ODcxNyw1NTEwOSw1MzE2MCw1MjA5Miw1MzU0Niw1MjM5Niw0NzM1OCw2MjY0OSw2NDgxNiw1ODYzMCw1MTkwMywyMTU4MCw5MjU5LDAsMCwwLDAsMCwwLDAsMF0sInZlcnNpb25SYW5nZSI6Ij49Ni4wLjAtMCA8Ni4xLjAifSx7ImNvdW50cyI6Wzg5NjcsMTAzMzcsMzg2OSw0OTI4LDkxMzcsMTAyMjcsMTIzODAsMTI5MTksMTI3MDcsMTM1NTgsMTUxMjYsMTQ2NTEsMTczNzAsMTczOTYsMTcyODksMTg0MDUsMjM4NzEsMTg3NDcsMTkzODcsMTcyNTYsMTkyNTksMTkzMTQsMjM1MzMsMjQ0OTQsMjIxMzksMjU1MTAsMjQ0NzksMjI1MDUsMjczNTYsMjY0MjIsMjY4MzcsMjg4MTMsMjY5NjAsMjg5NDAsMzI2NjQsMzEzMDgsMzI2NDgsNDE2MTUsNTcxNjEsNDc2NTIsMjYxNDYsMCwwLDAsMCwwLDAsMCwwLDAsMCwwXSwidmVyc2lvblJhbmdlIjoiPj03LjAuMC0wIDw3LjEuMCJ9LHsiY291bnRzIjpbMTA1NjI5LDk4Nzc2LDYwMzYxLDY0MjI3LDEyNTIyOCwxMzc5MDgsMTQ0NDQ3LDE1NTQzNCwxNzMzMDMsMTU3NTAxLDE2NTI2MywxNzUzMjMsMjA5NjM5LDI5ODg5MCwzMjcwMDMsMjc4OTI5LDMwMzAyMCwyNzU3NTcsMjczMzE1LDI1NjkwNCwyNTE5MjQsMjU3NjQ1LDI0Mzg0MiwyMjc2MTcsMjExOTI3LDE3NjQ5OSwxNTk3OTYsMTUyNzI5LDEzMTYwOCwxMzM5OTUsMTIxODgxLDExMjM4NiwxMDAwOTYsOTA4NjEsODE0MjMsNzU2MzcsNTIwOTQsMzA4NTYsMTUyNTIsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMF0sInZlcnNpb25SYW5nZSI6Ij49OC4wLjAtMCA8OC4xLjAifSx7ImNvdW50cyI6WzMzMzQyMiwyNjkzMDYsMTUyMTg5LDE1NDU0MCwyODcxOTEsMjY5OTI2LDIyNTAyNCwyMTY0MjUsMjE3MjE3LDIwNDY0MiwxOTA3OTAsMTY1NjM5LDE1OTQyMiw1Mjc0MywwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDBdLCJ2ZXJzaW9uUmFuZ2UiOiI+PTguMS4wLTAgPDguMi4wIn1dLCJwYXRjaFJhbmdlV2Vla2x5RG93bmxvYWRzIjpbeyJjb3VudHMiOls4MzkwLDgzOTEsNDkyMyw1NjkwLDEwNzQyLDEzNjgxLDEzMjE1LDE1NzY5LDE2OTkxLDE3NzM3LDE4NjEyLDIzNDk3LDQwNDE1LDExODI3NCw4OTkzNywwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwXSwidmVyc2lvblJhbmdlIjoiPj04LjAuMy0wIDw4LjAuNCJ9LHsiY291bnRzIjpbMjc5OTcsMzA1NzYsMTc2NzEsMjA2MzYsMzY2OTYsNDQ2MjQsNDYxMjksNDk4MDEsNTUyNTYsNjE3NzIsMTM0NjY3LDE2NTYzOSwxNTk0MjIsNTI3NDMsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwXSwidmVyc2lvblJhbmdlIjoiPj04LjEuMC0wIDw4LjEuMSJ9LHsiY291bnRzIjpbNTUwNzksNTY1MTAsMzE1MjcsMzYzOTEsNzgzNjAsMTY3NDgwLDE3ODg5NSwxNjY2MjQsMTYxOTYxLDE0Mjg3MCw1NjEyMywwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDBdLCJ2ZXJzaW9uUmFuZ2UiOiI+PTguMS4xLTAgPDguMS4yIn0seyJjb3VudHMiOlsxMDUxMjYsMTgyMjIwLDEwMjk5MSw5NzUxMywxNzIxMzUsNTc4MjIsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMF0sInZlcnNpb25SYW5nZSI6Ij49OC4xLjItMCA8OC4xLjMifSx7ImNvdW50cyI6WzE0NTIyMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMF0sInZlcnNpb25SYW5nZSI6Ij49OC4xLjMtMCA8OC4xLjQifV0sIm5ld2VzdERhdGUiOiIyMDI1LTAxLTE5VDAwOjAwOjAwLjAwMCJ9';
