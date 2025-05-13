import 'package:bali_baci_order/screens/login.dart';
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
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
