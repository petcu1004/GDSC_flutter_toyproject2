import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  String name = "";
  String phone = "";
  String email = "";

  void readData() {
    Stream collectionStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    Stream documentStream = FirebaseFirestore.instance
        .collection('users')
        .doc('ABC123')
        .snapshots();

    final userCollectionReference = FirebaseFirestore.instance
        .collection("user")
        .doc('${FirebaseAuth.instance.currentUser!.uid}');
    userCollectionReference.get().then((ds) {
      name = ds.data()!['name'];
      email = ds.data()!['email'];
      phone = ds.data()!['phone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: _fetch1(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // data를 아직 받아오지 못했을 때 실행하는 부분
                    if (snapshot.hasData == false) {
                      return CircularProgressIndicator();
                    }
                    //error가 발생하게 될 경우 반환하게 되는 부분
                    else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }
                    // 데이터를 정상적으로 받아오는 경우
                    else {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30), // 텍스트 필드
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
                              child: Column(
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
                                        '${name}',
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
                                        '${phone}',
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
                                        '${email}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              )),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 177, 208, 201),
                                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                                textStyle: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/second');
                            },
                            child: const Text('나의 대출목록'),
                          ),
                        ],
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _fetch1() async {
    await Future.delayed(Duration(seconds: 2));
    return '';
  }
}
