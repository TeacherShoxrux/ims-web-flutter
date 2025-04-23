import 'package:flutter/material.dart';

class SnackbarService {
  static final SnackbarService _instance = SnackbarService._internal();

  factory SnackbarService() => _instance;

  SnackbarService._internal();

  late GlobalKey<ScaffoldMessengerState> _messengerKey;

  GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  void init(GlobalKey<ScaffoldMessengerState> key) {
    _messengerKey = key;
  }

  void showSuccess(String message) {
    _showSnackbar(message, Colors.green);
  }

  void showError(String message) {
    _showSnackbar(message, Colors.red);
  }

  void _showSnackbar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    );
    _messengerKey.currentState?.showSnackBar(snackBar);
  }
}

