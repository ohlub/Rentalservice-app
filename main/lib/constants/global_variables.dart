import 'package:flutter/material.dart';

String uri = 'https://192.168.200.141:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(16, 192, 90, 1);
  static const backgroundColor = Colors.white;
  static var selectedNavBarColor = const Color(0xFFA6E267);
  static const unselectedNavBarColor = Colors.black87;

  static const List<String> carouselImages = ['assets/images/panel1.png'];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': '전자기기',
      'image': 'assets/images/1.png',
    },
    {
      'title': '생활용품',
      'image': 'assets/images/4.png',
    },
    {
      'title': '의류',
      'image': 'assets/images/3.png',
    },
    {
      'title': '도서',
      'image': 'assets/images/5.png',
    },
    {
      'title': '물건요청',
      'image': 'assets/images/2.png',
    },
  ];
}
