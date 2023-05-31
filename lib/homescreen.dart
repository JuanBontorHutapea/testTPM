import 'package:flutter/material.dart';
import 'package:projectakhirtpm/waktukonversi.dart';
// import 'package:tugas4/recommendations_screen.dart';
import 'volcanoes.dart';
import 'bottom_nav_bar.dart';
import 'member_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Utama'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih salah satu menu di bawah ini',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberList()),
                );
              },
              child: Text('Daftar Anggota'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VolcanoesListScreen()),
                );
              },
              child: Text('List Gunung Vulkano'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Kalender()),
                );
              },
              child: Text('Waktu'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => FavoritesScreen()),
            //     );
            //   },
            //   child: Text('Menu Favorite'),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
