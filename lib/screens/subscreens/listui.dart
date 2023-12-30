import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentlist/db/functions/dbfunctions.dart';
import 'package:studentlist/db/model/data_model.dart';
import 'package:studentlist/screens/subscreens/editstudent.dart';
import 'package:studentlist/screens/subscreens/viewstudent.dart';

class ListUi extends StatefulWidget {
  const ListUi({super.key});

  @override
  State<ListUi> createState() => _ListUiState();
}

class _ListUiState extends State<ListUi> {
  final _searchController = TextEditingController();
  String search = '';
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('studentList'),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final allStudents = Hive.box('studentList');
            return ValueListenableBuilder(
                valueListenable: Hive.box('studentList').listenable(),
                builder: (ctx, Box box, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 30, right: 30, bottom: 5),
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (String? value) {
                            setState(() {
                              search = value.toString();
                            });
                          },
                          style: const TextStyle(
                              color: Color.fromARGB(255, 94, 49, 120)),
                          cursorColor: const Color.fromARGB(255, 94, 49, 120),
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Search',
                              labelStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: allStudents.length,
                          itemBuilder: (context, index) {
                            final data =
                                allStudents.getAt(index) as StudentModel;
                            late String position = data.name.toString();
                            if (_searchController.text.isEmpty) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewStudentScreen(
                                            name: data.name!,
                                            age: data.age.toString(),
                                            place: data.place,
                                            phone: data.phone.toString(),
                                            imagePath: data.image!,
                                          )));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: data.image != null
                                          ? FileImage(File(data.image!))
                                          : AssetImage(
                                                  'assets/images/avatarPerson.jpeg')
                                              as ImageProvider),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditScreen(
                                                          index: index,
                                                          name: data.name!,
                                                          age: data.age,
                                                          phone: data.phone,
                                                          place: data.place,
                                                          imagePath: data.image,
                                                        )));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(
                                                255, 94, 49, 120),
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                useSafeArea: true,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      scrollable: true,
                                                      title:
                                                          const Text('Delete'),
                                                      content: const Text(
                                                          'Are you sure?'),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .redAccent),
                                                            onPressed: () {
                                                              deleteStudent(
                                                                  index);
                                                              print('delete');
                                                              isDeleted = true;
                                                              if (isDeleted ==
                                                                  true) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Cancel'))
                                                      ],
                                                    ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          )),
                                    ],
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(data.name!),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('age: ${data.age.toString()}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else if (position.toLowerCase().contains(
                                _searchController.text.toLowerCase())) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewStudentScreen(
                                            name: data.name!,
                                            age: data.age.toString(),
                                            place: data.place,
                                            phone: data.phone.toString(),
                                            imagePath: data.image!,
                                          )));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: data.image != null
                                          ? FileImage(File(data.image!))
                                          : AssetImage(
                                                  'assets/images/avatarPerson.jpeg')
                                              as ImageProvider),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditScreen(
                                                          index: index,
                                                          name: data.name!,
                                                          age: data.age,
                                                          phone: data.phone,
                                                          place: data.place,
                                                          imagePath: data.image,
                                                        )));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(
                                                255, 94, 49, 120),
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                useSafeArea: true,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      scrollable: true,
                                                      title:
                                                          const Text('Delete'),
                                                      content: const Text(
                                                          'Are you sure?'),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .redAccent),
                                                            onPressed: () {
                                                              deleteStudent(
                                                                  index);
                                                              print('delete');
                                                              isDeleted = true;
                                                              if (isDeleted ==
                                                                  true) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Cancel'))
                                                      ],
                                                    ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          )),
                                    ],
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(position),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('age: ${data.age.toString()}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
