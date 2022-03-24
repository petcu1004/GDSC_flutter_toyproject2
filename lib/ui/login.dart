import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_toy2/ui/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'signup.dart';
import 'mypage.dart';
import '../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final pwController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 페이지 뒤로가기 방지
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드 오버플로우 방지
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                width: 200,
                height: 50,
                child: Text(
                  '"Bookriendly"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 35,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 200,
                height: 40,
                child: Text('로그인',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Container(
                  // 배경
                  width: 350,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // 이메일 텍스트 필드
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 50, 25, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            // 이메일 입력 방식
                            if (value!.isEmpty ||
                                !RegExp(r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return ("잘못된 이메일 형식입니다.");
                            }
                          },
                          textInputAction:
                              TextInputAction.next, // 엔터치면 다음 위젯으로 이동
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      // 비밀번호 텍스트 필드
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          autofocus: false, // 자동으로 텍스트 필드가 선택되는 것을 막음
                          controller: pwController,
                          obscureText: true, // 비밀번호가 ...으로 표시되도록 함
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (!regex.hasMatch(value!)) {
                              return ("최소 6자리 이상의 비밀번호가 필요합니다.");
                            }
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.vpn_key),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
              // 회원가입 페이지 이동 버튼
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextButton(
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
              ),
              // 로그인 버튼
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    signIn(emailController.text, pwController.text);
                  },
                  child: Text("로그인",
                      style: TextStyle(fontSize: 23, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    elevation: 0.0,
                    minimumSize: Size(150, 50),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 로그인 시도하기
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home())); // 홈으로
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
