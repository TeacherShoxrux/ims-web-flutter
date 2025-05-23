import 'package:flutter/material.dart';
import 'package:ims_web/extensions/StringFormattingExtension.dart';
import 'package:ims_web/services/paymetn_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GetAlertDialogChek extends StatelessWidget {
  final PaymentService paymentService;
  final int id;
  const GetAlertDialogChek({
    super.key,
    required this.paymentService,
    required this.id,
  });

  final String qrdata = "E-baraka";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        // height: MediaQuery.of(context).size.height * 0.7,
        child: FutureBuilder(
          future: paymentService.getPaymentChekById(id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("E-baraka", style: TextStyle(fontSize: 32)),
                  ),
                  SizedBox(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mijoz:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      Text(
                        snapshot.data?.customer.name ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Vaqti:", style: TextStyle(fontSize: 16)),
                      Text(
                        snapshot.data?.createdAt.fmtDate() ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("To'lov turi:", style: TextStyle(fontSize: 16)),
                      Text(
                        snapshot.data?.paymentMethod ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Mahsulotlar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...?snapshot.data?.products.map(
                        (product) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  product.name,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Text(
                                product.salePrice.som(),

                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jami summa",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        snapshot.data?.amount.som() ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  // Spacer(),
                  Center(
                    child: QrImageView(
                      data: qrdata,
                      version: QrVersions.auto,
                      size: 180,
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
