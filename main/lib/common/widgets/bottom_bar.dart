import 'package:flutter/material.dart';
import 'package:sharing_world2/screens/login.dart';
import 'package:sharing_world2/features/home/screens/cart2_screen.dart';
import 'package:sharing_world2/features/home/screens/home_screen2.dart';
import 'package:sharing_world2/features/account/screens/top_categories.dart';
import 'package:sharing_world2/features/auth/screens/mypage.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [];
  String address = '안양5동';

  @override
  void initState() {
    super.initState();
    pages = [
      const HomeScreen2(),
      const TopCategories(),
      const LoginScreen(),
      const Cart2Screen(),
      const MyPageScreen(),
    ];

  }

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[_page],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: Colors.green), // 선택된 아이콘 스타일
        unselectedIconTheme: const IconThemeData(color: Colors.grey), // 선택되지 않은 아이콘 스타일
        selectedLabelStyle:
        const TextStyle(fontSize: 11, fontFamily: 'Nanum Round', fontWeight: FontWeight.bold), // 선택된 라벨 스타일
        unselectedLabelStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold),
        currentIndex: _page,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //홈
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '홈',
          ),
          // 계정
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(
                Icons.list_alt,
              ),
            ),
            label: '카테고리',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(
                Icons.chat_outlined,
              ),
            ),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(
                  Icons.event_available,
              ),
            ),
            label: '내 예약',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: bottomBarWidth,
              child: const Icon(
                Icons.person_outline_outlined),
            ),
            label: 'My',
          ),
        ],
      ),
    );
  }
}
