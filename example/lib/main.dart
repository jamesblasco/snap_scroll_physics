import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';
import 'examples/material.dart';
import 'examples/cupertino.dart';
import 'examples/music.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        () => MaterialExamplePage(),
        () => CupertinoExamplePage(),
        () => MusicExamplePage(),
      ][index](),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) => setState(() => this.index = index),
        items: [
          BottomNavigationBarItem(
            label: 'Material',
            icon: Icon(Icons.adb),
          ),
          BottomNavigationBarItem(
            label: 'Cupertino',
            icon: Icon(Icons.tab),
          ),
          BottomNavigationBarItem(
            label: 'Music',
            icon: Icon(Icons.music_note),
          )
        ],
      ),
    );
  }
}
