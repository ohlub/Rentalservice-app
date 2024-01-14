import 'package:flutter/material.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/search/screens/search.dart';
import 'package:sharing_world2/features/product_details/screens/product_details_screen.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/features/admin/screens/add_product_screen.dart';
import 'package:sharing_world2/features/admin/screens/request_product_screen.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:sharing_world2/features/home/screens/home_screen.dart';
import 'package:sharing_world2/features/home/screens/main_tabbar.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';

class HomeScreen2 extends StatefulWidget {
  static const String routeName = '/home2';
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreenState2();
}

class _HomeScreenState2 extends State<HomeScreen2> with SingleTickerProviderStateMixin {
  Product? product;
  Animation<double>? _animation;
  AnimationController? _animationController;


  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
    CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }



  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void navigateToRequestProduct() {
    Navigator.pushNamed(context, RequestProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: "물건등록",
            iconColor: Colors.white,
            bubbleColor: const Color(0xFFA6E247),
            icon: Icons.add_box,
            titleStyle: const TextStyle(
              fontFamily: 'Nanum Round',
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1.7,),
            onPress: navigateToAddProduct,
          ),
          Bubble(
            title: "물건요청",
            iconColor: Colors.white,
            bubbleColor: const Color(0xFFA6E247),
            icon: Icons.send_to_mobile_outlined,
            titleStyle: const TextStyle(
              fontFamily: 'Nanum Round',
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1.7,),
            onPress: navigateToRequestProduct,
          ),
        ],
        animation: _animation!,
        onPress: () => _animationController!.isCompleted
            ? _animationController!.reverse()
            : _animationController!.forward(),
        backGroundColor: const Color(0xFFA6E247),
        iconColor: Colors.white,
        iconData: Icons.add,
      ),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
              ),
          ),
          title: user.region == ''
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: const Alignment(-0.0, 0.2),
                  width: 50,
                  height: 50,
                  child: Text(
                    '123',
                    style: const TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 17,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                      height: 0.25,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3, // 아이콘과 아이콘 사이의 공간을 조절
                child: Container(
                  alignment: const Alignment(-1.05, 0.0),
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()),);
                    },
                    child: const Icon(
                      Icons.expand_more,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: const Alignment(1.2, 0.1),
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()),);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 26,
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
          )
          : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: const Alignment(-0.0, 0.2),
                  width: 50,
                  height: 50,
                  child: Text(
                    user.region ,
                    style: const TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 17,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                      height: 0.25,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3, // 아이콘과 아이콘 사이의 공간을 조절
                child: Container(
                  alignment: const Alignment(-1.05, 0.0),
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()),);
                    },
                    child: const Icon(
                      Icons.expand_more,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: const Alignment(1.2, 0.1),
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()),);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 26,
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
                  Expanded(child: PracticeTabBar()),
                ],
              ),
          ],
        ),
      );
  }
}

