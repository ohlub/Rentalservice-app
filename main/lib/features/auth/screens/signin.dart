import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/custom_button.dart';
import 'package:sharing_world2/common/widgets/custom_textfield.dart';
import 'package:sharing_world2/common/widgets/custom_textfield2.dart';
import 'package:sharing_world2/features/auth/services/auth_service.dart';
import 'package:sharing_world2/features/auth/screens/signup.dart';

class AuthScreen1 extends StatefulWidget {
  static const String routeName = '/auth-screen1';
  const AuthScreen1({Key? key}) : super(key: key);

  @override
  State<AuthScreen1> createState() => _AuthScreenState1();
}

class _AuthScreenState1 extends State<AuthScreen1> {
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    _emailController.clear();
    _passwordController.clear();
  }

  _login2() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen2())
    );
  }

  double getRelativeWidth(double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100;
  }

  double getRelativeHeight(double percentage) {
    return MediaQuery.of(context).size.height * percentage / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff3f4f8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: getRelativeHeight(23),
          ),
          Row(
            children: [
              SizedBox(
                width: getRelativeWidth(30),
              ),
              Container(
                child: Text(
                  '반갑습니다!',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 32,
                    color: Color(0xffa6e247),
                    letterSpacing: 1.0655999755859376,
                    fontWeight: FontWeight.w800,
                  ),
                  textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
              ),
            ],
          ),
          Container(
            child: SizedBox(
              width: getRelativeWidth(100), //
              height: 240,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _signInFormKey,
                  child: ListView(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hintText: '아이디',
                      ),
                      const SizedBox(height: 12),
                      CustomTextField2(
                        controller: _passwordController,
                        hintText: '비밀번호',
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: '로그인',
                        onTap: () {
                          if (_signInFormKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
                            signInUser();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: getRelativeWidth(8),
              ),
              Container(
                  child: TextButton(
                    onPressed: _login2,
                    child: const Text(
                        '아이디 찾기',
                        style: TextStyle(
                          fontFamily: 'Nanum Round',
                          fontSize: 10,
                          color: Color(0x99000000),
                          letterSpacing: 0.3329999923706055,
                          fontWeight: FontWeight.w700,
                          height: 0.8,
                        )
                    ),
                  )
              ),
              SizedBox(
                width: getRelativeWidth(8),
              ),
              Container( height:20,
                width:2.0,
                color:const Color(0xffE0E0E0),
              ),
              SizedBox(
                width: getRelativeWidth(8),
              ),
              Container(
                  child: TextButton(
                    onPressed: _login2,
                    child: const Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          fontFamily: 'Nanum Round',
                          fontSize: 10,
                          color: Color(0x99000000),
                          letterSpacing: 0.3329999923706055,
                          fontWeight: FontWeight.w700,
                          height: 0.8,
                        )
                    ),
                  )
              ),
              SizedBox(
                width: getRelativeWidth(8),
              ),
              Container( height:20,
                width:2.0,
                color:const Color(0xffE0E0E0),
              ),
              SizedBox(
                width: getRelativeWidth(7),
              ),
              Container(
                  child: TextButton(
                    onPressed: _login2,
                    child: const Text(
                        '회원가입',
                        style: TextStyle(
                          fontFamily: 'Nanum Round',
                          fontSize: 10,
                          color: Color(0x99000000),
                          letterSpacing: 0.3329999923706055,
                          fontWeight: FontWeight.w700,
                          height: 0.8,
                        )
                    ),
                  )
              ),
            ],
          ),
          SizedBox(
            height: getRelativeHeight(3),
          ),
          Row(
            children: [
              SizedBox(
                width: getRelativeWidth(5),
              ),
              Container( height:2,
                width:80,
                color:const Color(0xffD0D0D0),
              ),
              SizedBox(
                width: getRelativeWidth(10),
              ),
              Container(
                child: Text(
                  'SNS 계정으로 로그인',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 12,
                    color: Color(0x99000000),
                    letterSpacing: 0.3995999908447266,
                    fontWeight: FontWeight.w700,
                    height: 0.6666666666666666,
                  ),
                  textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
              ),
              SizedBox(
                width: getRelativeWidth(10),
              ),
              Container( height:2,
                width:80,
                color:const Color(0xffD0D0D0),
              ),
            ],
          ),
          SizedBox(
            height: getRelativeHeight(3),
          ),
          Row(
            children: [
              SizedBox(
                width: getRelativeWidth(13),
              ),
              Image.asset(
                'assets/images/naver_img.png',
                width: 70,
              ),
              Image.asset(
                'assets/images/kakao_img.png',
                width: 70,
              ),
              Image.asset(
                'assets/images/google_img.png',
                width: 70,
              ),
              Image.asset(
                'assets/images/apple_img.png',
                width: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}