import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/Controller/controller.dart';
import 'package:student_app/Model/model.dart';
import 'package:student_app/Screens/screen_student_add.dart';
import 'package:student_app/Screens/student_details.dart';
import 'package:student_app/Search/search.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  Box<StudentModel> box = Hive.box<StudentModel>(boxname);

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student details',
          style: GoogleFonts.adamina(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          )
        ],
      ),
      body: GetBuilder<Controller>(builder: (objController) {
        if (box.isEmpty) {
          return const Center(
            child: Text('No Students found'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              itemCount: box.length,
              itemBuilder: (context, index) {
                StudentModel? student = box.getAt(index);
                return Card(
                  color: const Color.fromARGB(255, 51, 51, 51),
                  shadowColor: Colors.white,
                  elevation: 8,
                  // shape: BeveledRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1.8,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      iconColor: Colors.red,
                      textColor: Colors.white,
                      onTap: () {
                        Get.to(ScreenStudentDetails(index: index));
                      },
                      leading: student!.image == null
                          ? const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/download.jpeg"),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(
                                File(student.image.toString()),
                              ),
                              radius: 30,
                            ),
                      title: Text(student.name),
                      trailing: IconButton(
                        onPressed: () {
                          // box.deleteAt(index);
                          objController.deleteStudent(index);
                          // Get.defaultDialog(
                          //     title: 'Are you want to delete?',
                          //     titleStyle: const TextStyle(color: Colors.white),
                          //     backgroundColor: Colors.black,
                          //     textCancel: 'cancel',
                          //     cancelTextColor: Colors.white,
                          //     textConfirm: 'confirm',
                          //     confirmTextColor: Colors.white,
                          //     onConfirm: () {
                          //       objController.deleteStudent(index);
                          //       Get.back();
                          //     });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          );
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ScreenAddStudent()));
          Get.to(ScreenAddStudent());
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Student'),
      ),
    );
  }
}
