import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmationDialog(BuildContext context, String name, [String? title]) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title:  Text(title??"O'chirishni tasdiqlang"),
      content: Text("“$name"),
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
