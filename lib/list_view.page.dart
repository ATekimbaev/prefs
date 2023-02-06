import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:prefs_1/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    List<String> data = widget.prefs.getStringList(AppConsts.list) ?? [];
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Dismissible(
            onDismissed: (_) {
              data.removeAt(index);
              widget.prefs.setStringList(AppConsts.list, data);
            },
            background: Container(color: Colors.red),
            key: UniqueKey(),
            child: Column(
              children: [
                Text(
                  data[index],
                  style: const TextStyle(fontSize: 25),
                ),
                const Divider(
                  thickness: 5,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
