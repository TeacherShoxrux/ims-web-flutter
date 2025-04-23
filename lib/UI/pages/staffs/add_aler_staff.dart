import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/Home/home.dart';
import 'package:ims_web/UI/pages/staffs/staffs.dart';
import 'package:ims_web/services/auth_service.dart';
import 'package:ims_web/services/progress_service.dart';
import 'package:ims_web/services/staffs_service.dart';

class AddAlerStaff extends StatefulWidget {
  final StaffsService authService;
  const AddAlerStaff({super.key, required this.authService});

  @override
  State<AddAlerStaff> createState() => _AddAlerStaffState();
}

class _AddAlerStaffState extends State<AddAlerStaff> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authService = StaffsService();

  void _handleAddAlerStaff(BuildContext context) async {
    ProgressService.show(context, message: "Iltimos kuting...");
    var result = await authService.addAlerstaff(
      _nameController.text,
      _phoneController.text,
      _passwordController.text,
    );
    ProgressService.hide(context);
    if (result)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => HomePage()),
        (e) => true,
      );
    if (!result)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login xatolik!')));
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sarlavha va ikonka
            Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.black87),
                SizedBox(width: 8),
                Text(
                  "Ishchi qo'shish",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Name maydoni
            Text('Ism', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              onChanged: (value) {
                // newSupplierName = value; // Kiritilgan matnni saqlash
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Ism kiriting',
              ),
            ),
            SizedBox(height: 16),
            // Phone maydoni
            Text('Telefon', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              onChanged: (value) {
                // newPhone = value;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Telefon no'mer kiriting",
              ),
            ),
            SizedBox(height: 16),
            // Email maydoni
            Text('Email', style: TextStyle(fontSize: 16)),
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
            // Text('Address', style: TextStyle(fontSize: 16)),
            // SizedBox(height: 8),
            // TextField(
            //   onChanged: (value) {
            //     // newAddress = value;
            //   },
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     hintText: 'Enter address',
            //   ),
            // ),
            // SizedBox(height: 16),
            // Password maydoni
            Text('Parol', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                // newPassword = value;
              },
              controller: _passwordController,
              keyboardType: TextInputType.number,
              obscureText: true, // Parolni yashirish uchun
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Parol kiriting',
              ),
            ),
            SizedBox(height: 16),
            // Tugmalar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _handleAddAlerStaff(context);
                    // if (newSupplierName.isNotEmpty) {
                    //   setState(() {
                    //     // Yangi yetkazib beruvchini ro'yxatga qo'shish
                    //     suppliers.insert(0, {
                    //       'sr': (suppliers.length + 1).toString(),
                    //       'name': newSupplierName,
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
