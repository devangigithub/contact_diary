import 'dart:math';

import 'package:flutter/material.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Contact'),
        actions: [
          // CircleAvatar(
          //   radius: 20,
          //   child: Text(
          //     // username ? username[0].toUpperCase() : "",
          //     // username != null ? username[0].toUpperCase() : "",
          //     //
          //     // style: const TextStyle(fontSize: 22, color: Colors.white),
          //   ),
          //   backgroundColor: Colors.blue,
          // ),
          const SizedBox(height: 20),
          Text(
            // "${username}",
            // username ?? "",
              username ?? "Guest",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
         ],
      ),

      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {

          if (value.contactList.isEmpty) {
            return Center(
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
                  child: Text("${contact.name?.split("").first}"),
                ),
                title: Text(
                  contact.name ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  contact.number ?? "",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse("tel:${contact.number}"));
                        },
                        icon: Icon(Icons.call)),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.edit), Text("Edit")],
                            ),
                            value: "edit",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.delete), Text("Delete")],
                            ),
                            value: "delete",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.share), Text("Share")],
                            ),
                            value: "share",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.mail), Text("Email")],
                            ),
                            value: "mail",
                          ),
                        ];
                      },
                      onSelected: (val) {
                        print("onSelected $val");
                        if (val == "edit") {
                          Navigator.pushNamed(context, 'add_contact',
                              arguments: index);
                        }
                        if (val == "delete") {
                          value.removeContact(index);
                        }
                        if (val == "mail") {
                          launchUrl(Uri.parse("mailto:${contact.email}"));
                        }
                        if (val == "share") {
                          String shareText =
                              "Please call me i am waiting ${contact.number}";
                          Share.share(shareText);
                          Share.shareXFiles([XFile("path")]);
                        }
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, 'add_contact');
          // LocalAuthentication authentication = LocalAuthentication();
          // if (await authentication.isDeviceSupported()) {
          //   print("isDeviceSupported");
          //   bool isAuth = await authentication.authenticate(
          //       localizedReason: "Please authenticate to add Contact");
          //   if (isAuth) {
          //     Navigator.pushNamed(context, PageName.addContact);
          //   }
          //   print("isAuth $isAuth");
          // } else {
          //   print("isDeviceSupported false");
          // }
        },
      ),
    );
  }

}
