import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectakhirtpm/encrypt.dart';
import 'package:projectakhirtpm/homescreen.dart';
import 'package:projectakhirtpm/registerpage.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    Hive.box('users').close();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }
  }

  void _processLogin(String username, String password) async {
    if (!Hive.isBoxOpen('users')) {
      await Hive.openBox('users');
    }

    bool isUserExist =
        await checkUser(_usernameController.text, _passwordController.text);

    if (isUserExist && context.mounted) {
      SnackBar snackBar = const SnackBar(content: Text("Berhasil Login"));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Either your Email or Password is incorrect!'),
        ),
      );
    }

    print(_usernameController.text);
    print(_passwordController.text);
  }

  Widget titleText() {
    return const Text(
      'Login',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget textField({
    required TextEditingController controller,
    required String hintText,
    required String errorText,
    required bool obscureText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: '\t $hintText',
          hintStyle: const TextStyle(
            color: color2,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.all(8.0),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(
              color: color1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(
              color: color1,
            ),
          ),
          filled: true,
          fillColor: color1,
        ),
        obscureText: obscureText,
        style: const TextStyle(
          color: color2,
          fontWeight: FontWeight.bold,
        ),
        validator: (value) => value!.isEmpty ? errorText : null,
        enabled: true,
      ),
    );
  }

  Widget submitButton(
      {required String labelButton, required Function(String) submitCallback}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 200,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
          backgroundColor: color1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        onPressed: () {
          submitCallback(labelButton);
        },
        child: Text(
          labelButton,
          style: const TextStyle(
            color: color3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<bool> checkUser(String mail, String pass) async {
    var user = Hive.box('users');
    final email = mail;
    final password = pass;

    // Fetch all users from the box
    final allUsers = user.values.toList();
    print("alluser : $allUsers");

    String encryptedPassword = CustomEncryption.enrcyptAES(password).toString();
    print("encrypted login : $encryptedPassword");

    // Check if there are matching email and password in the list of users
    final matchingUser = allUsers.any(
      (user) => user.email == email && user.password == encryptedPassword,
    );

    print("matching user $matchingUser");

    if (matchingUser == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color3,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 170),
                  titleText(),
                  const SizedBox(height: 55),
                  textField(
                    controller: _usernameController,
                    hintText: 'Username',
                    errorText: 'Username tidak boleh kosong',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  textField(
                    controller: _passwordController,
                    hintText: 'Password',
                    errorText: 'Password tidak boleh kosong',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  submitButton(
                    labelButton: 'Login',
                    submitCallback: (value) {
                      validateAndSave();
                      String currentUsername = _usernameController.value.text;
                      String currentPassword = _passwordController.value.text;

                      _processLogin(currentUsername, currentPassword);
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Belum Punya Akun?'),
                  submitButton(
                    labelButton: 'Register',
                    submitCallback: (value) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
