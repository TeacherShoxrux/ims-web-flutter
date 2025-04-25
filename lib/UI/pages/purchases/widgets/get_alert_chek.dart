import 'package:flutter/material.dart';

class GetAlertDialogChek extends StatelessWidget {
  final String customerName;
  final String sellerName;
  final String productName;
  final int? productNumber;
  final String paymentType;
  const GetAlertDialogChek({
    super.key,
    required this.customerName,
    required this.sellerName,
    required this.productName,
    required this.productNumber,
    required this.paymentType,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Chek", style: TextStyle(fontSize: 26))),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mijoz ismi", style: TextStyle(fontSize: 22)),

                Text(customerName, style: TextStyle(fontSize: 22)),
              ],
            ),
            SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Sotuvchi ismi", style: TextStyle(fontSize: 22)),

                Text(sellerName, style: TextStyle(fontSize: 22)),
              ],
            ),
            SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Mahsulot nomi", style: TextStyle(fontSize: 22)),

                Text(productName, style: TextStyle(fontSize: 22)),
              ],
            ),
            SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Mahsulot soni", style: TextStyle(fontSize: 22)),

                Text("${productNumber}", style: TextStyle(fontSize: 22)),
              ],
            ),
            SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("To'lov turi", style: TextStyle(fontSize: 22)),

                Text(paymentType, style: TextStyle(fontSize: 22)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
