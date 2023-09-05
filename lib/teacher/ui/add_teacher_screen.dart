import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/shared/string_const.dart';
import 'package:school_app/teacher/model/teacher_model.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  late TextEditingController idController;
  late TextEditingController teacherNameController;
  late TextEditingController salaryNameController;

  @override
  void initState() {
    idController = TextEditingController();
    teacherNameController = TextEditingController();
    salaryNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstant.addTeacherText,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Id',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: teacherNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: salaryNameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Salary',
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  addTeacher();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ADD',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTeacher() async {
    Teacher teacher = Teacher(
      id: int.parse(idController.text),
      teacherName: teacherNameController.text,
      salary: int.parse(salaryNameController.text),
    );
    await DatabaseHelper.addTeacherData(teacher);
    if (mounted) {
      Navigator.pop(context);
    }
    allClear();
  }

  void allClear() {
    idController.clear();
    teacherNameController.clear();
    salaryNameController.clear();
  }
}
