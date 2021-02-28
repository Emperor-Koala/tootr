import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tootr/save_file.dart';
import 'package:tootr/tracker.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool loaded = false;
  List<SaveFile> files = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final dir = await getApplicationDocumentsDirectory();

    for (FileSystemEntity fse in dir.listSync()) {
      if (fse is! File) continue;
      if (!fse.path.endsWith('.json')) continue;
      Map<String, dynamic> data = jsonDecode(await (fse as File).readAsString());
      files.add(SaveFile.fromJson(fse.path.split('/').last, data));
    }

    setState(() => loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Select'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              String saveName = await showDialog(
                context: context,
                builder: (_) {
                  TextEditingController ctrlr = TextEditingController();
                  return AlertDialog(
                    title: Text('File Name'),
                    content: TextField(
                      controller: ctrlr,
                    ),
                    actions: [
                      FlatButton(
                        child: Text('Cancel'),
                        color: Colors.red,
                        onPressed: () => Navigator.pop(_, null),
                      ),
                      FlatButton(
                        child: Text('Create'),
                        color: Colors.blue,
                        onPressed: () => Navigator.pop(_, ctrlr.text),
                      ),
                    ],
                  );
                },
              );
              if (saveName == null || saveName.isEmpty) return;
              String fileName = '${Uuid().v4()}.json';
              while (files.any((f) => f.fileName == fileName)) fileName = '${Uuid().v4()}.json';
              SaveFile sfile = SaveFile(fileName, saveName);
              files.add(sfile);
              await File('${(await getApplicationDocumentsDirectory()).path}/$fileName').writeAsString(jsonEncode(sfile.toJson()));
              setState((){});

            },
          ),
        ],
      ),
      body: loaded
          ? ListView(
        itemExtent: kToolbarHeight,
        children: (files..sort((a, b) => a.fileName.compareTo(b.fileName))).map((e) => ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(e.name ?? e.fileName)),
              Icon(Icons.arrow_right),
            ],
          ),
          onTap: () {
            // TODO
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Tracker(e)));
          },
        )).toList(),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
