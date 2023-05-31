import 'package:flutter/material.dart';
import 'volcanoes_model.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class VolcanoDetailsScreen extends StatefulWidget {
  final Volcanoes volcano;

  const VolcanoDetailsScreen({super.key, required this.volcano});

  @override
  State<VolcanoDetailsScreen> createState() => _VolcanoDetailsScreenState();
}

class _VolcanoDetailsScreenState extends State<VolcanoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volcano Details'),
        centerTitle: true,
        backgroundColor: color1,
      ),
      body: Container(
        alignment: Alignment.center,
        color: color2,
        padding: const EdgeInsets.fromLTRB(20, 250, 20, 250),
        child: Card(
          color: color3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name: ${widget.volcano.nama ?? ''}'),
                const SizedBox(height: 8),
                Text('Shape: ${widget.volcano.bentuk ?? ''}'),
                const SizedBox(height: 8),
                Text('Height (in meters): ${widget.volcano.tinggiMeter ?? ''}'),
                const SizedBox(height: 8),
                Text(
                    'Last Eruption Estimate: ${widget.volcano.estimasiLetusanTerakhir ?? ''}'),
                const SizedBox(height: 8),
                Text('Geolocation: ${widget.volcano.geolokasi ?? ''}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
