import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/purchases/widgets/products_lits.dart';
import 'package:ims_web/UI/pages/purchases/widgets/selected_products.dart';

import 'dialog_header.dart';
// Yangi xarid qo'shish dialogi
class AddPurchaseDialog extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final List<Map<String, String>> customers;
  final Function(List<Map<String, dynamic>>, String) onSave;

  AddPurchaseDialog({required this.products, required this.customers, required this.onSave});

  @override
  _AddPurchaseDialogState createState() => _AddPurchaseDialogState();
}

class _AddPurchaseDialogState extends State<AddPurchaseDialog> {
  List<Map<String, dynamic>> selectedProducts = [];
  String selectedCustomer = 'Cash';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            DialogHeaderWidget(
              customers: widget.customers,
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
                widget.onSave(selectedProducts, selectedCustomer);
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
                    child: ProductGridWidget(
                      products: widget.products,
                      onProductSelected: (product) {
                        setState(() {
                          bool exists = false;
                          for (var item in selectedProducts) {
                            if (item['name'] == product['name']) {
                              item['quantity'] += 1;
                              exists = true;
                              break;
                            }
                          }
                          if (!exists) {
                            selectedProducts.add({
                              'name': product['name'],
                              'price': product['price'],
                              'quantity': 1,
                            });
                          }
                        });
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