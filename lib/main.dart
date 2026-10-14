import 'package:flutter/material.dart';

import 'course_screen.dart';

void main() {
  runApp(const CourseApp());
}

class CourseApp extends StatelessWidget {
  const CourseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COMP 205',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const CourseScreen(),
    );
  }
}
