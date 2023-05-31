import 'package:flutter/material.dart';
import 'volcanoes_model.dart';
import 'volcanoescard.dart';

class VolcanoesListScreen extends StatefulWidget {
  @override
  _VolcanoesListScreenState createState() => _VolcanoesListScreenState();
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
        title: Text('Volcanoes List'),
      ),
      body: FutureBuilder<List<Volcanoes>>(
        future: futureVolcanoes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final volcanoes = snapshot.data!;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                              builder: (context) => VolcanoDetailsScreen(volcano: volcano),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}