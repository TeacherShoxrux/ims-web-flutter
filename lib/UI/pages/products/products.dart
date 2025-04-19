import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/products/widgets/add_product_alert.dart';
import 'package:ims_web/routes/urls.dart';
import 'package:ims_web/services/product_service.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final _productService=ProductService();
  // Ro'yxat uchun ma'lumotlar
  final List<Map<String, String>> products = [
    {'sr': '1', 'name': 'Coca Coal TINE', 'category': 'Category 2', 'purPrice': '48.00', 'salePrice': '50.00'},
    {'sr': '2', 'name': 'Coffe MATE', 'category': 'Category 2', 'purPrice': '800.00', 'salePrice': '850.00'},
    {'sr': '3', 'name': 'Nescafe 3in1', 'category': 'Category 1', 'purPrice': '35.00', 'salePrice': '40.00'},
    {'sr': '4', 'name': 'Sprit Tine', 'category': 'Category 1', 'purPrice': '47.00', 'salePrice': '50.00'},
    {'sr': '5', 'name': 'Pepcy Tin', 'category': 'Category 1', 'purPrice': '47.00', 'salePrice': '50.00'},
    {'sr': '6', 'name': 'Candy Biscuits', 'category': 'Category 1', 'purPrice': '28.00', 'salePrice': '30.00'},
    {'sr': '7', 'name': 'GALA Biscuits', 'category': 'Category 2', 'purPrice': '28.00', 'salePrice': '30.00'},
    {'sr': '8', 'name': 'National Ketchup Chilli', 'category': 'Category 1', 'purPrice': '330.00', 'salePrice': '350.00'},
    {'sr': '9', 'name': 'National Ketchup', 'category': 'Category 1', 'purPrice': '330.00', 'salePrice': '350.00'},
    {'sr': '10', 'name': 'LAYS Salted', 'category': 'Category 1', 'purPrice': '95.00', 'salePrice': '100.00'},
    {'sr': '11', 'name': 'Lays Masla', 'category': 'Category 1', 'purPrice': '55.00', 'salePrice': '60.00'},
    {'sr': '12', 'name': 'Lays Yogut and Harb', 'category': 'Category 2', 'purPrice': '18.00', 'salePrice': '20.00'},
    {'sr': '6', 'name': 'Candy Biscuits', 'category': 'Category 1', 'purPrice': '28.00', 'salePrice': '30.00'},
    {'sr': '7', 'name': 'GALA Biscuits', 'category': 'Category 2', 'purPrice': '28.00', 'salePrice': '30.00'},
    {'sr': '8', 'name': 'National Ketchup Chilli', 'category': 'Category 1', 'purPrice': '330.00', 'salePrice': '350.00'},
    {'sr': '9', 'name': 'National Ketchup', 'category': 'Category 1', 'purPrice': '330.00', 'salePrice': '350.00'},
    {'sr': '10', 'name': 'LAYS Salted', 'category': 'Category 1', 'purPrice': '95.00', 'salePrice': '100.00'},
    {'sr': '11', 'name': 'Lays Masla', 'category': 'Category 1', 'purPrice': '55.00', 'salePrice': '60.00'},
    {'sr': '12', 'name': 'Lays Yogut and Harb', 'category': 'Category 2', 'purPrice': '18.00', 'salePrice': '20.00'},
  ];
  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductAlert(productService: _productService,);
      },
    );
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
            // Sarlavha va Add New tugmasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mahsulotlar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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
                    child: SizedBox(

                    ), // Bo'sh joy ikonlar uchun
                  ),
                ],
              ),
            ),
            // Ro'yxat elementlari
            FutureBuilder(
                future: _productService.getAllProducts(),
                builder: (context,snapshot) {
                  return
                    Expanded(
              child: ListView.builder(
                itemCount: snapshot.data?.length??0,
                itemBuilder: (context, index) {
                  return Container(
                    color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                          child:snapshot.data?[index].image==null?Icon(Icons.image):Image.network("${Urls.baseUrlImage}/${snapshot.data?[index].image}"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Edit tugmasi bosilganda
                                  print('Edit bosildi: ${products[index]['name']}');
                                },
                                icon: Icon(Icons.edit, color: Colors.yellow[700]),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Delete tugmasi bosilganda
                                  setState(() {
                                    products.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.delete, color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );}),
          ],
        ),
      ),
    );
  }
}