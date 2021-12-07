import 'package:flutter/material.dart';
import 'package:meme_g/screens/rounded_button.dart';
import 'package:meme_g/screens/settings_page.dart';

class ReportBug extends StatefulWidget {
  const ReportBug({Key? key}) : super(key: key);
  static const route = 'report_bug';
  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SettingsPage.route);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
        ),
        title: Text('Report Bug'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
        ),
      ),

      //Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(0.0, 15.0),
                    color: Colors.black54,
                  ),
                ],
              ),
              child: TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Bug!',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) {
                  print("The value entered is : $value");
                },
              ),
            ),
            RoundedButton(
              icon: Icon(Icons.arrow_forward),
              iconColor: Colors.white,
              bgColor: Colors.lightGreen,
              tap: () {
                // setState(() {
                //   feedbackRef
                //       .doc(user!.uid)
                //       .set({'stars': rating, 'comment': comment});
                // });
              },
            )
          ],
        ),
      ),
    );
  }
}
