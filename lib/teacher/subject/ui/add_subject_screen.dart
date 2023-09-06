import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/teacher/subject/model/subject_model.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  late TextEditingController subjectIdController;
  late TextEditingController subjectNameController;

  @override
  void initState() {
    subjectIdController = TextEditingController();
    subjectNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: subjectIdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Fill Id',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: subjectNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Fill Subject',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: ()async {
                    Subject subject = Subject(
                        subjectId: int.parse(subjectIdController.text),
                        subjectName: subjectNameController.text);
                    await DatabaseHelper.addSubjectData(subject);
                    if(mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add')),
            )
          ],
        ),
      ),
    );
  }
}
