import 'package:flutter/material.dart';
import 'model/book_model.dart';
import 'ui/return_screen.dart';

class Detail extends StatefulWidget {
  final Book book;
  Detail({required this.book});
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Container(
        height: 100,
        width: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black12, width: 3)),
        child: ListView(children: [
          Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                widget.book.bookname,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.book.borrowDate),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 0.0,
                  minimumSize: Size(60, 40),
                ),
                onPressed: () {
                  print(widget.book.bookname);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReturnScreen(
                      bookname: widget.book.bookname,
                    ),
                  ));
                },
                child: Text(
                  '반납',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
