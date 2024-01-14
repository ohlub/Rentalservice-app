import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/features/account/screens//category_product.dart';
import 'package:sharing_world2/features/product_details/screens/product_details_screen.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';

class Category_List extends StatefulWidget {
  final String category;
  const Category_List({Key? key, required this.category}) : super(key: key);

  @override
  State<Category_List> createState() => _Category_ListState(category: category);
}

class _Category_ListState extends State<Category_List> {
  List<Product>? products;
  final String category;
  final AdminServices adminServices = AdminServices();

  _Category_ListState({required this.category}); // 생성자로부터 image 값을 받아와서 초기화


  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }



  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: products,
    );
  }




  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Stack(
      children: [
        Container(
          alignment: const Alignment(-0.8, 0.0),
          height: 700,
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: products!.length,
            itemBuilder: (context, index) {
              final productData = products![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetailScreen.routeName,
                    arguments: productData,
                  );
                },
                child: CategoryProduct(
                  image: productData.images[0],
                  name: productData.name,
                  price: productData.price,
                  seller: productData.seller,
                  type: productData.type,
                  region: productData.region,
                  option: productData.option,
                  category: productData.category,
                  categories: widget.category,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
