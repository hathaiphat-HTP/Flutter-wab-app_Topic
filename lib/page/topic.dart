import 'package:chapter4_cloud_firestore/page/post_topic.dart';
import 'package:chapter4_cloud_firestore/page/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Topic extends StatefulWidget {
  const Topic({super.key});

  @override
  State<Topic> createState() => _Topic();
}

class _Topic extends State<Topic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.topic, color: Colors.purple[800]),
            Text("   ตั้งกะทู้",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800])),
          ],
        ),
        actions: [
          CircleAvatar(
            // substring หั่นตัวอักษร เพื่อโชวอักษรตัวแรก โดยตำแหน่ง เริ่มที่ 0 จบที่ 1
            child: Text(FirebaseAuth.instance.currentUser!.email
                .toString()
                .substring(0, 1)),
          ),
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SignInScreen();
                  }), (route) => false);
                });
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          padding: EdgeInsets.all(50),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 150,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostTopic();
                                  }));
                            },
                            icon: Icon(Icons.question_mark,color: Colors.yellow,), // ใส่ไอคอนที่นี่
                            label: Text('กระทู้คำถาม',style: TextStyle(color: Colors.yellow),),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                              ),
                              backgroundColor: Colors.purple[800],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.purple[800],
                          height: 150,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostTopic();
                                  }));
                            },
                            icon: Icon(Icons.question_answer,color: Colors.yellow), // ใส่ไอคอนที่นี่
                            label: Text('กระทู้สนทนา',style: TextStyle(color: Colors.yellow),),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                              ),
                              backgroundColor: Colors.purple[800],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.purple[800],
                          height: 150,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostTopic();
                                  }));
                            },
                            icon: Icon(Icons.poll,color: Colors.yellow), // ใส่ไอคอนที่นี่
                            label: Text('กระทู้โพล',style: TextStyle(color: Colors.yellow),),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                              ),
                              backgroundColor: Colors.purple[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.purple[800],
                          height: 150,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostTopic();
                                  }));
                            },
                            icon: Icon(Icons.star_half,color: Colors.yellow), // ใส่ไอคอนที่นี่
                            label: Text('กระทู้รีวิว',style: TextStyle(color: Colors.yellow),),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(  // กำหนดรูปร่างเป็นสี่เหลี่ยมจัตุรัส
                              ),
                              backgroundColor: Colors.purple[800],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.purple[800],
                          height: 150,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostTopic();
                                  }));
                            },
                            icon: Icon(Icons.newspaper,color: Colors.yellow), // ใส่ไอคอนที่นี่
                            label: Text('กระทู้ข่าว',style: TextStyle(color: Colors.yellow),),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(    // กำหนดรูปร่างเป็นสี่เหลี่ยมจัตุรัส
                              ),
                              backgroundColor: Colors.purple[800],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.purple[800],
                          height: 150,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PostTopic();
                                  }));
                            },
                            icon: Icon(Icons.shopping_cart_outlined,color: Colors.yellow), // ใส่ไอคอนที่นี่
                            label: Text('กระทู้ขายของ',style: TextStyle(color: Colors.yellow),),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(  // กำหนดรูปร่างเป็นสี่เหลี่ยมจัตุรัส
                              ),
                              backgroundColor: Colors.purple[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
