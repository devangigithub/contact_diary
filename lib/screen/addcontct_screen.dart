import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icon_button/tap_fill_icon.dart';
import 'package:provider/provider.dart';
import '../model/add_contact.dart';
import '../provider/contct_provider.dart';
import '../provider/home_provider.dart';
import 'package:image_picker/image_picker.dart';

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
  File? image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
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

    var isAndroid = Provider.of<HomeProvider>(context, listen: false).isAndroid;
    if (isAndroid) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [

            SliverPadding(
              padding: const EdgeInsets.all(18.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 50,),
                    Container(
                      height: 250,
                      // color: Color.fromARGB(255, r, g, b),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 250,
                              child: Column(
                                children: [
                                  image == null
                                  ?  Container(
                                    alignment: Alignment.center,
                              height: 170,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueAccent,
                                      width: 2
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blue.withOpacity(0.1),
                                ),
                                    child: IconButton(onPressed:pickImage, icon: Icon(Icons.camera_alt_outlined,
                                      color: Colors.black54,size: 40,)
                                    ),
                              )
                                      : SizedBox(
                                        child: CircleAvatar(
                                          radius: 80,
                                          backgroundImage: FileImage(image!),
                                        ),
                                      ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TapFillIcon(
                                        borderIcon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        fillIcon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(fontSize: 18),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                        icon: Icon(Icons.person,color: Colors.blue,),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 39),
                      child: TextFormField(
                        controller: surnameController,
                        style: TextStyle(fontSize: 18),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Surname",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: numberController,
                      style: TextStyle(fontSize: 18),
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Number",
                        icon: Icon(Icons.phone,color: Colors.blue,),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        icon: Icon(Icons.mail,color: Colors.blue,),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: addressController,
                      style: TextStyle(fontSize: 18),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Address",
                        icon: Icon(Icons.home,color: Colors.blue,),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: dobController,
                      style: TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Select DOB",
                        icon: Icon(Icons.cake,color: Colors.blue,),
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 39
                      ),
                      child: TextFormField(
                        controller: timeController,
                        style: TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
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
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Text color
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        Contact contact = Contact(
                          name: nameController.text,
                          number: numberController.text,
                          email: emailController.text,
                          address: addressController.text,
                           imagePath: image?.path,
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
                      child: Text(editIndex != null ? "Edit Contact" : "Add Contact",style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    else{
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(editIndex != null ? "Edit Contact" : "Add Contact"),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [

                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                        ),
                        child: Column(
                          children: [
                            image == null
                                ? SizedBox(
                                  child: Container(
                                    height: 170,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                            width: 2
                                      ),
                                  borderRadius: BorderRadius.circular(100),
                                      color: CupertinoColors.activeBlue.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      "A",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 150,
                                        color: CupertinoColors.activeBlue,
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                  ),
                                )
                                : SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Image.file(
                                  image!,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CupertinoButton(
                                  onPressed: pickImage,
                                  child: Icon(CupertinoIcons.camera, color: CupertinoColors.black, size: 40),
                                ),
                                TapFillIcon(
                                  borderIcon: const Icon(
                                    CupertinoIcons.heart,
                                    color: CupertinoColors.black,
                                    size: 40,
                                  ),
                                  fillIcon: const Icon(
                                    CupertinoIcons.heart_solid,
                                    color: CupertinoColors.systemRed,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      CupertinoTextField(
                        controller: nameController,
                        placeholder: "Name",
                        style: TextStyle(fontSize: 18),
                        placeholderStyle: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        minLines: 1,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: surnameController,
                        placeholder: "Surname",
                        style: TextStyle(fontSize: 18),
                        placeholderStyle: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        minLines: 1,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text
                      ),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: numberController,
                        placeholder: "Number",
                        style: TextStyle(fontSize: 18),
                        placeholderStyle: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.number,


                      ),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: emailController,
                        placeholder: "Email",
                        style: TextStyle(fontSize: 18),
                        placeholderStyle: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: addressController,
                        placeholder: "Address",
                        style: TextStyle(fontSize: 18),
                        placeholderStyle: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        minLines: 1,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: dobController,
                        placeholder: "Select DOB",
                        style: TextStyle(fontSize: 18),
                        placeholderStyle: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        readOnly: true,
                      prefix: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 250,
                                  color: CupertinoColors.systemBackground,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          initialDateTime: DateTime.now(),
                                          onDateTimeChanged: (DateTime date) {
                                            setState(() {
                                              dobController.text = "${date.day} / ${date.month} / ${date.year}";
                                            });
                                          },
                                        ),
                                      ),
                                      CupertinoButton(
                                        child: Text("Done"),
                                        onPressed: () {
                                          Navigator.pop(context); // Close the modal
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(CupertinoIcons.calendar),
                        ),
                      ),

                      const SizedBox(height: 10),
                      CupertinoTextField(
                          controller: timeController,
                          placeholder: "Select Time",
                          style: TextStyle(fontSize: 18),
                          placeholderStyle: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                          readOnly: true, // Prevent manual input
                          prefix: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 250,
                                    color: CupertinoColors.systemBackground,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: CupertinoTimerPicker(
                                            mode: CupertinoTimerPickerMode.hm, // Hours and minutes
                                            onTimerDurationChanged: (Duration newTimer) {
                                              setState(() {
                                                String formattedTime = "${newTimer.inHours.toString().padLeft(2, '0')}:${(newTimer.inMinutes % 60).toString().padLeft(2, '0')}";
                                                timeController.text = formattedTime;
                                              });
                                            },
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text("Done"),
                                          onPressed: () {
                                            Navigator.pop(context); // Close the modal
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(CupertinoIcons.clock), // Using a clock icon to represent time selection
                          ),
                        ),

                      const SizedBox(height: 50),
                      CupertinoButton.filled(
                        onPressed: () {
                          Contact contact = Contact(
                            name: nameController.text,
                            number: numberController.text,
                            email: emailController.text,
                            address: addressController.text,
                            imagePath: image?.path,
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
        ),
      );
    }

  }
}
