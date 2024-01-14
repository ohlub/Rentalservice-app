// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sharing_world2/models/order.dart';
import 'package:sharing_world2/features/account/services/account_services.dart';

class OrderProduct extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  const OrderProduct({Key? key, required this.image, required this.name, required this.price}) : super(key: key);

  @override
  State<OrderProduct> createState() => _OrderProductState(image: image, name: name, price: price);
}

class _OrderProductState extends State<OrderProduct> {
  final String image;
  final String name;
  final double price;
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  _OrderProductState({required this.image, required this.name, required this.price}); // 생성자로부터 image 값을 받아와서 초기화


  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                            height: 0.25,
                          ),
                        ),
                      ),
                    ],
                  ) :Row(
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
                              height: 0.25,
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
                            height: 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    alignment: Alignment.topLeft,
                    height: 40,
                    child: Text(
                      '${price.toInt()}원',
                      style: const TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 15,
                        color: Color(0xff292929),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
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
    );
  }
}
