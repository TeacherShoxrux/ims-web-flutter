import 'package:flutter/material.dart';


class StatisticsPage extends StatelessWidget {
// Statistik ma'lumotlar (haqiqiy loyihada bu ma'lumotlar bazadan olinadi)
  final int totalCustomers = 3; // Mijozlar soni
  final int totalSuppliers = 4; // Yetkazib beruvchilar soni
  final int totalProducts = 14; // Mahsulotlar soni
  final double totalPurchasesAmount = 13295.0; // Xaridlar summasi

  @override
  Widget build(BuildContext context) {
    // Ekran kengligini aniqlash
    final double screenWidth = MediaQuery.of(context).size.width;

    // CrossAxisCount ni ekran kengligiga qarab aniqlash
    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 4; // Katta ekranlar uchun 4 ta karta yonma-yon
    } else if (screenWidth > 600) {
      crossAxisCount = 2; // O'rta ekranlar uchun 2 ta karta yonma-yon
    } else {
      crossAxisCount = 1; // Kichik ekranlar uchun 1 ta karta (vertikal)
    }

    return Scaffold(
      backgroundColor: Colors.grey[200], // Fon rangi
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 1200
              ? 64.0
              : screenWidth > 600
              ? 32.0
              : 16.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Qidiruv paneli
            Container(
              width: screenWidth > 1200 ? 400 : double.infinity,
              child: TextField(
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
            ),
            SizedBox(height: 16),
            // Sarlavha
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: screenWidth > 600 ? 24 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Statistik kartalar
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: screenWidth > 1200
                    ? 2
                    : screenWidth > 600
                    ? 1.5
                    : 3, // Kartalarning o'lcham nisbati
                children: [
                  // Total Customers karta
                  StatCard(
                    title: 'Total Customers',
                    value: totalCustomers.toString(),
                    icon: Icons.person,
                    color: Colors.blue,
                    screenWidth: screenWidth,
                  ),
                  // Total Suppliers karta
                  StatCard(
                    title: 'Total Suppliers',
                    value: totalSuppliers.toString(),
                    icon: Icons.local_shipping,
                    color: Colors.green,
                    screenWidth: screenWidth,
                  ),
                  // Total Products karta
                  StatCard(
                    title: 'Total Products',
                    value: totalProducts.toString(),
                    icon: Icons.inventory,
                    color: Colors.orange,
                    screenWidth: screenWidth,
                  ),
                  // Total Purchases Amount karta
                  StatCard(
                    title: 'Total Purchases Amount',
                    value: totalPurchasesAmount.toStringAsFixed(2),
                    icon: Icons.attach_money,
                    color: Colors.purple,
                    screenWidth: screenWidth,
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
  final double screenWidth;

  StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth > 600 ? 16.0 : 12.0),
        child: Row(
          children: [
            // Ikonka
            CircleAvatar(
              radius: screenWidth > 600 ? 30 : 25,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(
                icon,
                size: screenWidth > 600 ? 30 : 25,
                color: color,
              ),
            ),
            SizedBox(width: screenWidth > 600 ? 16 : 12),
            // Matn qismi
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 16 : 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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