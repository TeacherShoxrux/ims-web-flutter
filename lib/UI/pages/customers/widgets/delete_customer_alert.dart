import 'package:flutter/material.dart';

Future<bool> showDeleteCustomerDialog(BuildContext context, String name) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("O'chirishni tasdiqlang"),
      content: Text("“$name mijozni o‘chirishni xohlaysizmi?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Yo'q"),
        ),
        ElevatedButton(
          onPressed: () => 
          Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Ha"),
        ),
      ],
    ),
  ) ?? false; // agar foydalanuvchi dialogni yopsa => false
}
