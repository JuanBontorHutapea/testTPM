import 'package:flutter/material.dart';
import 'volcanoes_model.dart';
import 'volcanoescard.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class VolcanoesListScreen extends StatefulWidget {
  const VolcanoesListScreen({super.key});

  @override
  State<VolcanoesListScreen> createState() => _VolcanoesListScreenState();
}

class _VolcanoesListScreenState extends State<VolcanoesListScreen> {
  late Future<List<Volcanoes>> futureVolcanoes;

  @override
  void initState() {
    super.initState();
    futureVolcanoes = fetchVolcanoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volcanoes List'),
        centerTitle: true,
        backgroundColor: color1,
      ),
      body: Container(
        color: color2,
        child: FutureBuilder<List<Volcanoes>>(
          future: futureVolcanoes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final volcanoes = snapshot.data!;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    for (final volcano in volcanoes)
                      Card(
                        child: ListTile(
                          title: Text(volcano.nama ?? ''),
                          subtitle: Text(volcano.bentuk ?? ''),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VolcanoDetailsScreen(volcano: volcano),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
