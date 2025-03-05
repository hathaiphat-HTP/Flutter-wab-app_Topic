import 'package:chapter4_cloud_firestore/page/list_topic.dart';
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

class PostTopic extends StatefulWidget {
  const PostTopic({super.key});

  @override
  State<PostTopic> createState() => _PostTopic();
}

class _PostTopic extends State<PostTopic> {
  TextEditingController _topichead = TextEditingController(); //หัวข้อ
  TextEditingController _topicdetail = TextEditingController(); //รายละเอียดข้อความ
  TextEditingController _tage = TextEditingController(); //แท็กข้อความ

  String dropdownValue = list.first;

  //ส่วนเป็นการสร้าง Object studentCollection เป็นตัวแทนของ student
  CollectionReference topicCollection = FirebaseFirestore.instance.collection("topic");

  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ใส่รายละเอียดกระทู้",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Prompt',
                fontWeight: FontWeight.bold,
                color: Colors.purple[800])),
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
              icon: Icon(Icons.logout,color: Colors.purple[800],)),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _topichead,
              decoration: InputDecoration(
                icon: Icon(Icons.question_answer, color: Colors.purple[800]),
                labelText: "ระบุคำถามของคุณ ?",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _topicdetail,
              decoration: InputDecoration(
                icon: Icon(Icons.text_snippet, color: Colors.purple[800]),
                labelText: "เขียนรายละเอียดของคำถาม",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 20), // กำหนดขนาดพื้นที่รอบข้อความ
                helperText: "* พิมพ์ข้อความได้ไม่เกิน 10,000 ตัวอักษร (0 / 10000) ",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _tage,
              decoration: InputDecoration(
                icon: Icon(Icons.tag, color: Colors.purple[800]),
                suffixIcon: Icon(Icons.arrow_drop_down),
                labelText: "เลือกแท็กที่เกี่ยวข้องกับกระทู้",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              onTap: () {
                _showDropdown(context);
              },
              readOnly: true,
            ),
            SizedBox(height: 10,),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (_isChecked)
                        ? () async {
                      var topichead = _topichead.text.toString();
                      var topicdetail = _topicdetail.text.toString();
                      var tage = _tage.text.toString();

                      if (topichead.isEmpty ||
                          topicdetail.isEmpty ||
                          tage.isEmpty ) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                          content: Text("กรุณากรอกข้อมูลให้ครบ"),
                          backgroundColor: Colors.orange,
                        ));
                      } else {
                        setState(() {
                          _isChecked = false;
                        });

                        await topicCollection.add({
                          "topichead":topichead,
                          "topicdetail":topicdetail,
                          "tage": tage,
                        }).then((value) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text("บันทึกข้อมูลสำเร็จ"),
                            backgroundColor: Colors.purple,
                          )); // callbackFunction

                          _topichead.clear();
                          _topicdetail.clear();
                          _tage.clear();

                          setState(() {
                            _isChecked = true;
                          });
                        });
                      }
                    }
                        : null,
                    child: (_isChecked)
                        ? Text(
                      "ส่งกระทู้",
                      style: TextStyle(color: Colors.white),
                    )
                        : SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.purple),
                    )))

          ],
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


