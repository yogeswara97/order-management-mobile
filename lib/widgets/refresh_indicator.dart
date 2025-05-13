import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const RefreshIndicatorWidget(
      {super.key, required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child, 
      onRefresh: onRefresh,
      color: AppColors.darkGrey,
      backgroundColor: Colors.white,
    );
  }
}