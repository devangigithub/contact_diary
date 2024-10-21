import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/contact.dart';
import '../provider/contct_provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  int? editIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int r = Random().nextInt(255);
    int g = Random().nextInt(255);
    int b = Random().nextInt(255);

    editIndex = ModalRoute.of(context)?.settings.arguments as int?;
    if (editIndex != null) {
      Contact contact = Provider.of<ContactProvider>(context, listen: false).contactList[editIndex!];
      nameController.text = contact.name ?? "";
      surnameController.text = contact.surname ?? "";
      numberController.text = contact.number ?? "";
      emailController.text = contact.email ?? "";
      addressController.text = contact.address ?? "";
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   title: Column(
          //     children:  Text("A",style: TextStyle(
          //       fontWeight: FontWeight.w800,
          //       fontSize: 100,
          //       color: Colors.white,
          //     ),),
          //   ),
          //   pinned: true,
          //   expandedHeight: 250,
          //   backgroundColor: Color.fromARGB(255, r, g, b),
          //   flexibleSpace: const FlexibleSpaceBar(
          //     expandedTitleScale: 1.5, // Controls how large the title expands
          //     collapseMode: CollapseMode.parallax,
          //   ),
          // ),
          SliverAppBar(
            title: Column(
              children: [
                  // Text(
                  //   "A",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w800,
                  //     fontSize: 100,
                  //     color: Colors.white,
                  //   ),
                  // ),
              ],
            ),
            pinned: true,
            expandedHeight: 250,
            backgroundColor: Color.fromARGB(255, r, g, b), // Make sure to define r, g, b values
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.5, // Controls how large the title expands
              collapseMode: CollapseMode.parallax,
              title: Container(
                alignment: Alignment.center, // Align title as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30,),
                    Text(
                      "A",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 100,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(18.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      icon: Icon(Icons.face),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: surnameController,
                    decoration: const InputDecoration(
                      hintText: "Surname",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: numberController,
                    decoration: const InputDecoration(
                      hintText: "Number",
                      icon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      icon: Icon(Icons.mail),
                    ),
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: "Address",
                      icon: Icon(Icons.home),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      hintText: "Select DOB",
                      icon: Icon(Icons.cake),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2005),
                        currentDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      );
                      if (selectDate != null) {
                        dobController.text = "${selectDate.day}-${selectDate.month}-${selectDate.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: timeController,
                    decoration: const InputDecoration(
                      hintText: "Select Time",
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {

                          return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), // Force 24-hour format
                          child: child!,
                          );
                        },
                      );
                      if (time != null) {
                        timeController.text = "${time.hour}:${time.minute}";
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Contact contact = Contact(
                        name: nameController.text,
                        number: numberController.text,
                        email: emailController.text,
                        address: addressController.text,
                      );

                      if (editIndex == null) {
                        Provider.of<ContactProvider>(context, listen: false).addContact(contact);
                      } else {
                        Provider.of<ContactProvider>(context, listen: false).editContact(contact, editIndex!);
                      }

                      nameController.clear();
                      surnameController.clear();
                      numberController.clear();
                      emailController.clear();
                      addressController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(editIndex != null ? "Edit Contact" : "Add Contact"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
