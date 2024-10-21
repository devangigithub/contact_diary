// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pr_one_contct/provider/home_provider.dart';
// import 'package:pr_one_contct/provider/main_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../model/contact.dart';
// import '../provider/contct_provider.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     int r = Random().nextInt(255);
//     int g = Random().nextInt(255);
//     int b = Random().nextInt(255);
//
//     final String? username = ModalRoute.of(context)?.settings.arguments as String?;
//     var isAndroid = Provider.of<HomeProvider>(context, listen: false).isAndroid;
//
//     if (isAndroid) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Contact'),
//           actions: [
//             const SizedBox(height: 20),
//             Text(
//               username ?? "Guest",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(30.0),
//             child: Consumer<HomeProvider>(
//               builder: (context, homeProvider, child) {
//                 return Switch(
//                   value: homeProvider.isAndroid,
//                   onChanged: (value) => homeProvider.change(),
//                 );
//               },
//             ),
//           ),
//         ),
//         bottomNavigationBar:
//         Consumer<MainProvider>(builder:(context, value, child) {
//           return  BottomNavigationBar(
//
//               type:  BottomNavigationBarType.fixed,
//               currentIndex: value.menuIndex,
//               onTap: (index){
//                 print("index $index");
//                 value.pageController.animateToPage(index, duration: Duration(seconds: 100), curve: Curves.linear);
//               },
//               items: [
//             BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Search',),
//             BottomNavigationBarItem(icon:SizedBox.shrink() , label: 'Search',),
//             BottomNavigationBarItem(icon:SizedBox.shrink(), label: 'Search', ),
//           ]);
//         },),
//
//         body: Consumer<ContactProvider>(
//           builder: (BuildContext context, ContactProvider value, Widget? child) {
//             if (value.contactList.isEmpty) {
//               return const Center(
//                 child: Text(
//                   "No Contact",
//                   style: TextStyle(fontSize: 50),
//                 ),
//               );
//             }
//
//             return ListView.builder(
//               itemCount: value.contactList.length,
//               itemBuilder: (context, index) {
//                 Contact contact = value.contactList[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Color.fromARGB(255, r, g, b),
//                     child: Text(contact.name?.split("").first ?? ""),
//                   ),
//                   title: Text(
//                     contact.name ?? "",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     contact.number ?? "",
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: () => launchUrl(Uri.parse("tel:${contact.number}")),
//                         icon: const Icon(Icons.call),
//                       ),
//                       PopupMenuButton<String>(
//                         itemBuilder: (context) => [
//                           PopupMenuItem(
//                             value: "edit",
//                             child: Row(
//                               children: const [Icon(Icons.edit), Text("Edit")],
//                             ),
//                           ),
//                           PopupMenuItem(
//                             value: "delete",
//                             child: Row(
//                               children: const [Icon(Icons.delete), Text("Delete")],
//                             ),
//                           ),
//                           PopupMenuItem(
//                             value: "share",
//                             child: Row(
//                               children: const [Icon(Icons.share), Text("Share")],
//                             ),
//                           ),
//                           PopupMenuItem(
//                             value: "mail",
//                             child: Row(
//                               children: const [Icon(Icons.mail), Text("Email")],
//                             ),
//                           ),
//                         ],
//                         onSelected: (val) {
//                           switch (val) {
//                             case "edit":
//                               Navigator.pushNamed(context, 'add_contact', arguments: index);
//                               break;
//                             case "delete":
//                               value.removeContact(index);
//                               break;
//                             case "mail":
//                               launchUrl(Uri.parse("mailto:${contact.email}"));
//                               break;
//                             case "share":
//                               String shareText = "Please call me I am waiting ${contact.number}";
//                               Share.share(shareText);
//                               Share.shareXFiles([XFile("path")]);
//                               break;
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => Navigator.pushNamed(context, 'add_contact'),
//         ),
//       );
//     }
//     else
//       {
//         return CupertinoPageScaffold(
//             child:SafeArea(child:
//             Column(
//               children: [
//                 Text('them1',style: TextStyle(
//                   fontSize: 100
//                 ),),
//     Consumer<HomeProvider>(
//     builder: (context, homeProvider, child) {
//       return CupertinoSwitch(
//         value: homeProvider.isAndroid,
//         activeColor: Colors.red,
//         trackColor: Colors.black,
//         onChanged: (value) {
//           homeProvider.change();
//         },
//       );
//     }
//     ),
//
//               ],
//             )
//             )
//         );
//       }
//   }
// }


import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_one_contct/provider/home_provider.dart';
import 'package:pr_one_contct/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/contact.dart';
import '../provider/contct_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int r = Random().nextInt(255);
    int g = Random().nextInt(255);
    int b = Random().nextInt(255);

    final String? username = ModalRoute.of(context)?.settings.arguments as String?;
    var isAndroid = Provider.of<HomeProvider>(context, listen: false).isAndroid;

    if (isAndroid) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Contact'),
          actions: [
            const SizedBox(height: 20),
            Text(
              username ?? "Guest",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                return Switch(
                  value: homeProvider.isAndroid,
                  onChanged: (value) => homeProvider.change(),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar:
        Consumer<MainProvider>(builder:(context, value, child) {
          return  BottomNavigationBar(

              type:  BottomNavigationBarType.fixed,
              currentIndex: value.menuIndex,
              onTap: (index){
                print("index $index");
                value.pageController.animateToPage(index, duration: Duration(microseconds: 1000), curve: Curves.ease);
              },
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Search',),
            BottomNavigationBarItem(icon:SizedBox.shrink() , label: 'Search',),
            BottomNavigationBarItem(icon:SizedBox.shrink(), label: 'Search', ),
          ]);
        },),

        body: PageView(


          controller: Provider.of<MainProvider>(context, listen: false).pageController,
          onPageChanged: (value) {
            Provider.of<MainProvider>(context, listen: false)
                .changeMenuIndex(value);
          },
          children: [
            Consumer<ContactProvider>(
              builder: (BuildContext context, ContactProvider value, Widget? child) {
                if (value.contactList.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Contact",
                      style: TextStyle(fontSize: 50),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: value.contactList.length,
                  itemBuilder: (context, index) {
                    Contact contact = value.contactList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, r, g, b),
                        child: Text(contact.name?.split("").first ?? ""),
                      ),
                      title: Text(
                        contact.name ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        contact.number ?? "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => launchUrl(Uri.parse("tel:${contact.number}")),
                            icon: const Icon(Icons.call),
                          ),
                          PopupMenuButton<String>(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: "edit",
                                child: Row(
                                  children: const [Icon(Icons.edit), Text("Edit")],
                                ),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Row(
                                  children: const [Icon(Icons.delete), Text("Delete")],
                                ),
                              ),
                              PopupMenuItem(
                                value: "share",
                                child: Row(
                                  children: const [Icon(Icons.share), Text("Share")],
                                ),
                              ),
                              PopupMenuItem(
                                value: "mail",
                                child: Row(
                                  children: const [Icon(Icons.mail), Text("Email")],
                                ),
                              ),
                            ],
                            onSelected: (val) {
                              switch (val) {
                                case "edit":
                                  Navigator.pushNamed(context, 'add_contact', arguments: index);
                                  break;
                                case "delete":
                                  value.removeContact(index);
                                  break;
                                case "mail":
                                  launchUrl(Uri.parse("mailto:${contact.email}"));
                                  break;
                                case "share":
                                  String shareText = "Please call me I am waiting ${contact.number}";
                                  Share.share(shareText);
                                  Share.shareXFiles([XFile("path")]);
                                  break;
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Container(
              child: Text('hello'),
              color: Colors.blue,
            ),
            Container(
              child: Text('hello'),
              color: Colors.red,
            )


          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, 'add_contact'),
        ),
      );
    }
    else
      {
        return CupertinoPageScaffold(
            child:SafeArea(child:
            Column(
              children: [
                Text('them1',style: TextStyle(
                  fontSize: 100
                ),),
    Consumer<HomeProvider>(
    builder: (context, homeProvider, child) {
      return CupertinoSwitch(
        value: homeProvider.isAndroid,
        activeColor: Colors.red,
        trackColor: Colors.black,
        onChanged: (value) {
          homeProvider.change();
        },
      );
    }
    ),

              ],
            )
            )
        );
      }
  }
}


