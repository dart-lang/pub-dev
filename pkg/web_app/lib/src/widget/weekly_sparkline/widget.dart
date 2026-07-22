// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:_pub_shared/format/encoding.dart';
import 'package:_pub_shared/format/number_format.dart';
import 'package:web/web.dart';

void create(HTMLElement element, Map<String, String> options) {
  final dataPoints = options['points'];
  if (dataPoints == null) {
    throw UnsupportedError('data-weekly-sparkline-points required');
  }

  final svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');

  // Safari needs these to render the svg.
  svg.setAttribute('height', '100%');
  svg.setAttribute('width', '100%');

  element.append(svg);

  final toolTip = HTMLDivElement()
    ..setAttribute('class', 'weekly-downloads-sparkline-tooltip');
  document.body!.appendChild(toolTip);

  final chartSubText = HTMLDivElement()
    ..setAttribute('class', 'weekly-downloads-sparkline-text');
  element.append(chartSubText);

  List<({DateTime date, int downloads})> prepareDataForSparkline(
    String dataPoints,
  ) {
    final decoded = decodeIntsFromLittleEndianBase64String(dataPoints);
    final newestDate = DateTime.fromMillisecondsSinceEpoch(decoded[0] * 1000);
    final weeklyDownloads = decoded.sublist(1);
    // TODO(https://github.com/dart-lang/pub-dev/issues/8251): Update this to 52.
    final dataListLength = min(47, weeklyDownloads.length);
    return List.generate(
      weeklyDownloads.length,
      (i) => (
        date: newestDate.copyWith(day: newestDate.day - 7 * i),
        downloads: weeklyDownloads[i],
      ),
    ).sublist(0, dataListLength).reversed.toList();
  }

  drawChart(svg, toolTip, chartSubText, prepareDataForSparkline(dataPoints));
}

void drawChart(
  Element svg,
  HTMLDivElement toolTip,
  HTMLDivElement chartSubText,
  List<({DateTime date, int downloads})> data,
) {
  final height = 80;
  final width = 190;
  final padding = 4;
  final drawingHeight = height - padding;
  final drawingWidth = width - 2 * padding;

  final lastDate = data.last.date;
  final firstDate = data.first.date;
  final firstDay = firstDate.copyWith(day: firstDate.day - 7);
  final xAxisSpan = lastDate.difference(firstDate);
  // We start with 1 as initial value. In the special case where all downloads
  // are 0 we want a straight line in the bottom of the chart.
  final maxDownloads = data.fold<int>(1, (a, b) => max<int>(a, b.downloads));

  final toolTipOffsetFromMouse = 15;
  // Small margin so the tooltip never touches the very edge of the viewport.
  final viewportMargin = 8;

  (double, double) computeCoordinates(DateTime date, int downloads) {
    final duration = date.difference(firstDate);
    final x =
        padding +
        drawingWidth * duration.inMilliseconds / xAxisSpan.inMilliseconds;
    final y = height - drawingHeight * (downloads / maxDownloads);
    return (x, y);
  }

  String generateSparkline(List<({DateTime date, int downloads})> data) {
    final line = StringBuffer();
    var c = 'M';
    for (final d in data) {
      final (x, y) = computeCoordinates(d.date, d.downloads);
      line.write(' $c$x $y');
      c = 'L';
    }
    return line.toString();
  }

  String formatDate(DateTime date) {
    final year = '${date.year}';
    final month = date.month < 10 ? '0${date.month}' : '${date.month}';
    final day = date.day < 10 ? '0${date.day}' : '${date.day}';
    return '$year.$month.$day';
  }

  // Positions the tooltip near the mouse pointer while keeping it fully
  // inside the viewport, flipping above/left of the cursor when there isn't
  // enough room below/right.
  void positionTooltip(MouseEvent e) {
    final tooltipRect = toolTip.getBoundingClientRect();
    final viewportWidth = window.innerWidth;
    final viewportHeight = window.innerHeight;

    var left = e.clientX.toDouble();
    if (left + tooltipRect.width + viewportMargin > viewportWidth) {
      // Not enough room to the right: show the tooltip to the left of the
      // cursor instead.
      left = e.clientX - tooltipRect.width;
    }
    left = left
        .clamp(
          viewportMargin,
          max(
            viewportMargin,
            viewportWidth - tooltipRect.width - viewportMargin,
          ),
        )
        .toDouble();

    var top = (e.clientY + toolTipOffsetFromMouse).toDouble();
    if (top + tooltipRect.height + viewportMargin > viewportHeight) {
      // Not enough room below: show the tooltip above the cursor instead.
      top = e.clientY - toolTipOffsetFromMouse - tooltipRect.height;
    }
    top = top
        .clamp(
          viewportMargin,
          max(
            viewportMargin,
            viewportHeight - tooltipRect.height - viewportMargin,
          ),
        )
        .toDouble();

    toolTip.style.top = '${top + document.scrollingElement!.scrollTop}px';
    toolTip.style.left = '${left + document.scrollingElement!.scrollLeft}px';
  }

  // Render chart

  chartSubText.textContent =
      '${formatDate(firstDay)} - ${formatDate(lastDate)}';
  final chart = SVGGElement();

  final sparklineBar = SVGLineElement();
  final sparklineCursor = SVGGElement();
  final sparklineSpot = SVGCircleElement();

  sparklineCursor
    ..appendChild(sparklineBar)
    ..appendChild(sparklineSpot);

  sparklineSpot
    ..setAttribute('class', 'weekly-sparkline')
    ..setAttribute('r', '3');

  sparklineBar.setAttribute('class', 'weekly-sparkline-bar');
  sparklineBar.setAttribute('x1', '0');
  sparklineBar.setAttribute('x2', '0');
  sparklineBar.setAttribute('y1', '0');
  sparklineBar.setAttribute('y2', '$height');
  chart.append(sparklineCursor);

  final line = generateSparkline(data);
  final sparkline = SVGPathElement();
  sparkline.setAttribute('class', 'weekly-sparkline-line');
  sparkline.setAttribute('d', '$line');

  final area = SVGPathElement();
  area.setAttribute('class', 'weekly-sparkline-area');
  area.setAttribute(
    'd',
    '$line  L${drawingWidth + padding} $height L$padding $height Z',
  );

  chart.append(area);
  chart.append(sparkline);

  svg.append(chart);

  // Setup mouse handling

  DateTime? lastSelectedDay;
  chart.onMouseMove.listen((e) {
    sparklineCursor.style.opacity = '1';
    toolTip.style.opacity = '1';

    final s =
        (e.x - (chart.getBoundingClientRect().x + padding)) / drawingWidth;
    final selectedDayIndex =
        lowerBoundBy<({DateTime date, int downloads}), double>(
          data,
          (e) =>
              e.date.difference(firstDate).inMilliseconds /
              xAxisSpan.inMilliseconds,
          (a, b) => a.compareTo(b),
          s,
        );
    final selectedDay = data[selectedDayIndex];
    if (selectedDay.date != lastSelectedDay) {
      final coords = computeCoordinates(
        selectedDay.date,
        selectedDay.downloads,
      );
      sparklineSpot.setAttribute('cy', '${coords.$2}');
      sparklineCursor.setAttribute('transform', 'translate(${coords.$1}, 0)');
      toolTip.textContent =
          '${formatWithThousandSeperators(selectedDay.downloads)}';

      final startDay = selectedDay.date.subtract(Duration(days: 7));
      chartSubText.textContent =
          '${formatDate(startDay)} - ${formatDate(selectedDay.date)}';

      lastSelectedDay = selectedDay.date;
    }

    // Re-position on every move (not just when the selected day changes) so
    // the tooltip tracks the cursor smoothly, and re-clamp against the
    // viewport since the tooltip's content/size may have just changed.
    positionTooltip(e);
  });

  void hideSparklineCursor(_) {
    sparklineCursor.style.opacity = '0';
    toolTip.style.opacity = '0';
    chartSubText.textContent =
        '${formatDate(firstDay)} - ${formatDate(lastDate)}';
    lastSelectedDay = null;
  }

  hideSparklineCursor(1);
  chart.onMouseLeave.listen(hideSparklineCursor);
}

int lowerBoundBy<E, K>(
  List<E> sortedList,
  K Function(E element) keyOf,
  int Function(K, K) compare,
  K value,
) {
  var min = 0;
  var max = sortedList.length - 1;
  final key = value;
  while (min < max) {
    final mid = min + ((max - min) >> 1);
    final element = sortedList[mid];
    final comp = compare(keyOf(element), key);
    if (comp < 0) {
      min = mid + 1;
    } else {
      max = mid;
    }
  }
  return min;
}
