import 'package:flutter/material.dart';
import 'package:sharing_world2/model/message.dart';
import 'package:sharing_world2/providers/home.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'package:sharing_world2/constants/global_variables.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:sharing_world2/models/chat.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/features/address/screens/address_screen.dart';
import 'package:sharing_world2/features/address/screens/address_screen2.dart';
import 'package:sharing_world2/features/address/screens/address_screen3.dart';
import 'package:sharing_world2/common/widgets/custom_button2.dart';
import 'package:sharing_world2/models/product.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String chatname;
  final Chat chat;
  final int index;
  const ChatScreen({Key? key, required this.chat, required this.username, required this.chatname, required this.index}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket _socket;
  List<Chat>? chats;
  late TextEditingController _messageInputController;
  List<Message> allMessages = [];
  final AdminServices adminServices = AdminServices();
  late ScrollController _scrollController;


  void _sendMessage(String message) {
    if (message.trim().isNotEmpty) {
      if(mounted) {
        _socket.emit('message', {
          'message': message,
          'senderUsername': widget.username, //
        });
        addMessages(message, DateTime.now());
        _messageInputController.clear();
        FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
      }
    }
  }

  void fetchUser() async {
    chats = await adminServices.fetchAllChats(context);
    setState(() {
      _loadMessages();
    });
    Future.delayed(const Duration(milliseconds: 10), () {
      _scrollToBottom();
    });
  }

  @override
  void initState() {
    super.initState();
    _messageInputController = TextEditingController(); // 초기화 추가
    _socket = IO.io(
      uri,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'foo': 'bar'})
          .setQuery({'username': widget.chatname}) // 여기에 클라이언트의 유저네임을 추가
          .build(),
    );

    _socket.connect();
    print('Socket connected: ${_socket.connected}');

    _socket.on('message', (data) {
      if(mounted) {
        Provider.of<HomeProvider>(context, listen: false).addNewMessage(
          Message(
            message: data['message'],
            senderUsername: data['senderUsername'],
            sentAt: DateTime.now(),
          ),
        );
      }
    });
    fetchUser();
  }

  _loadMessages() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    final messages1 = chats![widget.index].message1;
    final messages2 = chats![widget.index].message2;
    final sentAt1 = chats![widget.index].sentAt1;
    final sentAt2 = chats![widget.index].sentAt2;


    for (int j = 0; j < messages1.length; j++) {
      if (messages1[j] != null) {
        final sentAt = DateTime.parse(sentAt1[j] ?? '');
        allMessages.add(Message(
          message: messages1[j],
          senderUsername: widget.chat.member1,
          sentAt: sentAt,
        ));
      }
    }

    for (int k = 0; k < messages2.length; k++) {
      if (messages2[k] != null) {
        final sentAt = DateTime.parse(sentAt2[k] ?? '');
        allMessages.add(Message(
          message: messages2[k],
          senderUsername: widget.chat.member2,
          sentAt: sentAt,
        ));
      }
    }
    allMessages.sort((a, b) => a.sentAt.compareTo(b.sentAt));

    for (int m = 0; m < allMessages.length; m++) {
      homeProvider.addNewMessage(allMessages[m]);
    }
  }

  void addMessages(String messageText, DateTime sentAt) {
    print(widget.chatname);
    print(widget.username);
    print(widget.chat.member1);
    print(widget.chat.member2);
    if ((widget.chat.member1 == widget.chatname &&
        widget.chat.member2 == widget.username)) {
      adminServices.addMessage2(
        context: context,
        member1: widget.chatname,
        member2: widget.username,
        name: widget.chat.name,
        message2: [messageText],
        sentAt2: [sentAt.toIso8601String()],
      );
    } else if ((widget.chat.member2 == widget.chatname &&
        widget.chat.member1 == widget.username)) {
      adminServices.addMessage1(
        context: context,
        member1: widget.username,
        member2: widget.chatname,
        name: widget.chat.name,
        message1: [messageText],
        sentAt1: [sentAt.toIso8601String()],
      );
    }
  }

  void deleteChat(Chat chat) {
    adminServices.deleteChat(
      context: context,
      name: widget.chat.name,
      username: widget.chatname,
    );
  }

  void _onMoreOptionsSelected(String option) {
    // 각 옵션에 대한 로직을 여기에 구현합니다.
    if (option == '채팅 나가기') {
      deleteChat(widget.chat);
      Navigator.pop(context);
      // 채팅 나가기 기능을 구현합니다.
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = ScrollController();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void navigateToAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddressScreen(
            totalPrice: widget.chat.price,
            index: widget.index
        ),
      ),
    );
  }

  void navigateToAddress2() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddressScreen2(
            totalPrice: widget.chat.price,
            index: widget.index
        ),
      ),
    );
  }


  void navigateToAddress3() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddressScreen3(
            totalPrice: widget.chat.price,
            index: widget.index
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: _onMoreOptionsSelected,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '채팅 나가기',
                  child: Text('채팅 나가기'),
                ),
                // 필요에 따라 추가 옵션을 더합니다.
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ...widget.chat.images.map((imageUrl) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                      width: 70,
                      height: 70,
                    ),
                  ),
                );
              }).toList(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: 5,
                    child: Text(
                      widget.chat.name,
                      style: const TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 15,
                        color: Color(0xff292929),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 10,
                    child: Text(
                      '${widget.chat.price.toInt()}원',
                      style: const TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 13,
                        color: Color(0xff292929),
                        fontWeight: FontWeight.w800,
                        height: 0.25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          widget.chat.option == 'BASIC'
              ? widget.chat.direct == true
              ? widget.chat.delivery == true
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: 100,
                  height: 30,
                  child: CustomButton2(
                    text: '직거래 예약',
                    onTap: () => navigateToAddress2(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: 100,
                  height: 30,
                  child: CustomButton2(
                    text: '배송 예약',
                    onTap: () => navigateToAddress(),
                  ),
                ),
              ),
            ],
          ) : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: 100,
                  height: 30,
                  child: CustomButton2(
                    text: '직거래 예약',
                    onTap: () => navigateToAddress2(),
                  ),
                ),
              ),
            ],
          ) : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: 100,
                  height: 30,
                  child: CustomButton2(
                    text: '배송 예약',
                    onTap: () => navigateToAddress(),
                  ),
                ),
              ),
            ],
          ) : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: 100,
                  height: 30,
                  child: CustomButton2(
                    text: '예약하기',
                    onTap: () => navigateToAddress3(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container( height:1.5,
            width:550.0,
            color:const Color(0xffEEEEEE),),
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (_, provider, __) {
                return ListView.builder(
                  controller: _scrollController, // 컨트롤러 설정
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    final message = provider.messages[index];
                    return Wrap(
                      alignment: message.senderUsername == widget.username
                          ? WrapAlignment.end
                          : WrapAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment:
                          message.senderUsername == widget.username
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              ),
                              color: message.senderUsername == widget.username
                                  ? const Color(0xffceeeaf)
                                  : const Color(0xfff6f6f6),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                child: Column(
                                  children: [
                                    Text(
                                      message.message,
                                      style: const TextStyle(
                                        fontFamily: 'Nanum Round',
                                        fontSize: 14,
                                        color: Color(0xff494949),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Padding(
                              padding: message.senderUsername == widget.username
                                  ? const EdgeInsets.fromLTRB(0, 0, 15, 0)
                                  : const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                DateFormat('hh:mm a').format(message.sentAt),
                                style: const TextStyle(
                                  fontFamily: 'Nanum Round',
                                  fontSize: 10,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width:1),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        fontFamily: 'Nanum Round',
                        fontSize: 16,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: '메시지를 입력해주세요.',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageInputController.text.trim().isNotEmpty) {

                        _sendMessage(_messageInputController.text);
                        _scrollToBottom();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}