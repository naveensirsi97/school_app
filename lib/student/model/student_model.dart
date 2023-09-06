class Student {
  int rollNo;
  String studentName;
  num grade;
  String address;

  Student({
    required this.rollNo,
    required this.studentName,
    required this.grade,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'RollNo': rollNo,
      'StudentName': studentName,
      'Grade': grade,
      'Address': address
    };
  }

  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      rollNo: map['RollNo'],
      studentName: map['StudentName'],
      grade: map['Grade'],
      address: map['Address'],
    );
  }
}
