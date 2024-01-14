import 'package:flutter/material.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/search/screens/search.dart';
import 'package:sharing_world2/features/account/screens/category_screen.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({
    Key? key,
  }) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  String category = '';

  void navigateToCategoryPage(String category) {
    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    final itemCountPerRow = 1; // 한 행당 표시할 아이템 수
    final rowCount = (GlobalVariables.categoryImages.length / itemCountPerRow)
        .ceil(); // 행 수 계산


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          automaticallyImplyLeading: false,
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
                  alignment: const Alignment(-0.8, 0.2),
                  height: 50,
                  child: const Text(
                    '카테고리',
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
              Expanded(
                child: Container(
                  alignment: const Alignment(1.025, 0.1),
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()),);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 26,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(rowCount, (rowIndex) {
                return Row(
                  children: List.generate(itemCountPerRow, (index) {
                    final itemIndex = rowIndex * itemCountPerRow + index;
                    if (itemIndex >= GlobalVariables.categoryImages.length) {
                      // 리스트의 끝에 도달했을 때 빈 컨테이너 반환
                      return Container();
                    }
                    return GestureDetector(
                      onTap: () => navigateToCategoryPage(GlobalVariables.categoryImages[itemIndex]['title']!),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                              10, 5, 10, 5,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                GlobalVariables.categoryImages[itemIndex]['image']!,
                                fit: BoxFit.cover,
                                height: 150, // 버튼 크기 조정
                                width: 364, // 버튼 크기 조정
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
