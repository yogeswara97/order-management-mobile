import 'package:bali_baci_order/widgets/metrics/metrics_grid.dart';
import 'package:bali_baci_order/widgets/refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:bali_baci_order/widgets/card_widget.dart';
import 'package:bali_baci_order/widgets/table/table_widget.dart';
import 'package:bali_baci_order/data/orderData.dart';

class Order extends StatefulWidget {
  const Order({super.key});

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

      return statusMatch;
    }).toList();
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
                MetricsGrid(
                  metricsData: orderStatusMetrics,
                ),
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
