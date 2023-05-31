import 'dart:convert';
import 'package:http/http.dart' as http;

class Volcanoes {
  String? nama;
  String? bentuk;
  String? tinggiMeter;
  dynamic? estimasiLetusanTerakhir;
  String? geolokasi;

  Volcanoes({
    this.nama,
    this.bentuk,
    this.tinggiMeter,
    this.estimasiLetusanTerakhir,
    this.geolokasi,
  });

  factory Volcanoes.fromJson(Map<String, dynamic> json) {
    return Volcanoes(
      nama: json['nama'],
      bentuk: json['bentuk'],
      tinggiMeter: json['tinggi_meter'],
      estimasiLetusanTerakhir: json['estimasi_letusan_terakhir'],
      geolokasi: json['geolokasi'],
    );
  }
}

Future<List<Volcanoes>> fetchVolcanoes() async {
  final response = await http.get(Uri.parse(
      'https://indonesia-public-static-api.vercel.app/api/volcanoes'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    
    return jsonData.map((item) => Volcanoes.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch volcanoes');
  }
}
