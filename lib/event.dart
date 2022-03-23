import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}

// 모델 생성 (DB에서 불러오기)
Map<DateTime, dynamic> eventSource = {
  DateTime(22,3,22) : [Event('book1', true)],
  DateTime(22,3,29) : [Event('book1', true)],

  // DateTime('${borrowDate}') : [Event(documentSnapshot['bookname'], true)],
  // DateTime(documentSnapshot['returnDate']) : [Event(documentSnapshot['bookname'], true)],
};

// Map 객체를 LinkedHashMap 객체로 변형
final events =  LinkedHashMap(
  equals: isSameDay, // isSameDay 함수 실행으로 equal 여부를 판단하도록 사용자를 정의
)..addAll(eventSource); // 객체 생성과 동시에 addAll 메소드 실행