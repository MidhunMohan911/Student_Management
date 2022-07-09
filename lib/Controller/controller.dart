import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/Model/model.dart';

class Controller extends GetxController {
  final studentBox = Hive.box<StudentModel>(boxname);

  String? imagePath;

  dynamic pickImage(ImageSource gallery) async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    imagePath = file.path;
    update();
  }

  void addStudent(StudentModel studentDetails) {
    studentBox.add(studentDetails);
    update();
  }

  void editStudent(int index, StudentModel studentDetails) {
    studentBox.putAt(index, studentDetails);
    update();
  }

  void deleteStudent(int index) {
    studentBox.deleteAt(index);
    update();
  }
}
