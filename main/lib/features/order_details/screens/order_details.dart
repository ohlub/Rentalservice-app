import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:sharing_world2/common/widgets/custom_button.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:sharing_world2/features/search/screens/search_screen.dart';
import 'package:sharing_world2/models/order.dart';
import 'dart:async';
import 'package:sharing_world2/ObjectDetect.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 4;
  final AdminServices adminServices = AdminServices();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  String? Dates;


  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
  }


  void deleteOrder(Order order) {
    adminServices.deleteOrder(
      context: context,
      order: widget.order,
    );
  }

  void _onMoreOptionsSelected(String option) {
    // 각 옵션에 대한 로직을 여기에 구현합니다.
    if (option == '예약 취소하기') {
      deleteOrder(widget.order);
      Navigator.pop(context);
      // 채팅 나가기 기능을 구현합니다.
    }
  }

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          if (currentStep < 4) {
            currentStep += 1;
          } else {}
        });
      },
    );
  }


  _login2() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ObjectDetect())
    );
  }

  @override
  Widget build(BuildContext context) {
    Duration diff1 = DateTime.parse(widget.order.endDate).difference(DateTime.now());

    int days1 = diff1.inDays.toInt();
    int hours1 = diff1.inHours.toInt() - (diff1.inDays.toInt() * 24);
    int minutes1 = diff1.inMinutes.toInt() - (diff1.inHours.toInt() * 60);

    Duration diff2 = DateTime.parse(widget.order.startDate).difference(DateTime.now());

    int days2 = diff2.inDays.toInt();
    int hours2 = diff2.inHours.toInt() - (diff2.inDays.toInt() * 24);
    int minutes2 = diff2.inMinutes.toInt() - (diff2.inHours.toInt() * 60);

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
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
                  alignment: const Alignment(-1.13, 0.2),
                  height: 50,
                  child: const Text(
                    '예약 정보',
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
          actions: [
            PopupMenuButton<String>(
              onSelected: _onMoreOptionsSelected,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '예약 취소하기',
                  child: Text('예약 취소하기'),
                ),
                // 필요에 따라 추가 옵션을 더합니다.
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child: Text('주문 번호 ${widget.order.id}',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        color: Colors.black54,
                      ),)
                ),
              ],
            ),
            for (int i = 0; i < widget.order.products.length; i++)
            Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.order.products[i].images[0],
                  fit: BoxFit.fill,
                  width: 350,
                  height: 300,
                ), // Text(key['title']),
              ),
            ),
            SizedBox(
              height: 15
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                height: 210,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: Text(
                        '결제 정보',
                        style: TextStyle(
                          fontFamily: 'Nanum Round',
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: Text(
                            '물건 이름',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Spacer(),
                        for (int i = 0; i < widget.order.products.length; i++)
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                          child: Text(
                            widget.order.products[i].name,
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                          child: Text(
                            '물건 가격',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Spacer(),
                        for (int i = 0; i < widget.order.products.length; i++)
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            '${widget.order.products[i].price.toInt()} 원',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                          child: Text(
                            '대여 기간',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Spacer(),
                        for (int i = 0; i < widget.order.products.length; i++)
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            '${(widget.order.totalPrice/widget.order.products[i].price).toInt()} 일',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(18, 15, 0, 0),
                      child: Container(
                        height: 1.5,
                        width: 310,
                        color: Color(0xffEAEAEA),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                          child: Text(
                            '총 결제금액',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Spacer(),
                        for (int i = 0; i < widget.order.products.length; i++)
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 20, 0),
                          child: Text(
                            '${(widget.order.totalPrice*widget.order.quantity[i]).toInt()} 원',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            widget.order.products[0].option == 'BASIC'
                ? Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    minutes2 < 0
                        ? minutes1 > 0
                        ? Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        '반납까지 ' + days1.toString() + '일 ' + hours1.toString() + '시간 ' + minutes1.toString() + '분 남았습니다.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ) : Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        '물건을 반납해주시기 바랍니다.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ) : Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        '대여까지 ' + days2.abs().toString() + '일 ' + hours2.abs().toString() + '시간 ' + minutes2.abs().toString() + '분 남았습니다.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) : Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Container(
                height: 700,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    minutes2 < 0
                        ? minutes1 > 0
                        ? Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        '반납까지 ' + days1.toString() + '일 ' + hours1.toString() + '시간 ' + minutes1.toString() + '분 남았습니다.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ) : Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        '물건을 반납해주시기 바랍니다.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ) : Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        '대여까지 ' + days2.abs().toString() + '일 ' + hours2.abs().toString() + '시간 ' + minutes2.abs().toString() + '분 남았습니다.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),
                            child: Text(
                              '배송조회',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Stepper(
                              currentStep: currentStep,
                              controlsBuilder: (context, details) {
                                return Stack(
                                  children: [
                                     Padding(
                                       padding: EdgeInsets.only(top: 10),
                                     child: CustomButton(
                                       text: '파손 확인',
                                       onTap: () => _login2(),
                                     ),
                                     )
                                  ],
                                );
                              },
                              steps: [
                                Step(
                                  title: const Text('판매자 배송 완료'),
                                  content: const Text(
                                    '판매자가 물건을 배송하는 중이에요',
                                  ),
                                  isActive: currentStep >= 0,
                                  state: currentStep >= 0
                                      ? StepState.complete
                                      : StepState.indexed,
                                ),
                                Step(
                                  title: const Text('수령 완료'),
                                  content: const Text(
                                    '업체가 물건을 수령했어요',
                                  ),
                                  isActive: currentStep >= 1,
                                  state: currentStep >= 1
                                      ? StepState.complete
                                      : StepState.indexed,
                                ),
                                Step(
                                  title: const Text('검수 중'),
                                  content: const Text(
                                    '물건을 검수중이에요',
                                  ),
                                  isActive: currentStep >= 2,
                                  state: currentStep >= 2
                                      ? StepState.complete
                                      : StepState.indexed,
                                ),
                                Step(
                                  title: const Text('검수 완료'),
                                  content: const Text(
                                    '물건 검수가 완료되었어요',
                                  ),
                                  isActive: currentStep >= 3,
                                  state: currentStep >= 3
                                      ? StepState.complete
                                      : StepState.indexed,
                                ),
                                Step(
                                  title: const Text('업체 배송 완료'),
                                  content: const Text(
                                    '고객님에게 물건을 배송하는 중이에요',
                                  ),
                                  isActive: currentStep >= 4,
                                  state: currentStep >= 4
                                      ? StepState.complete
                                      : StepState.indexed,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: '물건 검색',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '상세 주문 내역',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('주문 날짜:      ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}'),
                    Text('주문 ID:          ${widget.order.id}'),
                    Text('결제 금액:      \$${widget.order.totalPrice}'),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '남은 대여 기간',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '반납까지 $_hoursRemaining시간 $_minutesRemaining분 남았습니다',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const HomeScreen2(), // HomeScreen2로 이동
                              ),
                            );
                          },
                          child: const Text(
                            '알람 설정하기', // 버튼 텍스트
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                '주문한 물건',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '개수: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '배송조회',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                      return CustomButton(
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                  },
                  steps: [
                    Step(
                      title: const Text('결제 완료'),
                      content: const Text(
                        '빠르게 상품을 준비할게요',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('상품 준비중'),
                      content: const Text(
                        '택배사에 물건을 보내고 있어요',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('배송중'),
                      content: const Text(
                        '주문하신 물건이 배송중입니다',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('배송중'),
                      content: const Text(
                        '주문하신 물건이 배송중입니다',
                      ),
                      isActive: currentStep > 3,
                      state: currentStep > 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('배송중'),
                      content: const Text(
                        '주문하신 물건이 배송중입니다',
                      ),
                      isActive: currentStep > 5,
                      state: currentStep > 5
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */
