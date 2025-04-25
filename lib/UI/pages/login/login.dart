import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';
import '../../../services/progress_service.dart';
import '../Home/home.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authService = AuthService();
  void _handleLogin(BuildContext context)async {
    ProgressService.show(context, message: "Iltimos kuting...");
    var result= await authService.login(_emailController.text, _passwordController.text);
    ProgressService.hide(context);
   if(result)Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>HomePage()), (e)=>true);
   if(!result)  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login xatolik!')),);
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth > 1200
                      ? 400
                      : screenWidth > 600
                      ? 200
                      : 32,
                  vertical: 16,
                ),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth > 600 ? 32 : 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sarlavha
                        Center(widthFactor: 1.6,
                          child: Text(
                            'Tizimga kirish',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth > 600 ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        // Email maydoni
                        Text(
                          'Telifon',
                          textAlign:TextAlign.start ,
                          style: TextStyle(
                            fontSize: screenWidth > 600 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Telefon raqamingizni kiriting',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Parol maydoni
                        Text(
                          'Parol',
                          style: TextStyle(
                            fontSize: screenWidth > 600 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true, // Parolni yashirish
                            decoration: InputDecoration(
                              hintText: 'Parol kiriting',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        // Login tugmasi
                        Center(widthFactor: 2,
                          child: ElevatedButton(
                            onPressed: () => _handleLogin(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth > 600 ? 48 : 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Kirish',
                              style: TextStyle(
                                fontSize: screenWidth > 600 ? 18 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
