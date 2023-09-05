import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/shared/string_const.dart';
import 'package:school_app/teacher/model/teacher_model.dart';

class UpdatePatientScreen extends StatefulWidget {
  const UpdatePatientScreen({required this.teacher, super.key});

  final Teacher teacher;

  @override
  State<UpdatePatientScreen> createState() => _UpdatePatientScreenState();
}

class _UpdatePatientScreenState extends State<UpdatePatientScreen> {
  late TextEditingController idController;
  late TextEditingController teacherNameController;
  late TextEditingController salaryNameController;

  @override
  void initState() {
    Teacher teacher = widget.teacher;
    idController = TextEditingController(text: teacher.id.toString());
    teacherNameController = TextEditingController(text: teacher.teacherName);
    salaryNameController =
        TextEditingController(text: teacher.salary.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstant.updateTeacherText,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
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
                  updateTeacher();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Update',
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

  Future<void> updateTeacher() async {
    Teacher teacher = Teacher(
      id: int.parse(idController.text),
      teacherName: teacherNameController.text,
      salary: int.parse(salaryNameController.text),
    );
    await DatabaseHelper.updateTeacher(teacher);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
