import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:bali_baci_order/widgets/bottom_naviagtion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bali Baci',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.figtree().fontFamily,
        appBarTheme: const AppBarTheme(
          color: AppColors.darkGrey,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: BottomNavigation(),
    );
  }
}
