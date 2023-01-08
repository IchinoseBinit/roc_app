import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/providers/user_provider.dart';

bool isAdmin(BuildContext context) {
  return Provider.of<UserProvider>(context, listen: false).getIsAdmin();
}

String getText(TextEditingController controller) {
  return controller.text.trim();
}

String getUserId() {
  return FirebaseAuth.instance.currentUser!.uid;
}
