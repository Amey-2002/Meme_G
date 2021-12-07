import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:meme_g/widgets/icon_widget.dart';

class AccountPage extends StatelessWidget {
  static const keyLangauge = 'key-langauge';
  static const keyLocation = 'key_location';
  static const keyPassword = 'key_password';
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildLangauge() {
      return DropDownSettingsTile(
        settingKey: keyLangauge,
        title: 'Langauge',
        subtitle: '',
        selected: 1,
        values: <int, String>{
          1: 'English',
          2: 'Hindi',
          3: 'Chinese',
          4: 'Marathi',
        },
        onChange: (langauge) {},
      );
    }

    Widget buildLocation() {
      return TextInputSettingsTile(
        settingKey: keyLocation,
        title: 'Location',
        initialValue: 'India',
        onChange: (location) {},
      );
    }

    Widget buildPassword() {
      return TextInputSettingsTile(
        settingKey: keyPassword,
        title: 'Change Password',
        obscureText: true,
        validator: (password) => password != null && password.length >= 6
            ? null
            : 'Enter atleast 6 characters!',
      );
    }

    Widget buildPrivacy(BuildContext context) {
      return SimpleSettingsTile(
        title: 'Privacy',
        subtitle: '',
        leading: IconWidget(icon: Icons.lock, color: Colors.blue),
        onTap: () {},
      );
    }

    Widget buildSecurity(BuildContext context) {
      return SimpleSettingsTile(
        title: 'Security',
        subtitle: '',
        leading: IconWidget(icon: Icons.security, color: Colors.orangeAccent),
        onTap: () {},
      );
    }

    Widget buildAccountInfo(BuildContext context) {
      return SimpleSettingsTile(
        title: 'Account Info',
        subtitle: '',
        leading: IconWidget(icon: Icons.info, color: Colors.blue),
        onTap: () {},
      );
    }

    return Column(
      children: [
        SimpleSettingsTile(
          title: 'Account Settings',
          subtitle: 'Privacy, Security, Langauge',
          leading: IconWidget(icon: Icons.person, color: Colors.green),
          child: SettingsScreen(children: <Widget>[
            buildLangauge(),
            buildLocation(),
            buildPassword(),
            buildPrivacy(context),
            buildSecurity(context),
            buildAccountInfo(context),
          ]),
        ),
      ],
    );
  }
}
