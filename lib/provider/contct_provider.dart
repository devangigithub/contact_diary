
import 'package:flutter/material.dart';

import '../model/add_contact.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contactList = [];

  void addContact(Contact contact) {
    contactList.add(contact);
    notifyListeners();
  }

  void editContact(Contact contact, int index) {
    contactList[index] = contact;
    notifyListeners();
  }

  void removeContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }
}
