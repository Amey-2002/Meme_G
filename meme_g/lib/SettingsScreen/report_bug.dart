import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/SettingsScreen/app_header.dart';
import 'package:meme_g/SettingsScreen/profile_image2.dart';
import 'package:meme_g/SettingsScreen/rounded_button.dart';
import 'package:meme_g/SettingsScreen/settings_page.dart';
import 'package:meme_g/screens/profile_image.dart';
import 'package:meme_g/screens/profile_image_picker.dart';

class ReportBug extends StatefulWidget {
  const ReportBug({Key? key}) : super(key: key);
  static const route = 'report_bug';
  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  late CollectionReference reportRef;
  String? profileImageUrl;

  var report = '';

  void initState() {
    super.initState();
    reportRef = FirebaseFirestore.instance.collection('Report');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AppHeader(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    //CustomAppBar(),
                    Row(
                      children: [
                        RoundedButton(
                          icon: Icon(Icons.arrow_back),
                          tap: () => {
                            Navigator.pushReplacementNamed(context, SettingsPage.route),
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Report Bug',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      height: 80,
                      color: Colors.lightGreenAccent,
                    ),

                    SizedBox(
                      height: 0.0,
                    ),

                    Text(
                      'What problem are you facing?',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),

                    SizedBox(
                      height: 18.0,
                    ),

                    // MultiLineInput(),
                    Container(
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: Offset(0.0, 15.0),
                            color: Colors.black,
                          ),
                        ],
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            color: Colors.black,
                          ),
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter bug',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          // print("The value entered is : $value");
                          report = value;
                        },
                      ),
                    ),

                    

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Report',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RoundedButton(
                          icon: Icon(Icons.arrow_forward),
                          tap: () {
                            setState(() {
                              reportRef.doc().set({'report': report});
                            });
                          },
                        ),
                      ],
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
