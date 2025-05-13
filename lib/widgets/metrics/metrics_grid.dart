import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:bali_baci_order/widgets/metrics/metric_card.dart';
import 'package:flutter/material.dart';

class MetricsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> metricsData;
  const MetricsGrid({super.key, required this.metricsData});

  @override
  Widget build(BuildContext context) {
    

    return Stack(
      children: [
        Column(
          children: [
            Container(height: 60, color: AppColors.darkGrey),
            Container(height: 60),
          ],
        ),
        Positioned.fill(
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: metricsData.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 5,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final data = metricsData[index];
              return MetricCard(
                icon: data['icon'] as IconData,
                title: data['title'] as String,
                value: data['value'] as String,
                percentage: data['percentage'] != null
                    ? (data['percentage'] as num).toDouble()
                    : null,
                percentageStatus: data['status'] as String?,
              );
            },
          ),
        ),
      ],
    );
  }
}
