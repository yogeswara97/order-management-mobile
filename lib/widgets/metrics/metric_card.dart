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

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, color: Colors.blue[600], size: 24),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              if (percentage != null && percentageStatus != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textColor),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
