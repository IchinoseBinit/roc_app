import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';

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

  updateUserImage(BuildContext context, String image) async {
    try {
      _user.image = image;

      await FirebaseHelper().addOrUpdateContent(
        context,
        collectionId: UserConstants.userCollection,
        whereId: UserConstants.userId,
        whereValue: user.uuid,
        map: _user.toJson(),
      );
    } catch (ex) {
      GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
    notifyListeners();
  }

  logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}
