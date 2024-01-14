import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/account/services/account_services.dart';
import 'package:sharing_world2/features/account/widgets/order_product.dart';
import 'package:sharing_world2/features/order_details/screens/order_details.dart';
import 'package:sharing_world2/models/order.dart';

class DealTabBar extends StatefulWidget {
  const DealTabBar({Key? key}) : super(key: key);

  @override
  State<DealTabBar> createState() => _DealTabBarState();
}

class _DealTabBarState extends State<DealTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
    _tabController = TabController(length: 2, vsync: this);
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose(); // TabController를 dispose
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column (
      children: [
        const SizedBox(
          height: 10,
        ),
        TabBar(
          controller: _tabController, // TabBar에 TabController 설정
          tabs: [
            Tab(
              child: Text(
                '거래 중',
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
                '거래 완료',
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
              Column(
                children: [
                  Container(
                    alignment: const Alignment(-0.8, 0.0),
                    height: 540,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 0,
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                OrderDetailScreen.routeName,
                                arguments: orders![index],
                              );
                            },
                            child: OrderProduct(
                              image: orders![index].products[0].images[0],
                              name: orders![index].products[0].name,
                              price: orders![index].products[0].price,
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
              // 두 번째 탭의 내용
              Column(
                children: const [
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}