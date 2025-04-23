import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ims_web/models/category_model.dart';
import 'package:ims_web/services/category_service.dart';
import 'package:ims_web/services/product_service.dart';

import '../../../../services/progress_service.dart';

class AddProductAlert extends StatefulWidget {
 const AddProductAlert({super.key, required this.productService});
  final ProductService productService;
  @override
  State<AddProductAlert> createState() => _AddProductAlertState();
}

class _AddProductAlertState extends State<AddProductAlert> {
  final _productName = TextEditingController();
  final _productDescription = TextEditingController();
  final _purchasePrice = TextEditingController();
  final _salePrice = TextEditingController();
  final _quantity = TextEditingController();
  final _categoryService = CategoryService();
  PlatformFile? image;
  String? imageUrl;
  Future<void> pickImageWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    PlatformFile? file = result?.files.first;

    if (file != null) {
      image = file;
      //
      // if (kDebugMode) {
      //   print("-----------------------------------------------------------------------------------");
      //   imageUrl=await uploadImage();
      //   print(imageUrl);
      //   print("-----------------------------------------------------------------------------------");
      // }
      setState(() {});
    }
  }

  Future<String?> uploadImage()async{
    if(image!=null) {
      return await widget.productService.uploadImage(image!);
    }
    return null;
  }

  static CategoryModel? _selectedCategory;

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
                Icon(Icons.inventory, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Yangi mahsulot',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Text('Nomi', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: _productName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Mahsulot nomi?',
              ),
            ),
            // Text('Mahsulot haqida?', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              maxLines: 4,
              controller: _productDescription,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Mahsulot haqida qisqacha ma'lumot",
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Kirish narxi', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      TextField(
                        controller: _purchasePrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Kirish narxi?',
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        controller: _salePrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Sotish narxi?',
                        ),
                      ),

                      SizedBox(height: 10),

                      TextField(
                        controller: _quantity,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Soni',
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 16),
            // Category dropdown
            Row(
              children: [
                Text('Kategoriyasi', style: TextStyle(fontSize: 16)),
              ],
            ),
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
                    Text('Mahsulot rasmi', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: image != null
                                ? Image.memory(image!.bytes!)
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
                      child: Text('Yuklash'),
                    ),

                    SizedBox(height: 8),

                    IconButton(
                      onPressed: () {

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
                  onPressed: ()async {
                    try{
                      ProgressService.show(context, message: "Iltimos kuting...");
                      var image=await uploadImage();
                      var result= await widget.productService.createProduct({
                        "name": _productName.text,
                        "description": _productDescription.text,
                        "salePrice": int.parse(_salePrice.text),
                        "purchasePrice": int.parse(_purchasePrice.text),
                        "quantity": int.parse(_quantity.text),
                        "categoryId": _selectedCategory?.id,
                        "image": image
                      });

                      print("------------------------------------------------");
                      print(result);
                      print("------------------------------------------------");
                      ProgressService.hide (context);
                      if(result){
                        Navigator.of(context).pop();
                      }
                    }catch(e){

                    }


                       // Dialogni yopish

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // SAVE tugmasi rangi
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Saqlash'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dialogni yopish
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // CLOSE tugmasi rangi
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Yopish'),
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
