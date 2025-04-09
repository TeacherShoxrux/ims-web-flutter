import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmationDialog(BuildContext context, String categoryName) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("O'chirishni tasdiqlang"),
      content: Text("“$categoryName” kategoriyasini o‘chirishni xohlaysizmi?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Yo'q"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Ha"),
        ),
      ],
    ),
  ) ?? false; // agar foydalanuvchi dialogni yopsa => false
}
