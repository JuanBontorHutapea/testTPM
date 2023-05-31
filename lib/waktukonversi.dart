import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Kalender extends StatefulWidget {
  @override
  _KalenderState createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  String _zonaWaktu = "WIB";
  int _jamOffset = 0;
  late Timer timer;

  TextEditingController _dateController = TextEditingController();
  DateFormat _dateFormat = DateFormat("EEEE, dd MMMM yyyy");
  DateTime _currentDate = DateTime.now();
  DateFormat _timeFormat = DateFormat("HH:mm:ss");

  void _setZonaWaktu(String zonaWaktu) {
    setState(() {
      _zonaWaktu = zonaWaktu;
      switch (zonaWaktu) {
        case "WIB":
          _jamOffset = 0;
          break;
        case "WIT":
          _jamOffset = 1;
          break;
        case "WITA":
          _jamOffset = 2;
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
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Kalender'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Zona Waktu:'),
                SizedBox(width: 16.0),
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
            SizedBox(height: 16.0),
            Text(
              _dateFormat.format(_currentDate),
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
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
            SizedBox(height: 16.0),
            Text(
              _timeFormat.format(_currentDate),
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
