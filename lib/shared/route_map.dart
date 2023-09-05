import 'package:flutter/cupertino.dart';
import 'package:school_app/dashboard/ui/dashboard_screen.dart';
import 'package:school_app/student/ui/add_student_screen.dart';
import 'package:school_app/student/ui/show_student_screen.dart';
import 'package:school_app/teacher/ui/add_teacher_screen.dart';
import 'package:school_app/teacher/ui/show_teacher_screen.dart';

Map<String, WidgetBuilder> routeMap = {
  ScreenName.dashboardScreen: (context) {
    return const DashBoardScreen();
  },
  ScreenName.addTeacherScreen: (context) {
    return const AddTeacherScreen();
  },
  ScreenName.showTeacherScreen: (context) {
    return const ShowTeacherScreen();
  },
  ScreenName.addStudentScreen: (context) {
    return const AddStudentScreen();
  },
  ScreenName.showStudentScreen: (context) {
    return const ShowStudentScreen();
  }
};

class ScreenName {
  static const String dashboardScreen = "DashBoardScreen";
  static const String addTeacherScreen = "AddTeacherScreen";
  static const String showTeacherScreen = "ShowTeacherScreen";
  static const String addStudentScreen = "AddStudentScreen";
  static const String showStudentScreen = "ShowStudentScreen";
}
