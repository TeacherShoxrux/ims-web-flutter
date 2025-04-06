import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.home, 'label': 'Bosh sahifa'},
    {'icon': Icons.category, 'label': 'Kategoriyalar'},
    {'icon': Icons.shopping_bag, 'label': 'Mahsulotlar'},
    {'icon': Icons.shopping_cart_checkout, 'label': 'Mijozlar'},
    // {'icon': Icons.local_shipping, 'label': 'Supplier'},
    {'icon': Icons.lock, 'label': "To'lovlar"},
    // {'icon': Icons.sell, 'label': 'Sales'},
    {'icon': Icons.person, 'label': 'Ishchilar'},
    {'icon': Icons.insert_chart, 'label': 'Hisoblatlar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: Color(0xFF6A5AE0),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 10),
          const Text(
            'Waqar Ahmad',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Divider(color: Colors.white54, height: 30),
          // Dynamic menu generation
          for (int i = 0; i < menuItems.length; i++)
            menuItem(
              icon: menuItems[i]['icon'],
              title: menuItems[i]['label'],
              isSelected: i == selectedIndex,
              onTap: () => onItemSelected(i),
            ),
        ],
      ),
    );
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}