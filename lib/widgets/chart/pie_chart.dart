import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample3 extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PieChartSample3({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State<PieChartSample3> {
  int touchedIndex = -1;

  final List<Color> colors = [
    Color(0xFF1C64F2),
    Color(0xFF16BDCA),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse?.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse!
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final filteredData = widget.data.where((e) => e['value'] > 0).toList();
    final total = filteredData.fold<double>(
        0.0, (sum, item) => sum + (item['value'] as num).toDouble());

    return List.generate(filteredData.length, (i) {
      final item = filteredData[i];
      final label = item['label'];
      final value = (item['value'] as num).toDouble();
      final percentage = (value / total * 100).toStringAsFixed(0);
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 12.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: colors[i % colors.length],
        value: value,
        title: '$label\n$percentage%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }
}
