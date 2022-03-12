import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'signup.dart';
import 'mypage.dart';
import 'main.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: TabPage(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

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
    return WillPopScope( // 페이지 뒤로가기 방지
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // 이메일 텍스트 필드
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 75, 25, 0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        // 이메일 입력 방식
                        if (value!.isEmpty || !RegExp(r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                          return ("잘못된 이메일 형식입니다.");
                        }
                      },
                      textInputAction: TextInputAction.next, // 엔터치면 다음 위젯으로 이동
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // 비밀번호 텍스트 필드
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
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
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
            // 회원가입 페이지 이동 버튼
            Container(
              margin: EdgeInsets.only(top: 40),
              child: TextButton(
                child: Text('회원가입'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                },
              ),
            ),
            // 로그인 버튼
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {signIn(emailController.text, pwController.text);},
                child: Text("로그인"),
                style: ElevatedButton.styleFrom(primary: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
  // 로그인 시도하기
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home())); // 홈으로
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}