import 'package:flutter/material.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/account/widgets/below_app_bar.dart';
import 'package:sharing_world2/features/account/widgets/top_buttons.dart';

import '../widgets/orders.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/sharing_world.png',
                  width: 120,
                  height: 45,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notification_add_outlined),
                      ),
                      Icon(Icons.search),
                    ],
                  ))
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          Orders(),
        ],
      ),
    );
  }
}
