import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/student/model/student_model.dart';
import 'package:school_app/student/ui/update_student_screen.dart';

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
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: (studentList.length),
            itemBuilder: (context, index) {
              Student student = studentList[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'RollNo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Text(
                          student.rollNo.toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        IconButton(onPressed:(){
                        showDialog(context: context, builder:(context){
                          return AlertDialog(
                            title: const Text('Delete'),
                            content: const Text('Are you sure you delete it'),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child:const Text('Cancel'),),
                              TextButton(onPressed: ()async{
                                          await DatabaseHelper.deleteStudent(
                                              student.rollNo);
                                          showStudentData();
                                          if (mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () async {
                            await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UpdateStudentScreen(student: student);
                            }));
                            showStudentData();
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Text(
                          student.studentName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Grade',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Text(
                          student.grade.toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Address',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Text(
                          student.address,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
