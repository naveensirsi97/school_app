import 'package:flutter/material.dart';
import 'package:school_app/database/database_helper.dart';
import 'package:school_app/shared/string_const.dart';
import 'package:school_app/teacher/model/teacher_model.dart';
import 'package:school_app/teacher/subject/model/subject_model.dart';

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
    loadSubject();
    super.initState();
  }

   String? currentValue;

  late List<Subject> subjectList = [];

  Future loadSubject() async {
    subjectList = await DatabaseHelper.getSubjectData();
    currentValue = subjectList[0].subjectName;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropDownMenuList = [];
    for (var subject in subjectList) {
      dropDownMenuList.add(DropdownMenuItem(
        value: subject.subjectName,
        child: Text(subject.subjectName),
      ));
    }
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
                  labelText: StringConstant.labelText1,
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
                  labelText: StringConstant.labelText2,
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
                  labelText: StringConstant.labelText3,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Subject',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (currentValue != null && dropDownMenuList.isNotEmpty)
                    DropdownButton(
                      items: dropDownMenuList,
                      onChanged: (value) {
                        currentValue = value;
                        setState(() {});
                      },
                      value: currentValue,
                    ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: ()async {
                 await addTeacher(context);
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

  Future<void> addTeacher(BuildContext context) async {
    Teacher teacher = Teacher(
      id: int.parse(idController.text),
      teacherName: teacherNameController.text,
      salary: int.parse(salaryNameController.text),
      subject: currentValue!,
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
