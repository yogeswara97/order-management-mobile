import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample7 extends StatefulWidget {
  final double? aspectRatio;
  final Map<String, List<dynamic>> data; // Data passed as a Map
  final Color color; // Single color for all bars
  final String
      valueField; // Field to use for bar heights (e.g., 'revenue', 'order_count')
  final String keyField;

  BarChartSample7(
      {super.key,
      this.aspectRatio = 1.4,
      required this.data,
      this.color = AppColors.primaryGrey, // Default color
      required this.valueField, // Default field for bar heights
      required this.keyField});

  @override
  State<BarChartSample7> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<BarChartSample7> {
  int touchedGroupIndex = -1;
  int rotationTurns = 1;

  // Generate bar groups dynamically
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 10,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  // Calculate maxY dynamically based on the specified value field
  double getMaxY() {
    final values = widget.data[widget.valueField]
            ?.map((e) => (e is int ? e.toDouble() : e as double))
            .toList() ??
        [];

    if (values.isEmpty) return 40.0;

    final max = values.reduce((a, b) => a > b ? a : b);
    return max.ceilToDouble(); 
  }

  @override
  Widget build(BuildContext context) {
    // Extract data from the provided map and convert to double
    final values = widget.data[widget.valueField]
            ?.map((e) => (e is int ? e.toDouble() : e as double))
            .toList() ??
        [];
    final keys = widget.data[widget.keyField]?.cast<String>() ?? [];
    final dataLength = values.length;

    // Generate bar data dynamically with a single color
    final dataList = List.generate(
      dataLength,
      (index) => _BarData(
        widget.color, // Use the single color for all bars
        values[index],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: widget.aspectRatio ?? 1.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                rotationQuarterTurns: rotationTurns,
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: AppColors.darkGrey.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: const AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 60,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        final label = (index >= 0 && index < keys.length)
                            ? keys[index]
                            : '';
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: SizedBox(
                            width: 60,
                            child: Text(
                              label,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.darkGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.darkGrey.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  ),
                ),
                barGroups: dataList.asMap().entries.map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(index, data.color, data.value);
                }).toList(),
                maxY: getMaxY(), // Dynamically set maxY based on valueField
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                    tooltipMargin: 0,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY % 1 == 0
                            ? rod.toY.toInt().toString()
                            : rod.toY.toStringAsFixed(1),
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: rod.color,
                          fontSize: 18,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value);

  final Color color;
  final double value;
}
