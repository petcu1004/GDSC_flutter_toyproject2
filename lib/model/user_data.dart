class UserData {
  String? email;
  String? name;
  String? phone;

  UserData({this.email, this.name, this.phone}); // 생성자?

  // userdata값을 맵 형태로 바꿔 리턴시켜준다.
  Map<String, dynamic> toMap() {
    return {
      'email' : email, // test.gmail.com
      'name' : name, // name: hyunjin
      'phone' : phone, // phone: 01012345678
    };
  }
}