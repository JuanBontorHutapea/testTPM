import 'package:flutter/material.dart';
import 'package:projectakhirtpm/loginpage.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color3,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _helpText('Kesan dan Pesan'),
            const SizedBox(height: 20),
            _helpText(
                'Saran : Materi yang diajarkan sudah sesuai dengan perkembangan bahasa pemrograman mobile'),
            const SizedBox(height: 20),
            _helpText('Kesan : Kegiatan belajar yang seru, asik dan menantang'),
            const SizedBox(height: 80),
            _logoutButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _helpText(String text) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: const TextStyle(
          color: color1,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color1,
          backgroundColor: color2,
          shadowColor: Colors.black,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: const Size(90, 40),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(
            color: color1,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
      ),
    );
  }
}
