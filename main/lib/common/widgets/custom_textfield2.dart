import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const CustomTextField2({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize:12,
        fontFamily: 'Nanum Round',
      color: Color(0xff484848),
      fontWeight: FontWeight.w600),
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0x61000000),
                width:0.5,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0x61000000),
                width:1,
              )
          )
      ),
      maxLines: maxLines,
      obscureText: true,
    );
  }
}
