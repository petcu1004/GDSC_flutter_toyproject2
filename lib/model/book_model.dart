import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String bookname;
  final String library;
  var borrowDate;
  var returnDate;
  bool check;
  final DocumentReference reference;

  //모델 작성
  Book.fromMap(Map<String, dynamic> map, {required this.reference})
      : bookname = map['bookname'],
        library = map['library'],
        borrowDate = map['borrowDate'],
        returnDate = map['returnDate'],
        check = map['check'];

  Book.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap((snapshot.data() as Map<String, dynamic>),
            reference: snapshot.reference);

  @override
  String toString() => "Book<$bookname:$borrowDate>";
}
