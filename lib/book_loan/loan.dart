import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bookriendly'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController libraryController = new TextEditingController();
  DateTime _selectedDate = DateTime(2022);
  DateTime _selectedDate1 = DateTime(2022);
  var _selectedTime;
  // DateTime formattedDate = DateFormat('yyyy-MM-dd').format('$_selectedDate');

// String convertedDateTime = "${_selectedDate.year.toString()}-${_selectedDate.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString()}-${now.minute.toString()}";
  @override
  Widget build(BuildContext context) {
    // DateFormat.yMMMd().format(_selectedDate)

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
        title: Text(widget.title),
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
              const Text(
                '책 제목',
                style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    '도서관명',
                    style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  libraryField(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    '대여일',
                    style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                  Text(
                    '$_selectedDate',
                    // formattedDate,
                    // 'd',
                    style: TextStyle(fontSize: 20),
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
                      // selectedDate.then((dateTime) {
                      //   Fluttertoast.showToast(
                      //     msg: dateTime.toString(),
                      //     toastLength: Toast.LENGTH_LONG,
                      //   );
                      //   setState(() {
                      //     _selectedDate = dateTime!;
                      //     // '${dateTime!.year}-${dateTime.month}-${dateTime.day}'
                      //     //     as DateTime;
                      //   });
                      // });
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
                    style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Text(
                    '$_selectedDate1',
                    // formattedDate,
                    // 'd',
                    style: TextStyle(fontSize: 20),
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
                      // selectedDate1.then((dateTime) {
                      //   Fluttertoast.showToast(
                      //     msg: dateTime.toString(),
                      //     toastLength: Toast.LENGTH_LONG,
                      //   );
                      //   setState(() {
                      //     _selectedDate1 = dateTime!;
                      //   });
                      // });
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
                    style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
                  ),
                  SizedBox(
                    width: 245,
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
                      style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
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
                  onPressed: () {},
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
