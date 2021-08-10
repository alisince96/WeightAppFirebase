import 'dart:io';

import 'package:flutter/cupertino.dart';

deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Future<bool> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
  return null;
}

String insertCommasInString(String value) {
  return value.replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
}
