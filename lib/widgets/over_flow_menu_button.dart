import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

class OverflowMenuButton extends StatelessWidget {
  const OverflowMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: AppColors.white,
      ), // Ikon titik tiga vertikal
      onSelected: (String result) {
        // Handle pilihan menu
        switch (result) {
          case 'logout':
            print('Logout diklik');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'logout',
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
