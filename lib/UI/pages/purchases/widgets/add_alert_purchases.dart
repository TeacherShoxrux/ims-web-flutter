import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/purchases/widgets/products_lits.dart';
import 'package:ims_web/UI/pages/purchases/widgets/selected_products.dart';
import 'package:ims_web/models/product_model.dart';
import 'package:ims_web/services/paymetn_service.dart';
import 'package:ims_web/services/product_service.dart';

import 'dialog_header.dart';

// Yangi xarid qo'shish dialogi
class AddPurchaseDialog extends StatefulWidget {
  final PaymetnService paymetnService;
  //final List<ProductModel> products;
  final List<Map<String, String>> customers;
  final Function(List<Map<String, dynamic>>, String) onSave;

  AddPurchaseDialog({
    // required this.products,
    required this.customers,
    required this.onSave,
    required this.paymetnService,
  });

  @override
  _AddPurchaseDialogState createState() => _AddPurchaseDialogState();
}

class _AddPurchaseDialogState extends State<AddPurchaseDialog> {
  List<ProductModel> selectedProducts = [];
  String selectedCustomer = 'Cash';
  List<ProductModel> products = [];
  final _productService = ProductService();

  String text = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            DialogHeaderWidget(
              customers: [],
              onChanged: (x) async {
                text = x;
                //await _productService.searchAllProducts(text: x);
                setState(() {});
              },

              //   customers: widget.customers,
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
              onSave: () {
                // widget.onSave(
                //   selectedProducts, selectedCustomer);
                Navigator.of(context).pop();
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
                                  if (item.name == product.name) {
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
