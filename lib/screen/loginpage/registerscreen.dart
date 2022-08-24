import 'package:flutter/material.dart';
import 'package:loginapp/screen/providerpage/lrprovider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController e1 = TextEditingController();
  TextEditingController p1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: e1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: p1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async{
                  var res =await Provider.of<LRProvider>(context, listen: false)
                      .findUser(e1.text, p1.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$res")));

                  if(res == "Success"){
                    Navigator.pushReplacementNamed(context, 'home');
                  }
                },
                child: Text("Sign up"),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
