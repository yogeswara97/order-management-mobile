import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SalesProgressBar extends StatelessWidget {
  const SalesProgressBar({super.key});

  final List<Map<String, dynamic>> salesData = const [
    {'label': 'Asia', 'value': 75, 'color': Color(0xFFdc2626)},
    {'label': 'Europe', 'value': 60, 'color': Color(0xFF2563eb)},
    {'label': 'America', 'value': 45, 'color': Color(0xFF059669)},
    {'label': 'Australia', 'value': 20, 'color': Color(0xFF9333ea)},
    {'label': 'Africa', 'value': 30, 'color': Color(0xFFca8a04)},
    {'label': 'Undefined', 'value': 30, 'color': Color(0xFF4b5563)},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sales by Continent",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkGrey,
            ),
          ),
          ...salesData.map((data) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${data['label']} - ${data['value']}%"),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: data['value'] / 100,
                        minHeight: 10,
                        backgroundColor: AppColors.lightGrey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(data['color']),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
