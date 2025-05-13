import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample extends StatelessWidget {
  final List<Map<String, dynamic>> jsonData;
  final Color barColor;
  final String xKey;
  final String yKey;

  const BarChartSample({
    super.key,
    required this.jsonData,
    this.barColor = const Color(0xFF5A5A5A),
    this.xKey = 'label',
    this.yKey = 'value',
  });

  @override
  Widget build(BuildContext context) {
    final barGroups = _generateBarGroups();

    // Dynamically calculate the maxY and interval based on the data
    final maxY = _calculateMaxY();
    final interval = _calculateInterval(maxY);

    return AspectRatio(
      aspectRatio: 1.3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            maxY: maxY, // Use the dynamic maxY value
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '${jsonData[group.x.toInt()][xKey]}\n${rod.toY}',
                    const TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        jsonData[value.toInt()][xKey],
                        style: const TextStyle(fontSize: 11),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: interval,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    String formattedValue = _formatValue(value.toInt());
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(formattedValue),
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            barGroups: barGroups,
            gridData: FlGridData(show: true),
          ),
        ),
      ),
    );
  }

  // Method to calculate the dynamic maxY based on the highest value in jsonData
  double _calculateMaxY() {
  final maxValue = jsonData.fold<double>(0, (prev, element) {
    final value = (element[yKey] ?? 0).toDouble();
    return value > prev ? value : prev;
  });

  final interval = _calculateInterval(maxValue);
  return (maxValue / interval).ceil() * interval;
}

  // Method to calculate the dynamic interval based on the maximum value
  double _calculateInterval(double maxValue) {
  if (maxValue <= 0) return 1;

  final roughInterval = maxValue / 5; // target 5 garis horizontal
  final magnitude = pow(10, (log(roughInterval) / ln10).floor());
  final residual = roughInterval / magnitude;

  double niceResidual;
  if (residual <= 1) {
    niceResidual = 1;
  } else if (residual <= 2) {
    niceResidual = 2;
  } else if (residual <= 5) {
    niceResidual = 5;
  } else {
    niceResidual = 10;
  }

  return niceResidual * magnitude;
}


  // Method to format the values in a readable way (e.g., "10M", "1B")
  String _formatValue(int value) {
  if (value >= 1e9) {
    return '${(value / 1e9).toStringAsFixed(1).replaceAll('.0', '')}B';
  } else if (value >= 1e6) {
    return '${(value / 1e6).toStringAsFixed(1).replaceAll('.0', '')}M';
  } else if (value >= 1e3) {
    return '${(value / 1e3).toStringAsFixed(1).replaceAll('.0', '')}K';
  } else {
    return value.toString();
  }
}


  List<BarChartGroupData> _generateBarGroups() {
    return jsonData.asMap().entries.map((entry) {
      int index = entry.key;
      final value = entry.value[yKey].toDouble();

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: barColor,
            width: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }
}
