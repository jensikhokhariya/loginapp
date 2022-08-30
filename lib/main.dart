import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/screen/home/homescreen.dart';
import 'package:loginapp/screen/loginpage/loginscreen.dart';
import 'package:loginapp/screen/loginpage/registerscreen.dart';
import 'package:loginapp/screen/providerpage/homeprovider.dart';
import 'package:loginapp/screen/providerpage/lrprovider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LRProvider()),
        ChangeNotifierProvider(create: (context)=> HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash_Screen(),
          'login': (context) => LoginScreen(),
          'resgi': (context) => RegisterScreen(),
          'home': (context) => HomeScreen(),
        },
      ),
    ),
  );
}

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
    navigat();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            child: Image.network(
                "https://thumbs.dreamstime.com/b/recipe-word-text-green-leaf-logo-icon-design-white-background-suitable-card-typography-143638205.jpg"),
          ),
        ),
      ),
    );
  }

  void navigat() {
    bool check = Provider.of<LRProvider>(context,listen: false).cheakUser();
    if(check){
      Timer(Duration(seconds: 3), () {Navigator.pushReplacementNamed(context, 'home');});
    }
    else{
      Timer(Duration(seconds: 3), () {Navigator.pushReplacementNamed(context, 'login');});
    }
  }
}
