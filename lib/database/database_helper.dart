import 'package:path/path.dart';
import 'package:school_app/student/model/student_model.dart';
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
  static String studentName = 'StudentName';
  static String grade = 'Grade';
  static String address = 'Address';

  static String subjectTable = 'Subject';
  static String subjectId = 'SubjectId';
  static String subjectName = 'SubjectName';

  static Future createDatabase() async {
    String dbName = 'School.db';
    String path = await getDatabasesPath();
    String dbPath = join(path, dbName);
    database = await openDatabase(dbPath,
        version: 1, onCreate: (database, version) {
      database.execute("create table $studentTable($rollNo int primary key,$studentName text,$grade int,$address text)");
      print('Table create successfully');
        });
  }
  static Future addStudent(Student student)async{
   await database.rawInsert('insert into $studentTable values(?,?,?,?)',
     [student.rollNo,student.studentName,student.grade,student.address]
    );
    print('Data inserted successfully');
  }
  static Future<List<Student>>
  getStudentData()async{
    List<Map<String, dynamic>> mapList =
        await database.rawQuery('select * from $studentTable');

    List<Student> stdList = [];
    for (int i = 0; i < mapList.length; i++) {
      Map<String, dynamic> map = mapList[i];
      Student student = Student.fromMap(map);
      stdList.add(student);
    }
    return stdList;
  }

  static Future deleteStudent(int IdNo) async {
    await database.rawDelete('delete from $studentTable where $rollNo=$IdNo');
    print('Delete successfully');
  }

  static Future updateStudent(Student student) async {
    await database.rawUpdate(
        'update $studentTable set $studentName=?,$grade=?,$address=? where $rollNo=?',
        [
          student.studentName,
          student.grade,
          student.address,
          student.rollNo,
        ]);
    print('Update Student Successfully');
  }
}
