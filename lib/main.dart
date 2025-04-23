import 'package:flutter/material.dart';
import 'package:ims_web/services/auth_service.dart';
import 'package:ims_web/services/snackbar_service.dart';

import 'UI/pages/Home/home.dart';
import 'UI/pages/login/login.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final messengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {

  SnackbarService().init(messengerKey);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool aht=false;
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
      scaffoldMessengerKey: messengerKey,
      title: 'e-baraka.uz',
      navigatorKey: navigatorKey, // 👈 muhim!
      home: aht?   LoginPage():HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}






