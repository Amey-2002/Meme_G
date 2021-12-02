import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/settings_page.dart';
import 'package:meme_g/screens/wrapper.dart';
import 'package:meme_g/widgets/create.dart';

import 'package:meme_g/widgets/meme_list.dart';
import 'package:meme_g/widgets/theme_changer.dart';
import 'package:meme_g/widgets/theme_constants.dart';
import 'package:meme_g/widgets/theme_manager.dart';
// import 'package:meme_g/widgets/theme_provider.dart';
import './widgets/drawer.dart';

import './screens/photo_editor.dart';
import 'screens/account_details_screen.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:switcher_button/switcher_button.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: MyHomePage(),
      routes: {
        PhotoEditor.route: (context) => PhotoEditor(),
        Account_det.route: (context) => Account_det(),
        Homescreen.route: (context) => Homescreen(),
        SettingsPage.route: (context) => SettingsPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // void dispose() {
  //   themeManager.removeListener(themeListener);
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   themeManager.addListener(() {});
  //   super.initState();
  // }

  // themeListener() {
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Wrapper();
  }
}
