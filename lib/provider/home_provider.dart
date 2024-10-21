import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{

  bool isAndroid =false;

  void change(){

    isAndroid=!isAndroid;

    notifyListeners();

  }

}