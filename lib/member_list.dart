import 'package:flutter/material.dart';

class MemberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daftar Anggota:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text('Nisrina Athiyya Zain (123200042)'),
            Text('Juan Bontor Hutapea (1232000116)'),
          ],
        ),
      ),
    );
  }
}
