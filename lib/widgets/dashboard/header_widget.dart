import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ganesh Kumar',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'iamganesh@yahoo.com',
                  style: TextStyle(color: AppColors.darkGrey),
                ),
                SizedBox(width: 8),
                Text(
                  'Super Admin',
                  style: TextStyle(color: AppColors.lightGrey),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );

  }
}