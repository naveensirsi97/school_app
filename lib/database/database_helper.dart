import 'package:path/path.dart';
import 'package:school_app/teacher/model/teacher_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database database;
  static String teacherTable = 'Teacher';
  static String id = 'Id';
  static String teacherName = 'Name';
  static String salary = 'Salary';

  static String studentTable = 'Student';
  static String rollNo = 'RollNo';
  static String studentName = 'Name';
  static String grade = 'Grade';
  static String address = 'Address';

  static String subjectTable = 'Subject';
  static String subjectId = 'SubjectId';
  static String subjectName = 'SubjectName';

  static Future createDatabase() async {
    String dbName = 'School.db';
    String path = await getDatabasesPath();
    String dbPath = join(path, dbName);
    database =
        await openDatabase(dbPath, version: 1, onCreate: (database, version) {
      database.execute(
          'create table $teacherTable($id int primary key,$teacherName text,$salary int)');
      print("Table created successfully");
    });
  }

  static Future addPatientData(Teacher teacher) async {
    await database.rawInsert(
      'insert into $teacherTable values(?,?,?)',
      [
        teacher.id,
        teacher.teacherName,
        teacher.salary,
      ],
    );
    print('Data inserted successfully');
  }

  static Future<List<Teacher>> getPatientData() async {
    List<Map<String, dynamic>> mapList =
        await database.rawQuery('select * from $teacherTable');

    List<Teacher> patList = [];
    for (int i = 0; i < mapList.length; i++) {
      Map<String, dynamic> map = mapList[i];
      Teacher patientData = Teacher.fromMap(map);
      patList.add(patientData);
    }
    return patList;
  }

  static Future deletePatient(int idNo) async {
    await database.rawDelete("delete from $teacherTable where $id = $idNo");
    print("delete teacher successfully");
  }

  static Future updatePatient(Teacher teacher) async {
    await database.rawUpdate(
        "update $teacherTable set $teacherName=?,$salary=? where $id=?", [
      teacher.teacherName,
      teacher.salary,
      teacher.id,
    ]);
    print("update teacher successfully");
  }
}
