import 'package:flutter/material.dart';
import 'package:studentlist/db/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

void addStudent(StudentModel value) {
  final hivebox = Hive.box('studentList');

  hivebox.add(value);
  studentListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

void deleteStudent(int index) {
  final hivebox = Hive.box('studentList');
  hivebox.deleteAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

void editstudent(index, StudentModel value) {
  final studentDB = Hive.box('studentList');
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
  studentDB.putAt(index, value);
}
