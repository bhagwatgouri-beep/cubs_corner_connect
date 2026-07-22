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

  AttendanceRecord? attendanceForStudentOnDate(
      String studentId,
      DateTime date,
      ) {
    try {
      return _records.firstWhere(
            (record) =>
        record.studentId == studentId &&
            record.date.year == date.year &&
            record.date.month == date.month &&
            record.date.day == date.day,
      );
    } catch (_) {
      return null;
    }
  }

  bool hasAttendanceForDate(DateTime date) {
    return attendanceForDate(date).isNotEmpty;
  }

  void updateAttendance(List<AttendanceRecord> records) {
    saveAttendance(records);
  }
  void markAttendance({
    required String studentId,
    required AttendanceStatus status,
    required String markedBy,
  }) {
    final today = DateTime.now();

    final existing = attendanceForStudentOnDate(
      studentId,
      today,
    );

    final record = AttendanceRecord(
      id: existing?.id ??
          '${studentId}_${today.millisecondsSinceEpoch}',
      studentId: studentId,
      date: DateTime(
        today.year,
        today.month,
        today.day,
      ),
      status: status,
      markedAt: DateTime.now(),
      markedBy: markedBy,
    );

    if (existing != null) {
      _records.remove(existing);
    }

    _records.add(record);
  }
}