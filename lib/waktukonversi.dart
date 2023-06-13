import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  String _zonaWaktu = "WIB";
  int _jamOffset = 0;
  late Timer timer;

  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat("EEEE, dd MMMM yyyy");
  DateTime _currentDate = DateTime.now();
  final DateFormat _timeFormat = DateFormat("HH:mm:ss");

  void _setZonaWaktu(String zonaWaktu) {
    setState(() {
      _zonaWaktu = zonaWaktu;
      switch (zonaWaktu) {
        case "WIB":
          _jamOffset = 0;
          break;
        case "WIT":
          _jamOffset = 2;
          break;
        case "WITA":
          _jamOffset = 1;
          break;
        case "LONDON":
          _jamOffset = -6;
          break;
        default:
          _jamOffset = 0;
      }
    });
  }

  void _updateTime() {
    setState(() {
      _currentDate = DateTime.now().add(Duration(hours: _jamOffset));
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Kalender'),
        centerTitle: true,
        backgroundColor: color1,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Zona Waktu:'),
                const SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: _zonaWaktu,
                  items: <String>['WIB', 'WIT', 'WITA', 'LONDON']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    _setZonaWaktu(value!);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              _dateFormat.format(_currentDate),
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                hintText: 'Tanggal (dd/MM/yyyy)',
              ),
              keyboardType: TextInputType.datetime,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _currentDate,
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _currentDate = pickedDate.add(Duration(hours: _jamOffset));
                    _dateController.text = _dateFormat.format(_currentDate);
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              _timeFormat.format(_currentDate),
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
