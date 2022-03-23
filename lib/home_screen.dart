import 'package:flutter/material.dart';
import 'package:flutter_toy2/book_loan/loan.dart';
import 'widget/loan_list.dart';
import 'widget/search_bar.dart';

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
              child: loanList(),
            ),

            // //대출하기 버튼
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => loan()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
