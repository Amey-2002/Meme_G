import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:meme_g/SettingsScreen/rate.dart';
import 'package:meme_g/SettingsScreen/report_bug.dart';
import 'package:meme_g/screens/wrapper.dart';
import 'package:meme_g/widgets/icon_widget.dart';
import 'package:path/path.dart';
import 'account_page.dart';
import '../screens/homescreen.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:meme_g/main.dart';
import 'package:meme_g/Theme/theme_manager.dart';

class SettingsPage extends StatefulWidget {
  static const route = 'settings_page';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

dynamic appbarcolor = false;

class _SettingsPageState extends State<SettingsPage> {
  Widget buildLogout() => SimpleSettingsTile(
        title: 'Logout',
        subtitle: '',
        leading: IconWidget(icon: Icons.logout, color: Colors.blueAccent),
      );

  Widget buildDeleteAccount() => SimpleSettingsTile(
        title: 'Delete Account',
        subtitle: '',
        leading: IconWidget(icon: Icons.delete, color: Colors.blueAccent),
        onTap: () {},
      );

  Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
        title: 'Report Bug',
        subtitle: '',
        leading: IconWidget(icon: Icons.report, color: Colors.green),
        onTap: () {
          Navigator.pushReplacementNamed(context, ReportBug.route);
        },
      );

  Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
        title: 'Send Feedback',
        subtitle: '',
        leading: IconWidget(icon: Icons.feedback, color: Colors.green),
        onTap: () {
          Navigator.pushReplacementNamed(context, RateScreen.route);
        },
      );

  Widget buildChangeTheme(BuildContext context) => ListTile(
        title: Text('Dark Mode'),
        leading: Switch(
          value: themeManager.themeMode == ThemeMode.dark,
          onChanged: (newvalue) {
            setState(() {
              appbarcolor = newvalue;
            });
            themeManager.toggleTheme(newvalue);
            print(newvalue);
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SettingsGroup(
              title: 'GENERAL',
              children: <Widget>[
                buildChangeTheme(context),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SettingsGroup(
              title: 'FEEDBACK',
              children: <Widget>[
                buildReportBug(context),
                buildSendFeedback(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
