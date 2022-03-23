//메인에 들어갈 대출 목록
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../ui/return_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //flutter 코어 엔진 초기화
  await Firebase.initializeApp(); //파이어베이스 초기화
  runApp(loanList());
}

class loanList extends StatefulWidget {
  //불러오기가 됐는지 확인
  bool isLoading = false;

  _loanListState createState() => _loanListState();
}

class _loanListState extends State<loanList> {
  //borrow_list 컬렉션 스냅샷
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black12, width: 3)),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('borrow_list')
                //check가 false인 경우만 보이도록 조건 추가
                //.where("check", isEqualTo: "false")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    // print(snapshot.data!.docs.length);
                    String borrowDate = documentSnapshot['borrowDate'];
                    String returnDate = documentSnapshot['returnDate'];
                    return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            documentSnapshot['bookname'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(documentSnapshot['borrowDate']),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              elevation: 0.0,
                              minimumSize: Size(60, 40),
                            ),
                            onPressed: () {
                              print(documentSnapshot['bookname']);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReturnScreen(
                                  bookname: documentSnapshot['bookname'],
                                ),
                              ));
                            },
                            child: Text(
                              '반납',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ));
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
