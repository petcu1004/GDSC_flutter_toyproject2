import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'book_loan/loan.dart';
import 'rent_list.dart';
import 'return_screen.dart';
import 'search_bar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //search bar
            Container(
              padding: const EdgeInsets.all(10),
              child: SearchBar(),
            ),

            //반납리스트
            Container(
              height: 250,
              padding: const EdgeInsets.all(15),
              child: RentList(),
            ),

            //대출하기 버튼
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: Text('대출하기', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 0.0,
                  minimumSize: Size(100, 40),
                ),
                onPressed: () {
                  // CupertinoTabView(
                  //   builder: (context) {
                  //     return CupertinoPageScaffold(child: RentScreen());
                  //   },
                  // );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => loan()));
                },
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: Text('반납하기', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 0.0,
                  minimumSize: Size(100, 40),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReturnScreen(
                                bookname: '테스트 2',
                              )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
