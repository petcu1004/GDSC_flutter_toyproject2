//대출 화면
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class BorrowList {
  String bookname;
  String library;
  var borrowDate;
  var returnDate;
  bool check;

  BorrowList(
      {required this.bookname,
      required this.library,
      required this.borrowDate,
      required this.returnDate,
      required this.check});

  //모델 작성
  BorrowList.fromJson(Map<String, dynamic> json)
      : bookname = json['bookname'],
        library = json['library'],
        borrowDate = json['borrowDate'],
        returnDate = json['retgiurnDate'],
        check = json['check'];
  Map<String, dynamic> toJson() => {
        'bookname': bookname,
        'library': library,
        'borrowDate': borrowDate,
        'returnDate': returnDate,
        'check': check,
      };
}

class loan extends StatefulWidget {
  _loanState createState() => _loanState();
}

class _loanState extends State<loan> {
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController booknameController = new TextEditingController();
  final TextEditingController libraryController = new TextEditingController();
  DateTime _selectedDate = DateTime(2022);
  DateTime _selectedDate1 = DateTime(2022);
  var _selectedTime;
  // DateTime formattedDate = DateFormat('yyyy-MM-dd').format('$_selectedDate');

// String convertedDateTime = "${_selectedDate.year.toString()}-${_selectedDate.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString()}-${now.minute.toString()}";
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    // DateFormat.yMMMd().format(_selectedDate)
    Widget bookNameField() {
      return Expanded(
        child: TextFormField(
          autofocus: false,
          controller: booknameController,
          onSaved: (value) {
            libraryController.text = value!;
          },
        ),
      );
    }

    Widget libraryField() {
      return Expanded(
        child: TextFormField(
          autofocus: false,
          controller: libraryController,
          onSaved: (value) {
            libraryController.text = value!;
          },
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Bookriendly'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              const Text(
                '대출 정보 입력',
                style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    '도서 이름',
                    style: TextStyle(
                        fontSize: 25.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  bookNameField(),
                ],
              ),
              Row(
                children: [
                  const Text(
                    '도서관명',
                    style: TextStyle(fontSize: 15.0, letterSpacing: 1.0),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  libraryField(),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Text(
                    '대여일',
                    style: TextStyle(fontSize: 15.0, letterSpacing: 1.0),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$_selectedDate',
                    // formattedDate,
                    // 'd',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      Future<DateTime?> selectedDate = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), // 초깃값
                        firstDate: DateTime(2020), // 시작일
                        lastDate: DateTime(2030), // 마지막일
                      );
                      selectedDate.then((dateTime) {
                        Fluttertoast.showToast(
                          msg: dateTime.toString(),
                          toastLength: Toast.LENGTH_LONG,
                        );
                        setState(() {
                          _selectedDate = dateTime!;
                          // '${dateTime!.year}-${dateTime.month}-${dateTime.day}'
                          //     as DateTime;
                        });
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '반납일',
                    style: TextStyle(fontSize: 15.0, letterSpacing: 1.0),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$_selectedDate1',
                    // formattedDate,
                    // 'd',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      Future<DateTime?> selectedDate1 = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), // 초깃값
                        firstDate: DateTime(2020), // 시작일
                        lastDate: DateTime(2030), // 마지막일
                      );
                      selectedDate1.then((dateTime) {
                        Fluttertoast.showToast(
                          msg: dateTime.toString(),
                          toastLength: Toast.LENGTH_LONG,
                        );
                        setState(() {
                          _selectedDate1 = dateTime!;
                        });
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '알림 여부',
                    style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                  ),
                  SizedBox(
                    width: 195,
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                        shape: CircleBorder(),
                        tristate: false,
                        splashRadius: 30,
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              // ignore: unnecessary_new
              new Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.0))),
                child: Column(
                  children: <Widget>[
                    const Text(
                      '알람시간',
                      style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // MainAxisAlignment.c,
                        Text(
                          '$_selectedTime',
                          // formattedDate,
                          // 'd',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            Future<TimeOfDay?> selectedTime = showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            // selectedTime.then((timeOfDay) {
                            //   Fluttertoast.showToast(
                            //       msg: timeOfDay.toString(),
                            //       toastLength: Toast.LENGTH_LONG);
                            // });
                            selectedTime.then((time) {
                              setState(() {
                                _selectedTime = '${time!.hour}:${time.minute}';
                              });
                            });
                          },
                          icon: Icon(Icons.alarm),
                          iconSize: 30.0,
                        )
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    //클래스 객체 이용해, 파이어베이스에 들어갈 정보 저장
                    BorrowList _rent = BorrowList(
                        bookname: booknameController.text,
                        library: libraryController.text,
                        borrowDate: '$_selectedDate',
                        returnDate: '$_selectedDate1',
                        check: false);
                    //체크용
                    print(_rent);
                    //파이어 베이스에 넣어주기
                    FirebaseFirestore.instance
                        .collection('borrow_list')
                        .doc(_rent.bookname)
                        .set(_rent.toJson());
                    print(_rent);
                  },
                  child: Text(
                    '완료',
                    style: TextStyle(fontSize: 35),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
