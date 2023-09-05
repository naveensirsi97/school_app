class Subject {
  int subjectId;
  String subjectName;

  Subject({
    required this.subjectId,
    required this.subjectName,
  });

  Map<String, dynamic> toMap() {
    return {
      'SubjectId': subjectId,
      'SubjectName': subjectName,
    };
  }

  static Subject fromMap(Map<String, dynamic> map) {
    return Subject(
      subjectId: map['SubjectId'],
      subjectName: map['SubjectName'],
    );
  }
}
