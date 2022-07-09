import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/Model/model.dart';
import 'package:student_app/Screens/screen_home.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  Hive.registerAdapter(StudentModelAdapter());

  await Hive.openBox<StudentModel>(boxname);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.grey[800]),
        scaffoldBackgroundColor: Colors.black,
        fontFamily: GoogleFonts.acme().fontFamily,
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
    );
  }
}
