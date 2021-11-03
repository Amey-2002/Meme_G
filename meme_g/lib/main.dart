import 'package:flutter/material.dart';
import 'package:meme_g/widgets/meme_list.dart';
import './widgets/drawer.dart';
import './widgets/create.dart';
import './screens/photo_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      routes: {
        PhotoEditor.route : (context) => PhotoEditor(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Meme Gen'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.chat),title: Text('Chats')),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('You')),
      ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Create(),
              MemeList(),
            ],
          ),
        ),
      ),
    );
  }
}
