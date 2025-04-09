import 'package:flutter/material.dart';


class SuccessAlert extends StatelessWidget {
  const SuccessAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                'IMS',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Kategoriya muvaffqaiyatli yaratildi!!!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Dialogni yopish
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // OK tugmasi rangi
              foregroundColor: Colors.white,
            ),
            child: Text('OK'),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Dialog fon rangi
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
