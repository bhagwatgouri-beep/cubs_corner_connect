import 'package:flutter/material.dart';

import '../../../models/parent.dart';
import '../../../models/student.dart';
import '../../../repositories/billing_repository.dart';
import '../../../repositories/parent_repository.dart';
import '../../../repositories/student_repository.dart';
import '../../../models/attendance_record.dart';
import '../../../repositories/attendance_repository.dart';
import '../billing/generate_invoice_screen.dart';
import 'edit_student_screen.dart';
import 'student_attendance_screen.dart';
import 'student_daycare_screen.dart';
import 'student_documents_screen.dart';
import 'student_notes_screen.dart';
import 'student_timeline_button.dart';

class StudentProfileScreen extends StatefulWidget {
  final Student student;

  const StudentProfileScreen({
    super.key,
    required this.student,
  });

  @override
  State<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState
    extends State<StudentProfileScreen> {
late Student _student;

@override
void initState() {
super.initState();
_student = widget.student;
}

Widget _sectionTitle(
BuildContext context,
String title,
) {
return Padding(
padding: const EdgeInsets.fromLTRB(
16,
16,
16,
4,
),
child: Align(
alignment: Alignment.centerLeft,
child: Text(
title,
style:
Theme.of(context).textTheme.titleMedium,
),
),
);
}

Widget _infoTile(
IconData icon,
String title,
String value,
) {
final display =
value.trim().isEmpty ? '-' : value;

return ListTile(
leading: Icon(icon),
title: Text(title),
subtitle: Text(display),
);
}

Parent? _parentForStudent() {
if (_student.parentIds.isEmpty) return null;

return ParentRepository.instance
.getParent(_student.parentIds.first);
}

Future<void> _openEdit() async {
final saved =
await Navigator.push<bool>(
context,
MaterialPageRoute(
builder: (_) => EditStudentScreen(
student: _student,
parent: _parentForStudent(),
),
),
);

if (saved == true && mounted) {
final updated =
StudentRepository.instance
.getStudent(_student.id);

if (updated != null) {
setState(() {
_student = updated;
});
}
}
}

Future<void> _toggleActiveStatus() async {
final updated = _student.copyWith(
isActive: !_student.isActive,
updatedAt: DateTime.now(),
);

StudentRepository.instance
.updateStudent(updated);

setState(() {
_student = updated;
});
}

double _outstandingBalance() {
final invoices = BillingRepository
.instance
.invoicesForStudent(_student.id);

return invoices.fold(
0.0,
(sum, invoice) =>
sum + invoice.balance,
);
}
int _attendancePercentage() {
  final attendance = AttendanceRepository.instance
      .attendanceForStudent(_student.id);

  if (attendance.isEmpty) {
    return 0;
  }

  final present = attendance.where(
        (record) =>
    record.status == AttendanceStatus.present ||
        record.status == AttendanceStatus.late,
  ).length;

  return ((present / attendance.length) * 100).round();
}

@override
Widget build(BuildContext context) {
final parent = _parentForStudent();

final dob =
'${_student.dateOfBirth.day.toString().padLeft(2, '0')}/'
'${_student.dateOfBirth.month.toString().padLeft(2, '0')}/'
'${_student.dateOfBirth.year}';

final admissionDate =
'${_student.createdAt.day.toString().padLeft(2, '0')}/'
'${_student.createdAt.month.toString().padLeft(2, '0')}/'
'${_student.createdAt.year}';

return Scaffold(
appBar: AppBar(
title: Text(_student.fullName),
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Card(
elevation: 3,
shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(16),
),
child: Padding(
padding:
const EdgeInsets.all(24),
child: Column(
children: [
CircleAvatar(
radius: 42,
child: Text(
_student.firstName
.isEmpty
? '?'
: _student
.firstName[0]
.toUpperCase(),
style:
const TextStyle(
fontSize: 30,
fontWeight:
FontWeight.bold,
),
),
),

const SizedBox(
height: 16,
),

Text(
_student.fullName,
textAlign:
TextAlign.center,
style: Theme.of(context)
.textTheme
.headlineSmall
?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(
height: 6,
),

Text(
_student
.admissionNumber,
),

const SizedBox(
height: 16,
),
Wrap(
alignment: WrapAlignment.center,
spacing: 8,
runSpacing: 8,
children: [
Chip(
avatar: Icon(
_student.isActive
? Icons.check_circle
: Icons.cancel,
size: 18,
color: Colors.white,
),
backgroundColor:
_student.isActive
? Colors.green
: Colors.red,
label: Text(
_student.isActive
? 'Active'
: 'Inactive',
style: const TextStyle(
color: Colors.white,
),
),
),
Chip(
avatar: const Icon(
Icons.class_,
size: 18,
),
label: Text(
_student.classroomId,
),
),
],
),

if (parent != null) ...[
const SizedBox(
height: 12,
),
Row(
mainAxisAlignment:
MainAxisAlignment.center,
children: [
const Icon(
Icons.family_restroom,
size: 18,
),
const SizedBox(
width: 6,
),
Flexible(
child: Text(
parent.fullName,
overflow:
TextOverflow
.ellipsis,
),
),
],
),
],
],
),
),
),

_sectionTitle(
context,
'Student Summary',
),

Card(
child: Padding(
padding:
const EdgeInsets.all(16),
child: Column(
children: [
Row(
children: [
Expanded(
child: ListTile(
leading:
const Icon(
Icons
.calendar_month,
color:
Colors.green,
),
title: const Text(
'Attendance',
),
  subtitle: Text(
    '${_attendancePercentage()}%',
  ),
),
),
Expanded(
child: ListTile(
leading:
const Icon(
Icons
.receipt_long,
color: Colors
.orange,
),
title: const Text(
'Outstanding',
),
subtitle: Text(
'₹${_outstandingBalance().toStringAsFixed(0)}',
),
),
),
],
),

const Divider(),

Row(
children: [
Expanded(
child: ListTile(
leading:
const Icon(
Icons
.health_and_safety,
color:
Colors.red,
),
title: const Text(
'Health Alerts',
),
subtitle:
const Text(
'0',
),
),
),
Expanded(
child: ListTile(
leading:
const Icon(
Icons
.child_care,
color:
Colors.blue,
),
title: const Text(
'Daycare',
),
subtitle:
const Text(
'Not Enrolled',
),
),
),
],
),
],
),
),
),

_sectionTitle(
context,
'Quick Actions',
),

Card(
child: Padding(
padding:
const EdgeInsets.all(16),
child: Column(
children: [
Row(
children: [
Expanded(
child: FilledButton.icon(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
StudentAttendanceScreen(
student: _student,
),
),
);
},
icon: const Icon(
Icons.calendar_month,
),
label: const Text(
'Attendance',
),
),
),
const SizedBox(width: 12),
Expanded(
child: FilledButton.icon(
onPressed: () async {
final generated =
await Navigator.push<bool>(
context,
MaterialPageRoute(
builder: (_) =>
GenerateInvoiceScreen(
student: _student,
),
),
);

if (generated == true &&
mounted) {
setState(() {});
}
},
icon: const Icon(
Icons.receipt_long,
),
label: const Text(
'Billing',
),
),
),
],
),

const SizedBox(height: 12),

Row(
children: [
Expanded(
child: FilledButton.icon(
onPressed: () {},
icon: const Icon(
Icons.health_and_safety,
),
label: const Text(
'Health',
),
),
),
const SizedBox(width: 12),
Expanded(
child: FilledButton.icon(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
StudentDocumentsScreen(
student: _student,
),
),
);
},
icon: const Icon(
Icons.folder_open,
),
label: const Text(
'Documents',
),
),
),
],
),

const SizedBox(height: 12),

Row(
children: [
Expanded(
child: FilledButton.icon(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
StudentDaycareScreen(
student: _student,
),
),
);
},
icon: const Icon(
Icons.child_care,
),
label: const Text(
'Daycare',
),
),
),
const SizedBox(width: 12),
Expanded(
child: FilledButton.icon(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
StudentNotesScreen(
student: _student,
),
),
);
},
icon: const Icon(
Icons.note_alt,
),
label: const Text(
'Notes',
),
),
),
],
),

const SizedBox(height: 12),

SizedBox(
width: double.infinity,
child: StudentTimelineButton(
student: _student,
),
),
],
),
),
),

_sectionTitle(
context,
'Student Information',
),

Card(
child: Column(
children: [
_infoTile(
Icons.badge,
'Admission Number',
_student.admissionNumber,
),
_infoTile(
Icons.person,
'Full Name',
_student.fullName,
),
_infoTile(
Icons.person_outline,
'Gender',
_student.gender,
),
_infoTile(
Icons.cake,
'Date of Birth',
dob,
),
_infoTile(
Icons.class_,
'Current Class',
_student.classroomId,
),
_infoTile(
Icons.circle,
'Status',
_student.isActive
? 'Active'
: 'Inactive',
),
],
),
),

_sectionTitle(
context,
'Parent Information',
),

Card(
child: Column(
children: [
_infoTile(
Icons.person,
'Parent Name',
parent?.fullName ?? '',
),
_infoTile(
Icons.family_restroom,
'Relationship',
parent?.relationship ?? '',
),
_infoTile(
Icons.phone,
'Mobile',
parent?.mobileNumber ?? '',
),
_infoTile(
Icons.email,
'Email',
parent?.email ?? '',
),
],
),
),
  _sectionTitle(
    context,
    'Admission Information',
  ),

  Card(
    child: Column(
      children: [
        _infoTile(
          Icons.event,
          'Admission Date',
          admissionDate,
        ),
        _infoTile(
          Icons.badge,
          'Admission Number',
          _student.admissionNumber,
        ),
      ],
    ),
  ),

  _sectionTitle(
    context,
    'Health',
  ),

  Card(
    child: Column(
      children: [
        _infoTile(
          Icons.bloodtype,
          'Blood Group',
          '-',
        ),
        _infoTile(
          Icons.warning_amber,
          'Allergies',
          _student.allergies,
        ),
        _infoTile(
          Icons.medical_information,
          'Medical Notes',
          _student.medicalNotes,
        ),
      ],
    ),
  ),

  _sectionTitle(
    context,
    'Emergency Contact',
  ),

  Card(
    child: Column(
      children: [
        _infoTile(
          Icons.person,
          'Name',
          '-',
        ),
        _infoTile(
          Icons.phone,
          'Phone',
          '-',
        ),
      ],
    ),
  ),

  _sectionTitle(
    context,
    'Actions',
  ),

  Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _openEdit,
              icon: const Icon(Icons.edit),
              label: const Text(
                'Edit Student',
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed:
              _toggleActiveStatus,
              icon: Icon(
                _student.isActive
                    ? Icons.archive
                    : Icons.check_circle,
              ),
              label: Text(
                _student.isActive
                    ? 'Archive Student'
                    : 'Activate Student',
              ),
            ),
          ),
        ],
      ),
    ),
  ),
],
),
);
}
}