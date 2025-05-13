import 'package:bali_baci_order/widgets/button_widget.dart';
import 'package:bali_baci_order/widgets/date_picker.dart';
import 'package:bali_baci_order/widgets/metrics/metrics_grid.dart';
import 'package:bali_baci_order/widgets/refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:bali_baci_order/widgets/card_widget.dart';
import 'package:bali_baci_order/widgets/table/table_widget.dart';
import 'package:bali_baci_order/data/orderData.dart';
class Order extends StatefulWidget {
  Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool showDefaultConfig = true;
  String selectedView = 'Line & Column';
  String selectedStatus = 'All';
  TextEditingController totalController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  List<Map<String, String>> getFilteredData() {
    return orderData.where((row) {
      final statusMatch =
          selectedStatus == 'All' || row['status'] == selectedStatus;

      final startDate = DateTime.tryParse(startDateController.text);
      final endDate = DateTime.tryParse(endDateController.text);
      final rowDate = DateTime.tryParse(row['date'] ?? '');

      final dateMatch = (startDate == null ||
              (rowDate != null &&
                  rowDate
                      .isAfter(startDate.subtract(const Duration(days: 1))))) &&
          (endDate == null ||
              (rowDate != null &&
                  rowDate.isBefore(endDate.add(const Duration(days: 1)))));

      return statusMatch && dateMatch;
    }).toList();
  }

  void _showDateRangePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: EdgeInsets.all(16),
          child: DatePicker(
            onDateRangeSelected: (String start, String end) {
              setState(() {
                startDateController.text = start;
                endDateController.text = end;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: RefreshIndicatorWidget(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 300));
          setState(() {
            selectedStatus = 'All';
            startDateController.clear();
            endDateController.clear();
          });
        },
        child: Stack(
          children: [
            ListView(
              children: [
                MetricsGrid(metricsData: [],),
                // Filter Section inside CardWidget
                CardWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Filter by Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status"),
                            SizedBox(
                              width: 150,
                              child: DropdownButton<String>(
                                value: selectedStatus,
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedStatus = newValue!;
                                  });
                                },
                                items: <String>[
                                  'All',
                                  'New',
                                  'Quotation',
                                  'Invoice',
                                  'Paid',
                                  'Cancelled'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          children: [
                            // Start Date
                            Expanded(
                              child: TextFormField(
                                controller: startDateController,
                                readOnly: true,
                                onTap: _showDateRangePicker,
                                decoration: InputDecoration(
                                  labelText: "Start Date",
                                  hintText: "YYYY-MM-DD",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),

                            SizedBox(width: 20),

                            // End Date
                            Expanded(
                              child: TextFormField(
                                controller: endDateController,
                                readOnly: true,
                                onTap: _showDateRangePicker,
                                decoration: InputDecoration(
                                  labelText: "End Date",
                                  hintText: "YYYY-MM-DD",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonWidget(
                              text: 'Reset',
                              onPressed: () {
                                setState(() {
                                  selectedStatus = 'All';
                                  startDateController.clear();
                                  endDateController.clear();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                CardWidget(
                    child: TableWidget(
                        titleData: titleData, tableData: getFilteredData()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
