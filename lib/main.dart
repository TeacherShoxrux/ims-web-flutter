import 'package:flutter/material.dart';
import 'package:ims_web/services/auth_service.dart';

import 'UI/pages/Home/home.dart';
import 'UI/pages/login/login.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool aht=true;
  getToken()async{
    var aht=(await  AuthService().getToken)==null;
    if(aht){
      setState(() {
      });
    }
  }
@override
  void initState() {
    getToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidebar Example',
      navigatorKey: navigatorKey, // 👈 muhim!
      home: aht? HomePage() : LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}






