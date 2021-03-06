import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/collage/collage_menu.dart';
import 'package:meme_g/screens/emailandpass_signin.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/liked_memes.dart';
import 'package:meme_g/screens/personal_info.dart';
import 'package:meme_g/screens/my_work.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:meme_g/SettingsScreen/about.dart';
import 'package:meme_g/SettingsScreen/ask_question.dart';
import 'package:meme_g/SettingsScreen/help.dart';
import 'package:meme_g/SettingsScreen/rate.dart';
import 'package:meme_g/SettingsScreen/report_bug.dart';
import 'package:meme_g/SettingsScreen/settings_page.dart';
import 'package:meme_g/widgets/splash_screen.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/Theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'screens/account_details_screen.dart';
import 'package:meme_g/services/authstate.dart';

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
        Provider<Auth>(create: (_) => Auth()),
        StreamProvider(
            initialData: null,
            create: (context) => context.read<authforState>().authstatechanges),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.green,),
        darkTheme: ThemeData.dark(),
        themeMode: themeManager.themeMode,
        home: MyHomePage(),
        routes: {
          Account_det.route: (context) => Account_det(),
          Homescreen.route: (context) => Homescreen(),
          EmailandPass.route: (context) => EmailandPass(),
          personal_info.route: (context) => personal_info(),
          MyWork.route: (context) => MyWork(),
          LikedMemes.route: (context) => LikedMemes(),
          //ImageEditorPro.route: (context) => ImageEditorPro(),
          SettingsPage.route: (context) => SettingsPage(),
          RateScreen.route: (context) => RateScreen(),
          ReportBug.route: (context) => ReportBug(),
          AboutScreen.route: (context) => AboutScreen(),
          HelpScreen.route: (context) => HelpScreen(),
          AskQuestion.route: (context) => AskQuestion(),
          GridMenu.route: (context) => GridMenu(),
          //StaggeredPage.route: (context) => StaggeredPage.(),

          signIn.route: (context) => signIn(),
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
    return //Wrapper();
    splash_screen();
  }
}
