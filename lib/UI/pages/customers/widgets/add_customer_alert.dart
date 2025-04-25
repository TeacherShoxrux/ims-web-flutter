// Yangi mijoz qo'shish uchun dialog
import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/Home/home.dart';
import 'package:ims_web/services/customer_service.dart';
import 'package:ims_web/services/progress_service.dart';

class AddCustomerAlert extends StatefulWidget {
  final CustomerService customerService;
  const AddCustomerAlert({super.key, required this.customerService});

  @override
  State<AddCustomerAlert> createState() => _AddCustomerAlertState();
}

class _AddCustomerAlertState extends State<AddCustomerAlert> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final customerService = CustomerService();

 void _handleAddCustomer(BuildContext context) async {
    ProgressService.show(context, message: "Iltimos kuting...");
    var result = await customerService.AddCustomer(
      _nameController.text,
      _phoneController.text,
      _infoController.text,
    );


    ProgressService.hide(context);
    Navigator.pop(context,result);
    if (!result)ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text('Login xatolik!')));
  }
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
                Icon(Icons.shopping_cart, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Mijoz',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
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
                      Text('Ism', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          // newCustomerName = value; // Kiritilgan matnni saqlash
                        },
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Ism kiriting',
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
                      Text('Telefon', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          // newPhone = value;
                        },
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Telefon nomer kiting',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Address maydoni
            Text('Malumot', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                // newAddress = value;
              },
              controller: _infoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Malumot kiriting',
              ),
            ),
            SizedBox(height: 16),
            // Tugmalar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                  _handleAddCustomer(context);
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
