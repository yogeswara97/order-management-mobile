import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

class Table2Widget extends StatelessWidget {
  final List<String> titleData;
  final List<Map<String, String>> tableData;

  Table2Widget({super.key, required this.titleData, required this.tableData});

  Map<String, Map<String, Color>> getStatusColors() {
    return {
      'member': {
        'background': Colors.blue, // Replace with AppColors.blue if defined
        'text': Colors.white,
      },
      'common': {
        'background': Colors.grey, // Replace with AppColors.grey if defined
        'text': Colors.white,
      },
      'super admin': {
        'background': Colors.yellow, // Replace with AppColors.yellow if defined
        'text': Colors.black,
      },
      'admin': {
        'background': Colors.green, // Replace with AppColors.green if defined
        'text': Colors.white,
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final statusColors = getStatusColors();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.8),
              2: FlexColumnWidth(2.5),
            },
            children: [
              // Header Row
              TableRow(
                decoration:
                    BoxDecoration(color: AppColors.lightGrey.withOpacity(0.3)),
                children: titleData
                    .map((title) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              // Data Rows
              ...tableData.map((row) {
                final status = row['status']!;
                final statusStyle = statusColors[status] ??
                    {
                      'background': Colors.transparent,
                      'text': Colors.black,
                    };

                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        row['name']!,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: statusStyle['background'],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 14,
                            color: statusStyle['text'],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(row['email']!,
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
