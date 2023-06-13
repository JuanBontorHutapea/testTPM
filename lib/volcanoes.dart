import 'package:flutter/material.dart';
import 'volcanoes_model.dart';
import 'volcanoescard.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class VolcanoesListScreen extends StatefulWidget {
  const VolcanoesListScreen({Key? key}) : super(key: key);

  @override
  State<VolcanoesListScreen> createState() => _VolcanoesListScreenState();
}

class _VolcanoesListScreenState extends State<VolcanoesListScreen> {
  late Future<List<Volcanoes>> futureVolcanoes;
  late TextEditingController searchController;
  List<Volcanoes> filteredVolcanoes = [];

  @override
  void initState() {
    super.initState();
    futureVolcanoes = fetchVolcanoes();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterVolcanoes(String query) {
    setState(() {
      filteredVolcanoes = [];
      futureVolcanoes.then((volcanoes) {
        filteredVolcanoes = volcanoes.where((volcano) {
          final name = volcano.nama?.toLowerCase() ?? '';
          final shape = volcano.bentuk?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) ||
              shape.contains(query.toLowerCase());
        }).toList();
      });
    });
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterVolcanoes,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Volcanoes>>(
                future: futureVolcanoes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final volcanoes = snapshot.data!;
                    final displayVolcanoes = filteredVolcanoes.isNotEmpty
                        ? filteredVolcanoes
                        : volcanoes;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayVolcanoes.length,
                      itemBuilder: (context, index) {
                        final volcano = displayVolcanoes[index];
                        return Card(
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
                        );
                      },
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
          ],
        ),
      ),
    );
  }
}
