import 'package:flutter/material.dart';

class MemeView extends StatefulWidget {
  final String imgUrl;
  final String userName;

  MemeView({required this.imgUrl, required this.userName});

  @override
  State<MemeView> createState() => _MemeViewState();
}

class _MemeViewState extends State<MemeView> {
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
            padding: const EdgeInsets.only(bottom: 20, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //Icon(Icons.favorite_border,size: 27,),
                //Icon(Icons.send,size: 27,),
                //Icon(Icons.share,size: 27,),
                RaisedButton(
                  color: Colors.greenAccent[700],
                  onPressed: () {},
                  child: Icon(
                    Icons.favorite_border,
                    size: 27,
                  ),
                ),
                //IconButton(onPressed: () {}, icon: Icon(Icons.send,size: 27,)),
                RaisedButton(
                  color: Colors.greenAccent[700],
                  onPressed: () {},
                  child: Icon(
                    Icons.share,
                    size: 27,
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
