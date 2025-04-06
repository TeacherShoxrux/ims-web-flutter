// Yangi mijoz qo'shish uchun dialog
import 'package:flutter/material.dart';
class AddCustomerAlert extends StatelessWidget {
  const AddCustomerAlert({super.key});

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
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Customer Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Name va Phone maydonlari
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          // newCustomerName = value; // Kiritilgan matnni saqlash
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Enter customer name',
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
                        'Phone',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          // newPhone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Enter phone number',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Email maydoni
            Text(
              'Email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                // newEmail = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter email address',
              ),
            ),
            SizedBox(height: 16),
            // Address maydoni
            Text(
              'Address',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                // newAddress = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter address',
              ),
            ),
            SizedBox(height: 16),
            // Tugmalar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // if (newCustomerName.isNotEmpty) {
                    //   setState(() {
                    //     // Yangi mijozni ro'yxatga qo'shish
                    //     customers.insert(0, {
                    //       'sr': (customers.length + 1).toString(),
                    //       'name': newCustomerName,
                    //       'phone': newPhone.isEmpty ? '-' : newPhone,
                    //       'email': newEmail.isEmpty ? '-' : newEmail,
                    //       'address': newAddress.isEmpty ? '-' : newAddress,
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
