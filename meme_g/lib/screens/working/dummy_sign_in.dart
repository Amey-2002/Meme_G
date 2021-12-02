import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/services/database.dart';

class DummySignIn extends StatefulWidget {
  const DummySignIn({Key? key}) : super(key: key);
  static const route = 'dummy';

  @override
  State<DummySignIn> createState() => _DummySignInState();
}

class _DummySignInState extends State<DummySignIn> {
  @override
  Widget build(BuildContext context) {
    late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
        shadowColor: Colors.green,
      ),
      body: Container(
        child: Center(
          child: TextField(
            controller: TextEditingController(),
            onSubmitted: (String value) {
              Database(uid: value).updateUserData(name: 'New Memer', age: 20);
              Navigator.pushNamed(context, Homescreen.route);
            },
          ),
        ),
      ),
    );
  }
}
