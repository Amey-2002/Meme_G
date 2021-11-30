import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/working/dummy_sign_in.dart';
import 'package:meme_g/screens/working/save_upload.dart';
import './screens/image_editor.dart';
import 'screens/working/profile_image_picker.dart';
import 'package:meme_g/screens/wrapper.dart';
import 'package:meme_g/widgets/create.dart';

import 'package:meme_g/widgets/meme_list.dart';
import './widgets/drawer.dart';

import './screens/photo_editor.dart';
import 'screens/account_details_screen.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),  
      home: MyHomePage(),
      /*routes: {
        PhotoEditor.route: (context) => PhotoEditor(),
        Account_det.route: (context) => Account_det(),
        Homescreen.route: (context) => Homescreen(),
        ImageEditor.route: (context) => ImageEditor(),
        SaveUpload.route: (context) => SaveUpload(),
        //ProflieImagePicker.route: (context) => ProflieImagePicker(),
      },*/
      onGenerateRoute: generateRoute,
    );
  }
  Route<dynamic> generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name)
    {
      case Account_det.route :
        return MaterialPageRoute(builder: (context) => Account_det());
      case SaveUpload.route :
        return MaterialPageRoute(builder: (context) => SaveUpload());
      case DummySignIn.route :
        return MaterialPageRoute(builder: (context) => DummySignIn());
      case ImageEditor.route :
        return MaterialPageRoute(builder: (context) => ImageEditor());
      default:
        return MaterialPageRoute(builder: (context) => Homescreen());
    }
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
