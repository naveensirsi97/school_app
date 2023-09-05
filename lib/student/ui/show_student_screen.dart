import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/student/model/student_model.dart';

class ShowStudentScreen extends StatefulWidget {
  const ShowStudentScreen({super.key});

  @override
  State<ShowStudentScreen> createState() => _ShowStudentScreenState();
}

class _ShowStudentScreenState extends State<ShowStudentScreen> {
  List<Student> studentList = [];

  @override
  void initState() {
    showStudentData();
    super.initState();
  }

  Future showStudentData() async {
    studentList = await DatabaseHelper.getStudentData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: (studentList.length),
            itemBuilder: (context, index) {
              Student student = studentList[index];
              return Column(
                children: [
                  Row(
                    children: [
                      const Text('RollNo'),
                      Text(student.rollNo.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Name'),
                      Text(student.studentName),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Grade'),
                      Text(student.grade.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Address'),
                      Text(student.address),
                    ],
                  ),
                  const Divider(),
                ],
              );
            }),
      ),
    );
  }
}
