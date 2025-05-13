import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final List<String> titleData;
  final List<Map<String, String>> tableData;

  const TableWidget({super.key, required this.titleData, required this.tableData});

  Map<String, Map<String, Color>> getStatusColors() {
    return {
      'New': {
        'background': Colors.blue, // Replace with AppColors.blue if defined
        'text': Colors.white,
      },
      'Quotation': {
        'background': Colors.grey, // Replace with AppColors.grey if defined
        'text': Colors.white,
      },
      'Invoice': {
        'background': Colors.yellow, // Replace with AppColors.yellow if defined
        'text': Colors.black,
      },
      'Paid': {
        'background': Colors.green, // Replace with AppColors.green if defined
        'text': Colors.white,
      },
      'Cancelled': {
        'background': Colors.red, // Replace with AppColors.red if defined
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
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1), // Column for Action Button
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
                    .toList()
                    ..add(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
              ),
              // Data Rows
              ...tableData.asMap().entries.map((entry) {
                final index = entry.key;
                final row = entry.value;
                final isEvenRow = index.isEven;
                final rowColor = isEvenRow
                    ? Colors.white
                    : AppColors.lightGrey
                        .withOpacity(0.1); // atau pakai warna lain

                final status = row['status']!;
                final statusStyle = statusColors[status] ?? {
                  'background': Colors.transparent,
                  'text': Colors.black,
                };

                return TableRow(
                  decoration: BoxDecoration(color: rowColor),
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
                      child: Text(row['total']!,
                          style: const TextStyle(fontSize: 14)),
                    ),
                    // Action Button Column
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.remove_red_eye_rounded),
                        onPressed: () {
                          print('More options for ${row['name']}');
                        },
                      ),
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
