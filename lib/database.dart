import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectakhirtpm/model/user_model.dart';

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database User'),
        centerTitle: true,
        backgroundColor: color1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Hive.openBox("users"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      var users = Hive.box("users");

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: ((context, index) {
                          User user = users.getAt(index);
                          return Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ListTile(
                              tileColor: color2,
                              contentPadding: const EdgeInsets.all(20),
                              title: Text(user.email),
                              subtitle: Text(user.password),
                            ),
                          );
                        }),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
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
