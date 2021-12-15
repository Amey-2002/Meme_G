import 'package:flutter/material.dart';
import 'package:meme_g/SettingsScreen/ask_question.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/SettingsScreen/report_bug.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static const route = 'help_screen';

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    // Ask a Question
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, AskQuestion.route);
                      },
                      leading: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.question_answer_outlined),
                        color: Colors.grey[800],
                      ),
                      title: Text(
                        'Ask a Question',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                    // Report Bug
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, ReportBug.route);
                      },
                      leading: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.report),
                        color: Colors.purple[600],
                      ),
                      title: Text(
                        'Report Bug',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                    // Privacy Policy
                    ListTile(
                      onTap: () {},
                      leading: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.privacy_tip),
                        color: Colors.green,
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
