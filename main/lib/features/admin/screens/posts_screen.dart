import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:sharing_world2/features/admin/screens/add_product_screen.dart';
import 'package:sharing_world2/features/admin/screens/request_product_screen.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:sharing_world2/models/product.dart';
// add_product_request_screen.dart 파일을 import합니다.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsScreen(),
      routes: {
        AddProductScreen.routeName: (context) => const AddProductScreen(),
        RequestProductScreen.routeName: (context) =>
        const RequestProductScreen(), // RequestProductScreen을 routes에 추가합니다.
      },
    );
  }
}

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with SingleTickerProviderStateMixin {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
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
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
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
    return products == null
        ? const Loader()
        : Scaffold(
            floatingActionButton: FloatingActionBubble(
              items: <Bubble>[
                Bubble(
                  title: "물건등록",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.add_box,
                  titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: navigateToAddProduct,
                ),
                Bubble(
                  title: "물건요청",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.device_unknown,
                  titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: navigateToRequestProduct,
                ),
              ],
              animation: _animation!,
              onPress: () => _animationController!.isCompleted
                  ? _animationController!.reverse()
                  : _animationController!.forward(),
              backGroundColor: Colors.blue,
              iconColor: Colors.white,
              iconData: Icons.menu,
            ),
          );
  }
}
