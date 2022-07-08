import 'package:hive/hive.dart';
 part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final int phone;
  @HiveField(3)
  late String branch;
  @HiveField(4)
  String? image;

  StudentModel({
    required this.name,
    required this.age,
    required this.phone,
    required this.branch,
    this.image,
  });
}

String boxname = 'student-model';

// class StudModelBox {
//   static Box<StudentModel>? _box;
//   static Box<StudentModel> getInstance() {
//     return _box ??= Hive.box(boxname);
//   }
// }
