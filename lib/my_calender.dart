import 'package:flutter/material.dart';
import 'mypage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({ Key? key }) : super(key: key);

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
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
        backgroundColor: Color.fromARGB(255, 165, 157, 192),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Home()
            )
          );
        }, 
        icon: const Icon(Icons.arrow_back)), // 홈으로 가기 버튼
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 200,
              height: 50,
              child: Text(
                '나의 대출 목록',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TableCalendar<Event>(
                onDaySelected: _OnDaySelected,
                focusedDay: DateTime.now(),
                firstDay: DateTime(2022,1,1),
                lastDay: DateTime(2022,12,31),
                //locale: 'ko-KR',
                daysOfWeekHeight: 30,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                ),
                eventLoader: (day) {
                  return _getEventsForDay(day);
                },
              ),
            ),
          ],
        ), 
      ),
    );
  }
}