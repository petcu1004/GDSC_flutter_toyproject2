import 'dart:convert' as convert;
import 'package:flutter_toy2/model/ev.dart';
// import 'package:flutter_toy2/src/model/ev.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class EvRepository {
  Future<List<Ev>?> loadEvs() async {
    // var addr = "서울";
    String baseUrl =
        "http://openapi.seoul.go.kr:8088/6f554567436d73773636757171684a/xml/TnFcltySttusInfo10073/1/20/";
    final response = await http.get(Uri.parse(baseUrl));

    // 정상적으로 데이터를 불러왔다면
    if (response.statusCode == 200) {
      // 데이터 가져오기
      final body = convert.utf8.decode(response.bodyBytes);

      // xml => json으로 변환(json형식인 경우 바꿔줄 필요 없음)
      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      // 필요한 데이터 찾기
      Map<String, dynamic> jsonResult = convert.json.decode(json);
      final jsonEv = jsonResult['TnFcltySttusInfo10073'];

      // 필요한 데이터 그룹이 있다면
      if (jsonEv['row'] != null) {
        // map을 통해 데이터를 전달하기 위해 객체인 List로 만든다.
        List<dynamic> list = jsonEv['row'];

        // map을 통해 Ev형태로 item을  => Ev.fromJson으로 전달
        return list.map<Ev>((row) => Ev.fromJson(row)).toList();
      }
    }
  }
}
