import '../models/daycare_record.dart';

class DaycareRepository {
  DaycareRepository._();

  static final DaycareRepository instance = DaycareRepository._();

  final List<DaycareRecord> _records = [];

  List<DaycareRecord> get records => List.unmodifiable(_records);

  void saveRecord(DaycareRecord record) {
    _records.removeWhere((r) => r.id == record.id);
    _records.add(record);
  }

  void saveRecords(List<DaycareRecord> records) {
    for (final record in records) {
      saveRecord(record);
    }
  }

  DaycareRecord? recordForStudentOnDate(
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

  List<DaycareRecord> recordsForDate(DateTime date) {
    return _records.where(
          (record) =>
      record.date.year == date.year &&
          record.date.month == date.month &&
          record.date.day == date.day,
    ).toList();
  }

  List<DaycareRecord> activeChildren(DateTime date) {
    return recordsForDate(date)
        .where(
          (record) =>
      record.isCheckedIn &&
          !record.isCheckedOut,
    )
        .toList();
  }
}