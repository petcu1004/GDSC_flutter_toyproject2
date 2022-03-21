//// 아직 이벤트 처리 못했어요!! ////

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  _SearchBarWidget createState() => _SearchBarWidget();
}

class _SearchBarWidget extends State<SearchBar> {
  final TextEditingController _filter = TextEditingController(); //검색 위젯 컨트롤
  FocusNode focusNode = FocusNode(); //현재 커서 위치
  String _searchText = ""; //검색어 저장

  _SearchBarState() {
    //필터에 변화가 있는 경우 내용 저장
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  // //스트립 데이터를 가져와 buildList 호출
  // Widget buildBody(BuildContext context){
  //   return StreamBuilder<QuerySnapshot>(builder: FireStore.instanse.collection''.snapshots(),
  //   builder:(context,snapshot){
  //     if(!snapshot.hasData) return LinearProgressIndicator();
  //     return _buildList(context,snapshot.data.documents);
  //   });
  // }

  // //검색 결과에 따라 데이터를 처리해 View 리스트 생성
  // Widget _buildList(BuildContext context,List<DocumentSnapshot>snapshot){
  //   List<DocumentSnapShot>ssearchResults=[];
  //   for(DocumentSnapShot d in snapshot){
  //     if(d.dage.toString{}.contains{_searchText}){
  //       searchResults.add(d);
  //     }
  //   }return Expanded(child: Column(children: searchResults.map((data)=>_buildListItem(context,data)),
  //   );
  // }

  // Widget _buildListItem(BuildContext context,DocumentSnapshot data){
  //   final book=Movie.fromSnapshot(data);
  //   return InkWell( child: Image.network(movie.poster),
  //   onTap: () {
  //     Navigator.of(context).push(MaterialPageRoute<Null>(
  //       fullscreenDialog: true,
  //       builder: (BuildContext context){
  //         return DetailScreen(movie:movie);
  //       }
  //       ));
  //   },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Container(
            color: Colors.white12,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(fontSize: 15),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      //앞에 붙는 아이콘
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                        size: 20,
                      ),
                      //뒤에 붙는 아이콘
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              icon: Icon(
                                Icons.cancel,
                                size: 20,
                              ),
                              onPressed: () {
                                _filter.clear();
                                _searchText = "";
                              },
                            )
                          : Container(),
                      hintText: '검색',
                      labelStyle: TextStyle(color: Colors.white),

                      //inputDecoration의 border를 모두 투명하게
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                //취소 버튼
                focusNode.hasFocus
                    ? Expanded(
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = "";
                              focusNode.unfocus();
                            });
                          },
                          child: Text(
                            '취소',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: Container(),
                      )
              ],
            ),
          ),
          //buildBody(context)
        ],
      ),
    );
  }
}
