import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ims_web/UI/widgets/image_viewer.dart';
import 'package:ims_web/models/product_model.dart';
import 'package:ims_web/routes/urls.dart';

class ProductGridWidget extends StatelessWidget {
  final List<ProductModel> products;
  final Function(ProductModel) onProductSelected;

  ProductGridWidget({required this.products, required this.onProductSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onProductSelected(products[index]..id),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child:
                          products[index].image == null
                              ? Icon(Icons.image)
                              : ImageViewer(
                                imagePath:
                                    "${Urls.baseUrlImage}/${products[index].image}",
                                width: 150,
                                height: 220,
                              ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    products[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    products[index].salePrice.toString(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
