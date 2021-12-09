import 'package:flutter/material.dart';

class GuestMemeView extends StatelessWidget {

  Image img;

  GuestMemeView({required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(Icons.account_circle,size: 37,),
                Text('User Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),)
              ],
            ),
          ),
          Container(
            height: 330,
            width: 330,
            child: img, /*const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'
                ),
            ),*/
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //Icon(Icons.favorite_border,size: 27,),
                //Icon(Icons.send,size: 27,),
                //Icon(Icons.share,size: 27,),
                IconButton(
                  onPressed: () {}, 
                  icon: Icon(Icons.share,size: 25,color: Colors.black,),
                  color : Colors.transparent,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
