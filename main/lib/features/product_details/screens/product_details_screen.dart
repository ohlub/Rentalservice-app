// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/product_details/services/product_details_services.dart';
import 'package:sharing_world2/features/search/screens/search_screen.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/providers/user_provider.dart';



class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  bool type = false;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  void deleteToCart() {
    productDetailsServices.deleteToCart(
      context: context,
      product: widget.product,
    );
  }


  void addOrder() {
    final user = Provider
        .of<UserProvider>(context, listen: false)
        .user;
    if (user.name == widget.product.seller) {
      print('자신과는 채팅을 진행 할 수 없습니다.');
    } else {
      productDetailsServices.addOrder(
          context: context,
          product: widget.product,
          member1: widget.product.seller,
          member2: user.name,
          name: widget.product.name,
          images: widget.product.images,
          price: widget.product.price,
          option: widget.product.option,
          direct: widget.product.direct,
          delivery: widget.product.delivery
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(),
        child: Container(
          height: 60,
          color: Color(0xFFA6E247),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              type == false
              ? Padding(
                padding: EdgeInsets.fromLTRB(15, 7, 0, 15),
                child: IconButton(
                    icon: Icon(Icons.favorite_border_outlined, size: 30),
                    color: Colors.white,
                    onPressed: () {
                      addToCart();
                      type = true;
                      setState(() {

                      });
                    },
                ),
              )
              : Padding(
                padding: EdgeInsets.fromLTRB(15, 7, 0, 15),
                child: IconButton(
                  icon: Icon(Icons.favorite, size: 30),
                  color: Colors.white,
                  onPressed: () {
                    deleteToCart();
                    type = false;
                    setState(() {

                    });
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 31, 10, 5),
                    child: Container(
                      child: Text(
                        '${widget.product.price.toInt()}원',
                        style: const TextStyle(
                          fontFamily: 'Nanum Round',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          height: 0.25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 13, 20, 0),
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      addOrder();
                    },
                    child: Center(
                      child: Text(
                        '채팅하기',
                        style: const TextStyle(
                          fontFamily: 'Nanum Round',
                          fontSize: 14,
                          color: Color(0xFFA6E247),
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          actions: [
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(Icons.more_vert),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: widget.product.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.fitWidth,
                      width:395,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 50,
                    color: Color(0xffBFBDBC),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                              widget.product.seller,
                              style: const TextStyle(
                                fontFamily: 'Nanum Round',
                                fontSize: 16,
                                color: Color(0xff292929),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 4, 1, 0),
                          child: Text(
                            widget.product.region,
                            style: const TextStyle(
                              fontFamily: 'Nanum Round',
                              fontSize: 9,
                              color: Color(0xffAAAAAA),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 35, 0, 10),
              child: Text(widget.product.name,
                style: const TextStyle(
                  fontFamily: 'Nanum Round',
                  fontSize: 22,
                  color: Color(0xff292929),
                  fontWeight: FontWeight.w800,
                  height: 0.25,
                ),
              ),
            ),
            Row(
              children: [
                widget.product.direct == true && widget.product.option == 'BASIC'
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                  child: Chip(
                    label: Text(
                      '직거래 가능',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color(0xFFA6E247),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  ),
                )
                : Container(),
                widget.product.delivery == true && widget.product.option == 'BASIC'
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Chip(
                    label: Text(
                      '배송 가능',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color(0xFFA6E247),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  ),
                )
                : Container(),
                widget.product.option == 'BASIC'
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Chip(
                    label: Text(
                      '일반 거래',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color(0xFFA6E247),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Chip(
                    label: Text(
                      '대세 케어',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color(0xFFA6E247),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                style: const TextStyle(
                  fontFamily: 'Nanum Round',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  color: Color(0xff292929),
                ),
                maxLines: 10,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: widget.product.description,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x61000000),
                        width:0.5,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black12,
                        width: 3,
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
