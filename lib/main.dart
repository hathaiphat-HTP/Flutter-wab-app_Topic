import 'package:chapter4_cloud_firestore/page/list_topic.dart';
import 'package:chapter4_cloud_firestore/page/topic.dart';
import 'package:chapter4_cloud_firestore/page/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAKT5f30ZlZMIdUErn_uaxGaZVV7QNZ1sI",
          appId: "1:994850625306:web:6fb130818d30618530fea3",
          messagingSenderId: "994850625306",
          projectId: "flutter-firebase-cloud-2fbac"));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignInScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            indicatorColor: Colors.deepPurple,
            labelColor: Colors.deepPurple,
            tabs: [
              Tab(
                child: Text("ตั้งกระทู้",style: TextStyle(color: Colors.purple)),
              ),
              Tab(
                child: Text("กระทู้ของฉัน",style: TextStyle(color: Colors.purple)),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Topic(),
              ListTopic()
            ],
          ),
        ),
    );
  }
}
