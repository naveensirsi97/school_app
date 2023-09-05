class Student {
  int rollNo;
  String studentName;
  num grade;
  String address;
  String path;

  Student({
    required this.rollNo,
    required this.studentName,
    required this.grade,
    required this.address,
    this.path = "",
  });
}
