import 'package:flutter/material.dart';
import 'package:sharing_world2/features/account/services/account_services.dart';
import 'package:sharing_world2/features/account/widgets/account_button.dart';
import 'package:sharing_world2/features/admin/screens/admin_screen.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: '주문 내역',
              onTap: () {},
            ),
            AccountButton(
              text: '물건 등록',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: '로그아웃',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(
              text: '찜',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 20), // 공간을 띄우기 위한 SizedBox 추가

        // ElevatedButton 추가
        ElevatedButton(
          onPressed: () {
            // Navigator를 사용하여 다른 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminScreen()),
            );
          },
          child: const Text('상품 판매 페이지로 이동'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
