import 'package:flutter/material.dart';

import '../../widgets/sidebar/customsidebar.dart';
import '../category/category.dart';
import '../customers/customers.dart';
import '../products/products.dart';
import '../purchases/purchases.dart';
import '../reports/reports.dart';
import '../saffs/staffs.dart';
import '../statsitics/statistics.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    StatisticsPage(),
    CategoryListPage(),
    ProductsListPage(),
    CustomerListPage(),
    PurchasesListPage(),
    StaffsListPage(),
    ReportsPage(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomSidebar(
            selectedIndex: _selectedIndex,
            onItemSelected: _onItemSelected,
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}