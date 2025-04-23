import 'package:flutter/material.dart';

import '../../../services/statistics_service.dart';


class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});
  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
 final statService = StatisticService();

  final int totalCustomers = 3;

  final int totalSuppliers = 4;

  final int totalProducts = 14;

  final double totalPurchasesAmount = 13295.0;

 // Xaridlar summasi
getData()async{
  var result= await statService.getDashboardStats();
  print(result);
}
@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 600) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
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
            FutureBuilder(
              future: statService.getDashboardStats(),
              builder: (context,snapshot) {
                if(snapshot.hasData) {
                  return Expanded(
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
                        title: 'Barcha Mijozlar',
                        value: "${snapshot.data?.totalCustomer}",
                        icon: Icons.person,
                        color: Colors.blue,
                        screenWidth: screenWidth,
                      ),
                      // Total Suppliers karta
                      StatCard(
                        title: 'Barcha Sotuvlar',
                        value: "${snapshot.data?.totalSales}",
                        icon: Icons.local_shipping,
                        color: Colors.green,
                        screenWidth: screenWidth,
                      ),
                      // Total Products karta
                      StatCard(
                        title: 'Barcha Mahsulotlar',
                        value: "${snapshot.data?.totalProduct}",
                        icon: Icons.inventory,
                        color: Colors.orange,
                        screenWidth: screenWidth,
                      ),
                      // Total Purchases Amount karta
                      StatCard(
                        title: 'Top Mahsulot ',
                        value: "${snapshot.data?.topProduct}",
                        icon: Icons.attach_money,
                        color: Colors.purple,
                        screenWidth: screenWidth,
                      ),
                    ],
                  ),
                );
                }
                return Center(child: CircularProgressIndicator());
              },
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

  const StatCard({
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
                      fontSize: screenWidth > 600 ? 12 : 10,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 16 : 14,
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