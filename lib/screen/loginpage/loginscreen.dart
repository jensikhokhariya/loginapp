import 'package:flutter/material.dart';
import 'package:loginapp/screen/providerpage/lrprovider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController e1 = TextEditingController();
  TextEditingController p1 = TextEditingController();
  bool login = false;

//   @override
//   void initState() {
//     super.initState();
//     login = Provider.of<LRProvider>(context,listen: false).cheakUser();
//   }
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
// void isLogin(){
//     if(login){
//       Navigator.pushReplacementNamed(context, 'home');
//     }
// }

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
                "Login",
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
                onPressed: () async {
                  var res =
                      await Provider.of<LRProvider>(context, listen: false)
                          .findUser(e1.text, p1.text);

                  print(res);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$res")));

                  if (res == "Success") {
                    Navigator.pushReplacementNamed(context, 'home');
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Provider.of<LRProvider>(context, listen: false)
                        .googleSignIn();
                  },
                  child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJvJeICVmrqFtHG1UX9TC8qPMJwuN-K3sUy9JdmHfulwwNg6AfanEyvXV_1I8qvmbRw&usqp=CAU")),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'resgi');
                },
                child: Text("create account | Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
