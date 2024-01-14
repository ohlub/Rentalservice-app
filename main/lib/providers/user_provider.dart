import 'package:flutter/material.dart';
import 'package:sharing_world2/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    region: '',
    token: '',
    cart: [],
    order: [],
    search: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void updateUserRegion(String newRegion) {
    _user = _user.copyWith(region: newRegion);
    notifyListeners();
  }

  void updateUserSearch(List<String> newSearch) {
    _user = _user.copyWith(search: newSearch);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
