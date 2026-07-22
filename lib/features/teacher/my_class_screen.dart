import 'package:flutter/material.dart';
import '../../repositories/attendance_repository.dart';
import '../../models/student.dart';
import '../../models/teacher.dart';
import '../../repositories/student_repository.dart';
import '../../repositories/teacher_repository.dart';
import '../admin/students/student_profile_screen.dart';
import '../../models/attendance_record.dart';
class MyClassScreen extends StatelessWidget {
const MyClassScreen({super.key});

@override
Widget build(BuildContext context) {
final teacherRepository =
TeacherRepository.instance;

final studentRepository =
StudentRepository.instance;
final attendanceRepository =
    AttendanceRepository.instance;

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
    subtitle: Builder(
      builder: (_) {
        final records = attendanceRepository
            .attendanceForStudent(student.id);

        final present = records.isNotEmpty &&
            (records.last.status ==
                AttendanceStatus.present ||
                records.last.status ==
                    AttendanceStatus.late);

        return Text(
          present
              ? '🟢 Present Today'
              : '🔴 Absent / Not Marked',
        );
      },
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