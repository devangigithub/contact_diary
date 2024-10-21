// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// class HomeProvider extends ChangeNotifier{
//
//   bool isAndroid = Platform.kIsWeb;
//
//   void change(){
//
//     isAndroid=!isAndroid;
//
//     notifyListeners();
//
//   }
//
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {

  bool isAndroid = !kIsWeb;

  void change() {
    isAndroid = !isAndroid;
    notifyListeners();
  }
}
