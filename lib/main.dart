import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/screen/home/homescreen.dart';
import 'package:loginapp/screen/loginpage/loginscreen.dart';
import 'package:loginapp/screen/loginpage/registerscreen.dart';
import 'package:loginapp/screen/providerpage/lrprovider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LRProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginScreen(),
          'page1': (context) => RegisterScreen(),
          'page2':(context)=>HomeScreen(),
        },
      ),
    ),
  );
}
