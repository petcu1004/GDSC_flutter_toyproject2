import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'my_calender.dart';

// 비동기
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 바인딩
  await Firebase.initializeApp(); // 비동기 함수
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookriendly',
      debugShowCheckedModeBanner: false,
      routes: {
        '/second': (context) => MyCalendar(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: Login(), // 로그인 페이지로
    );
  }
}