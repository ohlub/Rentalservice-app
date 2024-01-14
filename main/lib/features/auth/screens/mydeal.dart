import 'package:flutter/material.dart';
import 'package:sharing_world2/features/home/screens/deal_tabbar.dart';
import 'package:sharing_world2/constants/global_variables.dart';

class MyDeal extends StatefulWidget {
  const MyDeal({Key? key}) : super(key: key);

  @override
  State<MyDeal> createState() => _MyDealState();
}

class _MyDealState extends State<MyDeal> {

  @override
  Widget build(BuildContext context) {
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
                  alignment: const Alignment(-1.15, 0.2),
                  height: 50,
                  child: const Text(
                    '구매내역',
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
