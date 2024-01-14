  import 'package:flutter/material.dart';
  import 'package:sharing_world2/features/home/screens/deal_tabbar.dart';
  import 'package:sharing_world2/constants/global_variables.dart';

class Cart2Screen extends StatefulWidget {
  const Cart2Screen({Key? key}) : super(key: key);

  @override
  State<Cart2Screen> createState() => _Cart2ScreenState();
}

class _Cart2ScreenState extends State<Cart2Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          automaticallyImplyLeading: false,
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
                    '내 예약',
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: DealTabBar(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
