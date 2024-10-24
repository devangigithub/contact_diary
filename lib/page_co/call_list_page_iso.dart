
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_one_contct/provider/contct_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/add_contact.dart';


class CallListPageIso extends StatefulWidget {
  const CallListPageIso({super.key});

  @override
  State<CallListPageIso> createState() => _CallListPageIsoState();
}

class _CallListPageIsoState extends State<CallListPageIso> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Contacts"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CupertinoSearchTextField(
                controller: searchController,
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
              ),
            ),
            Expanded(
              child: Consumer<ContactProvider>(
                builder: (BuildContext context, ContactProvider value, Widget? child) {
                  if (value.contactList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Contact",
                        style: TextStyle(fontSize: 50),
                      ),
                    );
                  }
                  final filteredContacts = value.contactList.where((contact) {
                    final phoneNumber = contact.name?.toLowerCase() ?? '';
                    return phoneNumber.contains(searchQuery.toLowerCase())||
                        contact.number!.contains(searchQuery);
                  }).toList();

                  return CupertinoScrollbar(
                    child: ListView.builder(
                      itemCount: filteredContacts.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        Contact contact = filteredContacts[index];
                        return CupertinoListTile(
                          title: Text(
                            contact.name ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            contact.number ?? "",
                            style: const TextStyle(color: CupertinoColors.inactiveGray),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => launchUrl(Uri.parse("tel:${contact.number}")),
                                child: const Icon(CupertinoIcons.phone),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Icon(CupertinoIcons.ellipsis),
                                onPressed: () => _showActionSheet(context, contact, value, index),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context, Contact contact, ContactProvider provider, int index) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(contact.name ?? ""),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'add_contact', arguments: index);
            },
            child: const Text("Edit"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              provider.removeContact(index);
            },
            isDestructiveAction: true,
            child: const Text("Delete"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              String shareText = "Please call me I am waiting ${contact.number}";
              Share.share(shareText);
            },
            child: const Text("Share"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              launchUrl(Uri.parse("mailto:${contact.email}"));
            },
            child: const Text("Email"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ),
    );
  }
}
