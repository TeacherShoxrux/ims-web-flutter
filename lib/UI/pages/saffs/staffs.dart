import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/category/widgets/add_alert.dart';
import 'package:ims_web/UI/pages/saffs/add_aler_staff.dart';
import 'package:ims_web/services/staffs_service.dart';

class StaffsListPage extends StatefulWidget {
  @override
  _SupplierListPageState createState() => _SupplierListPageState();
}

class _SupplierListPageState extends State<StaffsListPage> {
  final staffsService = StaffsService();

  void _showAddCategoryDialog(BuildContext context) async {
    var result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AddAlerStaff(authService: staffsService);
      },
    );
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
                  'Supplier List',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add New tugmasi bosilganda bajariladigan kod
                    _showAddCategoryDialog(context);
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
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Ishchi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                future: staffsService.getStaffs(),
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
                                  snapshot.data?[index].fullName ?? 'null',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  snapshot.data?[index].phone ?? 'null',
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  snapshot.data?[index].phone ?? 'null',
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  snapshot.data?[index].role ?? 'null',
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
                                        //   print('Edit bosildi: ${suppliers[index]['name']}');

                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.yellow[700],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Delete tugmasi bosilganda
                                        setState(() {
                                          //  suppliers.removeAt(index);
                                        });
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
