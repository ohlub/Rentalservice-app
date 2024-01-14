import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/common/widgets/custom_textfield.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/address/services/address_services.dart';
import 'package:sharing_world2/providers/user_provider.dart';
import 'package:kpostal/kpostal.dart';
import 'package:sharing_world2/common/widgets/custom_button.dart';

class AddressScreen3 extends StatefulWidget {
  static const String routeName = '/address';
  final double totalPrice;
  final int index;
  const AddressScreen3({
    Key? key,
    required this.totalPrice,
    required this.index
  }) : super(key: key);

  @override
  State<AddressScreen3> createState() => _AddressScreen3State();
}

class _AddressScreen3State extends State<AddressScreen3> with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController callController = TextEditingController();
  final TextEditingController accessController = TextEditingController();
  late DateTime startDate = DateTime.now();
  late DateTime endDate = DateTime.now();
  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String postCode = '우편번호';
  String address2 = '도로명 / 지번';

  String delivery  = '직접 받고 부재 시 문 앞';
  List<String> deliverys = ['직접 받고 부재 시 문 앞', '문 앞', '경비실', '택배함', '기타사항'];

  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalPrice.toString(),
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void placeOrders() {
    Duration diff = endDate.difference(startDate);
    int diffInDays = diff.inDays;
    print(diffInDays);
    addressToBeUsed =
    '${nameController.text}, ${pincodeController.text} - ${areaController.text}, '
        '${cityController.text}, ${callController.text}, ${accessController.text}';
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: widget.totalPrice*diffInDays,
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String(),
        index: widget.index
    );
    Navigator.pop(context);
  }


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    callController.dispose();
    accessController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

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
                    '예약하기',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('날짜 선택',
                style: TextStyle(
                  fontFamily: 'Nanum Round',
                  fontSize: 12,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w800,
                  height: 0.25,
                ),),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffAEAEAE), width:1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: TextButton(
                      onPressed: _selectStartDate,
                      child: Text(
                        startDate != null
                            ? '시작 날짜: ${DateFormat('yyyy-MM-dd').format(startDate!)}'
                            : '시작 날짜 선택',
                        style: TextStyle(
                          fontFamily: 'Nanum Round',
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    height: 40,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffAEAEAE), width:1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: TextButton(
                      onPressed: _selectEndDate,
                      child: Text(
                        endDate != null
                            ? '종료 날짜: ${DateFormat('yyyy-MM-dd').format(endDate!)}'
                            : '종료 날짜 선택',
                        style: TextStyle(
                          fontFamily: 'Nanum Round',
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _addressFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('받는 사람',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 12,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
                      ),),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: nameController,
                      hintText: '받는 분 성함 입력',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('주소',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 12,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
                      ),),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: postCode,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: address2,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: '상세주소',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => KpostalView(
                                  useLocalServer: false,
                                  // kakaoKey: '{Add your KAKAO DEVELOPERS JS KEY}',
                                  callback: (Kpostal result) {
                                    setState(() {
                                      this.postCode = result.postCode;
                                      this.address2 = result.address;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFA6E247))),
                          child: Text(
                            '주소 찾기',
                            style: TextStyle(
                              fontFamily: 'Nanum Round',
                              fontSize: 14,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('연락처',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 12,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
                      ),),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: callController,
                      hintText: '구매자 전화번호 입력',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('출입정보',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 12,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
                      ),),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: accessController,
                      hintText: 'ex) 출입 비밀번호 1234',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('배송 요청사항',
                      style: TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 12,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
                      ),),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        child: DropdownButton(
                          value: delivery,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: deliverys.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item,
                                style: TextStyle(
                                  fontFamily: 'Nanum Round',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),),
                            );
                          }).toList(),
                          onChanged: (String? newVal) {
                            setState(() {
                              delivery = newVal!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: '입력 완료',
                        onTap: () {placeOrders();}
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
  Future<void> _selectStartDate() async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedStartDate != null && pickedStartDate != startDate) {
      setState(() {
        startDate = pickedStartDate;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedEndDate != null && pickedEndDate != endDate) {
      setState(() {
        endDate = pickedEndDate;
      });
    }
  }
}
