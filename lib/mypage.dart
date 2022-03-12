import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// 비동기 처리 어떻게...?
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //runApp(Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String name = "";
  String phone = "";
  String email = "";

  void readData() {

    Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
    Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();

    final userCollectionReference = FirebaseFirestore.instance.collection("user").doc('${FirebaseAuth.instance.currentUser!.uid}');
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
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            //로그아웃 버튼
            IconButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                },
                icon: Icon(Icons.exit_to_app)
            )
          ],
          title: Text(
            'Bookriendly',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 25.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)), // 홈으로 가기 버튼
        ),
        
        // bottomNavigaionBar

        body: Center( 
          child: Column(
            children: [
              Container (
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
              
              Container( // 정보 필드
                margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                padding: EdgeInsets.only(bottom: 50),
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 217, 91),
                  borderRadius: BorderRadius.circular(30), 
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ), 
                    Row(
                      children: [   
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
                      ]
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      children: [   
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
                      ]
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      children: [   
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
                      ]
                    ),
                  ],
                )
              ),

              Container ( // 대출 목록
                height: 70,
                width: 350,           
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 217, 91),
                  borderRadius: BorderRadius.circular(20), 
                ),
                child: Text(
                  '나의 대출 목록',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}