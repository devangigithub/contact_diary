import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/contactList.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Phone',
          style: TextStyle(fontSize: 30, color: Colors.black87),
        ),
      ),
      body: Container(
        color: CupertinoColors.white,
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: CupertinoColors.systemBlue,
                child: Text(
                  contact.name[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(contact.name),
              subtitle: Text('${contact.phoneType} • ${contact.date}'),
              trailing: Icon(
                CupertinoIcons.phone,
                color: CupertinoColors.systemBlue,
              ),
              onTap: () {
                // Handle tap on contact
              },
            );
          },
        ),
      ),
    );
  }
}
