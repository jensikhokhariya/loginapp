import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  void addData(
      {String? title,
      String? desc,
      String? cate,
      String? id,
      String? img,
      String? key}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbRef = firebaseDatabase.ref();
     if(key == null){
       dbRef.child("Recepi").push().set(
           {"id": id, "title": title, "desc": desc, "cate": cate, "img": img});
     }
     else{
       dbRef.child("Recepi").child(key).set(
           {"id": id, "title": title, "desc": desc, "cate": cate, "img": img});
     }
  }

  Stream<DatabaseEvent> readData(){
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbRef = firebaseDatabase.ref();
    return dbRef.child("Recepi").onValue;
  }
  Future<void> delete(String key){
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbRef = firebaseDatabase.ref();
    return dbRef.child("Recepi").child(key).remove();
  }
}
class RecipeModel{
  String? cate,desc,title,id,img,key;

  RecipeModel({this.cate, this.desc, this.title, this.id, this.img,this.key});
}
