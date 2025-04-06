import 'package:flutter/material.dart';


class AddProductAlert extends StatelessWidget {
   AddProductAlert({super.key});
  String newProductName = '';
  String newPurchasePrice = '';
  String newSalePrice = '';
  String selectedCategory = 'Category 1';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sarlavha va ikonka
            Row(
              children: [
                Icon(
                  Icons.inventory,
                  color: Colors.white,
                ),
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
            Text(
              'Name',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                // newProductName = value; // Kiritilgan matnni saqlash
              },
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
                      Text(
                        'Purchase Price',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          // newPurchasePrice = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Enter purchase price',
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
                      Text(
                        'Sale Price',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          // newSalePrice = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Enter sale price',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Category dropdown
            Text(
              'Category',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: ['Category 1', 'Category 2'].map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedCategory = newValue!;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Product Picture qismi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Picture',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ), // Standart placeholder rasm
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Browse tugmasi bosilganda rasm tanlash logikasi
                        print('Browse bosildi');
                      },
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
