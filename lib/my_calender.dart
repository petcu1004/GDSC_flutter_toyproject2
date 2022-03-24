import 'package:flutter/material.dart';
import 'mypage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //flutter 코어 엔진 초기화
  await Firebase.initializeApp(); //파이어베이스 초기화
  runApp(MyCalendar());
}

class MyCalendar extends StatefulWidget {
  //const MyCalendar({ Key? key }) : super(key: key);

  // 불러오기가 되었는지 확인
  bool isLoading = false;

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // Event
  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  // Events selected on tap
  void _OnDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  // Events selected on tap
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Bookriendly',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              //   Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => MyPage()));
            },
            icon: const Icon(Icons.arrow_back)), // 홈으로 가기 버튼
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25),
                  width: 200,
                  height: 50,
                  child: Text(
                    '나의 대출 목록',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  // 달력
                  child: TableCalendar<Event>(
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(2022, 1, 1),
                    lastDay: DateTime(2022, 12, 31),
                    //locale: 'ko-KR',

                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },

                    // 캘린더바 스타일
                    daysOfWeekHeight: 30,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),

                    // 캘린더 스타일
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      todayDecoration: BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                    ),

                    // 이벤트
                    onDaySelected: _onDaySelected,
                    eventLoader: (day) {
                      return _getEventsForDay(day);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // 책 제목과 반납일
                Container(
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Color.fromARGB(255, 218, 218, 218), width: 2),
                  ),
                  // 리스트
                  child: Container(
                      padding: EdgeInsets.all(10),
                      // 대출한 책 목록 가져오기
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('borrow_list')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];
                                  print(snapshot.data!.docs.length);
                                  String borrowDate =
                                      documentSnapshot['borrowDate'];
                                  String returnDate =
                                      documentSnapshot['returnDate'];
                                  return Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Text(
                                          documentSnapshot['bookname'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text('대출일: ' +
                                            documentSnapshot['borrowDate'] +
                                            "\t\t\t반납일: " +
                                            documentSnapshot['returnDate']),
                                      ));
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          })),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
