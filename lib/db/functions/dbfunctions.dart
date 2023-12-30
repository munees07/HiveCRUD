import 'package:flutter/material.dart';
import 'package:studentlist/db/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final hivebox = await Hive.box('studentList');
  await hivebox.add(value);

  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final hivebox = await Hive.box('studentList');
  await hivebox.deleteAt(index);
  studentListNotifier.notifyListeners();
}

Future<void> editstudent(index, StudentModel value) async {
  final studentDB = await Hive.box('studentList');
  studentListNotifier.notifyListeners();
  studentDB.putAt(index, value);
}
