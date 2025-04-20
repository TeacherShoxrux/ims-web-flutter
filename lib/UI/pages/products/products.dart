import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/products/widgets/add_product_alert.dart';
import 'package:ims_web/models/product_model.dart';
import 'package:ims_web/routes/urls.dart';
import 'package:ims_web/services/product_service.dart';

import '../../widgets/image_viewer.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final _productService = ProductService();
  // Ro'yxat uchun ma'lumotlar

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductAlert(productService: _productService);
      },
    );
  }
 String text='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fon rangi
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (x)async{
              text=x;
               setState(() {
                 
               });
              },
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
            // Sarlavha va Add New tugmasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mahsulotlar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddProductDialog();
                  },
                  icon: Icon(Icons.add),
                  label: Text('Yaratmoq'),
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
                      'Qoldiq',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Nomi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Kategoriya',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Narxi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Rasmi',
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
            FutureBuilder(
              future:text.length==0? _productService.getAllProducts():_productService.searchAllProducts(text: text),
              builder: (context, snapshot) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("${snapshot.data?[index].quantity}"),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text("${snapshot.data?[index].name}"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("${snapshot.data?[index].name}"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("${snapshot.data?[index].salePrice}"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child:
                                    snapshot.data?[index].image == null
                                        ? Icon(Icons.image)
                                        : ImageViewer(
                                          imagePath:
                                              "${Urls.baseUrlImage}/${snapshot.data?[index].image}",
                                          width: 30,
                                          height: 30,

                                        ),
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
                                      // print(
                                      //   'Edit bosildi: ${products[index]['name']}',
                                      // );
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
                                        // products.removeAt(index);
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
