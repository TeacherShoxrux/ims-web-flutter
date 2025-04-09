import 'package:flutter/material.dart';

class ProgressService {
  static void show(BuildContext context, {String? message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: 10),
              Text(message, style: const TextStyle(color: Colors.white)),
            ],
          ],
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}