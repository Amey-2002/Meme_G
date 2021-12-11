import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/rounded_button.dart';
import 'package:meme_g/screens/working/profile_image_picker.dart';
import 'package:meme_g/widgets/proportionals.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import 'app_header.dart';
import 'custom_app_bar.dart';
import 'multiline_input.dart';

class RateScreen extends StatefulWidget {
  static const route = 'ratescreen';

  RateScreen({Key? key}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference feedbackRef;
  String? profileImageUrl;

  var rating = 0.0;
  var dp = new ProfilePage();
  var comment = '';

  @override
  void initState() {
    super.initState();
    dp.setUid = user!.uid;
    feedbackRef = FirebaseFirestore.instance.collection('FeedBack');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(height: 20.0),
            AppHeader(),
            Positioned(
              top: -380,
              left: -187,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(''),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    CustomAppBar(),
                    SizedBox(height: 50.0),
                    dp,
                    // // CircleAvatar(
                    // //   backgroundColor: Colors.white,
                    // //   child: Icon(
                    // //     Icons.account_circle_rounded,
                    // //     size: 150,
                    // //   ),
                    //   // foregroundImage: NetworkImage(),
                    //   // backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRlybPj2CVQpdYMY2HSNEKLbT5PFv33ZThDg&usqp=CAU'),
                    //   // foregroundImage: NetworkImage(
                    //   //      'https://thumbs.dreamstime.com/b/feedback-concept-image-arrows-blue-chalkboard-background-40378284.jpg'),
                    //   radius: 90,
                    // ),
                    // Image.asset(
                    //   'assets/dummyMemes/1.jpg',
                    //   width: getScreenProportionWidth(166, size),
                    //   // height: getScreenProportionHeight(166,size),
                    //   // fit: BoxFit.cover,
                    // ),

                    // Image.asset(
                    //   'assets/dummyMemes/2.png',
                    //   width: getScreenProportionWidth(166, size),
                    // ),
                    SizedBox(
                      height: 5.0,
                    ),

                    Text(
                      'You',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'You',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Divider(
                      height: 80,
                      color: Colors.lightGreenAccent,
                    ),

                    SizedBox(
                      height: 0.0,
                    ),

                    Text(
                      'How much did you like this app?',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),

                    SizedBox(
                      height: 18.0,
                    ),

                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (value) {
                        rating = value;
                        print(rating);
                      },
                      starCount: 5,
                      rating: rating,
                      size: 45,
                      filledIconData: Icons.star_rate,
                      color: Colors.yellowAccent,
                      borderColor: Colors.grey,
                      spacing: 18.0,
                    ),

                    SizedBox(
                      height: 20.0,
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
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Additional Comment',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          // print("The value entered is : $value");
                          comment = value;
                        },
                      ),
                    ),

                    SizedBox(
                      height: 18.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Submit',
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
                          bgColor: Colors.lightGreen,
                          tap: () {
                            setState(() {
                              feedbackRef
                                  .doc(user!.uid)
                                  .set({'stars': rating, 'comment': comment});
                            });
                          },
                        )
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

  // void setState(Null Function() param0) {}
}