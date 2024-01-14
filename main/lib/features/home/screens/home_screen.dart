import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sharing_world2/features/address/services/address_services.dart';
import 'package:sharing_world2/features/search/services/search_services.dart';
import 'package:sharing_world2/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/models/user.dart';
import 'package:sharing_world2/features/home/screens/home_screen2.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late NaverMapController _mapController;
  final TextEditingController mapController = TextEditingController();
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  NLatLng? tappedLatLng; // 저장할 변수
  int color = 0xFFF0F0F0;
  int text = 0xFFA2A2A2;
  List<String>? gusi;
  final AddressServices addressServices = AddressServices();
  final SearchServices searchServices = SearchServices();
  Set<NInfoWindow> infoWindows = {};
  final _mapFormKey = GlobalKey<FormState>();

  Future<void> fetchData(double lat, double lng) async {

    Map<String,String> headerss = {
      "X-NCP-APIGW-API-KEY-ID": "xyh3jqnc7g",
      "X-NCP-APIGW-API-KEY": "fwhtWH6K42oyZH4bf0UnY6xODZMsJtABy2ABgeTn"
    };

    http.Response response = await http.get(
        Uri.parse(
            "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${lng},${lat}&sourcecrs=epsg:4326&output=json&orders=legalcode,admcode"),
        headers: headerss);

    String jsonData = response.body;

    var myJson_do =
    jsonDecode(jsonData)["results"][1]['region']['area1']['name'];
    var myJson_gu =
    jsonDecode(jsonData)["results"][1]['region']['area2']['name'];
    var myJson_si =
    jsonDecode(jsonData)["results"][1]['region']['area3']['name'];

    gusi = [myJson_do, myJson_gu, myJson_si];
  }

  void saveRegion() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // 수정된 지역과 함께 새 User 객체를 만듭니다.
    User updatedUser = userProvider.user.copyWith(region: gusi![2]);

    // 새 User 객체로 UserProvider를 직접 업데이트합니다.
    userProvider.user = updatedUser;

    addressServices.saveRegion(
      context: context,
      name: userProvider.user.name,
      region: userProvider.user.region,
    );
  }



  @override
  Widget build(BuildContext context) {
    gusi = ['1'];
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 615,
                child: NaverMap(
                  options: const NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(37.39, 126.92),
                      zoom: 15,
                    ),
                    consumeSymbolTapEvents: false,
                  ),
                  onMapTapped: (NPoint point, NLatLng latLng) {
                    setState(() {
                      tappedLatLng = latLng; // 사용자가 터치한 지점의 좌표를 저장
                      fetchData(tappedLatLng!.latitude, tappedLatLng!.longitude);
                      Future.delayed(const Duration(milliseconds: 100), () {
                        if (tappedLatLng != null) {
                          final tappedMarker = NMarker(
                            id: 'tapped',
                            position: tappedLatLng!,
                          );
                          _mapController.addOverlayAll({tappedMarker});
                          final onMarkerInfoWindow =
                          NInfoWindow.onMarker(id: tappedMarker.info.id, text: gusi![0] + ' ' + gusi![1] + ' ' + gusi![2]);
                          tappedMarker.openInfoWindow(onMarkerInfoWindow);
                        }
                      });
                      color = 0xFFA6E247;
                      text = 0xFFFFFFFF;
                    });
                  },
                  onMapReady: (controller) {
                    _mapController = controller;
                    mapControllerCompleter.complete(controller);
                  },
                ),
              ),
              ElevatedButton(
                // ignore: sort_child_properties_last
                  child: Text(
                    '선택하기',
                    style: TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize:16,
                      fontWeight: FontWeight.w700,
                      color: Color(text),
                    ),
                  ),
                  onPressed: () {
                    if(gusi![0] == '1'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('알림'),
                            content: Text('지역을 선택해주세요.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      saveRegion();
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(color),
                    minimumSize: const Size(double.infinity, 45),
                  )
              ),
            ],
          )

        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.navigate_before_outlined, color: Colors.black, size: 35),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: const Alignment(-1.2, 0.22),
                    height: 50,
                    child: const Text(
                      '내 지역 설정',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}