import 'package:flutter/material.dart';
import 'package:sharing_world2/features/home/widgets/regist_list.dart';
import 'package:sharing_world2/features/home/widgets/request_list.dart';
import 'package:sharing_world2/features/search/screens/search_screen.dart';
import 'package:sharing_world2/features/home/services/home_services.dart';
import 'package:sharing_world2/features/product_details/screens/product_details_screen.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/features/admin/screens/add_product_screen.dart';
import 'package:sharing_world2/features/admin/screens/request_product_screen.dart';


class PracticeTabBar extends StatefulWidget {
  const PracticeTabBar({Key? key}) : super(key: key);

  @override
  State<PracticeTabBar> createState() => _PracticeTabBarState();
}

class _PracticeTabBarState extends State<PracticeTabBar> with SingleTickerProviderStateMixin {
  Product? product;
  final HomeServices homeServices = HomeServices();
  late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchDealOfDay();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose(); // TabController를 dispose
    _pageController.dispose();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void navigateToRequestProduct() {
    Navigator.pushNamed(context, RequestProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),

        TabBar(
          controller: _tabController, // TabBar에 TabController 설정
          tabs: [
            Tab(
              child: Text(
                '물건 대여',
                style: TextStyle(
                fontFamily: 'Nanum Round',
                fontSize: 16,
                  color: _tabController.index == 0 ? const Color(0xff292929) : const Color(0xff9E9E9E),
                fontWeight: FontWeight.w800,
                height: 0.25,
                  letterSpacing: 0.8,
              ),
              ),
            ),
            Tab(
              child: Text(
                '요청중인 물건',
                style: TextStyle(
                  fontFamily: 'Nanum Round',
                  fontSize: 16,
                  color: _tabController.index == 1 ? const Color(0xff292929) : const Color(0xff9E9E9E),
                  fontWeight: FontWeight.w800,
                  height: 0.25,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
          indicatorColor: const Color(0xFFA6E247),
          indicatorPadding: const EdgeInsets.all(5), // Indicator 주위의 간격 조절
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
            setState(() {
            });
          },
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            children: [
              // 첫 번째 탭의 내용
              Column(
                children: const [
                  Expanded(
                    child: Regist_List(),
                  ),
                ],
              ),
              // 두 번째 탭의 내용
              Column(
                children: const [
                  Expanded(
                    child: Request_List(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}