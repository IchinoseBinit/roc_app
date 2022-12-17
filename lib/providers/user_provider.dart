import 'package:flutter/cupertino.dart';
import '/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

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
    String? panNumber,
    required bool isFoodDonor,
  }) {
    _user = User(
      uuid: uuid,
      email: email,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      isFoodDonor: isFoodDonor,
      panNumber: panNumber,
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
    required bool isFoodDonor,
  }) {
    _user = User(
      uuid: _user.uuid,
      email: _user.email,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      isFoodDonor: isFoodDonor,
      panNumber: panNumber,
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

  logout() {}
}
