import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map? localData;
  late SharedPreferences prefs;

  @override
  void initState() {
    loadJson();
    super.initState();
  }

  loadJson() async {
    String data = await rootBundle.loadString('assets/local-file.json');
    setState(() {
      localData = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: localData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Local Files Example app',
                  ),
                  Text(localData!['text']),
                  Text(localData!['number'].toString()),
                  Text(localData!['nested-map']['text']),
                  const Spacer(),
                  const Text('list data'),
                  Expanded(
                    child: ListView.builder(
                        itemCount: localData!['list-of-map'].length,
                        itemBuilder: (c, i) {
                          final item = localData!['list-of-map'][i];
                          return ListTile(
                            title: Text(item['name']),
                            subtitle: Text(item['age'].toString()),
                          );
                        }),
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
