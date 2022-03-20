import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 15);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'index 0: Home',
      style: optionStyle,
    ),
    Text(
      'index 1: Library',
      style: optionStyle,
    ),
    Text(
      'My Page',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                icon: Icon(Icons.exit_to_app))
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
          backgroundColor: Color.fromARGB(255, 165, 157, 192),
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back)), // 홈으로 가기 버튼
        ),

        // bottomNavigaionBar

        body: Center(
          child: Column(
            children: [
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
                    textStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pushNamed('/second');
                },
                child: const Text('나의 대출목록'),
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[300],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'My Page',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
