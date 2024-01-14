import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/features/home/widgets/regist_product.dart';
import 'package:sharing_world2/features/product_details/screens/product_details_screen.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';

class Regist_List extends StatefulWidget {
  const Regist_List({Key? key}) : super(key: key);

  @override
  State<Regist_List> createState() => _Regist_ListState();
}

class _Regist_ListState extends State<Regist_List> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

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
                child: SingleProduct(
                  image: productData.images[0],
                  name: productData.name,
                  price: productData.price,
                  seller: productData.seller,
                  type: productData.type,
                  region: productData.region,
                  option: productData.option,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
