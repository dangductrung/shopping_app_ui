import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/helpers/format_helpers.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';
import 'package:shopping_app/extensions/size_ext.dart';

class LineChartSample1 extends StatefulWidget {
  final List<List<FlSpot>> data;
  final double verticalInterval;
  final List<DateTime> horizontalAxisValues;
  final List<String> from;
  final String unit;

  const LineChartSample1({this.data, this.verticalInterval, this.horizontalAxisValues, this.from, this.unit});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  final double maxHorizontalValue = 6;
  final String datePattern = "dd/MM";
  final String hourPattern = "H'H'";
  final String timePattern = "HH:mm";
  final int secondToMilliseconds = 1000;
  final int minuteToMilliseconds = 60 * 1000;
  final int hourToMilliseconds = 60 * 60 * 1000;
  final int dayToMilliseconds = 24 * 60 * 60 * 1000;
  final int toleranceMinute = 10;
  String currentPattern = "";
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: UIColor.lightGrayBorder,
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              Text(
                'Biến động giá',
                style: UITextStyle.mediumBlack_16_w700,
                textAlign: TextAlign.center,
              ),
              Text(
                '(Đơn vị: ${widget?.unit ?? ''})',
                style: UITextStyle.mediumBlack_14_w400,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: LineChart(
                    sampleData1(),
                    swapAnimationDuration: const Duration(milliseconds: 250),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: UIColor.white,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipPadding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            final List<LineTooltipItem> tooltipItems = [];
            for (int i = 0; i < (touchedBarSpots?.length ?? 0); ++i) {
              tooltipItems.add(
                LineTooltipItem(
                  "${i == 0 ? FormatHelper.formatDateTime(DateTime.fromMillisecondsSinceEpoch(touchedBarSpots[i].x.toInt()), pattern: "dd/MM/yyyy \n") ?? "" : ""} ${FormatHelper.moneyFormat(touchedBarSpots[i].y)}",
                  TextStyle(color: getColor(i), fontSize: 14, fontWeight: FontWeight.w700),
                ),
              );
            }
            return tooltipItems;
          },
        ),
        touchCallback: (response) {
          isShow = true;
        },
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 15,
          getTextStyles: (value) => UITextStyle.mediumBlack_12_w400,
          margin: 10,
          interval: getHorizontalInterval(),
          getTitles: (value) {
            return getHorizontalValue(value.toInt());
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => UITextStyle.mediumBlack_12_w400,
          interval: widget.verticalInterval,
          getTitles: (value) {
            return getVerticalValue(value);
          },
          margin: 8,
          reservedSize: 25,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: UIColor.mediumBlack, width: 2),
          left: BorderSide(color: UIColor.mediumBlack, width: 2),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: getMinHorizontal(),
      maxX: getMaxHorizontal(),
      maxY: getMaxVertical(),
      minY: 0,
      lineBarsData: chartBarData(),
    );
  }

  List<LineChartBarData> chartBarData() {
    final List<LineChartBarData> result = [];
    for (int i = 0; i < (widget.data?.length ?? 0); ++i) {
      result.add(LineChartBarData(
        spots: widget.data[i],
        isCurved: false,
        colors: [getColor(i)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
            show: true,
            getDotPainter: (FlSpot spot, double xPercentage, LineChartBarData bar, int index, {double size}) {
              return FlDotCirclePainter(
                radius: 1.5.h,
                color: getColor(i),
                strokeColor: getColor(i),
              );
            }),
        belowBarData: BarAreaData(
          show: false,
        ),
      ));
    }
    return result;
  }

  Color getColor(int index) {
    return widget?.from[index] == "shopee" ? UIColor.yellow : Colors.blue;
  }

  double getHorizontalInterval() {
    final int statisticSize = widget.horizontalAxisValues?.length ?? 0;
    final double dayDiff = widget.horizontalAxisValues[statisticSize - 1].difference(widget.horizontalAxisValues[0]).inHours / 24 ?? 0;

    double result = 0;
    if (dayDiff > 1) {
      result = calcGapByDay(dayDiff, statisticSize);
    } else {
      result = calcGapByTime(dayDiff, statisticSize);
    }
    return result;
  }

  double calcGapByDay(double dayDiff, int statisticSize) {
    currentPattern = datePattern;
    final double dayGap = (dayDiff.toDouble() / maxHorizontalValue).toDouble() > 1 ? (dayDiff / maxHorizontalValue).toDouble() : 1;
    return dayGap.ceilToDouble() * dayToMilliseconds;
  }

  double calcGapByTime(double dayRange, int statisticSize) {
    final int hourDiff = widget.horizontalAxisValues[statisticSize - 1].difference(widget.horizontalAxisValues[0])?.inHours ?? 0;
    if (hourDiff > 1) {
      final double hourGap = (hourDiff / maxHorizontalValue).toDouble();
      currentPattern = hourPattern;
      return hourGap.ceilToDouble() * hourToMilliseconds;
    }

    currentPattern = timePattern;
    final double minuteGap = toleranceMinute.toDouble();
    return minuteGap * minuteToMilliseconds;
  }

  String getHorizontalValue(int index) {
    String res = FormatHelper.formatDateTime(DateTime.fromMillisecondsSinceEpoch(index), pattern: currentPattern);
    if (index == getMinHorizontal() && (currentPattern == hourPattern || currentPattern == timePattern)) {
      res = "${FormatHelper.formatDateTime(DateTime.fromMillisecondsSinceEpoch(index), pattern: "dd/MM")} $res";
    }
    return res;
  }

  String getVerticalValue(double value) {
    if (value < 1000000) {
      return "${(value / 1000).toStringAsFixed(0)}";
    } else if (value < 1000000000) {
      return "${(value / 1000000).toStringAsFixed(0)}";
    }
    return value.toStringAsFixed(0);
  }

  double getMinHorizontal() {
    if (currentPattern == datePattern) {
      return DateTime.parse(FormatHelper.formatDateTime(widget.horizontalAxisValues[0], pattern: FormatHelper.startDatePattern)).millisecondsSinceEpoch.toDouble();
    }
    final DateTime startDate = widget.horizontalAxisValues[0];
    final int deltaMilliseconds = (startDate.minute * minuteToMilliseconds + startDate.second * secondToMilliseconds) % (toleranceMinute * minuteToMilliseconds);
    return startDate.millisecondsSinceEpoch.toDouble() - deltaMilliseconds;
  }

  double getMinVertical() {
    if (widget.data?.isEmpty ?? false) {
      return 0;
    }
    if (widget.data[0]?.isEmpty ?? false) {
      return 0;
    }
    double min = widget.data[0]?.first?.y ?? 0;
    for (int j = 0; j < widget.data.length; ++j) {
      for (int i = 1; i < (widget.data[j]?.length ?? 0); ++i) {
        if (min > widget.data[j][i].y) {
          min = widget.data[j][i].y;
        }
      }
    }
    return min.floorToDouble();
  }

  double getMaxVertical() {
    if ((widget.data?.length ?? 0) == 0) {
      return 0;
    }
    if ((widget.data[0]?.length ?? 0) == 0) {
      return 0;
    }
    double max = widget.data[0]?.first?.y ?? 0;
    for (int j = 0; j < widget.data.length; ++j) {
      for (int i = 1; i < (widget.data[j]?.length ?? 0); ++i) {
        if (max < widget.data[j][i].y) {
          max = widget.data[j][i].y;
        }
      }
    }
    return max + widget.verticalInterval * 0.5;
  }

  double getMaxHorizontal() {
    if (currentPattern == datePattern) {
      return DateTime.parse(FormatHelper.formatDateTime(widget.horizontalAxisValues[widget.horizontalAxisValues.length - 1], pattern: FormatHelper.endDatePattern)).millisecondsSinceEpoch.toDouble();
    }
    final DateTime endDate = widget.horizontalAxisValues[widget.horizontalAxisValues.length - 1];
    final int deltaMilliseconds =
        ((toleranceMinute * minuteToMilliseconds) - (endDate.minute * minuteToMilliseconds + endDate.second * secondToMilliseconds)) % (toleranceMinute * minuteToMilliseconds);
    return endDate.millisecondsSinceEpoch.toDouble() + deltaMilliseconds;
  }
}
