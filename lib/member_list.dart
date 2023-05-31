import 'package:flutter/material.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class MemberList extends StatelessWidget {
  const MemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color3,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Daftar Anggota:',
            style: TextStyle(
              color: color1,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 16.0),
          Text(
            'Nisrina Athiyya Zain (123200042)',
            style: TextStyle(
              color: color1,
              fontSize: 15,
            ),
          ),
          Text(
            'Juan Bontor Hutapea (1232000116)',
            style: TextStyle(
              color: color1,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
