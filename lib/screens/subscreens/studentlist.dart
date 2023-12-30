import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentlist/db/model/data_model.dart';
import 'package:studentlist/db/functions/dbfunctions.dart';
import 'package:studentlist/screens/subscreens/listui.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final _formkey = GlobalKey<FormState>();

  File? _imagePick;
  final myColor =
      MaterialStateProperty.all(const Color.fromARGB(255, 94, 49, 120));
  final _namecontrol = TextEditingController();
  final _agecontrol = TextEditingController();
  final _phonecontrol = TextEditingController();
  final _placecontrol = TextEditingController();

  void add(BuildContext context, int? itemkey) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      top: 15,
                      right: 15,
                      left: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: _imagePick != null
                              ? FileImage(_imagePick!)
                              : AssetImage('assets/images/avatarPerson.jpeg')
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: myColor,
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)))),
                            onPressed: () {
                              _openImagePicker();
                            },
                            child: const Text("Add Image")),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 94, 49, 120)),
                        cursorColor: const Color.fromARGB(255, 94, 49, 120),
                        controller: _namecontrol,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 94, 49, 120))),
                            hintText: ' Name',
                            hintStyle: TextStyle(color: Colors.white70)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 94, 49, 120)),
                        cursorColor: const Color.fromARGB(255, 94, 49, 120),
                        controller: _agecontrol,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 94, 49, 120))),
                            hintText: ' Age',
                            hintStyle: TextStyle(color: Colors.white70)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the Age';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 94, 49, 120)),
                        cursorColor: const Color.fromARGB(255, 94, 49, 120),
                        controller: _phonecontrol,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 94, 49, 120))),
                            hintText: ' Phone Number',
                            hintStyle: TextStyle(color: Colors.white70)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a Phone Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 94, 49, 120)),
                        cursorColor: const Color.fromARGB(255, 94, 49, 120),
                        controller: _placecontrol,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 94, 49, 120))),
                            hintText: ' Address',
                            hintStyle: TextStyle(color: Colors.white70)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the Address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: myColor,
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)))),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  addclicked();
                                  print('create data');
                                  clearText();
                                }
                              },
                              child: const Text("ADD STUDENT"))),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 158, 158, 167),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 94, 49, 120),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          title: const Center(child: Text("STUDENT LIST")),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 94, 49, 120),
          onPressed: () {
            add(context, null);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: ListUi());
  }

  void clearText() {
    _namecontrol.clear();
    _agecontrol.clear();
    _phonecontrol.clear();
    _placecontrol.clear();
    setState(() {
      _imagePick = null;
    });
  }

  Future<void> addclicked() async {
    final value = StudentModel(
        name: _namecontrol.text,
        age: int.parse(_agecontrol.text),
        phone: int.parse(_phonecontrol.text),
        place: _placecontrol.text,
        image: _imagePick!.path);
    addStudent(value);
    Navigator.pop(context);
  }

  void _openImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicker =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagePicker == null) return;
    setState(() {
      _imagePick = File(imagePicker.path);
    });
  }
}
