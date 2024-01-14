import 'package:flutter/material.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';

class SearchProduct extends StatefulWidget {
  final Product product;
  final String selectedFilter1;
  final String selectedFilter2;
  final String selectedFilter3;
  final String selectedFilter4;

  const SearchProduct({Key? key, required this.product, required this.selectedFilter1, required this.selectedFilter2, required this.selectedFilter3, required this.selectedFilter4}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState(product: product, selectedFilter1: selectedFilter1, selectedFilter2: selectedFilter2, selectedFilter3: selectedFilter3, selectedFilter4: selectedFilter4);
}

class _SearchProductState extends State<SearchProduct> {
  final Product product;
  final String selectedFilter1;
  final String selectedFilter2;
  final String selectedFilter3;
  final String selectedFilter4;
  _SearchProductState({required this.product, required this.selectedFilter1, required this.selectedFilter2, required this.selectedFilter3, required this.selectedFilter4}); // 생성자로부터 image 값을 받아와서 초기화

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> filteredProducts = [];

    if (widget.selectedFilter1 == '거래방식') {
      filteredProducts.add(product);
    } else if (widget.selectedFilter1 == '일반' && product.option == 'BASIC') {
      filteredProducts.add(product);
    } else if (widget.selectedFilter1 == '대세케어' && product.option == 'PREMIUM') {
      filteredProducts.add(product);
    }

    if (widget.selectedFilter2 == '내 지역') {
      filteredProducts = filteredProducts.where((p) => p.region == user.region).toList();
    }

    if (widget.selectedFilter3 != '카테고리') {
      filteredProducts = filteredProducts.where((p) => p.category == widget.selectedFilter3).toList();
    }

    return Column(
      children: [
        filteredProducts.isNotEmpty
            ?
        Container(
          padding: const EdgeInsets.fromLTRB(10, 7, 10, 10),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      filteredProducts[0].images[0],
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                    ), // Text(key['title']),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      filteredProducts[0].option == 'BASIC'
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
                      filteredProducts[0].name.length < 17
                          ? Row(
                        children: [
                          for(int i=0; i<filteredProducts[0].name.length; i++)
                            Container(
                              alignment: Alignment.topLeft,
                              height: 27,
                              child: Text(
                                filteredProducts[0].name[i],
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
                                filteredProducts[0].name[i],
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
                          '${filteredProducts[0].price.toInt()}원',
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
                          filteredProducts[0].region,
                          style: const TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 10,
                            color: Color(0xffAAAAAA),
                            fontWeight: FontWeight.w800,
                            height: -0.5,
                          ),
                        ),
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
                children: const [
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
                color:const Color(0xffEEEEEE),)
            ],
          ),
        ):
            Container(),
      ],
    );
  }
}
