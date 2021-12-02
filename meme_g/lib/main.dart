import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/settings_page.dart';
import 'package:meme_g/screens/emailandpass_signin.dart';
import 'package:meme_g/screens/homescreen.dart';
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

import 'package:meme_g/widgets/theme_changer.dart';
import 'package:meme_g/widgets/theme_constants.dart';
import 'package:meme_g/widgets/theme_manager.dart';
// import 'package:meme_g/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import './widgets/drawer.dart';

import './screens/photo_editor.dart';
import 'screens/account_details_screen.dart';

import 'package:theme_provider/theme_provider.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/services/authstate.dart';

import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

ThemeManager themeManager = ThemeManager();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Settings.init(cacheProvider: SharePreferenceCache());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

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
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeManager.themeMode,
        home: MyHomePage(),
        routes: {
          PhotoEditor.route: (context) => PhotoEditor(),
          Account_det.route: (context) => Account_det(),
          Homescreen.route: (context) => Homescreen(),
          EmailandPass.route: (context) => EmailandPass(),
          ImageEditor.route: (context) => ImageEditor(),
          SaveUpload.route: (context) => SaveUpload(),
          SettingsPage.route: (context) => SettingsPage(),
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
// <<<<<<< HEAD
//   // @override
//   // void dispose() {
//   //   themeManager.removeListener(themeListener);
//   //   super.dispose();
//   // }

//   // @override
//   // void initState() {
//   //   themeManager.addListener(() {});
//   //   super.initState();
//   // }

//   // themeListener() {
//   //   if (mounted) {
//   //     setState(() {});
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Wrapper();
//   }
// }
// =======

  /* Future<bool> _onbackepressed(){
    return showDialog(
    context:  context, 
    builder: (context)=> AlertDialog(
     title: Text("Do you want to exit"),
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
