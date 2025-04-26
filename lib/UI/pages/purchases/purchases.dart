import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/purchases/widgets/add_alert_purchases.dart';
import 'package:ims_web/UI/pages/purchases/widgets/get_alert_chek.dart';
import 'package:ims_web/extensions/StringFormattingExtension.dart';
import 'package:ims_web/services/paymetn_service.dart';

class PurchasesListPage extends StatefulWidget {
  @override
  _PurchasesListPageState createState() => _PurchasesListPageState();
}

class _PurchasesListPageState extends State<PurchasesListPage> {
  final paymentService = PaymentService();

  void _showAddPurchaseDialog() async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AddPurchaseDialog(paymentService: paymentService);
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "To'lovlar",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddPurchaseDialog,
                  icon: Icon(Icons.add),
                  label: Text("Qo'shish"),
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
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: paymentService.getPayment(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return GetAlertDialogChek(
                                  paymentService: PaymentService(),
                                  id: snapshot.data![index].id,
                                );
                              },
                            );
                          },
                          child: Container(
                            color:
                                index % 2 == 0
                                    ? Colors.white
                                    : Colors.grey[100],
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
                                    snapshot.data?[index].customerName ??
                                        'null',
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "${snapshot.data?[index].createdAt?.fmtDate()}" ?? 'null',
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${snapshot.data?[index].userFullName}',
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${snapshot.data?[index].amount?.som()}',
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                    ],
                                  ),
                                ),
                              ],
                            ),
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
