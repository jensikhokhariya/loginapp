import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class  LRProvider extends ChangeNotifier{

  String findUser(String email,String password){
    var firebaseauth = FirebaseAuth.instance;
    firebaseauth.createUserWithEmailAndPassword(email: email, password: password).then((value) => "success");

    return "Success";
  }

}