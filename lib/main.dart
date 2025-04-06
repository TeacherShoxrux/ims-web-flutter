import 'package:flutter/material.dart';

import 'UI/pages/Home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidebar Example',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}






