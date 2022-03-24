//상단 앱바랑 하단 앱바가 중복돼서 지웠습니다

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'my_calender.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //flutter 코어 엔진 초기화
  await Firebase.initializeApp(); //파이어베이스 초기화
  runApp(MyPage());
}

class MyPage extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);

  // 불러오기가 되었는지 확인
  bool isLoading = false;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(children: <Widget>[
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: 70), // 텍스트 필드
                height: 100,
                width: 300,
                child: Text(
                  '내 정보',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                  // 정보 필드
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  padding: EdgeInsets.only(bottom: 50),
                  width: 350,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 237, 237, 237),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];
                                print(snapshot.data!.docs.length);
                                String name = documentSnapshot['name'];
                                String phone = documentSnapshot['phone'];
                                String email = documentSnapshot['email'];
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 30),
                                        height: 25,
                                        width: 100,
                                        child: Text(
                                          'Name',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 210,
                                        height: 40,
                                        color: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          documentSnapshot['name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 30),
                                        height: 25,
                                        width: 100,
                                        child: Text(
                                          'Phone',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 210,
                                        height: 40,
                                        color: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          documentSnapshot['phone'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 30),
                                        height: 25,
                                        width: 100,
                                        child: Text(
                                          'Email',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 210,
                                        height: 40,
                                        color: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          documentSnapshot['email'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                );
                              });
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCalendar()),
                  );
                },
                child: const Text('나의 대출목록'),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
