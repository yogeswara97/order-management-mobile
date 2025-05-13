import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:bali_baci_order/widgets/over_flow_menu_button.dart';
import 'package:flutter/material.dart';

class Navtop extends StatelessWidget {
  const Navtop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    color: AppColors.darkGrey,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gezz',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'gezz@gmail.com',
                  style: TextStyle(color: AppColors.white),
                ),
                SizedBox(width: 8),
                Text(
                  'Super Admin',
                  style: TextStyle(color: AppColors.lightGrey),
                ),
              ],
            ),
          ],
        ),
        OverflowMenuButton()
      ],
    ),
  );

  }
}