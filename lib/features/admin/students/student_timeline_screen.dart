import 'package:flutter/material.dart';

import '../../../models/student.dart';
import '../../../repositories/attendance_repository.dart';
import '../../../repositories/billing_repository.dart';
import '../../../repositories/daycare_repository.dart';

class StudentTimelineScreen extends StatelessWidget {
  final Student student;

  const StudentTimelineScreen({
    super.key,
    required this.student,
  });

  static final AttendanceRepository _attendanceRepository =
      AttendanceRepository.instance;

  static final DaycareRepository _daycareRepository =
      DaycareRepository.instance;

  static final BillingRepository _billingRepository =
      BillingRepository.instance;

  String _date(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/'
        '${value.year}';
  }

  String _time(DateTime? value) {
    if (value == null) return '-';

    return '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final attendance = _attendanceRepository
        .attendanceForStudent(student.id);

    final daycare = _daycareRepository
        .recordsForDate(DateTime.now())
        .where((record) => record.studentId == student.id)
        .toList();

    final invoices =
    _billingRepository.invoicesForStudent(student.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('${student.firstName} Timeline'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Admission',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.school),
              title: Text(student.fullName),
              subtitle: Text(
                'Admission No: ${student.admissionNumber}',
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Attendance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (attendance.isEmpty)
            const Card(
              child: ListTile(
                title: Text('No attendance records'),
              ),
            ),

          ...attendance.map(
                (record) => Card(
              child: ListTile(
                leading: const Icon(Icons.fact_check),
                title: Text(record.status.name),
                subtitle: Text(
                  '${_date(record.date)}  ${_time(record.markedAt)}',
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Daycare',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (daycare.isEmpty)
            const Card(
              child: ListTile(
                title: Text('No daycare records'),
              ),
            ),

          ...daycare.map(
                (record) => Card(
              child: ListTile(
                leading: const Icon(Icons.child_care),
                title: Text(_date(record.date)),
                subtitle: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check In : ${_time(record.checkInTime)}',
                    ),
                    Text(
                      'Check Out : ${_time(record.checkOutTime)}',
                    ),
                    Text(
                      'Pickup : ${record.pickupPerson.isEmpty ? "-" : record.pickupPerson}',
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Billing',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (invoices.isEmpty)
            const Card(
              child: ListTile(
                title: Text('No invoices'),
              ),
            ),

          ...invoices.map(
                (invoice) => Card(
              child: ListTile(
                leading:
                const Icon(Icons.receipt_long),
                title: Text(invoice.invoiceNumber),
                subtitle: Text(
                  '₹${invoice.balance.toStringAsFixed(0)} outstanding',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}