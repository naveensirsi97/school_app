import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/teacher/subject/model/subject_model.dart';
import 'package:school_app/teacher/subject/ui/update_subject_screen.dart';

class ShowSubjectScreen extends StatefulWidget {
  const ShowSubjectScreen({super.key});

  @override
  State<ShowSubjectScreen> createState() => _ShowSubjectScreenState();
}

class _ShowSubjectScreenState extends State<ShowSubjectScreen> {
  List<Subject> subjectList = [];

  @override
  void initState() {
    getSubjectDate();
    super.initState();
  }

  Future getSubjectDate() async {
    subjectList = await DatabaseHelper.getSubjectData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: subjectList.isEmpty
          ? const Center(
              child: Text(""),
            )
          : ListView.builder(
              itemCount: subjectList.length,
              itemBuilder: (context, index) {
                Subject subject = subjectList[index];

                return Dismissible(
                    key: Key('$index'),
                    confirmDismiss: (direction) async {
                      if (direction.name == 'endToStart') {
                        confirmDelete(subject.subjectId);
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         children: [
                                           const Text(
                                             'Id : ',
                                             style: TextStyle(
                                                 fontSize: 20, fontWeight: FontWeight.w500),
                                           ),
                                           Text(
                                             subject.subjectId.toString(),
                                             style: const TextStyle(fontSize: 16),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         children: [
                                           const Text('Subject : ',
                                               style: TextStyle(
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.w500)),

                                           Text(
                                             subject.subjectName,
                                             style: const TextStyle(
                                               fontSize: 16,
                                             ),
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                   const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        confirmDelete(subject.subjectId);
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
                                              return UpdateSubjectScreen(
                                                  subject: subject);
                                            }));
                                        getSubjectDate();
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                  ],
                                ),
                              ],),

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
                    await deleteSubject(id);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }

  Future<void> deleteSubject(int id) async {
    await DatabaseHelper.deleteSubject(id);
    await getSubjectDate();
  }
}
