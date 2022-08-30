import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/screen/providerpage/homeprovider.dart';
import 'package:loginapp/screen/providerpage/lrprovider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController cate = TextEditingController();
  TextEditingController img = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Recipe"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Provider.of<LRProvider>(context, listen: false).signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: Provider.of<HomeProvider>(context, listen: false).readData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                print("============= ${snapshot.data.snapshot}");

                List l1 = [];
                DataSnapshot data = snapshot.data.snapshot;

                for (var x in data.children) {
                  String cate = x.child("cate").value.toString();
                  String img = x.child("img").value.toString();
                  String title = x.child("title").value.toString();
                  String desc = x.child("desc").value.toString();
                  String id = x.child("id").value.toString();
                  String? key = x.key;

                  RecipeModel r1 = RecipeModel(
                      id: id, title: title, cate: cate, desc: desc, img: img);
                  l1.add(r1);
                }
                return ListView.builder(
                    itemCount: l1.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text("${l1[index].id}"),
                        title: Text("${l1[index].cate}"),
                        subtitle: Text("${l1[index].desc}"),
                        trailing: Text("${l1[index].id}"),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              DilogeBox();
            },
            child: Icon(Icons.add),
          )),
    );
  }

  void DilogeBox(String? key) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: id,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "id",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "title",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: desc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "desc",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: cate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "cate",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: img,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "img",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false).addData(
                        title:title.text, desc:desc.text, cate:cate.text, id:id.text, img:img.text,key: key );
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        });
  }
}
