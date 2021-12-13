import 'package:flutter/material.dart';
import 'package:meme_g/SettingsScreen/settings_page.dart';

import 'rounded_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedButton(
          icon: Icon(Icons.arrow_back),
          iconColor: Colors.blueGrey,
          bgColor: Colors.white,
          tap: () => {Navigator.pushNamed(context, SettingsPage.route)},
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Feedback',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
