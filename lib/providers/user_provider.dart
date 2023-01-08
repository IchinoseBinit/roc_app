import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';

import '/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

  bool getIsAdmin() {
    return _user.isAdmin;
  }

  setUser(Map obj) {
    _user = User.fromJson(obj);
    notifyListeners();
  }

  User get user => _user;

  Map<String, dynamic> createUser({
    required String uuid,
    required String email,
    required String name,
    required String address,
    required String phoneNumber,
    required bool isAdmin,
  }) {
    _user = User(
      uuid: uuid,
      email: email,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      isAdmin: isAdmin,
      image: null,
      photoUrl: null,
    );
    final map = _user.toJson();
    // _user = null;
    return map;
  }

  Map<String, dynamic> updateUser({
    required String name,
    required String address,
    required String phoneNumber,
    String? panNumber,
    required bool isAdmin,
  }) {
    _user = User(
      uuid: _user.uuid,
      email: _user.email,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      isAdmin: isAdmin,
      image: _user.tempImage,
      photoUrl: null,
    );

    notifyListeners();
    return _user.toJson();
  }

  updateUserImage(String image) {
    _user.tempImage = image;
    notifyListeners();
  }

  logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}
