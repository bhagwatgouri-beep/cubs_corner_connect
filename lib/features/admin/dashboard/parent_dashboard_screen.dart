import 'package:flutter/material.dart';
import '../../../repositories/communication_repository.dart';
import '../../../models/student.dart';
import '../../../repositories/attendance_repository.dart';
import '../../../repositories/billing_repository.dart';
import '../../../repositories/daycare_repository.dart';
import '../../../repositories/student_repository.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() =>
      _ParentDashboardScreenState();
}

class _ParentDashboardScreenState
    extends State<ParentDashboardScreen> {
final StudentRepository _studentRepository =
StudentRepository.instance;

final AttendanceRepository _attendanceRepository =
AttendanceRepository.instance;

final BillingRepository _billingRepository =
BillingRepository.instance;

final DaycareRepository _daycareRepository =
DaycareRepository.instance;

final CommunicationRepository _communicationRepository =
    CommunicationRepository.instance;

late Student _student;

@override
void initState() {
super.initState();

_student = _studentRepository.activeStudents.first;}

bool get _isPresentToday {
final attendance =
_attendanceRepository.attendanceForStudent(
_student.id,
);

if (attendance.isEmpty) {
return false;
}

final latest = attendance.last;

return latest.status.name != 'absent';
}

String get _daycareStatus {
final record =
_daycareRepository.recordForStudentOnDate(
_student.id,
DateTime.now(),
);

if (record == null) {
return 'Not Using Today';
}

if (record.isCheckedIn &&
!record.isCheckedOut) {
return 'Checked In';
}

if (record.isCheckedOut) {
return 'Checked Out';
}

return 'Not Using Today';
}

double get _outstandingFees {
  final invoices = _billingRepository
      .invoicesForStudent(_student.id);

  return invoices.fold(
    0.0,
        (sum, invoice) => sum + invoice.balance,
  );
}
String get _latestNotice {
  final notices =
      _communicationRepository.publishedAnnouncements;

  if (notices.isEmpty) {
    return 'No notices available';
  }

  notices.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
  );

  return notices.first.title;
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'Parent Dashboard',
),
centerTitle: true,
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Card(
child: Padding(
padding: const EdgeInsets.all(16),
child: Row(
children: [
const CircleAvatar(
radius: 36,
child: Icon(
Icons.child_care,
size: 40,
),
),
const SizedBox(width: 16),
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
_student.fullName,
style: Theme.of(context)
.textTheme
.titleLarge,
),
const SizedBox(height: 4),
Text(
_student.classroomId,
style: Theme.of(context)
.textTheme
.bodyMedium,
),
const SizedBox(height: 8),
Chip(
label: Text(
_student.isActive
? 'Active'
: 'Inactive',
),
),
],
),
),
],
),
),
),

const SizedBox(height: 16),

Card(
child: ListTile(
leading: Icon(
_isPresentToday
? Icons.check_circle
: Icons.cancel,
color: _isPresentToday
? Colors.green
: Colors.red,
),
title:
const Text('Attendance Today'),
subtitle: Text(
_isPresentToday
? 'Present'
: 'Absent',
),
),
),

const SizedBox(height: 12),

Card(
child: ListTile(
leading: const Icon(
Icons.child_care,
color: Colors.blue,
),
title: const Text(
'Daycare Status',
),
subtitle: Text(
_daycareStatus,
),
),
),

const SizedBox(height: 12),

Card(
child: ListTile(
leading: const Icon(
Icons.currency_rupee,
color: Colors.orange,
),
title:
const Text('Fee Summary'),
subtitle: Text(
_outstandingFees == 0
? 'No Outstanding Fees'
: 'Outstanding ₹${_outstandingFees.toStringAsFixed(0)}',
),
),
),

const SizedBox(height: 12),
  Card(
    child: ListTile(
      leading: const Icon(
        Icons.notifications,
        color: Colors.deepPurple,
      ),
      title: const Text(
        'Latest Notice',
      ),
      subtitle: Text(
        _latestNotice,
      ),
    ),
  ),

  const SizedBox(height: 12),

  Card(
    child: ListTile(
      leading: const Icon(
        Icons.note_alt,
        color: Colors.teal,
      ),
      title: const Text(
        'Teacher Notes',
      ),
      subtitle: const Text(
        'No notes available',
      ),
    ),
  ),

  const SizedBox(height: 12),

  Card(
    child: ListTile(
      leading: const Icon(
        Icons.photo_library,
        color: Colors.pink,
      ),
      title: const Text(
        'Gallery',
      ),
      subtitle: const Text(
        'Photos will appear here',
      ),
    ),
  ),

  const SizedBox(height: 20),

  FilledButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.phone),
    label: const Text(
      'Contact School',
    ),
  ),
],
),
);
}
}