class Ev {
  String? CLTUR_EVENT_ETC_NM; // 도서관명
  String? ATDRC_NM; // 자치구명
  String? BASS_ADRES; // 기본주소
  String? DETAIL_ADRES; // 상세주소
  String? RNTFEE_FREE_AT; // 사용료 무료 여부
  String? GUIDANCE_URL; // 안내 URL
  String? X_CRDNT_VALUE; // 위도
  String? Y_CRDNT_VALUE; // 경도

  Ev({
    this.CLTUR_EVENT_ETC_NM,
    this.ATDRC_NM,
    this.BASS_ADRES,
    this.DETAIL_ADRES,
    this.RNTFEE_FREE_AT,
    this.GUIDANCE_URL,
    this.Y_CRDNT_VALUE,
    this.X_CRDNT_VALUE,
  });

  factory Ev.fromJson(Map<String, dynamic> json) {
// 안내 URL
    if (json["GUIDANCE_URL"] == null) {
      json["GUIDANCE_URL"] = "정보 없음";
    }

// 위도
    if (json["X_CRDNT_VALUE"] == null) {
      json["X_CRDNT_VALUE"] = "0";
    }

// 경도
    if (json["Y_CRDNT_VALUE"] == null) {
      json["Y_CRDNT_VALUE"] = "0";
    }
    // else if (json["cpStat"] == "2") {
    //   json["cpStat"] = "충전기 상태 : 충전중";
    // } else if (json["cpStat"] == "3") {
    //   json["cpStat"] = "충전기 상태 : 고장/정검";
    // } else if (json["cpStat"] == "4") {
    //   json["cpStat"] = "충전기 상태 : 통신장애";
    // } else if (json["cpStat"] == "5") {
    //   json["cpStat"] = "충전기 상태 : 통신미연결";
    // }

// // 충전 방식
//     if (json["cpTp"] == "1") {
//       json["cpTp"] = "충전 방식 : B타입(5핀)";
//     } else if (json["cpTp"] == "2") {
//       json["cpTp"] = "충전 방식 : C타입(5핀)";
//     } else if (json["cpTp"] == "3") {
//       json["cpTp"] = "충전 방식 : BC타입(5핀)";
//     } else if (json["cpTp"] == "4") {
//       json["cpTp"] = "충전 방식 : BC타입(5핀)";
//     } else if (json["cpTp"] == "5") {
//       json["cpTp"] = "충전 방식 : DC차데모";
//     } else if (json["cpTp"] == "6") {
//       json["cpTp"] = "충전 방식 : AC3상";
//     } else if (json["cpTp"] == "7") {
//       json["cpTp"] = "충전 방식 : DC콤보";
//     } else if (json["cpTp"] == "8") {
//       json["cpTp"] = "충전 방식 : DC차데모+DC콤보";
//     } else if (json["cpTp"] == "9") {
//       json["cpTp"] = "충전 방식 : DC차데모+AC3상";
//     } else if (json["cpTp"] == "10") {
//       json["cpTp"] = "충전 방식 : DC차데모+DC콤보+AC3상";
//     }

    return Ev(
      CLTUR_EVENT_ETC_NM: json["CLTUR_EVENT_ETC_NM"] as String,
      ATDRC_NM: json["ATDRC_NM"] as String,
      BASS_ADRES: json["BASS_ADRES"] as String,
      DETAIL_ADRES: json["DETAIL_ADRES"] as String,
      RNTFEE_FREE_AT: json["RNTFEE_FREE_AT"] as String,
      GUIDANCE_URL: json["GUIDANCE_URL"] as String,
      Y_CRDNT_VALUE: json["Y_CRDNT_VALUE"] as String,
      X_CRDNT_VALUE: json["X_CRDNT_VALUE"] as String,
    );
  }
}
