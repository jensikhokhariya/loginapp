import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  void addData(String title, String desc, String cate, String id, String img) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbRef = firebaseDatabase.ref();
    dbRef.child("Recepi").child("2").set(
        {"id": id, "title": title, "desc": desc, "cate": cate, "img": img});
  }
}
