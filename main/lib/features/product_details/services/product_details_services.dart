import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/constants/error_handling.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/constants/utils.dart';
import 'package:sharing_world2/models/product.dart';
import 'package:sharing_world2/models/chat.dart';
import 'package:sharing_world2/models/user.dart';
import 'package:sharing_world2/providers/user_provider.dart';
import 'package:sharing_world2/providers/chat_provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
          showSnackBar(context, '물건을 찜했습니다.');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());

    }
  }

  void deleteToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
          userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
          showSnackBar(context, '찜을 취소했습니다.');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());

    }
  }



  void addOrder({
    required BuildContext context,
    required Product product,
    required String member1,
    required String member2,
    required String name,
    required List<String> images,
    required double price,
    required String option,
    required bool direct,
    required bool delivery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'member1': member1,
        }),
      );

      // ignore: use_build_context_synchronously
      if (res.statusCode == 200) {
        addChat(
            context: context,
            member1: member1,
            member2: member2,
            name: name,
            images: images,
            price: price,
            option: option,
            direct: direct,
            delivery: delivery
        );
        User user = userProvider.user.copyWith(order: jsonDecode(res.body)['order']);
        userProvider.setUserFromModel(user);

      } else if (res.statusCode == 400) {
        Map<String, dynamic> data = jsonDecode(res.body);
        String message = data['message'];
        showSnackBar(context, message); // 이미 주문한 경우 메시지를 표시
      } else {
        showSnackBar(context, '서버 오류'); // 기타 오류 처리
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  void addChat({
    required BuildContext context,
    required String member1,
    required String member2,
    required String name,
    required List<String> images,
    required double price,
    required String option,
    required bool direct,
    required bool delivery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Chat chat = Chat(
        id: '',
        member1: member1,
        member2: member2,
        message1: [],
        message2: [],
        sentAt1: [],
        sentAt2: [],
        name: name,
        images: images,
        price: price,
        option: option,
        direct: direct,
        delivery: delivery
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-chat'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: chat.toJson(),
      );



      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, '채팅 생성 완료');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
