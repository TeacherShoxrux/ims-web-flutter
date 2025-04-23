import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/category/widgets/success_alert.dart';

import '../../../../services/category_service.dart';

class AddAlert extends StatelessWidget {
  AddAlert({super.key, required this.categoryService});
  final CategoryService categoryService;
  void _showSuccessDialog( BuildContext context)async {
   var result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SuccessAlert();
      },
    );
   if(result==true)
     {
       Navigator.pop(context,result);
     }
  }
final categoryNameController=TextEditingController();
final categoryDescriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sarlavha va ikonka
          Row(
            children: [
              Icon(
                Icons.layers,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Kategoriya yaratish',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Kategoriya nomi uchun matn maydoni
          // Text(
          //   'Kategoriya nomini kiriting',
          //   style: TextStyle(fontSize: 16),
          // ),
          SizedBox(height: 8),
          TextField(
            controller: categoryNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Nomi',
            ),
          ),
          SizedBox(height: 8),

          TextField(
          controller: categoryDescriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'kategoriya haqida (ixtiyoriy)',
            ),
          ),
          SizedBox(height: 16),
          // Tugmalar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: ()async {
               var result = await categoryService.createCategory({
                  "name": categoryNameController.text,
                  "description": categoryDescriptionController.text
                });
               if(result){
                _showSuccessDialog(context);
               }
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
      backgroundColor: Colors.grey[200], // Dialog fon rangi
      titlePadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
