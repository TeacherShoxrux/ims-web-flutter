import 'package:flutter/material.dart';

import 'UI/pages/Home/home.dart';
import 'UI/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidebar Example',
      home:  LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}






