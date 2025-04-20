import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/customers/widgets/add_customer_alert.dart';
import 'package:ims_web/services/customer_service.dart';

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  // Ro'yxat uchun ma'lumotlar
  final List<Map<String, String>> customers = [
    {
      'sr': '1',
      'name': 'Cash',
      'phone': '-',
      'email': 'cash@gmail.com',
      'address': '-',
    },
    {
      'sr': '2',
      'name': 'Customer 2',
      'phone': '25335',
      'email': 'jkd@hotmail.com',
      'address': '15353',
    },
    {
      'sr': '3',
      'name': 'Customer 1',
      'phone': '0355',
      'email': 'abc@gmail.com',
      'address': 'New Address',
    },
  ];

  final customerService = CustomerService();

  void _showAddCategoryDialog(BuildContext context) async {
    var result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AddCustomerAlert(customerService: customerService);
      },
    );
    if (result == true) {
      setState(() {});
    }
  }
  // void _showAddCustomerDialog() {
  //   String name = '';
  //   String newPhone = '';
  //   String newEmail = '';
  //   String newAddress = '';

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AddCustomerAlert();
  //     },
  //   );
  // }

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
            // Sarlavha va Add New tugmasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Customer List',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add New tugmasi bosilganda bajariladigan kod
                    _showAddCategoryDialog(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add New'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Tugma rangi
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Ro'yxat sarlavhasi
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
                      'Ism',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Telefon',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Malumot',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 2,
                  //   child: Text(
                  //     'Address',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(), // Bo'sh joy ikonlar uchun
                  ),
                ],
              ),
            ),
            // Ro'yxat elementlari
            Expanded(
              child: FutureBuilder(
                future: customerService.getAllCustomer(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          color:
                              index % 2 == 0 ? Colors.white : Colors.grey[100],
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: Text("${index + 1}")),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  snapshot.data?[index].name ?? 'null',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  snapshot.data?[index].phone ?? 'null',
                                ),
                              ),
                              Expanded(flex: 0, child: Text('')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  snapshot.data?[index].info ?? 'null',
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Edit tugmasi bosilganda
                                        // print('Edit bosildi: ${customers[index]['name']}');
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.yellow[700],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Delete tugmasi bosilganda
                                        // setState(() {
                                        //   customers.removeAt(index);
                                        // });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
