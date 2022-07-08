import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/Model/model.dart';

class ScreenAddStudent extends StatefulWidget {
  ScreenAddStudent({
    Key? key,
    this.isEditing = false,
    this.student,
    this.index,
  }) : super(key: key);
  bool isEditing;
  StudentModel? student;
  int? index;

  @override
  State<ScreenAddStudent> createState() => _ScreenAddStudentState();
}

class _ScreenAddStudentState extends State<ScreenAddStudent> {
  XFile? file;

  dynamic pickImage(ImageSource source) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    file = pickedFile;
    imagePath = file!.path;
    setState(() {});
  }

  @override
  void initState() {
    if (widget.isEditing) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age.toString();
      phoneController.text = widget.student!.phone.toString();
      placeController.text = widget.student!.branch;
      imagePath = widget.student!.image.toString();
    }

    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  // late String name, branch;

  // int? age, phone;
  String? imagePath;
  Box<StudentModel> studentBox = Hive.box<StudentModel>(boxname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                      color: Colors.grey[800]),
                ),
                imagePath == null
                    ? const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/user.png'),
                          radius: 80,
                        ),
                      )
                    : Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(File(imagePath!)),
                          radius: 80,
                        ),
                      ),
                Positioned(
                  left: 240,
                  bottom: -3,
                  child: IconButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(
                      CupertinoIcons.photo_camera_solid,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // CircleAvatar(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: nameController,
                      // onChanged: (value) {
                      //   setState(
                      //     () {
                      //       name = value;
                      //     },
                      //   );
                      // },
                      validator: (value) {
                        String pattern = r'(^[a-z A-Z]+$)';
                        RegExp regExp = RegExp(pattern.toString());
                        if (value!.isEmpty) {
                          return 'enter a name';
                        } else if (!regExp.hasMatch(value)) {
                          return 'please enter a valid name';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.edit,
                          color: Colors.white60,
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.white60),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      // onChanged: (value) {
                      //   setState(
                      //     () {
                      //       age = int.parse(value);
                      //     },
                      //   );
                      // },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter age';
                        } else if (int.parse(value) < 17 ||
                            int.parse(value) > 45) {
                          return 'please enter b/w 18-45';
                        }
                      },
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.person_fill,
                          color: Colors.white60,
                        ),
                        hintText: 'Age',
                        hintStyle: TextStyle(color: Colors.white60),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      // onChanged: (value) {
                      //   setState(
                      //     () {
                      //       phone = int.parse(value);
                      //     },
                      //   );
                      // },
                      validator: (value) {
                        String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = RegExp(patttern.toString());
                        if (value == null || value.isEmpty) {
                          return 'enter phone number';
                        } else if (!regExp.hasMatch(value)) {
                          return 'please enter a valid phone number';
                        }
                      },
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_iphone_rounded,
                          color: Colors.white60,
                        ),
                        hintText: 'Phone',
                        hintStyle: TextStyle(color: Colors.white60),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autocorrect: true,
                      controller: placeController,
                      // onChanged: (value) {
                      //   setState(
                      //     () {
                      //       branch = value;
                      //     },
                      //   );
                      // },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter branch';
                        } else if (value.trim().isEmpty) {
                          return 'please enter a branch';
                        }
                      },
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.place,
                          color: Colors.white60,
                        ),
                        hintText: 'place',
                        hintStyle: TextStyle(color: Colors.white60),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel'),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              StudentModel std = StudentModel(
                                  name: nameController.text,
                                  age: int.parse(ageController.text.toString()),
                                  phone: int.parse(
                                      phoneController.text.toString()),
                                  branch: placeController.text,
                                  image: imagePath);

                              if (widget.isEditing) {
                                studentBox.putAt(widget.index!, std);
                              } else {
                                studentBox.add(std);
                              }
                              // Navigator.of(context).pop();
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: widget.isEditing
                                    ? const Text(
                                        'Student details updated',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : const Text(
                                        'student added successfully',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                          child: widget.isEditing
                              ? const Text('Update Student')
                              : const Text('Add Student'),
                        ),
                      ],
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
