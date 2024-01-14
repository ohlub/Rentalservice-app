// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';

class MyRequest_Product extends StatefulWidget {
  final Product product;
  final String image;
  final String name;
  final double price;
  final String seller;
  final String type;
  final String region;
  final String option;
  final int index;
  const MyRequest_Product({Key? key, required this.product, required this.image, required this.name, required this.price, required this.seller, required this.type, required this.region, required this.option, required this.index}) : super(key: key);

  @override
  State<MyRequest_Product> createState() => _MyRequest_ProductState(product: product, image: image, name: name, price: price, seller: seller, type: type, region: region, option: option, index: index);
}

class _MyRequest_ProductState extends State<MyRequest_Product> {
  final Product product;
  final String image;
  final String name;
  final double price;
  final String seller;
  final String type;
  final String region;
  final String option;
  final int index;
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  _MyRequest_ProductState({required this.product, required this.image, required this.name, required this.price, required this.seller, required this.type, required this.region, required this.option, required this.index}); // 생성자로부터 image 값을 받아와서 초기화

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }


  void fetchDealOfDay() async {
    products = await adminServices.fetchAllProducts(context);
  }


  void deleteProduct(Product product) {
    adminServices.deleteProduct(
      context: context,
      product: product,
    );
  }

  void _onMoreOptionsSelected(String option) {
    if (option == '물건 삭제하기') {
      deleteProduct(widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return type == "request" && seller == user.name
        ? Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                ), // Text(key['title']),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  option == 'BASIC'
                      ?
                  Row(
                    children: [
                      SizedBox(
                        width: 190,
                      ), Container(
                        alignment: Alignment.topLeft,
                        height: 27,
                        child: Text(
                          '일반',
                          style: const TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 15,
                            color: Color(0xff626262),
                            fontWeight: FontWeight.w800,
                            height: -0.3,
                          ),
                        ),
                      ),
                    ],
                  ) : Row(
                    children: [
                      SizedBox(
                        width: 165,
                      ), Container(
                        alignment: Alignment.topLeft,
                        height: 27,
                        child: Text(
                          '대세케어',
                          style: const TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 15,
                            color: Color(0xff134f2c),
                            fontWeight: FontWeight.w800,
                            height: -0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  name.length < 17
                      ? Row(
                    children: [
                      for(int i=0; i<name.length; i++)
                        Container(
                          alignment: Alignment.topLeft,
                          height: 27,
                          child: Text(
                            name[i],
                            style: const TextStyle(
                              fontFamily: 'Nanum Round',
                              fontSize: 15,
                              color: Color(0xff292929),
                              fontWeight: FontWeight.w800,
                              height: -0.5,
                            ),
                          ),
                        ),
                    ],
                  )
                      : Row(
                    children: [
                      for(int i=0; i<17; i++)
                        Container(
                          alignment: Alignment.topLeft,
                          height: 27,
                          child: Text(
                            name[i],
                            style: const TextStyle(
                              fontFamily: 'Nanum Round',
                              fontSize: 15,
                              color: Color(0xff292929),
                              fontWeight: FontWeight.w800,
                              height: -0.5,
                            ),
                          ),
                        ),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 27,
                        child: Text(
                          '...',
                          style: const TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 15,
                            color: Color(0xff292929),
                            fontWeight: FontWeight.w800,
                            height: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 30,
                    child: Text(
                      '${price.toInt()}원',
                      style: const TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 15,
                        color: Color(0xff292929),
                        fontWeight: FontWeight.w800,
                        height: -0.5,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      region,
                      style: const TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 10,
                        color: Color(0xffAAAAAA),
                        fontWeight: FontWeight.w800,
                        height: -0.5,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      PopupMenuButton(
                        onSelected: _onMoreOptionsSelected,
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem(
                            value: '물건 삭제하기',
                            child: Text('물건 삭제하기'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 290),
              Icon(
                Icons.forum_outlined,
                color: Colors.grey,
                size:15,
              ),
              SizedBox(width: 15),
              Icon(
                Icons.favorite_border_outlined,
                color: Colors.grey,
                size:15,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container( height:1.5,
            width:550.0,
            color:const Color(0xffEEEEEE),
          )
        ],
      ),
    )
        : Container();
  }
}
