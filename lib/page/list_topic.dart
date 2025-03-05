import 'package:chapter4_cloud_firestore/page/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> list = <String>[
  '#ร้านกาแฟยอดฮิต',
  '#How to เครื่องสำอาง',
  '#พรีเมียร์ลีก',
  '#cafe',
  '#เที่ยวต่างประเทศ',
  '#ร้านอาหารในเชียงใหม่',
];

class ListTopic extends StatefulWidget {
  const ListTopic({super.key});

  @override
  State<ListTopic> createState() => _ListTopic();
}

class _ListTopic extends State<ListTopic> {
  CollectionReference topicCollection =
      FirebaseFirestore.instance.collection("topic");

  bool _checkState = true;

  TextEditingController _topichead = TextEditingController(); //หัวข้อ
  TextEditingController _topicdetail =
      TextEditingController(); //รายละเอียดข้อความ
  TextEditingController _tage = TextEditingController(); //แท็กข้อความ

  String dropdownValue = list.first;

  //จำนวนตั๋ว

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.list, color: Colors.purple[800]),
            Text("   รายการกระทู้",
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
      body: Container(
        child: StreamBuilder(
          stream: topicCollection.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.hasError.toString()}"),
              );
            } else if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text("ไม่มีข้อมูล..."),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot topic = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                    elevation: 6,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      title: Text(topic['topichead'].toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Prompt',
                              color: Colors.purple[800])),
                      subtitle: Text("แฮชแท็ก " + topic['tage'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    _topichead.text = topic['topichead'];
                                    _topicdetail.text = topic['topicdetail'];
                                    _tage.text = topic['tage'];
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function())
                                              setState) {
                                        return AlertDialog(
                                          actions: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('ยกเลิก',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)),
                                              style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.red.shade700),
                                            ),
                                            OutlinedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _checkState = false;
                                                });
                                                var topichead =
                                                    _topichead.text.toString();
                                                var topicdetail = _topicdetail
                                                    .text
                                                    .toString();
                                                var tage =
                                                    _tage.text.toString();

                                                await topicCollection
                                                    .doc(topic.id)
                                                    .update({
                                                  "topichead": topichead,
                                                  "topicdetail": topicdetail,
                                                  "tage": tage,
                                                }).then((value) {
                                                  setState(() {
                                                    _checkState = true;
                                                  });
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "แก้ไขข้อมูลสำเร็จ"),
                                                    backgroundColor:
                                                        Colors.green,
                                                  )); // callbackFunction
                                                });
                                              },
                                              child: (_checkState)
                                                  ? Text(
                                                      'แก้ไข',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    )
                                                  : SizedBox(
                                                      width: 16,
                                                      height: 16,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 1.5,
                                                      ),
                                                    ),
                                              style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.purple[800]),
                                            ),
                                          ],
                                          //หน้าต่างสีเทา
                                          title: Text("แก้ไขข้อมูล"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize
                                                .min, //ขนาดเท่ากับฟอร์ม
                                            children: [
                                              TextField(
                                                controller: _topichead,
                                                decoration: InputDecoration(
                                                  icon: Icon(
                                                      Icons.question_answer,
                                                      color:
                                                          Colors.purple[800]),
                                                  labelText:
                                                      "ระบุคำถามของคุณ ?",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                controller: _topicdetail,
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.text_snippet,
                                                      color:
                                                          Colors.purple[800]),
                                                  labelText:
                                                      "เขียนรายละเอียดของคำถาม",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 50,
                                                          horizontal:
                                                              20), // กำหนดขนาดพื้นที่รอบข้อความ
                                                  helperText:
                                                      "* พิมพ์ข้อความได้ไม่เกิน 10,000 ตัวอักษร (0 / 10000) ",
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                controller: _tage,
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.tag,
                                                      color:
                                                          Colors.purple[800]),
                                                  suffixIcon: Icon(
                                                      Icons.arrow_drop_down),
                                                  labelText:
                                                      "เลือกแท็กที่เกี่ยวข้องกับกระทู้",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                ),
                                                onTap: () {
                                                  _showDropdown(context);
                                                },
                                                readOnly: true,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.purple[800],
                              )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function())
                                              setState) {
                                        return AlertDialog(
                                          title: Text("คุณต้องการลบหรือไม่ ?"),
                                          content: Text(" "),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "ยกเลิก",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                            TextButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _checkState = false;
                                                  });
                                                  await topicCollection
                                                      .doc(topic.id)
                                                      .delete()
                                                      .then((value) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "ลบข้อมูลสำเร็จ"),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ));
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: (_checkState)
                                                    ? Text(
                                                        "ยืนยัน",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                    : SizedBox(
                                                        width: 16,
                                                        height: 16,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 1.5,
                                                        ),
                                                      )),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เลือกแท็กที่เกี่ยวข้องกับกระทู้'),
          content: DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                _tage.text = newValue; // Update text field value
              });
              Navigator.of(context).pop();
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
