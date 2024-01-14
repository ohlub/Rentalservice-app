import 'package:flutter/material.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/account/screens//category_list.dart';


class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category-screen';
  final String category;
  const CategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState(category: category);
}

class _CategoryScreenState extends State<CategoryScreen> {
  final String category;

  _CategoryScreenState({required this.category});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: const Alignment(-1.15, 0.2),
                  height: 50,
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 16,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                      height: 0.25,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Category_List(category: widget.category),
          ),
        ],
      ),
    );
  }
}
