import 'package:flutter/material.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/search/screens/search_screen.dart';
import 'package:sharing_world2/features/search/services/search_services.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final SearchServices searchServices = SearchServices();
  bool detect = false;
  // 이전 검색어 목록



  void navigateToSearchScreen(String query) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (query.isNotEmpty) {
      for(int i=0; i<userProvider.user.search.length; i++){
        print(userProvider.user.search[i]);
        if(userProvider.user.search[i] == query){
          detect = true;
        }
      }

      if (detect == false) {
        userProvider.user.search.add(query);
        searchServices.saveUserSearch(
          context: context,
          name: userProvider.user.name,
          search: userProvider.user.search,
        );
        setState(() {
          Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
        });
      }
      else {
        print(detect);
        setState(() {
          Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
        });
      }
    }
  }

  void navigateToSearchScreen2(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

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
                      controller: _searchController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nanum Round',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '검색어를 입력하세요',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nanum Round',
                            color: Colors.black38,
                            fontWeight: FontWeight.w600),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            )),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            )),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            )),
                        suffixIcon: InkWell(
                          onTap: () {
                            _searchController.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이전 검색어 목록 표시
            if (user.search.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      '최근 검색어',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 8,
                      children: user.search.map((search) {
                        return InkWell(
                          onTap: () {
                            _searchController.text = search;
                            navigateToSearchScreen2(search);
                          },
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 88), // 최대 가로 길이 지정
                            child: Chip(
                              label: Row(
                                children: [
                                  Text(
                                    search,
                                    style: TextStyle(
                                      fontFamily: 'Nanum Round',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.close, // 원하는 아이콘 지정
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black12, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}