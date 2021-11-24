import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  final String uid;
  Database({required this.uid});

  final CollectionReference meme = FirebaseFirestore.instance.collection('memes');


}