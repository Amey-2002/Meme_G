import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/help.dart';
import 'package:meme_g/screens/rounded_button.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({Key? key}) : super(key: key);
  static const route = 'ask_question';

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference questionRef;
  var question = '';

  void initState() {
    super.initState();
    questionRef = FirebaseFirestore.instance.collection('Question');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HelpScreen.route);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          iconSize: 30,
        ),
        title: Text('Ask a Question'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: Colors.grey[800],
      ),

      //Body
      body: Column(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        //Multiline Input
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
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Your Question..',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              // print("The value entered is : $value");
                              question = value;
                              print(question);
                            },
                          ),
                        ),

                        SizedBox(height: 20),

                        // Ask question Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Ask',
                              style: TextStyle(
                                color: Colors.black,
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
                              iconColor: Colors.white,
                              bgColor: Colors.teal,
                              tap: () {
                                setState(() {
                                  questionRef
                                      .doc(user!.uid)
                                      .set({'question': question});
                                  // reportRef.doc(user!.uid).set({'report': report});
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
        ],
      ),
    );
  }
}
