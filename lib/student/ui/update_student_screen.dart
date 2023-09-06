import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/student/model/student_model.dart';

class UpdateStudentScreen extends StatefulWidget {
  const UpdateStudentScreen({required this.student, super.key});

  final Student student;

  @override
  State<UpdateStudentScreen> createState() => UpdateStudentScreenState();
}

class UpdateStudentScreenState extends State<UpdateStudentScreen> {
  late TextEditingController rollNoController;
  late TextEditingController studentNameController;
  late TextEditingController gradeController;
  late TextEditingController addressController;

  @override
  void initState() {
    Student student = widget.student;
    rollNoController = TextEditingController(text: student.rollNo.toString());
    studentNameController = TextEditingController(text: student.studentName);
    gradeController = TextEditingController(text: student.grade.toString());
    addressController = TextEditingController(text: student.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: rollNoController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Enter RollNo'),
              ),
              const SizedBox(height: 18,),
              TextField(
                keyboardType: TextInputType.number,
                controller: studentNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Enter Name'),
              ),
              const SizedBox(
                height: 18,
              ),
              TextField(
                controller: gradeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Enter Grade'),
              ),
              const SizedBox(
                height: 18,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: addressController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Enter Address'),
              ),
              const SizedBox(height: 18,),
              ElevatedButton(
                onPressed: () async {
                  Student student = Student(
                      rollNo: int.parse(rollNoController.text),
                      studentName: studentNameController.text,
                      grade: int.parse(gradeController.text),
                      address: addressController.text);
                  await DatabaseHelper.updateStudent(student);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Update'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
