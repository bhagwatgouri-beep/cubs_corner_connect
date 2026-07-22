import 'package:flutter/material.dart';

import '../../models/attendance_record.dart';
import '../../models/student.dart';
import '../../models/teacher.dart';
import '../../repositories/attendance_repository.dart';
import '../../repositories/student_repository.dart';
import '../../repositories/teacher_repository.dart';
import '../admin/attendance/attendance_dashboard_screen.dart';
import '../admin/students/student_profile_screen.dart';

class MyClassScreen extends StatefulWidget {
  const MyClassScreen({super.key});

  @override
  State<MyClassScreen> createState() =>
      _MyClassScreenState();
}

class _MyClassScreenState
    extends State<MyClassScreen> {
String _search = '';

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

final List<Student> students = studentRepository
.activeStudents
.where(
(student) => teacher.classroomIds.contains(
student.classroomId,
),
)
.where(
(student) => student.fullName
.toLowerCase()
.contains(
_search.toLowerCase(),
),
)
.toList();

return Scaffold(
appBar: AppBar(
title: const Text('My Class'),
),
body: Padding(
padding: const EdgeInsets.all(16),
child: Column(
children: [
TextField(
decoration: const InputDecoration(
hintText: 'Search student...',
prefixIcon: Icon(Icons.search),
),
onChanged: (value) {
setState(() {
_search = value;
});
},
),

const SizedBox(height: 16),

Expanded(
child: ListView.builder(
itemCount: students.length,
itemBuilder: (context, index) {
final student = students[index];
final records =
attendanceRepository
.attendanceForStudent(
student.id,
);

final present =
records.isNotEmpty &&
(records.last.status ==
AttendanceStatus.present ||
records.last.status ==
AttendanceStatus.late);

return Card(
margin: const EdgeInsets.only(
bottom: 12,
),
child: ListTile(
leading: Stack(
children: [
CircleAvatar(
child: Text(
student.firstName.isNotEmpty
? student.firstName[0]
: '?',
),
),
if (student
.allergies
.isNotEmpty ||
student
.medicalNotes
.isNotEmpty)
const Positioned(
right: 0,
bottom: 0,
child: CircleAvatar(
radius: 8,
backgroundColor:
Colors.red,
child: Icon(
Icons.warning,
size: 12,
color: Colors.white,
),
),
),
],
),
title: Text(
student.fullName,
),
subtitle: Text(
present
? '🟢 Present Today'
: '🔴 Absent / Not Marked',
),
trailing: IconButton(
icon: const Icon(
Icons.fact_check,
color: Colors.green,
),
tooltip: 'Attendance',
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
const AttendanceDashboardScreen(),
),
);
},
),
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
StudentProfileScreen(
student: student,
),
)
);
},
),
);
},
),
),
],
),
),
);
}
}