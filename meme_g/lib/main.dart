import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/emailandpass_signin.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/screens/wrapper.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/widgets/create.dart';

import 'package:meme_g/widgets/meme_list.dart';
import 'package:provider/provider.dart';
import './widgets/drawer.dart';

import './screens/photo_editor.dart';
import 'screens/account_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/services/authstate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<authforState?>(
            create: (_) => authforState(FirebaseAuth.instance)),
        StreamProvider(
            initialData: null,
            create: (context) => context.read<authforState>().authstatechanges),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: MyHomePage(),
        routes: {
          PhotoEditor.route: (context) => PhotoEditor(),
          Account_det.route: (context) => Account_det(),
          Homescreen.route: (context) => Homescreen(),
          EmailandPass.route: (context) => EmailandPass(),
        },
      ),
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
    return Wrapper();
  }
}
