import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ims_web/models/category_model.dart';
import 'package:ims_web/services/category_service.dart';

class AddProductAlert extends StatefulWidget {
 const AddProductAlert({super.key});

  @override
  State<AddProductAlert> createState() => _AddProductAlertState();
}

class _AddProductAlertState extends State<AddProductAlert> {
  final _productName = TextEditingController();

  final _purchasePrice = TextEditingController();

  final _salePrice = TextEditingController();

  final _categoryService = CategoryService();

  Uint8List? base64Image;

  Future<void> pickImageWeb() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      base64Image = await pickedFile.readAsBytes();
      setState(() {});
    }
else{

    }
  }

  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sarlavha va ikonka
            Row(
              children: [
                Icon(Icons.inventory, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Name maydoni
            Text('Name', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: _productName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter product name',
              ),
            ),
            SizedBox(height: 16),
            // Purchase Price va Sale Price maydonlari
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kirish narxi', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      TextField(
                        controller: _purchasePrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Kirish narxi?',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sotish narxi', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      TextField(
                        controller: _salePrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Sotish narxi',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Category dropdown
            Text('Kategoriyasi', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            FutureBuilder<List<CategoryModel>>(
              future: _categoryService.getAllCategories(),
              builder: (context, snapshot) {
                if (snapshot.data is List) {
                  return DropdownButtonFormField<CategoryModel>(
                    value: _selectedCategory,
                    items:
                        snapshot.data?.map((CategoryModel category) {
                          return DropdownMenuItem<CategoryModel>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                    onChanged: (CategoryModel? newValue) {
                      _selectedCategory = newValue;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 16),
            // Product Picture qismi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Picture', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child:
                            base64Image != null
                                ? Image.memory(base64Image!)
                                : Icon(Icons.image,size: 50, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: pickImageWeb,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Browse'),
                    ),
                    SizedBox(height: 8),
                    IconButton(
                      onPressed: () {
                        // Rasmni o'chirish logikasi
                        print('Rasm o\'chirildi');
                      },
                      icon: Icon(Icons.delete, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Tugmalar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // if (newProductName.isNotEmpty &&
                    //     newPurchasePrice.isNotEmpty &&
                    //     newSalePrice.isNotEmpty) {
                    //   setState(() {
                    //     // Yangi mahsulotni ro'yxatga qo'shish
                    //     products.insert(0, {
                    //       'sr': (products.length + 1).toString(),
                    //       'name': newProductName,
                    //       'category': selectedCategory,
                    //       'purPrice': newPurchasePrice,
                    //       'salePrice': newSalePrice,
                    //     });
                    //   });
                    //   Navigator.of(context).pop(); // Dialogni yopish
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // SAVE tugmasi rangi
                    foregroundColor: Colors.white,
                  ),
                  child: Text('SAVE'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dialogni yopish
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // CLOSE tugmasi rangi
                    foregroundColor: Colors.white,
                  ),
                  child: Text('CLOSE'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200], // Dialog fon rangi
      titlePadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
