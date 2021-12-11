import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const route = 'about_page';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Homescreen.route);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          iconSize: 30,
        ),
        title: Text('About app'),
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
                    Text(
                      'Tickles',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Tickles is a simple and cool Meme generator and which also provides a platform to share and explore memes!\n' +
                          'It allows you to pick any image and edit it in way you want\n\n' +
                          'After editing we also can upload it so that other app users can also see your work\n' +
                          'Any queries related to the working of app can be asked in Ask a Question section\n' +
                          'Your feedback would be useful for our futher projects!\n\n' +
                          'Project created by Amey, Amanpreet, Jay and Shubham under the guidance of Priya and Prerna',
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
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
