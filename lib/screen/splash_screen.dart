import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigateToNextScreen() {
    if(preferences.getBool("continue") ?? false) {
      Navigator.of(context).pushReplacementNamed('home');
    }else
      Navigator.of(context).pushReplacementNamed('login');
  }
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      // Navigator.of(context).pushReplacementNamed('home');
      navigateToNextScreen();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(''),
          Text('Contact Diary',)
        ],
      ),
    );
  }
}
