import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:bali_baci_order/widgets/card_widget.dart';
import 'package:bali_baci_order/widgets/chart/bar_chart.dart';
import 'package:bali_baci_order/widgets/chart/bar_chart_tabs.dart';
import 'package:bali_baci_order/widgets/chart/pie_chart.dart';
import 'package:bali_baci_order/widgets/chart/left_bar_chart.dart';
import 'package:bali_baci_order/widgets/metrics/metrics_grid.dart';
import 'package:bali_baci_order/widgets/navtop.dart';
import 'package:bali_baci_order/widgets/refresh_indicator.dart';
import 'package:bali_baci_order/widgets/table/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:bali_baci_order/data/dashboardData.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 8.0,
        backgroundColor: AppColors.darkGrey,
        shape: Border(
          bottom: BorderSide(
            color: AppColors.darkGrey,
            width: 0.3,
          ),
        ),
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
                Navtop(),
                MetricsGrid(
                  metricsData: metricsData,
                ),
                CardWidget(
                  cardHeader: CardHeader(
                    title: "Latest order",
                    subtitle: "Latest order",
                    iconData: Icons.receipt_long, // Icon for Latest Order
                  ),
                  child: TableWidget(
                    titleData: titleData,
                    tableData: tableData,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CardWidget(
                        cardHeader: CardHeader(
                          title: "Customers",
                          subtitle: "Member & Common",
                          iconData: Icons.group, // Icon for Customers
                        ),
                        child: PieChartSample3(
                          data: customerPersentage,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CardWidget(
                        cardHeader: CardHeader(
                          title: "Sales",
                          subtitle: "Sales by Continent",
                          iconData: Icons.public, // Icon for Sales by Continent
                        ),
                        child: PieChartSample3(data: sales),
                      ),
                    ),
                  ],
                ),
                CardWidget(
                  cardHeader: CardHeader(
                    title: "Order Revenue",
                    subtitle: "Order Revenue for 2025",
                    iconData:
                        Icons.stacked_line_chart, // Icon for Order Revenue
                  ),
                  child: BarChartSample7(
                    aspectRatio: 3.6,
                    data: data,
                    color: AppColors.darkGrey,
                    valueField: 'revenue',
                    keyField: 'currency',
                  ),
                ),
                CardWidget(
                  cardHeader: CardHeader(
                    title: "Order Count",
                    subtitle: "Order Count for 2025",
                    iconData: Icons.confirmation_num, // Icon for Order Count
                  ),
                  child: BarChartSample7(
                    aspectRatio: 3.6,
                    data: data,
                    color: Colors.greenAccent,
                    valueField: 'order_count',
                    keyField: 'currency',
                  ),
                ),
                CardWidget(
                  cardHeader: CardHeader(
                    title: "Revenue",
                    subtitle: "Monthly Revenue",
                    iconData: Icons.query_stats, // Icon for Monthly Revenue
                  ),
                  child: BarChartSample(
                    jsonData: sampleData,
                    barColor: AppColors.darkGrey,
                    xKey: 'label',
                    yKey: 'value',
                  ),
                ),
                CardWidget(
                  cardHeader: CardHeader(
                    title: "Revenue",
                    subtitle: "Monthly Revenue by Currency",
                    iconData:
                        Icons.currency_exchange, // Icon for Revenue by Currency
                  ),
                  child: BarChartWithTabs(
                    tabLabels: ['IDR', 'USD', 'EUR'],
                    chart: [
                      BarChartSample(
                        jsonData: idrData,
                        xKey: 'label',
                        yKey: 'value',
                        barColor: Colors.red,
                      ),
                      BarChartSample(
                        jsonData: usdData,
                        xKey: 'label',
                        yKey: 'value',
                        barColor: Colors.blue,
                      ),
                      BarChartSample(
                        jsonData: eurData,
                        xKey: 'label',
                        yKey: 'value',
                        barColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                CardWidget(
                  cardHeader: CardHeader(
                    title: "Top Customers",
                    subtitle: "Top Customers by Revenue and Orders",
                    iconData:
                        Icons.emoji_events, // Icon for Revenue by Currency
                  ),
                  child: BarChartWithTabs(
                    tabLabels: ['Revenue', 'Orders'],
                    chart: [
                      BarChartSample7(
                        aspectRatio: 1.2,
                        data: customerRevenue,
                        color: Colors.yellow,
                        valueField: 'revenue',
                        keyField: 'customers',
                      ),
                      BarChartSample7(
                        aspectRatio: 1.2,
                        data: customerOrders,
                        color: AppColors.primaryGrey,
                        valueField: 'orders',
                        keyField: 'customers',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
