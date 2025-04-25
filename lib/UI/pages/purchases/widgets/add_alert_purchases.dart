import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/purchases/widgets/products_lits.dart';
import 'package:ims_web/UI/pages/purchases/widgets/selected_products.dart';
import 'package:ims_web/models/customers_model/customerSearch_model.dart';
import 'package:ims_web/models/product_model.dart';
import 'package:ims_web/services/paymetn_service.dart';
import 'package:ims_web/services/product_service.dart';

import '../../../../services/progress_service.dart';
import '../../../../services/snackbar_service.dart';
import 'dialog_header.dart';

// Yangi xarid qo'shish dialogi
class AddPurchaseDialog extends StatefulWidget {
  final PaymentService paymentService;
  AddPurchaseDialog({
    required this.paymentService,
  });

  @override
  _AddPurchaseDialogState createState() => _AddPurchaseDialogState();
}

class _AddPurchaseDialogState extends State<AddPurchaseDialog> {
  List<ProductModel> selectedProducts = [];
  CustomersearchModel? selectedCustomer;
  List<ProductModel> products = [];
  final _productService = ProductService();

String paymentMethod='';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            DialogHeaderWidget(
              customers: [],
              onChanged: (x) async {
                text = x;
                await _productService.searchAllProducts(text: x);
                setState(() {});
              },
              onCustomerSelected: (customer) {
                setState(() {
                  selectedCustomer = customer;
                });
              },
              onClear: () {
                setState(() {
                  selectedProducts.clear();
                });
              },
              onPaymentMethodSelected: (method) {
                setState(() {
                  paymentMethod=method;
                });
              },
              onSave: () async{
                ProgressService.show(context, message: "Iltimos kuting...");
                await Future.delayed(Duration(seconds: 2));
                try{
               var result= await  widget.paymentService.createPayment(
                      customerId: selectedCustomer?.id??0,
                      products: selectedProducts,
                      paymentMethod: paymentMethod);
               if(result.isSuccess){

                  ProgressService.hide(context);
                  Navigator.of(context).pop();
                  SnackbarService().showSuccess("Saqlash muvaffaqiyatli amalga oshdi!");
               }else{
                 ProgressService.hide(context);
                 Navigator.of(context).pop(result);
                 SnackbarService().showError(result.errorMessage??"Xatolik yuz berdi");
               }
                }catch(e){
                  SnackbarService().showError(e.toString());
                }



              }, 
            ),
            SizedBox(height: 16),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: FutureBuilder(
                      future:
                          text.isEmpty
                              ? _productService.getAllProducts()
                              : _productService.searchAllProducts(text: text),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ProductGridWidget(
                            products: snapshot.data ?? [],
                            onProductSelected: (product) {
                              setState(() {
                                bool exists = false;
                                for (var item in selectedProducts) {
                                  if (item.id == product.id) {
                                    item.quantityPay += product.quantityPay;
                                    exists = true;
                                    break;
                                  }
                                }
                                if (!exists) {
                                  selectedProducts.add(product);
                                }
                              });
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: SelectedProductsWidget(
                      selectedProducts: selectedProducts,
                      onRemove: (index) {
                        setState(() {
                          selectedProducts.removeAt(index);
                        });
                      },
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
