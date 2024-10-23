

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/add_contact.dart';
import '../provider/contct_provider.dart';

class CallListPage extends StatefulWidget {
  const CallListPage({super.key});

  @override
  State<CallListPage> createState() => _CallListPageState();
}

class _CallListPageState extends State<CallListPage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ),
        ),

        // Contact List
        Expanded(
          child: Consumer<ContactProvider>(
            builder: (BuildContext context, ContactProvider value, Widget? child) {
              List<Contact> filteredContacts = value.contactList.where((contact) {
                return contact.name!.toLowerCase().contains(searchQuery);
              }).toList();

              if (filteredContacts.isEmpty) {
                return const Center(
                  child: Text(
                    "No Contact",
                    style: TextStyle(fontSize: 50),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredContacts.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Contact contact = filteredContacts[index];

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, 'add_contact', arguments: index);
                                      },
                                    ),
                                    const Text('Edit', style: TextStyle(color: Colors.blue)),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        value.removeContact(index);
                                      },
                                    ),
                                    const Text('Delete', style: TextStyle(color: Colors.blue)),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.share, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        String shareText = "Please call me I am waiting ${contact.number}";
                                        Share.share(shareText);
                                      },
                                    ),
                                    const Text('Share', style: TextStyle(color: Colors.blue)),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.mail_outline_rounded, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        launchUrl(Uri.parse("mailto:${contact.email}"));
                                      },
                                    ),
                                    const Text('Mail', style: TextStyle(color: Colors.blue)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: contact.imagePath != null
                            ? ClipOval(
                          child: Image.file(
                            File(contact.imagePath!),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        )
                            : Text(
                          contact.name?.split("").first ?? "",
                          style: const TextStyle(color: Colors.white),
                        ),
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
                            icon: const Icon(Icons.call_outlined, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

