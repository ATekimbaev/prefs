import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prefs_1/consts.dart';
import 'package:prefs_1/spalsh_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_view.page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences prefs;

  final storage = const FlutterSecureStorage();
  String name = '';
  List<String> data = [];
  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: name);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            storage.delete(key: 'token');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(name),
              const SizedBox(height: 25),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  name = controller.text;
                  await prefs.setString('name', controller.text);
                  setState(() {});
                  data = prefs.getStringList(AppConsts.list) ?? [];
                  data.add(controller.text);
                  await prefs.setStringList(AppConsts.list, data);
                },
                child: const Text('press'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListViewPage(
                prefs: prefs,
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
