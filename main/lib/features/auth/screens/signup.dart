import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/custom_button.dart';
import 'package:sharing_world2/common/widgets/custom_textfield.dart';
import 'package:sharing_world2/common/widgets/custom_textfield2.dart';
import 'package:sharing_world2/features/auth/services/auth_service.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharing_world2/features/auth/screens/signin.dart';
import 'package:sharing_world2/constants/utils.dart';


class AuthScreen2 extends StatefulWidget {
  static const String routeName = '/auth-screen2';
  const AuthScreen2({Key? key}) : super(key: key);

  @override
  State<AuthScreen2> createState() => _AuthScreenState2();
}

class _AuthScreenState2 extends State<AuthScreen2> {
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _passwordCheckController.dispose();
  }

  void signUpUser() {
    if(_nameController.text.length > 2 && _nameController.text.length < 6){
      if(_passwordController.text.length > 4 && _passwordController.text.length < 16 ){
        if(_passwordController.text == _passwordCheckController.text){
          authService.signUpUser(
            context: context,
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
            region: '안양5동',
          );
          _emailController.clear();
          _passwordController.clear();
          _nameController.clear();
          _passwordCheckController.clear();
        } else {
          showSnackBar(context, '비밀번호를 확인해주세요.');
        }
      } else {
        showSnackBar(context, '비밀번호를 4자리 이상 16자리 이하로 입력해주세요.');
      }
    } else {
      showSnackBar(context, '이름을 2자리 이상 4자리 이하로 입력해주세요.');
    }
  }

  _login1() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen1())
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
            height: getRelativeHeight(20),
          ),
          Row(
            children: [
              SizedBox(
                width: getRelativeWidth(30),
              ),
              Container(
                child: Text(
                  '환영합니다!',
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
              height: getRelativeHeight(46),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _signUpFormKey,
                  child: ListView(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: '이름',
                      ),
                      const SizedBox(height: 12),
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
                      CustomTextField2(
                        controller: _passwordCheckController,
                        hintText: '비밀번호 확인',
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: '회원가입',
                        onTap: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
                            signUpUser();
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    onPressed: _login1,
                    child: const Text(
                        '로그인',
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