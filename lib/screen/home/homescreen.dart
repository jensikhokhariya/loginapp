import 'package:flutter/material.dart';
import 'package:loginapp/screen/providerpage/homeprovider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController descri = TextEditingController();
  TextEditingController cate = TextEditingController();
  TextEditingController img = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Recipe"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              controller: id,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "id",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: title,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "title",
              ),
            ),
            SizedBox(height: 10,),TextField(
              controller: descri,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "desc",
              ),
            ),
            SizedBox(height: 10,),TextField(
              controller: cate,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "cate",
              ),
            ),
            SizedBox(height: 10,),TextField(
              controller: img,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "img",
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Provider.of<HomeProvider>(context,listen: false).addData(title.text, descri.text, cate.text, id.text, img.text);
            }, child: Text("Add"),),
          ],
        ),
      ),
    );
  }
}
