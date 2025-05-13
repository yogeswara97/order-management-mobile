import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:bali_baci_order/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final double? percentage;
  final String? percentageStatus; // 'up', 'down', 'flat'

  const MetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.percentage,
    this.percentageStatus,
  });

  @override
  Widget build(BuildContext context) {
    Color? bgColor;
    Color? textColor;
    IconData? statusIcon;

    switch (percentageStatus) {
      case 'up':
        bgColor = Colors.green[100];
        textColor = Colors.green[600];
        statusIcon = Icons.arrow_upward;
        break;
      case 'down':
        bgColor = Colors.red[100];
        textColor = Colors.red[600];
        statusIcon = Icons.arrow_downward;
        break;
      case 'flat':
        bgColor = Colors.grey[200];
        textColor = Colors.grey[600];
        statusIcon = Icons.compare_arrows;
        break;
    }

    return CardWidget(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, color: Colors.blue[600], size: 20),
          ),
          const SizedBox(height: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (percentage != null && percentageStatus != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(statusIcon, size: 14, color: textColor),
                          const SizedBox(width: 4),
                          Text(
                            '${percentage!.toStringAsFixed(1)}%',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Metrics extends StatelessWidget {
  const Metrics({super.key});

  @override
  Widget build(BuildContext context) {
    final metricsData = [
      {
        'icon': Icons.bar_chart,
        'title': 'New Order',
        'value': '\$12K',
        'percentage': 3.5,
        'status': 'up',
      },
      {
        'icon': Icons.people,
        'title': 'Total Order',
        'value': '1.2K',
        'percentage': -1.2,
        'status': 'down',
      },
      {
        'icon': Icons.shopping_cart,
        'title': 'Revenue Year',
        'value': '300',
        'percentage': 0,
        'status': 'flat',
      },
      {
        'icon': Icons.star,
        'title': 'Total Customers',
        'value': '4.8',
        'percentage': 1.1,
        'status': 'up',
      },
    ];

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
              childAspectRatio: 0.50,
            ),
            itemBuilder: (context, index) {
              final data = metricsData[index];
              return MetricCard(
                icon: data['icon'] as IconData,
                title: data['title'] as String,
                value: data['value'] as String,
                percentage: (data['percentage'] as num).toDouble(),
                percentageStatus: data['status'] as String,
              );
            },
          ),
        ),
      ],
    );
  }
}
