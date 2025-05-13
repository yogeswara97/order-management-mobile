import 'package:bali_baci_order/screens/admin.dart';
import 'package:bali_baci_order/screens/customer.dart';
import 'package:bali_baci_order/screens/dashboard.dart';
import 'package:bali_baci_order/screens/order.dart';
import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  BottomNavigation({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            Dashboard(),
            Order(),
            Customer(),
            Admin()
          ],
        ),
        bottomNavigationBar: Material(
          
          elevation: 10,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            selectedItemColor:
                AppColors.darkGrey, // Udah diganti ke biru dari utils
            unselectedItemColor: Colors.grey[700],
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w900),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon:
                    SizedBox(height: 30, child: Icon(Icons.dashboard_rounded)),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 30, child: Icon(Icons.shopping_cart_checkout)),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon:
                    SizedBox(height: 30, child: Icon(Icons.people_alt_rounded)),
                label: "Customers",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 30, child: Icon(Icons.admin_panel_settings)),
                label: "Admin",
              ),
            ],
          ),
        ));
  
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
