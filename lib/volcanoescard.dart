import 'package:flutter/material.dart';
import 'volcanoes_model.dart';

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
      ),
      body: Container(
        alignment: Alignment.center,
        // height: 300,
        // width: 500,
        color: const Color.fromARGB(213, 0, 0, 0),
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: const Color.fromARGB(248, 227, 69, 7),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
