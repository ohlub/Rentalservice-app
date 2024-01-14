import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/bottom_bar.dart';
import 'package:sharing_world2/features/admin/screens/add_product_screen.dart';
import 'package:sharing_world2/features/admin/screens/request_product_screen.dart';
import 'package:sharing_world2/features/auth/screens/signin.dart';
import 'package:sharing_world2/features/home/screens/category_deals_screen.dart';
import 'package:sharing_world2/features/home/screens/home_screen.dart';
import 'package:sharing_world2/features/order_details/screens/order_details.dart';
import 'package:sharing_world2/features/product_details/screens/product_details_screen.dart';
import 'package:sharing_world2/features/product_details/screens/myproduct_details_screen.dart';
import 'package:sharing_world2/features/search/screens/search_screen.dart';
import 'package:sharing_world2/models/order.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/screens/home.dart';
import 'package:sharing_world2/features/account/screens/category_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen1.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen1(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(
        ),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryScreen(
          category: category,
        ),
      );

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );

    case MyProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MyProductDetailScreen(
          product: product,
        ),
      );

    case RequestProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RequestProductScreen(),
      );


    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
