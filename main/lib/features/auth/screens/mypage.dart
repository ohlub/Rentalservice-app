import 'package:flutter/material.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';
import 'package:sharing_world2/features/auth/screens/myproduct.dart';
import 'package:sharing_world2/features/auth/screens/mycart.dart';
import 'package:sharing_world2/features/auth/screens/mydeal.dart';
import 'package:sharing_world2/features/account/services/account_services.dart';
import 'package:sharing_world2/features/account/widgets/account_button.dart';

class MyPageScreen extends StatefulWidget {
  static const String routeName = '/mypage';
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}


class _MyPageScreenState extends State<MyPageScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: const Alignment(-0.93, 0.2),
                  height: 50,
                  child: const Text(
                    '마이페이지',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                      height: 0.25,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 15, 20),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 80,
                    color: Color(0xffC0C0C0),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.name + ' 님',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 15,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        height: 0.25,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          '내 정보 관리',
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 11,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 80,
              width: 330,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFFD0D0D0),
                    width: 1.5,
                ),
                borderRadius:  BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 10, 25),
                        child: Text(
                          '내 마일리지',
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 16,
                            color: Color(0xff484848),
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 40, 10, 0),
                        child: Text(
                          '0 M',
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 55,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    borderRadius:  BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.fromLTRB(3, 0, 3, 3),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MyDeal()
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xff545454),
                      size: 35,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    borderRadius:  BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.fromLTRB(4, 0, 3, 3),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyProduct()
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.description_outlined,
                      color: Color(0xff545454),
                      size: 35,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    borderRadius:  BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MyCart()
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: Color(0xff545454),
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 61,
                ),
                Text(
                  '구매내역',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 12,
                    color: Color(0xff545454),
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
                SizedBox(
                  width: 71,
                ),
                Text(
                  '판매내역',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 12,
                    color: Color(0xff545454),
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
                SizedBox(
                  width: 75,
                ),
                Text(
                  '나의 찜',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 12,
                    color: Color(0xff545454),
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height:4,
              width:550.0,
              color:const Color(0xffEEEEEE),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
                  child: Text(
                    '거래후기',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                  child: Container(
                    alignment: const Alignment(-3.0, 0.0),
                    child: IconButton(
                      icon: Icon(Icons.chevron_right, size: 35, color: Color(0xff545454)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
                  child: Text(
                    '친구초대',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                  child: Container(
                    alignment: const Alignment(-3.0, 0.0),
                    child: IconButton(
                      icon: Icon(Icons.chevron_right, size: 35, color: Color(0xff545454)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height:4,
              width:550.0,
              color:const Color(0xffEEEEEE),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
                  child: Text(
                    '이벤트',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                  child: Container(
                    alignment: const Alignment(-3.0, 0.0),
                    child: IconButton(
                      icon: Icon(Icons.chevron_right, size: 35, color: Color(0xff545454)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
                  child: Text(
                    '공지사항',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                  child: Container(
                    alignment: const Alignment(-3.0, 0.0),
                    child: IconButton(
                      icon: Icon(Icons.chevron_right, size: 35, color: Color(0xff545454)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                  child: Text(
                    '고객센터',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                  child: Container(
                    alignment: const Alignment(-3.0, 0.0),
                    child: IconButton(
                      icon: Icon(Icons.chevron_right, size: 35, color: Color(0xff545454)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                  child: Text(
                    '로그아웃',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                  child: Container(
                    alignment: const Alignment(-3.0, 0.0),
                    child: IconButton(
                      icon: Icon(Icons.chevron_right, size: 35, color: Color(0xff545454)),
                      onPressed: () {
                          AccountServices().logOut(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height:4,
              width:550.0,
              color:const Color(0xffEEEEEE),
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}