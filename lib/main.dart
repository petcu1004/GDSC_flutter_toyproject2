import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_toy2/provider/ev_provider.dart';
// import 'package:flutter_toy2/ui/map.dart';
import 'package:provider/provider.dart';
import 'login.dart';
// import 'my_calender.dart';

// 비동기
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 바인딩
  await Firebase.initializeApp(); // 비동기 함수
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bookriendly',
        debugShowCheckedModeBanner: false,
        routes: {
          // '/second': (context) => MyCalendar(),
        },
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: MultiProvider(
          // ChangeNotifierProvider 통해 변화에 대해 구독
          providers: [
            ChangeNotifierProvider(
                create: (BuildContext context) => EvProvider())
          ],
          child: Login(), // 로그인 페이지로
        ));
    // Login(),
    // );
  }

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       // MultiProvider를 통해 여러가지 Provider를 관리
  //       home: MultiProvider(
  //         // ChangeNotifierProvider 통해 변화에 대해 구독
  //         providers: [
  //           ChangeNotifierProvider(
  //               create: (BuildContext context) => EvProvider())
  //         ],
  //         child: MapWidget(), // home.dart
  //       ));
  // }
}
