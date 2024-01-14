import 'package:flutter/material.dart';

class CustomButton3 extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton3({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // ignore: sort_child_properties_last
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Nanum Round',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: color == null ? Color(0xFFA6E247) : Colors.black,
        ),
      ),
      onPressed: onTap,
      style: TextButton.styleFrom(
        elevation: 1,
        backgroundColor: const Color(0xFFFFFFFF),
        minimumSize: const Size(double.infinity, 45),
      )
    );
  }
}
