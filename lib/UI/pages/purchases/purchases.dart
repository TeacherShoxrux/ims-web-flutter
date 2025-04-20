import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/purchases/widgets/add_alert_purchases.dart';
import 'package:ims_web/services/paymetn_service.dart';

class PurchasesListPage extends StatefulWidget {
  @override
  _PurchasesListPageState createState() => _PurchasesListPageState();
}

class _PurchasesListPageState extends State<PurchasesListPage> {
  // Xaridlar ro'yxati
  List<Map<String, String>> purchases = [
    {'sr': '1', 'date': '03/10/2022', 'supplier': 'Supplier 1', 'totalAmount': '2.475'},
    {'sr': '2', 'date': '05/10/2022', 'supplier': 'Cash', 'totalAmount': '946'},
    {'sr': '3', 'date': '05/10/2022', 'supplier': 'Supplier 1', 'totalAmount': '9.305'},
    {'sr': '4', 'date': '01/10/2022', 'supplier': 'Cash', 'totalAmount': '674'},
  ];

  // Mahsulotlar ro'yxati
  final List<Map<String, dynamic>> products = [
    {'name': 'Lays Yogut', 'price': '18.00', 'image': 'assets/lays_yogut.png'},
    {'name': 'Lays Masla', 'price': '55.00', 'image': 'assets/lays_masla.png'},
    {'name': 'Lays Salted', 'price': '95.00', 'image': 'assets/lays_salted.png'},
    {'name': 'National Ketchup', 'price': '330.00', 'image': 'assets/national_ketchup.png'},
    {'name': 'National Ketchup Chilli', 'price': '330.00', 'image': 'assets/national_ketchup_chilli.png'},
    {'name': 'Coca Coal Tine', 'price': '48.00', 'image': 'assets/coca_coal_tine.png'},
    {'name': 'Gala Biscuits', 'price': '28.00', 'image': 'assets/gala_biscuits.png'},
    {'name': 'Candy Biscuits', 'price': '28.00', 'image': 'assets/candy_biscuits.png'},
    {'name': 'Pepcy Tin', 'price': '47.00', 'image': 'assets/pepcy_tin.png'},
    {'name': 'Sprit Tine', 'price': '47.00', 'image': 'assets/sprit_tine.png'},
    {'name': 'Nescafe', 'price': '35.00', 'image': 'assets/nescafe.png'},
    {'name': 'Coffe Mate', 'price': '800.00', 'image': 'assets/coffe_mate.png'},
    {'name': 'Coca Coal', 'price': '48.00', 'image': 'assets/coca_coal.png'},
    {'name': 'New', 'price': '1500.00', 'image': 'assets/new_item.png'},
  ];

  // Mijozlar ro'yxati
  final List<Map<String, String>> customers = [
    {'name': 'Cash', 'phone': '-', 'email': 'cash@gmail.com', 'address': '-'},
    {'name': 'Customer 1', 'phone': '0355', 'email': 'abc@gmail.com', 'address': 'New Address'},
    {'name': 'Customer 2', 'phone': '25335', 'email': 'jkd@hotmail.com', 'address': '15353'},
  ];

final paymentService = PaymetnService();


  void _showAddPurchaseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddPurchaseDialog(
          paymetnService: paymentService,
        //  products: products,
          customers: customers,
          onSave: (selectedProducts, selectedCustomer) {
            setState(() {
              purchases.insert(0, {
                'sr': (purchases.length + 1).toString(),
                'date': '15/10/2022', // Statik sana
                'supplier': selectedCustomer,
                'totalAmount': selectedProducts
                    .fold(0.0, (sum, item) => sum + (double.parse(item['price']) * item['quantity']))
                    .toStringAsFixed(3),
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Purchases List',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddPurchaseDialog,
                  icon: Icon(Icons.add),
                  label: Text('Add New'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.purple[300],
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Id',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Mijoz',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Vaqti',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Sotuvchi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                   Expanded(
                    flex: 2,
                    child: Text(
                      'Summasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: paymentService.getPayment(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return   ListView.builder(
                  itemCount: snapshot.data?.length??0,
                  itemBuilder: (context, index) {
                    return Container(
                      color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("${index + 1}"),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(snapshot.data?[index].customerName??'null'),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(snapshot.data?[index].createdAt??'null'),
                          ),
                            Expanded(
                            flex: 2,
                            child: Text('${snapshot.data?[index].userFullName}'),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('${snapshot.data?[index].amount}'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print('Edit bosildi: ${purchases[index]['supplier']}');
                                  },
                                  icon: Icon(Icons.edit, color: Colors.yellow[700]),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      purchases.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                  }return Center(child: CircularProgressIndicator());
                }
                
               
              ),
            ),
          ],
        ),
      ),
    );
  }
}