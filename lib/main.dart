import 'package:flutter/material.dart';
import 'package:ims_web/services/auth_service.dart';

import 'UI/pages/Home/home.dart';
import 'UI/pages/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  var aht=false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidebar Example',
      home: aht? HomePage() : LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}






