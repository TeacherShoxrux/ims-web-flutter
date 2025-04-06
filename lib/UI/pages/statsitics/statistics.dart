import 'package:flutter/material.dart';


class StatisticsPage extends StatelessWidget {
  // Statistik ma'lumotlar (haqiqiy loyihada bu ma'lumotlar bazadan olinadi)
  final int totalCustomers = 3; // Mijozlar soni
  final int totalSuppliers = 4; // Yetkazib beruvchilar soni
  final int totalProducts = 14; // Mahsulotlar soni
  final double totalPurchasesAmount = 13295.0; // Xaridlar summasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fon rangi
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Qidiruv paneli
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Here',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            // Sarlavha
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Statistik kartalar
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 ta karta yonma-yon
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5, // Kartalarning o'lcham nisbati
                children: [
                  // Total Customers karta
                  StatCard(
                    title: 'Total Customers',
                    value: totalCustomers.toString(),
                    icon: Icons.person,
                    color: Colors.blue,
                  ),
                  // Total Suppliers karta
                  StatCard(
                    title: 'Total Suppliers',
                    value: totalSuppliers.toString(),
                    icon: Icons.local_shipping,
                    color: Colors.green,
                  ),
                  // Total Products karta
                  StatCard(
                    title: 'Total Products',
                    value: totalProducts.toString(),
                    icon: Icons.inventory,
                    color: Colors.orange,
                  ),
                  // Total Purchases Amount karta
                  StatCard(
                    title: 'Total Purchases Amount',
                    value: totalPurchasesAmount.toStringAsFixed(2),
                    icon: Icons.attach_money,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Statistik karta widgeti
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Ikonka
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),
            SizedBox(width: 16),
            // Matn qismi
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}