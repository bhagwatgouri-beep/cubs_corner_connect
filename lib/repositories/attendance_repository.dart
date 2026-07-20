import '../models/attendance_record.dart';

class AttendanceRepository {
  AttendanceRepository._();

  static final AttendanceRepository instance = AttendanceRepository._();

  final List<AttendanceRecord> _records = [];

  List<AttendanceRecord> get records => List.unmodifiable(_records);

  void saveAttendance(List<AttendanceRecord> records) {
    if (records.isEmpty) return;

    final date = DateTime(
      records.first.date.year,
      records.first.date.month,
      records.first.date.day,
    );

    _records.removeWhere(
          (record) =>
      record.date.year == date.year &&
          record.date.month == date.month &&
          record.date.day == date.day,
    );

    _records.addAll(records);
  }

  List<AttendanceRecord> attendanceForDate(DateTime date) {
    return _records.where(
          (record) =>
      record.date.year == date.year &&
          record.date.month == date.month &&
          record.date.day == date.day,
    ).toList();
  }

  List<AttendanceRecord> attendanceForStudent(String studentId) {
    return _records
        .where((record) => record.studentId == studentId)
        .toList();
  }

  List<AttendanceRecord> todayAttendance() {
    return attendanceForDate(DateTime.now());
  }
}
