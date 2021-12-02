// import 'package:flutter/material.dart';
// import 'package:flutter_settings_screens/flutter_settings_screens.dart';
// import 'package:meme_g/widgets/theme_provider.dart';
// import 'package:/theme_provider/theme_provider.dart';

// class ChangeThemeButtonWidget extends StatelessWidget {
//   const ChangeThemeButtonWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = ThemeProvider.themeOf(context);
//     return Switch.adaptive(
//         value: themeProvider.isDarkMode,
//         onChanged: (value) {
//           final provider = Provider.of<ThemeProvider>(context, listen: false);
//           provider.toggleTheme(value);
//         });
//   }
// }
