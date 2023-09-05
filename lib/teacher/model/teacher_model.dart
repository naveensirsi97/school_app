class Teacher {
  int id;
  String teacherName;
  int salary;

  Teacher({
    required this.id,
    required this.teacherName,
    required this.salary,
  });

  static Teacher fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['Id'],
      teacherName: map['Name'],
      salary: map['Salary'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': teacherName,
      'Salary': salary,
    };
  }
}
