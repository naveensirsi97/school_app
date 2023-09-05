class Teacher {
  int id;
  String teacherName;
  int salary;
  String subject;

  Teacher({
    required this.id,
    required this.teacherName,
    required this.salary,
    required this.subject,
  });

  static Teacher fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['Id'],
      teacherName: map['TeacherName'],
      salary: map['Salary'],
      subject: map['Subject'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': teacherName,
      'Salary': salary,
      'Subject': subject,
    };
  }
}
