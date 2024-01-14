import 'package:flutter/material.dart';
import 'package:sharing_world2/features/auth/screens/signin.dart';
import 'package:sharing_world2/features/auth/screens/signup.dart';
import 'package:sharing_world2/common/widgets/custom_button.dart';
import 'package:sharing_world2/common/widgets/custom_button3.dart';

class Onboarding extends StatefulWidget {
  static const String routeName = '/onboarding';
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}
class _OnboardingState extends State<Onboarding> {

  double getRelativeWidth(double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100;
  }

  double getRelativeHeight(double percentage) {
    return MediaQuery.of(context).size.height * percentage / 100;
  }


  _login1() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen1())
    );
  }
  _login2() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen2())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              height: getRelativeHeight(12),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Text(
                '우리 모두의',
                style: TextStyle(
                  fontFamily: 'Nanum Round',
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: Color(0xFFA6E247),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
              child: Text(
                '대여세상',
                style: TextStyle(
                  fontFamily: 'Nanum Round',
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  color: Color(0xFFA6E247),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 10),
              child: Text(
                '원하는 물건을 쉽게 대여해보세요',
                style: TextStyle(
                  fontFamily: 'Nanum Round',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFFAAAAAA),
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                ),
              ),
            ),
          ),
          Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/share.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: CustomButton(
                text: '로그인',
                onTap: _login1,
              ),
            ),
          ),
          SizedBox(
            height: getRelativeHeight(1),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFA6E247),  // 테두리 색상
                  width: 0.5,            // 테두리 두께
                ),
              ),
              child: CustomButton3(
                text: '회원가입',
                onTap: _login1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}