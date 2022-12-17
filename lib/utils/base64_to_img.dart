import 'dart:convert';

import 'package:flutter/foundation.dart';

Uint8List imageFromBase64String(String base64String) {
  return base64Decode(stripBase64String(base64String));
}

String stripBase64String(String body) {
  if (body.trim().isEmpty) {
    return "";
  } else if (!body.contains(",")) {
    return body;
  }
  final replaced = body.trim().replaceFirst(",", " ");
  final list = replaced.split(" ");
  return list[1];
}
