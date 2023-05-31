import 'package:flutter/material.dart';
import 'package:projectakhirtpm/logout.dart';
import 'package:projectakhirtpm/waktukonversi.dart';
import 'volcanoes.dart';
import 'member_list.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _listMenu;

  @override
  void initState() {
    _listMenu = [
      homePage(context),
      const MemberList(),
      const Logout(),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Akhir'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: color1,
      ),
      body: _listMenu[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xff0b2545),
        selectedItemColor: const Color(0xffeef4ed),
        unselectedItemColor: const Color(0xff8da9c4),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget homePage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Pilih salah satu menu di bawah ini',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MemberList()),
              );
            },
            buttonText: 'Daftar Anggota',
          ),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VolcanoesListScreen()),
              );
            },
            buttonText: 'List Gunung Vulkano',
          ),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Kalender()),
              );
            },
            buttonText: 'Waktu',
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: color1,
        backgroundColor: color2,
        shadowColor: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        minimumSize: const Size(90, 40),
      ),
      child: Text(buttonText),
    );
  }
}
