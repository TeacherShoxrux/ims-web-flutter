import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/customers/widgets/add_customer_alert.dart';
import 'package:ims_web/UI/pages/customers/widgets/delete_customer_alert.dart';
import 'package:ims_web/services/customer_service.dart';

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {

  final customerService = CustomerService();

  _showAddCategoryDialog(BuildContext context) async {
    var result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AddCustomerAlert(customerService: customerService);
      })??false;
    if (result == true) {
      setState(() {});
    }
  }
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
                hintText: 'Qidiruv',
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
                  'Mijozlar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () async{

                  await _showAddCategoryDialog(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text("Qo'shish"),
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
                                flex: 2,
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
                                flex: 3,
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
                                      onPressed: ()async {
                                    var confirm= await  showDeleteCustomerDialog(context,snapshot.data?[index].name??'null');
                                    if(confirm){
                                      var success= await customerService.deleteCustomer(snapshot.data?[index].id??0);
                                      if(success){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Mijoz o‘chirildi")),
                                        );
                                        setState(() {

                                        });
                                      }
                                    }
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
