import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class IsoHomeScreen extends StatefulWidget {
  const IsoHomeScreen({super.key});

  @override
  State<IsoHomeScreen> createState() => _IsoHomeScreenState();
}

class _IsoHomeScreenState extends State<IsoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var isAndroid = Provider.of<HomeProvider>(context, listen: false).kIsWeb;

    // return isAndroid
    return (kIsWeb || defaultTargetPlatform == TargetPlatform.android)
        ? Scaffold( // Material design for Android
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return Switch(
                value: homeProvider.isAndroid,
                onChanged: (value) {
                  homeProvider.change();
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("Hello everyone"),
            ElevatedButton(
              child: Text("Click"),
              onPressed: () {
                print("Click");
                print("Android => ${Platform.isAndroid}");
                print("IOS => ${Platform.isIOS}");
                print("Linux => ${Platform.isLinux}");
                print("MacOS => ${Platform.isMacOS}");
                print("Windows => ${Platform.isWindows}");
                print("web => ${kIsWeb}");
              },
            ),
          ],
        ),
      ),
    )
        : CupertinoPageScaffold( // iOS design for iOS
      navigationBar: CupertinoNavigationBar(
        middle: Text("Home Screen"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Text("Hello everyone"),
            CupertinoButton(
              child: Text("Click"),
              onPressed: () {
                print("Click");
                print("Android => ${Platform.isAndroid}");
                print("IOS => ${Platform.isIOS}");
                print("Linux => ${Platform.isLinux}");
                print("MacOS => ${Platform.isMacOS}");
                print("Windows => ${Platform.isWindows}");
                print("web => ${kIsWeb}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
