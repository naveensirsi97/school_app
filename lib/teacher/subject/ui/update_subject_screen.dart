import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/teacher/subject/model/subject_model.dart';

class UpdateSubjectScreen extends StatefulWidget {
  const UpdateSubjectScreen({required this.subject, super.key});

  final Subject subject;

  @override
  State<UpdateSubjectScreen> createState() => _UpdateSubjectScreenState();
}

class _UpdateSubjectScreenState extends State<UpdateSubjectScreen> {
  late TextEditingController subjectIdController;
  late TextEditingController subjectNameController;


  @override
  void initState() {
    Subject subject = widget.subject;
    subjectIdController = TextEditingController(text: subject.subjectId.toString());
    subjectNameController = TextEditingController(text: subject.subjectName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
         ''
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: subjectIdController,
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
                controller: subjectNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Subject',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  updateSubject();
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

  Future<void> updateSubject() async {
    Subject subject = Subject(
      subjectId: int.parse(subjectIdController.text),
      subjectName: subjectNameController.text,

    );
    await DatabaseHelper.updateSubject(subject);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
