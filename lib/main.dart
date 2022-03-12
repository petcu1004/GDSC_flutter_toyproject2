import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'mypage.dart';

// 비동기
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookriendly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Login(), // 로그인 페이지로
    );
  }
}

class TabPage extends StatefulWidget {
  const TabPage({ Key? key }) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _selectedIndex = 0;
  List _pages = [Home(), Text('page2'), Text('page3')]; // 이동할 페이지

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Container(
        padding: EdgeInsets.all(20),
        child: _pages[_selectedIndex], // 페이지 연결
      ),
      bottomNavigationBar: BottomNavigationBar(
      // type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex, // 현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages)
          ),
        ],
      ),
    );
  }
}