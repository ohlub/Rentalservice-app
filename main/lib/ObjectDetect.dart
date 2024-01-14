import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:sharing_world2/common/widgets/custom_button.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/constants/utils.dart';

class ObjectDetect extends StatefulWidget {
  const ObjectDetect({super.key});

  @override
  State<ObjectDetect> createState() => _ObjectDetectState();
}

class _ObjectDetectState extends State<ObjectDetect> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  late ModelObjectDetection _objectModel;
  String? _imagePrediction;
  File? _image;
  ImagePicker _picker = ImagePicker();
  bool objectDetection = false;
  List<ResultObjectDetection?> objDetect = [];
  bool firststate = false;
  bool message = true;
  bool isButtonVisible = true; // 초기에 버튼을 보이게 설정
  List<File> images = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadModel();
  }

  Future loadModel() async {
    String pathObjectDetectionModel = "assets/models/best.torchscript";
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
          pathObjectDetectionModel, 3, 640, 640,
          labelPath: "assets/labels/labels.txt");
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }

  void handleTimeout() {
    // callback function
    // Do some work.
    setState(() {
      firststate = true;
    });
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  //running detections on image
  Future runObjectDetection() async {
    setState(() {
      firststate = false;
      message = false;
    });
    //pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    objDetect = await _objectModel.getImagePrediction(
        await File(image!.path).readAsBytes(),
        minimumScore: 0.7,
        IOUThershold: 0.7);
    objDetect.forEach((element) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    });
    scheduleTimeout(5 * 1000);
    setState(() {
      _image = File(image.path);
    });
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose(); // TabController를 dispose
    _pageController.dispose();
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
                  alignment: const Alignment(-1.30, 0.2),
                  height: 50,
                  child: const Text(
                    '파손 확인',
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
                  alignment: const Alignment(1.3, 0.0),
                  height: 50,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Text(
              '파손 정보 확인',
              style: TextStyle(
                fontFamily: 'Nanum Round',
                fontSize: 20,
                color: const Color(0xff292929),
                fontWeight: FontWeight.w800,
                height: 0.25,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Text(
              '주문하신 물건의 파손 정보를 확인해주세요.',
              style: TextStyle(
                fontFamily: 'Nanum Round',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 0.25,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Text(
              '대여와 반납 간의 파손 정보를 비교하여 사후 처리를 진행합니다.',
              style: TextStyle(
                fontFamily: 'Nanum Round',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 0.25,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Text(
              '사용이 불가능한 정도의 파손이 있다면 문의해주세요.',
              style: TextStyle(
                fontFamily: 'Nanum Round',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 0.25,
                letterSpacing: 0.8,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TabBar(
            controller: _tabController, // TabBar에 TabController 설정
            tabs: [
              Tab(
                child: Text(
                  '전면',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 16,
                    color: _tabController.index == 0 ? const Color(0xff292929) : const Color(0xff9E9E9E),
                    fontWeight: FontWeight.w800,
                    height: 0.25,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '측면',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 16,
                    color: _tabController.index == 1 ? const Color(0xff292929) : const Color(0xff9E9E9E),
                    fontWeight: FontWeight.w800,
                    height: 0.25,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '후면',
                  style: TextStyle(
                    fontFamily: 'Nanum Round',
                    fontSize: 16,
                    color: _tabController.index == 1 ? const Color(0xff292929) : const Color(0xff9E9E9E),
                    fontWeight: FontWeight.w800,
                    height: 0.25,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
            indicatorColor: const Color(0xFFA6E247),
            indicatorPadding: const EdgeInsets.all(5), // Indicator 주위의 간격 조절
            onTap: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
              setState(() {
              });
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(67, 10, 45, 0),
                            child: Text(
                              '대여 전',
                              style: TextStyle(
                                fontFamily: 'Nanum Round',
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                height: 1,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(77, 10, 20, 0),
                            child: Text(
                              '반납 후',
                              style: TextStyle(
                                fontFamily: 'Nanum Round',
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                height: 1,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                            child: Container(
                              width: 150,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/before.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Container(
                              width: 154,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/after.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('파손 탐지 결과',
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 0.25,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                        child: Text('1: 전면 break (70%)',
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 0.25,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('- 총 1개의 파손이 탐지되었습니다.',
                          style: TextStyle(
                            fontFamily: 'Nanum Round',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 0.25,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    !firststate
                        ? !message ? const Loader() : Container()
                        : Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24, 20, 0, 0),
                        child: Container(
                            child: _objectModel.renderBoxesOnImage(_image!, objDetect)),
                      ),
                    ),

                    // !firststate
                    //     ? LoaderState()
                    //     : Expanded(
                    //         child: Container(
                    //             height: 150,
                    //             width: 300,
                    //             child: objDetect.isEmpty
                    //                 ? Text("hello")
                    //                 : _objectModel.renderBoxesOnImage(
                    //                     _image!, objDetect)),
                    //       ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isButtonVisible, // 버튼을 보이게 하거나 숨깁니다.
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CustomButton(
                          onTap: () {
                            runObjectDetection();
                            setState(() {
                              isButtonVisible = false; // 버튼을 숨깁니다.
                            });
                          },
                          text: '파손 탐지',
                        ),
                      ),
                    ),
                    Center(
                      child: Visibility(
                        visible: _imagePrediction != null,
                        child: Text("$_imagePrediction"),
                      ),
                    ),

                  ],
                ),
                Column(
                  children: const [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("파손 탐지 화면")),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image with Detections....

              !firststate
                  ? !message ? const LoaderState() : const Text("파손 탐지할 사진을 선택해 주세요.")
                  : Expanded(
                child: Container(
                    child: _objectModel.renderBoxesOnImage(_image!, objDetect)),
              ),

              // !firststate
              //     ? LoaderState()
              //     : Expanded(
              //         child: Container(
              //             height: 150,
              //             width: 300,
              //             child: objDetect.isEmpty
              //                 ? Text("hello")
              //                 : _objectModel.renderBoxesOnImage(
              //                     _image!, objDetect)),
              //       ),
              ElevatedButton(
                onPressed: () {
                  runObjectDetection();
                },
                child: const Icon(Icons.camera),
              ),
              //Button to click pic
              Center(
                child: Visibility(
                  visible: _imagePrediction != null,
                  child: Text("$_imagePrediction"),
                ),
              )
            ],
          )),
    );
  }
} */
