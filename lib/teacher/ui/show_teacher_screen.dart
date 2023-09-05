import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/shared/route_map.dart';
import 'package:school_app/shared/string_const.dart';
import 'package:school_app/teacher/model/teacher_model.dart';
import 'package:school_app/teacher/ui/update_teacher_screen.dart';

class ShowTeacherScreen extends StatefulWidget {
  const ShowTeacherScreen({super.key});

  @override
  State<ShowTeacherScreen> createState() => _ShowTeacherScreenState();
}

class _ShowTeacherScreenState extends State<ShowTeacherScreen> {
  List<Teacher> teacherList = [];

  @override
  void initState() {
    getTeacherDate();
    super.initState();
  }

  Future getTeacherDate() async {
    teacherList = await DatabaseHelper.getTeacherData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstant.showTeacherText),
      ),
      body: teacherList.isEmpty
          ? const Center(
              child: Text("No Teacher data"),
            )
          : ListView.builder(
              itemCount: teacherList.length,
              itemBuilder: (context, index) {
                Teacher teacherModel = teacherList[index];

                return Dismissible(
                  key: Key('$index'),
                  confirmDismiss: (direction) async {
                    if (direction.name == 'endToStart') {
                      confirmDelete(teacherModel.id);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Id :',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 148,
                              ),
                              Text(
                                teacherModel.id.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              IconButton(
                                onPressed: () async {
                                  confirmDelete(teacherModel.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UpdatePatientScreen(
                                        teacher: teacherModel);
                                  }));
                                  getTeacherDate();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Name : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                width: 108,
                              ),
                              Text(
                                teacherModel.teacherName,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Salary :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                width: 79,
                              ),
                              Text(
                                teacherModel.salary.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void confirmDelete(int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Alert"),
            content: const Text("Are you sure to delete it ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    await deleteStudent(id);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }

  Future<void> deleteStudent(int id) async {
    await DatabaseHelper.deleteTeacher(id);
    await getTeacherDate();
  }
}
