import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/features/cart/services/cart_services.dart';
import 'package:sharing_world2/features/product_details/services/product_details_services.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/providers/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
  ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }


  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 7, 10, 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                ), // Text(key['title']),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.option == 'BASIC'
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
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 27,
                        child: Text(
                          product.name,
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
                      '${product.price.toInt()}원',
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
                      product.region,
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
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(width: 310),
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
    );
  }
}
