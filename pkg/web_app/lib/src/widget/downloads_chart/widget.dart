// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:js_interop';
import 'dart:math' as math;

import 'package:_pub_shared/data/download_counts_data.dart';
import 'package:_pub_shared/format/date_format.dart';
import 'package:_pub_shared/format/number_format.dart';
import 'package:web/web.dart';
import 'package:web_app/src/web_util.dart';

import 'computations.dart';

const colors = ['blue', 'red', 'green', 'purple', 'orange', 'turquoise'];

String strokeColorClass(int i) => 'downloads-chart-stroke-${colors[i]}';
String fillColorClass(int i) => 'downloads-chart-fill-${colors[i]}';
String squareColorClass(int i) => 'downloads-chart-square-${colors[i]}';

enum DisplayMode { stacked, unstacked, percentage }

void create(HTMLElement element, Map<String, String> options) {
  final dataPoints = options['points'];
  if (dataPoints == null) {
    throw UnsupportedError('data-downloads-chart-points required');
  }

  final versionsRadio = options['versions-radio'];
  if (versionsRadio == null) {
    throw UnsupportedError('data-downloads-chart-versions-radio required');
  }

  final displayRadio = options['display-radio'];
  if (displayRadio == null) {
    throw UnsupportedError('data-downloads-chart-display-radio required');
  }

  Element createNewSvg() {
    return document.createElementNS('http://www.w3.org/2000/svg', 'svg')
      ..setAttribute('height', '100%')
      ..setAttribute('width', '100%');
  }

  var svg = createNewSvg();
  element.append(svg);

  final toolTip = HTMLDivElement()
    ..setAttribute('class', 'downloads-chart-tooltip');
  document.body!.appendChild(toolTip);

  final data = WeeklyVersionDownloadCounts.fromJson(
    (utf8.decoder.fuse(json.decoder).convert(base64Decode(dataPoints))
        as Map<String, dynamic>),
  );
  final weeksToDisplay = math.min(47, data.totalWeeklyDownloads.length);
  final totals = data.totalWeeklyDownloads
      .sublist(0, weeksToDisplay)
      .reversed
      .toList();

  final majorDisplayLists = prepareWeekLists(
    data.totalWeeklyDownloads,
    data.majorRangeWeeklyDownloads,
    weeksToDisplay,
  );

  final minorDisplayLists = prepareWeekLists(
    data.totalWeeklyDownloads,
    data.minorRangeWeeklyDownloads,
    weeksToDisplay,
  );

  final patchDisplayLists = prepareWeekLists(
    data.totalWeeklyDownloads,
    data.patchRangeWeeklyDownloads,
    weeksToDisplay,
  );

  var currentDisplayList = majorDisplayLists;
  var currentDisplayMode = DisplayMode.unstacked;

  final versionModesLists = {
    'major': majorDisplayLists,
    'minor': minorDisplayLists,
    'patch': patchDisplayLists,
  };

  final versionModes = document.getElementsByName(versionsRadio).toList();
  versionModes.forEach((i) {
    final radioButton = i as HTMLInputElement;
    final value = radioButton.value;
    final displayList = versionModesLists[value];

    if (displayList == null) {
      throw UnsupportedError('Unsupported versions-radio value: "$value"');
    }
    radioButton.onClick.listen((e) {
      element.removeChild(svg);
      svg = createNewSvg();
      element.append(svg);
      currentDisplayList = displayList;
      drawChart(
        svg,
        svg.getBoundingClientRect().width,
        toolTip,
        displayList,
        data.newestDate,
        totals,
        displayMode: currentDisplayMode,
      );
    });
  });

  final displayModesMap = <String, DisplayMode>{
    'stacked': DisplayMode.stacked,
    'unstacked': DisplayMode.unstacked,
    'percentage': DisplayMode.percentage,
  };

  final displayModes = document.getElementsByName(displayRadio).toList();
  displayModes.forEach((i) {
    final radioButton = i as HTMLInputElement;
    final value = radioButton.value;
    final displayMode = displayModesMap[value];

    if (displayMode == null) {
      throw UnsupportedError('Unsupported display-radio value: "$value"');
    }

    radioButton.onClick.listen((e) {
      element.removeChild(svg);
      svg = createNewSvg();
      element.append(svg);
      currentDisplayMode = displayMode;
      drawChart(
        svg,
        svg.getBoundingClientRect().width,
        toolTip,
        currentDisplayList,
        data.newestDate,
        totals,
        displayMode: displayMode,
      );
    });
  });

  void resize(double width) {
    element.removeChild(svg);
    svg = createNewSvg();
    element.append(svg);

    drawChart(
      svg,
      width,
      toolTip,
      currentDisplayList,
      data.newestDate,
      totals,
      displayMode: currentDisplayMode,
    );
  }

  final resizeObserver = ResizeObserver(
    (JSArray<ResizeObserverEntry> a, ResizeObserverBoxOptions b) {
      resize(a.toDart[0].contentRect.width);
    }.toJS,
  );

  drawChart(
    svg,
    svg.getBoundingClientRect().width,
    toolTip,
    currentDisplayList,
    data.newestDate,
    totals,
  );

  resizeObserver.observe(element);
}

void drawChart(
  Element svg,
  double width,
  HTMLDivElement toolTip,
  ({List<String> ranges, List<List<int>> weekLists}) displayLists,
  DateTime newestDate,
  List<int> totals, {
  DisplayMode displayMode = DisplayMode.unstacked,
}) {
  final ranges = displayLists.ranges;
  final values = displayLists.weekLists;
  final displayAreas = displayMode != DisplayMode.unstacked;

  if (values.isEmpty) return;

  final frameWidth = width;
  final topPadding = 30;
  final leftPadding = 30;
  final rightPadding = 70; // Make extra room for labels on y-axis
  final chartWidth = frameWidth - leftPadding - rightPadding;
  final chartHeight = 420;

  final toolTipOffsetFromMouse = 15;

  DateTime computeDateForWeekNumber(
    DateTime newestDate,
    int totalWeeks,
    int weekIndex,
  ) {
    return newestDate.copyWith(
      day: newestDate.day - 7 * (totalWeeks - weekIndex - 1),
    );
  }

  /// Computes max value on y-axis such that we get a nice division for the
  /// interval length between the numbers shown by the ticks on the y axis.
  (int maxY, int interval) computeMaxYAndInterval(List<List<int>> values) {
    final maxDownloads = switch (displayMode) {
      DisplayMode.unstacked => values.fold<int>(
        1,
        (a, b) => math.max<int>(a, b.reduce(math.max)),
      ),
      DisplayMode.stacked => values.fold<int>(
        1,
        (a, b) => math.max<int>(a, b.reduce((x, y) => x + y)),
      ),
      _ => 100, // percentage
    };

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

  (double, double) computeCoordinates(DateTime date, num downloads) {
    final duration = date.difference(firstDate);
    // We don't risk division by 0 here, since `xAxisSpan` is a non-zero duration.
    final x =
        leftPadding +
        chartWidth * duration.inMilliseconds / xAxisSpan.inMilliseconds;

    final y = topPadding + (chartHeight - chartHeight * (downloads / maxY));
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

    if (week % 8 == 0) {
      // We skip every other label on small screens.
      tickLabel.setAttribute(
        'class',
        'downloads-chart-tick-label  downloads-chart-anchored-tick-label-x',
      );
    } else {
      tickLabel.setAttribute(
        'class',
        'downloads-chart-tick-label  downloads-chart-tick-label-x',
      );
    }
    tickLabel.textContent = formatAbbrMonthDay(date);
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
      'class',
      'downloads-chart-tick-label  downloads-chart-tick-label-y',
    );
    final suffix = displayMode == DisplayMode.percentage
        ? '%'
        : compactFormat(i * interval).suffix;
    tickLabel.textContent = '${compactFormat(i * interval).value}$suffix';
    tickLabel.setAttribute('x', '${xMax + marginPadding}');
    tickLabel.setAttribute('y', '$y');
    chart.append(tickLabel);

    if (i == 0) {
      // No long tick in the bottom, we have the x-axis here.
      continue;
    }

    final longTick = SVGPathElement();
    longTick.setAttribute('class', 'downloads-chart-axis-line');
    longTick.setAttribute('d', 'M$xAxisStart $y L$xAxisEnd $y');
    chart.append(longTick);
  }

  // We use the clipPath to cut the ends of the chart lines so that we don't
  // draw outside the frame of the chart.
  final clipPath = SVGClipPathElement();
  clipPath.setAttribute('id', 'clipRect');
  final clipRect = SVGRectElement();
  clipRect.setAttribute('y', '$yMax');
  clipRect.setAttribute('height', '${chartHeight - (lineThickness / 2)}');
  clipRect.setAttribute('x', '$xZero');
  clipRect.setAttribute('width', '$chartWidth');
  clipPath.append(clipRect);
  chart.append(clipPath);

  // Chart lines, areas, and legends

  final latestDownloads = List<num>.filled(values.length, 0);
  final lines = <List<(double, double)>>[];
  for (int versionRange = 0; versionRange < ranges.length; versionRange++) {
    final List<(double, double)> lineCoordinates = <(double, double)>[];
    for (int week = 0; week < values.length; week++) {
      final value = displayMode == DisplayMode.percentage
          ? (totals[week] == 0
                ? 0 //Avoid division by zero, and return zero
                : values[week][versionRange] * 100 / totals[week])
          : values[week][versionRange];

      if (displayMode == DisplayMode.unstacked) {
        latestDownloads[week] = value;
      } else {
        latestDownloads[week] += value;
      }

      final (x, y) = computeCoordinates(
        computeDateForWeekNumber(newestDate, values.length, week),
        latestDownloads[week],
      );
      lineCoordinates.add((x, y));
    }
    lines.add(lineCoordinates);
  }

  final areas = <List<(double, double)>>[];
  if (displayAreas) {
    for (int i = 0; i < ranges.length; i++) {
      final prevLine = i == 0 ? [(xZero, yZero), (xMax, yZero)] : lines[i - 1];
      final areaLine = [...lines[i], ...prevLine.reversed, lines[i].first];
      areas.add(areaLine);
    }
  }

  StringBuffer computeLinePath(List<(double, double)> coordinates) {
    final path = StringBuffer();
    var command = 'M';
    coordinates.forEach((c) {
      path.write(' $command${c.$1} ${c.$2}');
      command = 'L';
    });
    return path;
  }

  int colorIndex(int i) {
    // We assign colors in reverse order so that the newest versions
    // get the main colors.
    return ranges.length - i - 1;
  }

  double legendX = xZero;
  double legendY =
      tickLabelYCoordinate + firstTickLabel.getBBox().height + labelPadding;
  final legendWidth = 20;
  final legendHeight = 8;

  final linePaths = <SVGPathElement>[];
  final areaPaths = <SVGPathElement>[];
  final legends = <(SVGRectElement, SVGTextElement)>[];
  for (int i = 0; i < ranges.length; i++) {
    final line = computeLinePath(lines[i]);
    final path = SVGPathElement();
    path.setAttribute(
      'class',
      '${strokeColorClass(colorIndex(i))} downloads-chart-line',
    );
    path.setAttribute('d', '$line');
    path.setAttribute('clip-path', 'url(#clipRect)');
    linePaths.add(path);
    chart.append(path);

    if (displayAreas) {
      final areaPath = computeLinePath(areas[i]);
      final area = SVGPathElement();
      area.setAttribute(
        'class',
        '${fillColorClass(colorIndex(i))} downloads-chart-area',
      );
      area.setAttribute('d', '$areaPath');
      area.setAttribute('clip-path', 'url(#clipRect)');
      areaPaths.add(area);
      chart.append(area);
    }

    final legend = SVGRectElement();
    legend.setAttribute(
      'class',
      'downloads-chart-legend ${fillColorClass(colorIndex(i))} ${strokeColorClass(colorIndex(i))}',
    );
    legend.setAttribute('height', '$legendHeight');
    legend.setAttribute('width', '$legendWidth');

    final legendLabel = SVGTextElement();
    legendLabel.setAttribute('class', 'downloads-chart-tick-label');
    legendLabel.textContent = ranges[i];
    chart.append(legendLabel);
    chart.append(legend);
    legends.add((legend, legendLabel));
  }

  // Setup cursor

  final cursor = SVGLineElement()
    ..setAttribute('class', 'downloads-chart-cursor')
    ..setAttribute('stroke-dasharray', '3,3')
    ..setAttribute('x1', '0')
    ..setAttribute('x2', '0')
    ..setAttribute('y1', '$yZero')
    ..setAttribute('y2', '$yMax');
  chart.append(cursor);

  void hideCursor(_) {
    cursor.style.opacity = '0';
    toolTip.style.opacity = '0';
  }

  hideCursor(1);

  void resetHighlights() {
    for (int i = 0; i < linePaths.length; i++) {
      final l = linePaths[i];
      l.removeAttribute('class');
      l.setAttribute(
        'class',
        '${strokeColorClass(colorIndex(i))} downloads-chart-line',
      );

      if (displayAreas) {
        areaPaths[i].removeAttribute('class');
        areaPaths[i].setAttribute(
          'class',
          '${fillColorClass(colorIndex(i))} downloads-chart-area',
        );
      }
      legends[i].$2.removeAttribute('class');
      legends[i].$2.setAttribute('class', 'downloads-chart-tick-label');
    }
  }

  void setHighlights(Set<int> highlightRangeIndices) {
    if (highlightRangeIndices.isEmpty) {
      resetHighlights();
    }

    for (int i = 0; i < ranges.length; i++) {
      linePaths[i].removeAttribute('class');
      if (displayAreas) {
        areaPaths[i].removeAttribute('class');
      }
      legends[i].$2.removeAttribute('class');

      if (highlightRangeIndices.contains(i)) {
        linePaths[i].setAttribute(
          'class',
          '${strokeColorClass(colorIndex(i))} downloads-chart-line',
        );
        if (displayAreas) {
          areaPaths[i].setAttribute(
            'class',
            '${fillColorClass(colorIndex(i))} downloads-chart-area',
          );
        }
        legends[i].$2.setAttribute(
          'class',
          'downloads-chart-legend-label-highlight',
        );
      } else if (highlightRangeIndices.isNotEmpty) {
        linePaths[i].setAttribute(
          'class',
          '${strokeColorClass(colorIndex(i))} downloads-chart-line-faded',
        );
        if (displayAreas) {
          areaPaths[i].setAttribute(
            'class',
            '${fillColorClass(colorIndex(i))} downloads-chart-area-faded',
          );
        }

        legends[i].$2.setAttribute('class', 'downloads-chart-tick-label');
      } else {
        linePaths[i].setAttribute(
          'class',
          '${strokeColorClass(colorIndex(i))} downloads-chart-line',
        );
        if (displayAreas) {
          areaPaths[i].setAttribute(
            'class',
            '${fillColorClass(colorIndex(i))} downloads-chart-area ',
          );
        }
        legends[i].$2.setAttribute('class', 'downloads-chart-tick-label');
      }
    }
  }

  // Place legends and set highlight on hover

  for (var i = legends.length - 1; i >= 0; i--) {
    // We traverse the legends in reverse order so that the legend of the newest
    // version is placed first.
    final (legend, legendLabel) = legends[i];

    if (legendX + marginPadding + legendWidth + legendLabel.getBBox().width >
        xMax) {
      // There is no room for the legend and label.
      // Make a new line and update legendX and legendY accordingly.
      legendX = xZero;
      legendY += 2 * marginPadding + legendHeight;
    }

    legend.setAttribute('x', '$legendX');
    legend.setAttribute('y', '$legendY');

    legendLabel.setAttribute('y', '${legendY + legendHeight}');
    legendLabel.setAttribute('x', '${legendX + marginPadding + legendWidth}');

    // Update x coordinate for next legend
    legendX +=
        legendWidth +
        marginPadding +
        legendLabel.getBBox().width +
        labelPadding;

    legend.onMouseMove.listen((e) {
      setHighlights({i});
      e.stopImmediatePropagation();
    });
    legendLabel.onMouseMove.listen((e) {
      setHighlights({i});
      e.stopImmediatePropagation();
    });

    legend.onMouseLeave.listen((e) {
      resetHighlights();
      e.stopImmediatePropagation();
    });
    legendLabel.onMouseLeave.listen((e) {
      resetHighlights();
      e.stopImmediatePropagation();
    });
  }

  // Setup mouse handling on chart: show cursor, tooltip and highlights

  svg.onMouseMove.listen((e) {
    final boundingRect = svg.getBoundingClientRect();
    final yPosition = e.y - boundingRect.y;
    final xPosition = e.x - boundingRect.x;

    if (xPosition < xZero ||
        xPosition > xMax ||
        yPosition < yMax ||
        yPosition > yZero) {
      // We are outside the actual chart area
      resetHighlights();
      hideCursor(1);
      return;
    }

    final pointPercentage = (xPosition - xZero) / chartWidth;
    final nearestIndex = ((values.length - 1) * pointPercentage).round();
    final selectedDay = computeDateForWeekNumber(
      newestDate,
      values.length,
      nearestIndex,
    );

    // Show cursor

    cursor.style.opacity = '1';
    final cursorPosition = computeCoordinates(selectedDay, 0);
    cursor.setAttribute('transform', 'translate(${cursorPosition.$1}, 0)');

    // Highlight version ranges where the mouse position is close to the line or
    // in the area below the line in the case of `stacked` or `percentage`
    // display mode.

    final highlightRangeIndices = <int>{};
    for (int i = 0; i < lines.length; i++) {
      if (isPointOnPathWithTolerance(lines[i], (xPosition, yPosition), 5)) {
        highlightRangeIndices.add(i);
      }
    }
    if (displayAreas) {
      for (int i = 0; i < areas.length; i++) {
        final a = areas[i];
        if (isPointInPolygon(a, (xPosition, yPosition))) {
          highlightRangeIndices.add(i);
        }
      }
    }

    setHighlights(highlightRangeIndices);

    // Setup tooltip

    final startDay = selectedDay.subtract(Duration(days: 7));
    toolTip.style.top =
        '${e.y + toolTipOffsetFromMouse + document.scrollingElement!.scrollTop}px';
    if (e.x + toolTip.getBoundingClientRect().width > width) {
      toolTip.style.left = '${e.x - toolTip.getBoundingClientRect().width}px';
    } else {
      toolTip.style.left = '${e.x}px';
    }
    toolTip.style.opacity = '1';
    toolTip.replaceChildren(
      HTMLDivElement()
        ..setAttribute('class', 'downloads-chart-tooltip-date')
        ..textContent =
            '${formatAbbrMonthDay(startDay)} - ${formatAbbrMonthDay(selectedDay)}',
    );

    final downloads = values[nearestIndex];
    for (int i = ranges.length - 1; i >= 0; i--) {
      // We traverse in reverse order so that the downloads of the newest
      // version is placed highest up in the tooltip.
      if (downloads[i] > 0) {
        // We only show the exact download count in the tooltip if it is non-zero.
        final square = HTMLDivElement()
          ..setAttribute(
            'class',
            'downloads-chart-tooltip-square ${squareColorClass(colorIndex(i))}',
          );
        final rangeText = HTMLSpanElement()..textContent = '${ranges[i]}: ';
        final suffix = (displayMode == DisplayMode.percentage)
            ? ' (${(downloads[i] * 100 / totals[nearestIndex]).toStringAsPrecision(2)}%)'
            : '';
        final text = '${formatWithThousandSeperators(downloads[i])}$suffix';
        final downloadsText = HTMLSpanElement()
          ..setAttribute('class', 'downloads-chart-tooltip-downloads')
          ..textContent = text;

        final tooltipRange = HTMLDivElement()
          ..setAttribute('class', 'downloads-chart-tooltip-row')
          ..append(square)
          ..append(rangeText);

        final tooltipRow = HTMLDivElement()
          ..setAttribute('class', 'downloads-chart-tooltip-row')
          ..append(tooltipRange)
          ..append(downloadsText);

        if (highlightRangeIndices.contains(i)) {
          rangeText.setAttribute('class', 'downloads-chart-tooltip-highlight');
          downloadsText.setAttribute(
            'class',
            'downloads-chart-tooltip-highlight',
          );
        }
        toolTip.append(tooltipRow);
      }
    }
  });

  svg.onMouseLeave.listen((e) {
    resetHighlights();
    hideCursor(1);
  });
}
