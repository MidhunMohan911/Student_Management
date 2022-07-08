import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/Model/model.dart';
import 'package:student_app/Screens/screen_student_add.dart';

class ScreenStudentDetails extends StatelessWidget {
  final int index;

  ScreenStudentDetails({
    Key? key,
    required this.index,
  }) : super(key: key);

  Box<StudentModel> box = Hive.box<StudentModel>(boxname);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(234, 108, 104, 104),
            Color.fromARGB(255, 66, 65, 65),
            Color.fromARGB(255, 24, 24, 24),
            Color.fromARGB(66, 14, 14, 14)
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: ValueListenableBuilder(
            valueListenable: Hive.box<StudentModel>(boxname).listenable(),
            builder: (context, Box<StudentModel> box, _) {
              StudentModel? student = box.getAt(index);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    student!.image == null
                        ? const CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage("assets/download.jpeg"),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                              File(student.image.toString()),
                            ),
                            radius: 80,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Name : ${student.name}',
                      style: GoogleFonts.changa(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Age : ${student.age}',
                      style: GoogleFonts.changa(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone : ${student.phone}',
                      style: GoogleFonts.changa(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Place : ${student.branch}',
                      style: GoogleFonts.changa(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 250,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenAddStudent(
                                  index: index,
                                  isEditing: true,
                                  student: student,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                shadows: [Shadow(color: Colors.black)]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
