import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/custom_button.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/constants/utils.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';

enum Options { BASIC, PREMIUM }

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  String seller = '';
  String category = '전자기기';
  String type = 'regist';
  String option = 'BASIC';
  List<File> images = [];
  Options _options = Options.BASIC;
  var _isChecked1 = true;
  var _isChecked2 = false;

  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = ['전자기기', '생활용품', '의류', '도서'];

  void sellProduct() {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        images: images,
        price: double.parse(priceController.text),
        quantity: 1,
        description: descriptionController.text,
        category: category,
        seller: seller,
        type: type,
        region: user.region,
        option: option,
        direct: _isChecked1,
        delivery: _isChecked2,
        reviews: [],
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    seller = user.name;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            '물건 등록',
            style: TextStyle(
              fontFamily: 'Nanum Round',
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '사진을 선택하세요',
                                    style: TextStyle(
                                      fontFamily: 'Nanum Round',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: productNameController,
                    style: const TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '물건 이름',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                  Container(
                    color: Colors.black12.withOpacity(0.08),
                    height: 1.5,
                  ),
                  TextFormField(
                    controller: priceController,
                    style: const TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '가격',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                  Container(
                    color: Colors.black12.withOpacity(0.08),
                    height: 1.5,
                  ),
                  Container(
                    height: 50,
                    width: 260,
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            title: Text('일반거래',
                              style: const TextStyle(
                                fontFamily: 'Nanum Round',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),),
                            value: Options.BASIC,
                            groupValue: _options,
                            onChanged: (value) {
                              setState(() {
                                _options = value!;
                                option = 'BASIC';
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            title: Text('대세케어',
                              style: const TextStyle(
                                fontFamily: 'Nanum Round',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),),
                            value: Options.PREMIUM,
                            groupValue: _options,
                            onChanged: (value) {
                              setState(() {
                                _options = value!;
                                option = 'PREMIUM';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black12.withOpacity(0.08),
                    height: 1.5,
                  ),
                  _options == Options.PREMIUM
                      ? Container()
                  : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: const Text('직거래 가능',
                                style: const TextStyle(
                                  fontFamily: 'Nanum Round',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),),
                              value: _isChecked1,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked1 = value!;
                                });
                              },
                              selected: _isChecked1,
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: const Text('배송거래 가능',
                                style: const TextStyle(
                                  fontFamily: 'Nanum Round',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),),
                              value: _isChecked2,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked2 = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black12.withOpacity(0.08),
                        height: 1.5,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: DropdownButton(
                        value: category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
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
                            category = newVal!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    style: const TextStyle(
                      fontFamily: 'Nanum Round',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                    maxLines: 10,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '상세하게 물건의 설명을 적어주세요.',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x61000000),
                              width:0.5,
                            )
                        ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            width: 1.5,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: '올리기',
                    onTap: sellProduct,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
