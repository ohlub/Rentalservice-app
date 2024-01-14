import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';

class CartSubtotal extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;

  const CartSubtotal({Key? key, this.startDate, this.endDate})
      : super(key: key);

  int calculateTotalPrice(UserProvider userProvider) {
    int totalPrice = 0;
    for (var cartItem in userProvider.user.cart) {
      totalPrice += cartItem['quantity'] * cartItem['product']['price'] as int;
    }
    return totalPrice;
  }

  int calculateDuration() {
    if (startDate != null && endDate != null) {
      final duration = endDate!.difference(startDate!);
      return duration.inDays;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final totalPrice = calculateTotalPrice(userProvider);
    final duration = calculateDuration();
    final finalPrice = totalPrice * duration;

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            '총 금액 ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '\$$finalPrice',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
