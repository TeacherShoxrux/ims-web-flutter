import 'package:flutter/material.dart';
import 'package:ims_web/models/product_model.dart';
import 'package:ims_web/services/product_service.dart';

class SelectedProductsWidget extends StatelessWidget {
  final List<ProductModel> selectedProducts;
  final Function(int) onRemove;

  SelectedProductsWidget({required this.selectedProducts, required this.onRemove});


final _productService = ProductService();
  @override
  Widget build(BuildContext context) {
    double grandTotal = selectedProducts.fold(0.0, (sum, item) {
      return sum + item.salePrice* item.quantityPay;
    });
  //int quantityPay
    return Column(
      children: [
        Container(
          color: Colors.purple[300],
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Qty',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Price',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Amount',
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
          child: 
                
                 ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                double amount = selectedProducts[index].salePrice * selectedProducts[index].quantityPay.toDouble();
                return Container(
                  color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(selectedProducts[index].name,),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(selectedProducts[index].quantityPay.toString()),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(selectedProducts[index].salePrice.toString()),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(amount.toStringAsFixed(1)),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () => onRemove(index),
                          icon: Icon(Icons.delete, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            
          
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Grand Total',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 16),
              Text(
                grandTotal.toStringAsFixed(0),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}