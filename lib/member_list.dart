import 'package:flutter/material.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class MemberList extends StatelessWidget {
  const MemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      decoration: const BoxDecoration(color: color2),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              backgroundColor: color1,
              radius: 125,
              child: CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage(
                  'images/user.jpg',
                ),
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'Juan Bontor Hutapea',
              style: TextStyle(
                  color: color1, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 7),
            const Text(
              '123200117',
              style: TextStyle(
                  color: color1, fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(height: 7),
            const Text(
              'Teknologi Pemrograman Mobile IF-C',
              style: TextStyle(
                  color: color1, fontWeight: FontWeight.w400, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Theme(
              data: ThemeData(
                dividerTheme: const DividerThemeData(
                  thickness: 2,
                  color: color2,
                ),
              ),
              child: const Divider(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Hobby berenang dan bercita-cita menjadi Software Engineer',
              style: TextStyle(
                color: color1,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
