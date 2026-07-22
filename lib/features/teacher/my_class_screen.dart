import 'package:flutter/material.dart';

import '../../models/student.dart';
import '../../models/teacher.dart';
import '../../repositories/student_repository.dart';
import '../../repositories/teacher_repository.dart';
import '../admin/students/student_profile_screen.dart';

class MyClassScreen extends StatelessWidget {
const MyClassScreen({super.key});

@override
Widget build(BuildContext context) {
final teacherRepository =
TeacherRepository.instance;

final studentRepository =
StudentRepository.instance;

if (teacherRepository.activeTeachers.isEmpty) {
return Scaffold(
appBar: AppBar(
title: const Text('My Class'),
),
body: const Center(
child: Text(
'No teacher assigned.',
),
),
);
}

final Teacher teacher =
teacherRepository.activeTeachers.first;

final List<Student> students =
studentRepository.activeStudents.where(
(student) {
return teacher.classroomIds
.contains(student.classroomId);
},
).toList();

return Scaffold(
appBar: AppBar(
title: const Text('My Class'),
),
body: ListView.builder(
padding: const EdgeInsets.all(16),
itemCount: students.length,
itemBuilder: (context, index) {
final student = students[index];
return Card(
  margin: const EdgeInsets.only(bottom: 12),
  child: ListTile(
    leading: CircleAvatar(
      child: Text(
        student.firstName.isNotEmpty
            ? student.firstName[0]
            : '?',
      ),
    ),
    title: Text(
      student.fullName,
    ),
    subtitle: Text(
      '${student.classroomId} • ${student.admissionNumber}',
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 18,
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StudentProfileScreen(
            student: student,
          ),
        ),
      );
    },
  ),
);
},
),
);
}
}