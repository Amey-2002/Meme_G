import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GuestMemeView extends StatefulWidget {

  final String imgUrl;
  final String userName;

  GuestMemeView({required this.imgUrl, required this.userName});

  @override
  State<GuestMemeView> createState() => _GuestMemeViewState();
}

class _GuestMemeViewState extends State<GuestMemeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 37,
                ),
                title: Text(
                  widget.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
              /*Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 37,
                ),
                (widget.userName == null)?
                Text(
                   'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ) :
                
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),*/
              ),
          Container(
            height: 330,
            width: 330,
            child: Image(
              image: NetworkImage(widget.imgUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //Icon(Icons.favorite_border,size: 27,),
                //Icon(Icons.send,size: 27,),
                //Icon(Icons.share,size: 27,),
                IconButton(onPressed: () {
                  Share.share(widget.imgUrl + ' Meme by ' + widget.userName);
                }, icon: Icon(Icons.share,size: 27,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
