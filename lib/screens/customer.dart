import 'package:bali_baci_order/widgets/refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:bali_baci_order/widgets/card_widget.dart';
import 'package:bali_baci_order/widgets/table/table2_widget.dart';
import 'package:bali_baci_order/data/customerData.dart';

class Customer extends StatelessWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
      ),
      body: RefreshIndicatorWidget(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          print("Refreshed!");
        },
        child: Stack(
          children: [
            ListView(
              children: [
                CardWidget(child: Table2Widget(titleData: titleData, tableData: tableData))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
