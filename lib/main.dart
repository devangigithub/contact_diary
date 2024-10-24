import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_one_contct/provider/contct_provider.dart';
import 'package:pr_one_contct/provider/home_provider.dart';
import 'package:pr_one_contct/provider/main_provider.dart';
import 'package:pr_one_contct/provider/theme_provider.dart';
import 'package:pr_one_contct/screen/addcontct_screen.dart';
import 'package:pr_one_contct/screen/home_screen.dart';
import 'package:pr_one_contct/screen/login_screen.dart';
import 'package:pr_one_contct/screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

late SharedPreferences preferences;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => ContactProvider()),
             ChangeNotifierProvider(create: (context) => HomeProvider()),
            ChangeNotifierProvider(create: (context) => MainProvider(),),
          ],
           builder: (context, child) {
           var isAndroid = Provider.of<HomeProvider>(context).isAndroid;

            return isAndroid
            ? MaterialApp(

            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => SplashScreen(),
              'home': (context) => HomeScreen(),
              'login': (context) => LoginScreen(),
              'add_contact': (context) => AddContact(),
            },
          )
          : CupertinoApp(
           initialRoute: '/',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => SplashScreen(),
           'home': (context) => HomeScreen(),
            'login': (context) => LoginScreen(),
             'add_contact': (context) => AddContact(),
          },
        );
        },
      ),
  );
}

