//반납 화면
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comment {
  String bookname;
  String emoji;
  String content;
  String recommand;

  Comment(
      {required this.bookname,
      required this.emoji,
      required this.content,
      required this.recommand});

  //모델 작성
  Comment.fromJson(Map<String, dynamic> json)
      : bookname = json['bookname'],
        emoji = json['emoji'],
        content = json['content'],
        recommand = json['recommand'];
  Map<String, dynamic> toJson() => {
        'bookname': bookname,
        'emoji': emoji,
        'content': content,
        'recommand': recommand,
      };
}

class ReturnScreen extends StatefulWidget {
  final String bookname;
  _ReturnScreenState createState() => _ReturnScreenState();
  ReturnScreen({Key? key, required this.bookname}) : super(key: key);
}

class _ReturnScreenState extends State<ReturnScreen> {
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('borrow_list');
  //Yes, No 버튼 누른 경우, 이벤트
  bool _yesTap = false;
  bool _noTap = false;
  _setYesTap() {
    setState(() {
      _yesTap = !_yesTap;
    });
  }

  _setNoTap() {
    setState(() {
      _noTap = !_noTap;
    });
  }

  //이모티콘 이벤트 수정 필요
  //이모티콘 누른 경우, 이벤트
  bool _check = false;

  _setcheck() {
    setState(() {
      _check = !_check;
    });
  }

  final _controller = TextEditingController();

  String emoji = ""; //이모티콘 선택
  String content = ""; //한줄 소감
  String recommand = ""; //추천여부

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.pink[200], elevation: 0.0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              widget.bookname,
              style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic),
            ),
          ),
          //이모티콘 선택
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: ButtonBar(
              alignment: MainAxisAlignment.center, //중앙 정렬
              buttonPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              children: [
                Ink(
                  decoration: BoxDecoration(
                    border: _check
                        ? Border.all(color: Colors.blue, width: 2.0)
                        : Border.all(color: Colors.black12, width: 2.0),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      emoji = "아주 좋음";
                      _setcheck();
                    },
                    icon: Icon(Icons.sentiment_very_satisfied),
                    color: Colors.pink[300],
                    iconSize: 50,
                    tooltip: '아주 좋음',
                  ),
                ),
                Ink(
                  decoration: BoxDecoration(
                    border: _check
                        ? Border.all(color: Colors.blue, width: 2.0)
                        : Border.all(color: Colors.black12, width: 2.0),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      emoji = "보통";
                      _setcheck();
                    },
                    icon: Icon(Icons.sentiment_satisfied),
                    color: Colors.pink[300],
                    iconSize: 50,
                    tooltip: '보통',
                  ),
                ),
                Ink(
                  decoration: BoxDecoration(
                    border: _check
                        ? Border.all(color: Colors.blue, width: 2.0)
                        : Border.all(color: Colors.black12, width: 2.0),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      emoji = "별로";
                      _setcheck();
                    },
                    icon: Icon(Icons.sentiment_very_dissatisfied_rounded),
                    color: Colors.pink[300],
                    iconSize: 50,
                    tooltip: '별로',
                  ),
                ),
              ],
            ),
          ),
          //한줄 소감
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
            child: TextField(
              controller: _controller,
              scrollPadding: EdgeInsets.all(20),
              autofocus: true,
              decoration: InputDecoration(
                hintText: '한줄 소감',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 2, color: Colors.pink),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 2, color: Colors.black12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              '다른 사람에게도 추천하나요?',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Yes 버튼
                ElevatedButton(
                  onPressed: () {
                    recommand = '추천';
                    if (_noTap != true) {
                      _setYesTap();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      side: _yesTap
                          ? BorderSide(color: Colors.white)
                          : BorderSide(color: Colors.black26, width: 3.0),
                      primary: _yesTap ? Colors.indigo[300] : Colors.white,
                      minimumSize: Size(150, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      elevation: 0.0),
                  child: Text(
                    'YES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _yesTap ? Colors.white : Colors.pink,
                        fontSize: 20),
                  ),
                ),
                //No 버튼
                ElevatedButton(
                  onPressed: () {
                    recommand = '비추천';
                    if (_yesTap != true) {
                      _setNoTap();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      side: _noTap
                          ? BorderSide(color: Colors.white)
                          : BorderSide(color: Colors.black26, width: 3.0),
                      primary: _noTap ? Colors.indigo[300] : Colors.white,
                      minimumSize: Size(150, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      elevation: 0.0),
                  child: Text(
                    'NO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _noTap ? Colors.white : Colors.pink,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          //반납 버튼
          Container(
            padding: EdgeInsets.only(bottom: 100),
            child: ElevatedButton(
              onPressed: () {
                content = _controller.text;
                //체크용
                print('이모티콘: ' + emoji);
                print('한 줄 소감: ' + content);
                print('추천 여부: ' + recommand);

                //comment 컬렉션에 리뷰 추가
                Comment _comment = Comment(
                    bookname: widget.bookname,
                    emoji: emoji,
                    content: content,
                    recommand: recommand);
                FirebaseFirestore.instance
                    .collection('comment')
                    .doc(widget.bookname)
                    .set(_comment.toJson());
                //borrow_list 컬렉션에 반납 여부(check) 변경 업데이트
                FirebaseFirestore.instance
                    .collection('borrow_list')
                    .doc(widget.bookname)
                    .update({'check': true});
              },
              child: Text(
                '반납하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  minimumSize: Size(200, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  elevation: 0.0),
            ),
          )
        ],
      ),
    );
  }

  mutableMapOf() {}
}
