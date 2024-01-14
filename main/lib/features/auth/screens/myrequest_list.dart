import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/features/product_details/screens/product_details_screen.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:sharing_world2/features/auth/screens/myrequest_product.dart';

class MyRequest_List extends StatefulWidget {
  const MyRequest_List({Key? key}) : super(key: key);

  @override
  State<MyRequest_List> createState() => _MyRequest_ListState();
}

class _MyRequest_ListState extends State<MyRequest_List> {
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
                child: MyRequest_Product(
                  product: productData,
                  image: productData.images[0],
                  name: productData.name,
                  price: productData.price,
                  seller: productData.seller,
                  type: productData.type,
                  region: productData.region,
                  option: productData.option,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
