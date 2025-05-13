import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:bali_baci_order/widgets/chart/bar_chart.dart';
import 'package:flutter/material.dart';

class BarChartWithTabs extends StatefulWidget {
  final List<String> tabLabels;
  final List<Widget> chart;
  const BarChartWithTabs({super.key, required this.chart, required this.tabLabels});

  @override
  State<BarChartWithTabs> createState() => _BarChartWithTabsState();
}

class _BarChartWithTabsState extends State<BarChartWithTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabLabels.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: AppColors.darkGrey,
          tabs: List.generate(widget.tabLabels.length, (index) {
            return Tab(text: widget.tabLabels[index]);  // Use the dynamic tab labels
          }),
        ),
        const SizedBox(height: 12),
        IndexedStack(
          index: _tabController.index,
          children: widget.chart, 
        ),
      ],
    );
  }
}

