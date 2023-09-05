import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database database;
  static String teacherTable = 'Teacher';
  static String id = 'Id';
  static String teacherName = 'Name';
  static String subject = 'Subject';
  static String salary = 'Salary';

  static String studentTable = 'Student';
  static String rollNo = 'RollNo';
  static String studentName = 'Name';
  static String grade = 'Grade';
  static String address = 'Address';
  static String imPath = 'Path';

  static String subjectTable = 'Subject';
  static String subjectId = 'SubjectId';
  static String subjectName = 'SubjectName';

  static Future createDatabase() async {
    String dbName = 'School.db';
    String path = await getDatabasesPath();
    String dbPath = join(path, dbName);
    database = await openDatabase(dbPath,
        version: 1, onCreate: (database, version) {});
  }
}
