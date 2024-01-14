import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/product_details/screens/product_details_screen.dart';
import 'package:sharing_world2/features/search/services/search_services.dart';
import 'package:sharing_world2/features/search/widget/searched_product.dart';
import 'package:sharing_world2/models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter1 = '거래방식';
  String selectedFilter2 = '내 지역';
  String selectedFilter3 = '카테고리';
  String selectedFilter4 = '가격';

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
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
                  height: 45,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      controller: _searchController, // 컨트롤러 연결
                      style: const TextStyle(
                          fontSize:16,
                          fontFamily: 'Nanum Round',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '검색어를 입력하세요',
                        hintStyle: TextStyle(
                            fontSize:16,
                            fontFamily: 'Nanum Round',
                            color: Colors.black38,
                            fontWeight: FontWeight.w600),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            )
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            )
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white, // 초점이 없을 때 테두리 색상
                              width: 0,
                            )),
                        suffixIcon: InkWell(
                          onTap: () {
                            _searchController.clear();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                              right: 6,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black87,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26), // 테두리 색상
                          borderRadius: BorderRadius.circular(5.0), // 테두리 모서리 각도
                        ),
                        child: DropdownButton<String>(
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                          value: selectedFilter1,
                          onChanged: (value) {
                            setState(() {
                              selectedFilter1 = value!;
                            });
                          },
                          items: ['거래방식', '일반', '대세케어'].map((filter) {
                            return DropdownMenuItem<String>(
                              value: filter,
                              child: Row(
                                children: [
                                  Text(filter),
                                ],
                              ),
                            );
                          }).toList(),
                          elevation: 4,
                          underline: Container(), // 테두리를 사용하지 않도록 설정
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26), // 테두리 색상
                          borderRadius: BorderRadius.circular(5.0), // 테두리 모서리 각도
                        ),
                        child: DropdownButton<String>(
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                          value: selectedFilter2,
                          onChanged: (value) {
                            setState(() {
                              selectedFilter2 = value!;
                            });
                          },
                          items: ['내 지역', '모든 지역'].map((filter) {
                            return DropdownMenuItem<String>(
                              value: filter,
                              child: Row(
                                children: [
                                  Text(filter),
                                ],
                              ),
                            );
                          }).toList(),
                          elevation: 4,
                          underline: Container(), // 테두리를 사용하지 않도록 설정
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26), // 테두리 색상
                          borderRadius: BorderRadius.circular(5.0), // 테두리 모서리 각도
                        ),
                        child: DropdownButton<String>(
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                          value: selectedFilter3,
                          onChanged: (value) {
                            setState(() {
                              selectedFilter3 = value!;
                            });
                          },
                          items: ['카테고리', '전자기기', '생활용품', '의류', '도서', '물건요청'].map((filter) {
                            return DropdownMenuItem<String>(
                              value: filter,
                              child: Row(
                                children: [
                                  Text(filter),
                                ],
                              ),
                            );
                          }).toList(),
                          elevation: 4,
                          underline: Container(), // 테두리를 사용하지 않도록 설정
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26), // 테두리 색상
                          borderRadius: BorderRadius.circular(5.0), // 테두리 모서리 각도
                        ),
                        child: DropdownButton<String>(
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                          value: selectedFilter4,
                          onChanged: (value) {
                            setState(() {
                              selectedFilter4 = value!;
                            });
                          },
                          items: ['가격', '높은 순', '낮은 순'].map((filter) {
                            return DropdownMenuItem<String>(
                              value: filter,
                              child: Row(
                                children: [
                                  Text(filter),
                                ],
                              ),
                            );
                          }).toList(),
                          elevation: 4,
                          underline: Container(), // 테두리를 사용하지 않도록 설정
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchProduct(
                          product: products![index],
                          selectedFilter1: selectedFilter1,
                          selectedFilter2: selectedFilter2,
                          selectedFilter3: selectedFilter3,
                          selectedFilter4: selectedFilter4,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
