

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/emailandpass_signin.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/personal_info.dart';
import 'package:meme_g/screens/working/dummy_sign_in.dart';
import 'package:meme_g/screens/working/save_upload.dart';
import 'package:meme_g/widgets/user.dart';
import './screens/image_editor.dart';
import 'screens/working/profile_image_picker.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/screens/wrapper.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/widgets/create.dart';

import 'package:meme_g/widgets/meme_list.dart';
import 'package:meme_g/widgets/user.dart';
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
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
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
          primarySwatch: Colors.green,
        ),
        home: MyHomePage(),
        routes: {
          PhotoEditor.route: (context) => PhotoEditor(),
          Account_det.route: (context) => Account_det(),
          Homescreen.route: (context) => Homescreen(),
          EmailandPass.route: (context) => EmailandPass(),
          personal_info.route:(context) => personal_info(),
          ImageEditor.route: (context) => ImageEditor(),
          SaveUpload.route: (context) => SaveUpload(),
          //ProflieImagePicker.route: (context) => ProflieImagePicker(),
        },
      ),
    );
  }
  /*Route<dynamic> generateRoute(RouteSettings routeSettings){
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
  }*/
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
 /* Future<bool> _onbackepressed(){
    return showDialog(
    context:  context, 
    builder: (context)=> AlertDialog(
     title: Text("Do you want to exit?"),
      actions:<Widget> [
        FlatButton(onPressed: ()=> Navigator.pop(context,false)  
        , 
        child:Text("No") ),
        FlatButton(
          onPressed: ()=> Navigator.pop(context,true), 
            child: Text("Yes"))
      ],
    )
  );
  }*/
  @override
  Widget build(BuildContext context) {
    return Wrapper();
     /*WillPopScope(
      child: Wrapper(),
      onWillPop: /*_onbackepressed*/);*/
  }
}