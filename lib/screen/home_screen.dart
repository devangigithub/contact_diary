import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pr_one_contct/provider/home_provider.dart';
import 'package:pr_one_contct/provider/main_provider.dart';
import 'package:provider/provider.dart';
import '../page_ad/call_list_page.dart';
import '../page_ad/income_call_android.dart';
import '../page_ad/setting_android.dart';
import '../page_co/call_list_page_iso.dart';
import '../page_co/income_call_iso.dart';
import '../page_co/setting_iso.dart';
import 'addcontct_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final String? username = ModalRoute.of(context)?.settings.arguments as String?;
    var isAndroid = Provider.of<HomeProvider>(context, listen: false).isAndroid;

    if (isAndroid) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Contacts',style: TextStyle(
            fontSize: 30,
            color: Colors.blue
          ),),

          actions: [
            const SizedBox(height: 20),
            Text(
              username ?? "Guest",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10,),
            Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                return Switch(
                  value: homeProvider.isAndroid,
                  trackColor: MaterialStateProperty.all(Colors.black54),
                  onChanged: (value) => homeProvider.change(),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: Consumer<MainProvider>(
          builder: (context, value, child) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: value.menuIndex,
              backgroundColor: Colors.white,
              fixedColor: Colors.blue,
              onTap: (index) {
                value.pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.ease,
                );
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.person_3), label: 'Contacts'),
                BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: 'Recent'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            );
          },
        ),
        body: PageView(
          controller: Provider.of<MainProvider>(context, listen: false).pageController,
          onPageChanged: (value) {
            Provider.of<MainProvider>(context, listen: false).changeMenuIndex(value);
          },
          children: [
            CallListPage(),
            ContactListScreen(),
            SettingsPage(),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () async {
            LocalAuthentication authentication = LocalAuthentication();

            if (await authentication.isDeviceSupported()) {
              print("isDeviceSupported");

              bool isAuth = await authentication.authenticate(
                  localizedReason: "Please authenticate to add Contact"
              );

              if (isAuth) {
                Navigator.pushNamed(context, 'add_contact');
              }
              print("isAuth $isAuth");
            } else {
              print("isDeviceSupported false");
            }
          },
        ),

      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                username ?? "Guest",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  return CupertinoSwitch(
                    value: homeProvider.isAndroid,
                    trackColor: Colors.black54,
                    onChanged: (value) {
                      homeProvider.change();
                    },
                  );
                },
              ),
            ],
          ),
        ),
        child: Stack(
          children: [
            Consumer<MainProvider>(
              builder: (context, value, child) {
                return CupertinoTabScaffold(
                  tabBar: CupertinoTabBar(
                    currentIndex: value.menuIndex,
                    onTap: (index) {
                      value.changeMenuIndex(index);
                      value.pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    items: const [
                      BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_2), label: 'Contacts'),
                      BottomNavigationBarItem(icon: Icon(CupertinoIcons.time), label: 'Recent'),
                      BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
                    ],
                  ),
                  tabBuilder: (context, index) {
                    return CupertinoTabView(
                      builder: (context) {
                        if (index == 0) {
                          return CallListPageIso();
                        } else if (index == 1) {
                          return ContactListScreenIso();
                        } else if (index == 2) {
                          return SettingsPageIso();
                        }
                        return Container();
                      },
                    );
                  },
                );
              },
            ),
            Positioned(
              bottom: 80,
              right: 16,
              child: CupertinoButton(
                onPressed: () async {
                  LocalAuthentication authentication = LocalAuthentication();
                  if (await authentication.isDeviceSupported()) {
                    print("isDeviceSupported");

                    bool isAuth = await authentication.authenticate(
                        localizedReason: "Please authenticate to add Contact"
                    );

                    if (isAuth) {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => AddContact(),
                        ),
                      );
                    }
                    print("isAuth $isAuth");
                  } else {
                    print("isDeviceSupported false");
                  }
                },
                color: CupertinoColors.activeBlue,
                child: const Icon(CupertinoIcons.add),
              ),
            ),

          ],
        ),
      );
    }
  }
}
