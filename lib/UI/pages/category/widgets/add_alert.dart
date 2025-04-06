import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/category/widgets/success_alert.dart';

class AddAlert extends StatelessWidget {
  const AddAlert({super.key});

  void _showSuccessDialog( BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessAlert();
      },
    );
  }

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
                'Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Kategoriya nomi uchun matn maydoni
          Text(
            'Category Name',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          TextField(
            onChanged: (value) {
              _showSuccessDialog(context);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Enter category name',
            ),
          ),
          SizedBox(height: 16),
          // Tugmalar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {

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
      backgroundColor: Colors.grey[200], // Dialog fon rangi
      titlePadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
