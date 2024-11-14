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
  element.append(svg);

  final toolTip = HTMLDivElement()
    ..setAttribute('class', 'weekly-downloads-sparkline-tooltip');
  document.body!.appendChild(toolTip);

  final chartSubText = HTMLDivElement()
    ..setAttribute('class', 'weekly-downloads-sparkline-text');
  element.append(chartSubText);

  List<({DateTime date, int downloads})> prepareDataForSparkline(
      String dataPoints) {
    final decoded = decodeIntsFromLittleEndianBase64String(dataPoints);
    final newestDate = DateTime.fromMillisecondsSinceEpoch(decoded[0] * 1000);
    final weeklyDownloads = decoded.sublist(1);
    // TODO(https://github.com/dart-lang/pub-dev/issues/8251): Update this to 52.
    final dataListLength =
        weeklyDownloads.length > 40 ? 40 : weeklyDownloads.length;
    return List.generate(
        weeklyDownloads.length,
        (i) => (
              date: newestDate.copyWith(day: newestDate.day - 7 * i),
              downloads: weeklyDownloads[i]
            )).sublist(0, dataListLength).reversed.toList();
  }

  drawChart(svg, toolTip, chartSubText, prepareDataForSparkline(dataPoints));
}

void drawChart(Element svg, HTMLDivElement toolTip, HTMLDivElement chartSubText,
    List<({DateTime date, int downloads})> data) {
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

  (double, double) computeCoordinates(DateTime date, int downloads) {
    final duration = date.difference(firstDate);
    final x = padding +
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

  // Render chart

  chartSubText.text = '${formatDate(firstDay)} - ${formatDate(lastDate)}';
  final chart = SVGGElement();
  final frame = SVGRectElement();
  frame.setAttribute('height', '$height');
  frame.setAttribute('width', '$width');
  frame.setAttribute('style', 'fill:white;stroke-width:1;stroke:white');
  chart.append(frame);

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
      'd', '$line  L${drawingWidth + padding} $height L$padding $height Z');

  chart.append(area);
  chart.append(sparkline);

  svg.append(chart);

  // Setup mouse handling

  DateTime? lastSelectedDay;
  chart.onMouseMove.listen((e) {
    sparklineCursor.setAttribute('style', 'opacity:1');
    toolTip.setAttribute(
        'style',
        'top:${e.y + toolTipOffsetFromMouse + document.scrollingElement!.scrollTop}px;'
            'left:${e.x}px;');

    final s =
        (e.x - (chart.getBoundingClientRect().x + padding)) / drawingWidth;
    final selectedDayIndex =
        lowerBoundBy<({DateTime date, int downloads}), double>(
            data,
            (e) =>
                e.date.difference(firstDate).inMilliseconds /
                xAxisSpan.inMilliseconds,
            (a, b) => a.compareTo(b),
            s);
    final selectedDay = data[selectedDayIndex];
    if (selectedDay.date == lastSelectedDay) return;

    final coords = computeCoordinates(selectedDay.date, selectedDay.downloads);
    sparklineSpot.setAttribute('cy', '${coords.$2}');
    sparklineCursor.setAttribute('transform', 'translate(${coords.$1}, 0)');
    toolTip.text = '${formatWithThousandSeperators(selectedDay.downloads)}';

    final startDay = selectedDay.date.subtract(Duration(days: 7));
    chartSubText.text =
        '${formatDate(startDay)} - ${formatDate(selectedDay.date)}';

    lastSelectedDay = selectedDay.date;
  });

  void hideSparklineCursor(_) {
    sparklineCursor.setAttribute('style', 'opacity:0');
    toolTip.setAttribute('style', 'opacity:0;position:absolute;');
    chartSubText.text = '${formatDate(firstDay)} - ${formatDate(lastDate)}';
    lastSelectedDay = null;
  }

  hideSparklineCursor(1);
  chart.onMouseLeave.listen(hideSparklineCursor);
}

int lowerBoundBy<E, K>(List<E> sortedList, K Function(E element) keyOf,
    int Function(K, K) compare, K value) {
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
