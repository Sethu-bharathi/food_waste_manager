import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogdata) async {
    FirebaseFirestore.instance
        .collection("posts")
        .add(blogdata)
        .catchError((e) {
      print(e);
    });
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy('timestamp');
  }

   getData(){
    return  FirebaseFirestore.instance
        .collection("posts")
        .snapshots();
  }
}