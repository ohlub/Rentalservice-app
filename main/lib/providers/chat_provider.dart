import 'package:flutter/material.dart';
import 'package:sharing_world2/models/chat.dart';

class ChatProvider extends ChangeNotifier {
  Chat _chat = Chat(
    id: '',
    member1: '',
    member2: '',
    message1: [],
    message2: [],
    sentAt1: [],
    sentAt2: [],
    name: '',
    images: [],
    price: 0,
    option: '',
    direct: false,
    delivery: false
  );

  Chat get chat => _chat;

  void setChat(String chat) {
    _chat = Chat.fromJson(chat);
    notifyListeners();
  }

  set chat(Chat newChat) {
    _chat = newChat;
    notifyListeners();
  }

  void setChatFromModel(Chat chat) {
    _chat = chat;
    notifyListeners();
  }
}