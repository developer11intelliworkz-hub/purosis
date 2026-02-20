import 'package:flutter/material.dart';
import 'package:purosis/feature/admin/product/view/product_view.dart';

import '../../marketing/view/marketing_content.dart';


class MainScreenAdmin extends StatelessWidget {
  const MainScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MarketingContent(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Color(0xFF8EBf1F)),
          selectedItemColor: Color(0xFF8EBf1F),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined),label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined),label: "Products"),
            BottomNavigationBarItem(icon: Icon(Icons.spoke_outlined),label: "Marketing Assets"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Profile"),
          ]),
    );
  }
}