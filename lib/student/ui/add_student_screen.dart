import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/student/model/student_model.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  late TextEditingController rollNoController;
  late TextEditingController studentNameController;
  late TextEditingController gradeController;
  late TextEditingController addressController;

  @override
  void initState() {
    rollNoController = TextEditingController();
    studentNameController = TextEditingController();
    gradeController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: rollNoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Enter RollNo',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: studentNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Enter Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: gradeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Enter Grade',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Enter Address',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed:()async{
                  Student student=Student(
                      rollNo:int.parse(rollNoController.text),
                      studentName: studentNameController.text,
                      grade: int.parse(gradeController.text),
                      address:addressController.text);
                  await DatabaseHelper.addStudent(student);
                  if(mounted) {
                    Navigator.pop(context);
                  }
                }, child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add'),
                  ],
                ),),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
