import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:project_akhir_anime_app/components/my_button.dart';
// import 'package:project_akhir_anime_app/components/my_textfield.dart';
// import 'package:project_akhir_anime_app/components/square_tile.dart';
// import 'package:project_akhir_anime_app/dashboard.dart';
// import 'package:project_akhir_anime_app/mainpage.dart';
import 'package:hive/hive.dart';
// import 'package:project_akhir_anime_app/register.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'model/user_model.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box<User> userBox; // Declare the userBox variable

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    openHiveBox(); // Call the method to open the box
  }

  Future<void> openHiveBox() async {
    await Hive.openBox<User>("users"); // Open the box
    userBox = Hive.box<User>("users"); // Assign the box to the variable
  }

  void _loginUser() {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final userBox = Hive.box<User>('users');
      final matchedUser = userBox.values.any(
        (user) => user.username == username && user.password == password,
      );

      if (matchedUser != false) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Successful'),
            actions: [
              TextButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) {return const HalamanUtama();}));},
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
          
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
          
                const SizedBox(height: 50),
          
                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 10),
          
                // username textfield
                MyTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),
          
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 20),
          
                // sign in button
                MyButton(
                  onTap: () {
                    _loginUser();
                  },
                ),
          
                const SizedBox(height: 50),
          
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // google + facebook sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'assets/google.png'),
          
                    SizedBox(width: 10),
          
                    // apple button
                    SquareTile(imagePath: 'assets/facebook.png')
                  ],
                ),
          
                const SizedBox(height: 50),
          
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    RichText(
                        text: TextSpan(
                            text: 'Register now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {return RegisterPage();}));
                            }))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}