import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/login/login.dart';
import 'package:ims_web/services/auth_service.dart';
import 'package:ims_web/services/statistics_service.dart';
import 'package:intl/intl.dart';

import '../category/widgets/delete_category_alert.dart'; // Sana formatlash uchun

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // Xaridlar ro'yxati (oldin yaratilgan "Purchases List" dan olingan)
  final List<Map<String, dynamic>> purchases = [
    {'date': '03/10/2022', 'supplier': 'Supplier 1', 'totalAmount': 2475.0},
    {'date': '05/10/2022', 'supplier': 'Cash', 'totalAmount': 946.0},
    {'date': '05/10/2022', 'supplier': 'Supplier 1', 'totalAmount': 9305.0},
    {'date': '01/10/2022', 'supplier': 'Cash', 'totalAmount': 674.0},
  ];

  // Tanlangan mahsulotlar (oldin yaratilgan "Add Purchase" dialogidan olingan)
  final List<Map<String, dynamic>> purchasedProducts = [
    {'name': 'Lays Yogut', 'quantity': 2},
    {'name': 'Candy Biscuits', 'quantity': 2},
    {'name': 'Coca Coal Tine', 'quantity': 1},
  ];

  DateTime? startDate;
  DateTime? endDate;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  // Sana tanlash funksiyasi
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  // Hisobot statistikalarini hisoblash
  Map<String, dynamic> _calculateReport() {
    if (startDate == null || endDate == null) {
      return {
        'totalPurchasesAmount': 0.0,
        'numberOfPurchases': 0,
        'mostPurchasedProduct': 'N/A',
      };
    }

    // Sana oralig'iga mos xaridlarni filtr qilish
    List<Map<String, dynamic>> filteredPurchases =
        purchases.where((purchase) {
          DateTime purchaseDate = formatter.parse(purchase['date']);
          return purchaseDate.isAfter(startDate!.subtract(Duration(days: 1))) &&
              purchaseDate.isBefore(endDate!.add(Duration(days: 1)));
        }).toList();

    // Umumiy xaridlar summasi
    double totalPurchasesAmount = filteredPurchases.fold(
      0.0,
      (sum, item) => sum + item['totalAmount'],
    );

    // Xaridlar soni
    int numberOfPurchases = filteredPurchases.length;

    // Eng ko'p xarid qilingan mahsulot
    String mostPurchasedProduct = 'N/A';
    if (purchasedProducts.isNotEmpty) {
      purchasedProducts.sort((a, b) => b['quantity'].compareTo(a['quantity']));
      mostPurchasedProduct = purchasedProducts.first['name'];
    }

    return {
      'totalPurchasesAmount': totalPurchasesAmount,
      'numberOfPurchases': numberOfPurchases,
      'mostPurchasedProduct': mostPurchasedProduct,
    };
  }

  final authService = AuthService();
  final statsService = StatisticService();

  @override
  Widget build(BuildContext context) {
    // Ekran kengligini aniqlash
    final double screenWidth = MediaQuery.of(context).size.width;

    // CrossAxisCount ni ekran kengligiga qarab aniqlash
    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 3; // Katta ekranlar uchun 3 ta karta yonma-yon
    } else if (screenWidth > 600) {
      crossAxisCount = 2; // O'rta ekranlar uchun 2 ta karta yonma-yon
    } else {
      crossAxisCount = 1; // Kichik ekranlar uchun 1 ta karta (vertikal)
    }

    // Hisobot statistikalarini olish
    final report = _calculateReport();

    return Scaffold(
      backgroundColor: Colors.grey[200], // Fon rangi
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              screenWidth > 1200
                  ? 64.0
                  : screenWidth > 600
                  ? 32.0
                  : 16.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hisobotlar',
                  style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  ElevatedButton(
                  onPressed: () async {
                  var result = await  showDeleteConfirmationDialog(context,"Siz tizimdan chiqib ketyapsiz?","Tizimdan chiqish ");
                    if(result){
                      authService.logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                            (delate) => false,
                      );
                    }
                  },
                  child: Text("Chiqish", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Sana tanlash
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('Start Date', style: TextStyle(fontSize: 16)),
            //           SizedBox(height: 8),
            //           GestureDetector(
            //             onTap: () => _selectDate(context, true),
            //             child: Container(
            //               padding: EdgeInsets.symmetric(
            //                 vertical: 12,
            //                 horizontal: 16,
            //               ),
            //               decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.grey),
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               child: Text(
            //                 startDate == null
            //                     ? 'Select Start Date'
            //                     : formatter.format(startDate!),
            //                 style: TextStyle(fontSize: 16),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(width: 16),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('End Date', style: TextStyle(fontSize: 16)),
            //           SizedBox(height: 8),
            //           GestureDetector(
            //             onTap: () => _selectDate(context, false),
            //             child: Container(
            //               padding: EdgeInsets.symmetric(
            //                 vertical: 12,
            //                 horizontal: 16,
            //               ),
            //               decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.grey),
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               child: Text(
            //                 endDate == null
            //                     ? 'Select End Date'
            //                     : formatter.format(endDate!),
            //                 style: TextStyle(fontSize: 16),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 16),
            // Statistik kartalar
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio:
                    screenWidth > 1200
                        ? 2
                        : screenWidth > 600
                        ? 1.5
                        : 3, // Kartalarning o'lcham nisbati
                children: [
                  // Total Purchases Amount karta
                  StatCard(
                    title: 'Mahsulotlar barcha mahsulotlar',
                    value: "excel formatda yuklash",
                    icon: Icons.attach_money,
                    color: Colors.purple,
                    screenWidth: screenWidth, onTap: () {

                      statsService.downloadProductsExcel();
                  },

                  ),
                  // Number of Purchases karta
                  StatCard(
                    title: 'Oylik savdo',
                    value: "excel formatda yuklash",
                    icon: Icons.receipt,
                    color: Colors.blue,
                    screenWidth: screenWidth,
                    onTap: () {
                      statsService.downloadProductsExcel();
                    },
                  ),
                  // Most Purchased Product karta
                  StatCard(
                    title: 'Haftalik savdo',
                    value: "excel formatda yuklash",
                    icon: Icons.star,
                    color: Colors.orange,
                    screenWidth: screenWidth, onTap: () {
                    statsService.downloadWeekExcel();
                  },
                  ),
                  StatCard(
                    title: 'Kunlik savdo',
                    value: "excel formatda yuklash",
                    icon: Icons.star,
                    color: Colors.orange,
                    screenWidth: screenWidth, onTap: () {
                    statsService.downloadWeekExcel();
                  },
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
  final VoidCallback onTap;

  StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.screenWidth, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Card(

        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(screenWidth > 600 ? 16.0 : 12.0),
          child: Row(
            children: [
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 14 : 12,
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
      ),
    );
  }
}
