import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loginapp/screen/providerpage/homeprovider.dart';
import 'package:loginapp/screen/providerpage/lrprovider.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging? firebaseMessaging;
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController cate = TextEditingController();
  TextEditingController img = TextEditingController();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    local();
    firebasenotification();

    AndroidInitializationSettings androidsettings =
        AndroidInitializationSettings('android');

    IOSInitializationSettings iossettings = IOSInitializationSettings();

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidsettings, iOS: iossettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

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
              IconButton(
                onPressed: () {
                  // notificationlocal();
                  notificationschedual();
                },
                icon: Icon(Icons.notifications_active),
              ),
            ],
          ),
          body: StreamBuilder(
            stream:
                Provider.of<HomeProvider>(context, listen: false).readData(),
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
                  RecipeModel r1 = RecipeModel(
                      id: x.child("id").value.toString(),
                      title: x.child("title").value.toString(),
                      cate: x.child("cate").value.toString(),
                      desc: x.child("desc").value.toString(),
                      img: x.child("img").value.toString(),
                      key: x.key);
                  l1.add(r1);
                }
                return ListView.builder(
                    itemCount: l1.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: Text("${l1[index].id}"),
                          title: Text("${l1[index].title}"),
                          subtitle: Text("${l1[index].cate}"),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    title = TextEditingController(
                                        text: l1[index].title);
                                    id = TextEditingController(
                                        text: l1[index].id);
                                    desc = TextEditingController(
                                        text: l1[index].desc);
                                    cate = TextEditingController(
                                        text: l1[index].cate);
                                    img = TextEditingController(
                                        text: l1[index].img);
                                    DilogeBox(l1[index].key.toString());
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<HomeProvider>(context,
                                            listen: false)
                                        .delete(l1[index].key);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              title = TextEditingController();
              id = TextEditingController();
              desc = TextEditingController();
              cate = TextEditingController();
              img = TextEditingController();
              DilogeBox(null);
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
            content: SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: Column(
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
                        Provider.of<HomeProvider>(context, listen: false)
                            .addData(
                                title: title.text,
                                desc: desc.text,
                                cate: cate.text,
                                id: id.text,
                                img: img.text,
                                key: key);
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  void notificationlocal(String title,String body) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "localnotify",
        importance: Importance.max, priority: Priority.high);
    IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(presentSound: false, presentAlert: false);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "Hiii.......", "Local Notification", notificationDetails);
  }
  void notificationschedual() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "localnotify",
        importance: Importance.max, priority: Priority.high);
    IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(presentSound: false, presentAlert: false);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Hiii.......",
        "Schedual Notification",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 3),),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
  void firebasenotification()async{
    firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings notificationSettings = await firebaseMessaging!.requestPermission(
      badge: true,
      alert: true,
      sound: false,
      provisional: false
    );
    if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
      FirebaseMessaging.onMessage.listen((event) {
        String title = event.notification!.title.toString();
        String body= event.notification!.body.toString();

        notificationlocal(title,body);

      });
    }
    else{
      print("No Permission");
    }
  }
  void local(){
    AndroidInitializationSettings androidsettings =
    AndroidInitializationSettings('android');

    IOSInitializationSettings iossettings = IOSInitializationSettings();

    InitializationSettings initializationSettings =
    InitializationSettings(android: androidsettings, iOS: iossettings);
    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
