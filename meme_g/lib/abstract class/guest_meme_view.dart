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
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              )),
          Container(
            height: 370,
            width: 370,
            child: Image(
              image: NetworkImage(widget.imgUrl),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      Share.share(
                          widget.imgUrl + ' Meme by ' + widget.userName);
                    },
                    icon: Icon(
                      Icons.share,
                      size: 27,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
