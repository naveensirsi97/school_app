import 'package:path/path.dart';
import 'package:school_app/teacher/model/teacher_model.dart';
import 'package:school_app/teacher/subject/model/subject_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database database;
  static String teacherTable = 'Teacher';
  static String id = 'Id';
  static String teacherName = 'Name';
  static String salary = 'Salary';
  static String subject = 'Subject';

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
        'create table $teacherTable($id int primary key,$teacherName text,$salary int,$subject text)',
      );
      database.execute(
        'create table $subjectTable($subjectId int primary key,$subjectName text)',
      );
      print("Table created successfully");
    });
  }

  static Future addTeacherData(Teacher teacher) async {
    await database.rawInsert(
      'insert into $teacherTable values(?,?,?,?)',
      [
        teacher.id,
        teacher.teacherName,
        teacher.salary,
        teacher.subject,
      ],
    );
    print('Data inserted successfully');
  }

  static Future<List<Teacher>> getTeacherData() async {
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

  static Future deleteTeacher(int idNo) async {
    await database.rawDelete("delete from $teacherTable where $id = $idNo");
    print("delete teacher successfully");
  }

  static Future updateTeacher(Teacher teacher) async {
    await database.rawUpdate(
        "update $teacherTable set $teacherName=?,$salary=?,$subject=? where $id=?",
        [
          teacher.teacherName,
          teacher.salary,
          teacher.subject,
          teacher.id,
        ]);
    print("update teacher successfully");
  }

  static Future addSubjectData(Subject subject) async {
    await database.rawInsert(
      'insert into $subjectTable values(?,?)',
      [
        subject.subjectId,
        subject.subjectName,
      ],
    );
    print('Data inserted successfully');
  }

  static Future<List<Subject>> getSubjectData() async {
    List<Map<String, dynamic>> mapList =
        await database.rawQuery('select * from $subjectTable');

    List<Subject> subList = [];
    for (int i = 0; i < mapList.length; i++) {
      Map<String, dynamic> map = mapList[i];
      Subject subjectData = Subject.fromMap(map);
      subList.add(subjectData);
    }
    return subList;
  }

  static Future deleteSubject(int idNo) async {
    await database
        .rawDelete("delete from $subjectTable where $subjectId = $idNo");
    print("delete subject successfully");
  }

  static Future updateSubject(Subject subject) async {
    await database.rawUpdate(
        "update $subjectTable set $subjectName=? where $subjectId=?",
        [subject.subjectId, subject.subjectName]);
    print("update subject successfully");
  }
}
