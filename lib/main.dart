import 'package:flutter/material.dart';
import 'package:studentlist/db/model/data_model.dart';
import 'package:studentlist/screens/subscreens/studentlist.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(StudentModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my app',
      home: const StudentList(),
      theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Color.fromARGB(255, 158, 158, 167))),
      debugShowCheckedModeBanner: false,
    );
  }
}
