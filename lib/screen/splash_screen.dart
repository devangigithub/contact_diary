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
      navigateToNextScreen();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,

        height: 700,
        width: double.infinity,
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 250,
              alignment: Alignment.center,
                child: Image.network('https://cdn-icons-png.flaticon.com/256/3238/3238016.png',height: 180,width: 140,)),
            SizedBox(height: 20,),
            Text('Contact  Diary',style: TextStyle(
              fontSize: 40,
              letterSpacing: 4,
              wordSpacing: 5,
              fontWeight: FontWeight.w500,
            ),)
          ],
        ),
      ),
    );
  }
}
