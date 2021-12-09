import 'package:flutter/material.dart';

class MemeView extends StatelessWidget {
  Image img;

  MemeView({required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 37,
                ),
                Text(
                  'User Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 330,
            width: 330,
            child:
                img, /*const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'
                ),
            ),*/
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 2),
              child: Row(
                crossAxisAlignment:CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Icon(Icons.favorite_border,size: 27,),
                  //Icon(Icons.send,size: 27,),
                  //Icon(Icons.share,size: 27,),

                  // FloatingActionButton(
                  //   heroTag: 'btn3',
                  //   onPressed: () {},
                  //   child: Center(
                  //     heightFactor: 25,
                  //     widthFactor: 100,
                  //     child: Icon(
                  //       Icons.favorite_border,
                  //       size: 27,
                  //     ),
                  //   ),
                  // ),
                  //IconButton(onPressed: () {}, icon: Icon(Icons.send,size: 27,)),
                  // FloatingActionButton(
                  //   heroTag: 'btn4',
                  //   onPressed: () {},
                  //   child: 
                  //   ClipRRect(
                  //     child: Center(
                  //       child: Icon(
                  //         Icons.share,
                  //         size: 27,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  IconButton(
                    splashColor: Colors.red,
                    onPressed: () {}, 
                    icon: Icon(Icons.favorite_border,size: 27,color: Colors.black,),
                    color : Colors.transparent,
                    ),
                  IconButton(
                    splashColor: Colors.blueAccent,
                    onPressed: () {}, 
                    icon: Icon(Icons.share,size: 27,color: Colors.black,),
                    color : Colors.transparent,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
