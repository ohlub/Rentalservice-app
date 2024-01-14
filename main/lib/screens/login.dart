import 'package:flutter/material.dart';
import 'package:sharing_world2/providers/home.dart';
import 'package:sharing_world2/providers/login.dart';
import 'package:sharing_world2/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:sharing_world2/providers/user_provider.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:sharing_world2/models/chat.dart';
import 'package:sharing_world2/common/widgets/loader.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Chat>? chats;
  String chatUser = '';
  String chatMessage = '';
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    chats = await adminServices.fetchAllChats(context);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;

    return chats == null
      ? const Loader()
      : Scaffold(
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
                  alignment: const Alignment(-0.93, 0.2),
                  height: 50,
                  child: const Text(
                    '채팅',
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
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1.5,
              ),
              Selector<LoginProvider, String>(
                selector: (_, provider) => provider.errorMessage,
                builder: (_, errorMessage, __) => errorMessage != ''
                    ? Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Card(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
                    : Container(),
              ),
            ],
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: chats!.length,
            itemBuilder: (context, index) {
              final chatData = chats![index];
              String chatUser = '';
              if (chats![index].member1 == user.name){
                chatUser = chats![index].member2;
                if (chats![index].message2.isNotEmpty) {
                  chatMessage = chats![index].message2.last;
                } else {
                  chatMessage = '';
                }
              } else if (chats![index].member2 == user.name){
                chatUser = chats![index].member1;
                if (chats![index].message1.isNotEmpty) {
                  chatMessage = chats![index].message1.last;
                } else {
                  chatMessage = '';
                }
              } else {
                return Container();
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ChangeNotifierProvider(
                            create: (context) => HomeProvider(),
                            child: ChatScreen(
                                chat: chatData,
                              username: user.name,
                              chatname: chatUser,
                                index: index
                            ),
                          ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/person.png',
                            fit: BoxFit.fill,
                            width: 60,
                            height: 60,
                          ),
                        ),

                        Column(
                          children: [
                            Container(
                              alignment: const Alignment(-1.0, -1.0),
                              height: 10,
                              width: 200,
                              child: Text(
                                chatUser,
                                style: const TextStyle(
                                  fontFamily: 'Nanum Round',
                                  fontSize: 15,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w800,
                                  height: 0.25,
                                ),
                              ),
                            ),
                            Container(
                              alignment: const Alignment(-0.99, 4.0),
                              height: 10,
                              width: 200,
                              child: Text(
                                chatMessage,
                                style: const TextStyle(
                                  fontFamily: 'Nanum Round',
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                  height: 0.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 5),
                          child: Container(
                            alignment: const Alignment(-3.0, 0.0),
                            child: Icon(
                              Icons.chevron_right, size: 35
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
