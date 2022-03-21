import 'package:flutter/material.dart';
import 'package:flutter_toy2/provider/ev_provider.dart';
// import 'package:flutter_toy2/src/provider/ev_provider.dart';
// import 'package:flutter_toy2/src/map/map_marker.dart';
// import 'package:flutter_toy2/src/ui/map.dart';
import 'package:flutter_toy2/ui/map.dart';
import 'package:provider/provider.dart';

class Home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // MultiProvider를 통해 여러가지 Provider를 관리
        home: MultiProvider(

            // ChangeNotifierProvider 통해 변화에 대해 구독
            providers: [
              ChangeNotifierProvider(
                  create: (BuildContext context) => EvProvider())
            ], child: MapWidget() // home.dart
            ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: MapWidget(),
  //   );
  // }
}
