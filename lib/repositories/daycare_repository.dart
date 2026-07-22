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

  void checkInStudent({
    required String studentId,
    required String checkedInBy,
  }) {
    final today = DateTime.now();

    final existing = recordForStudentOnDate(
      studentId,
      today,
    );

    final record = DaycareRecord(
      id: existing?.id ??
          '${studentId}_${today.millisecondsSinceEpoch}',
      studentId: studentId,
      date: DateTime(
        today.year,
        today.month,
        today.day,
      ),
      checkInTime:
      existing?.checkInTime ?? DateTime.now(),
      checkOutTime: existing?.checkOutTime,
      checkedInBy: checkedInBy,
      checkedOutBy: existing?.checkedOutBy ?? '',
      pickupPerson: existing?.pickupPerson ?? '',
      pickupRelation: existing?.pickupRelation ?? '',
      isCheckedIn: true,
      isCheckedOut: false,
      createdAt: existing?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    saveRecord(record);
  }

  void checkOutStudent({
    required String studentId,
    required String checkedOutBy,
  }) {
    final today = DateTime.now();

    final existing = recordForStudentOnDate(
      studentId,
      today,
    );

    if (existing == null) return;

    saveRecord(
      DaycareRecord(
        id: existing.id,
        studentId: existing.studentId,
        date: existing.date,
        checkInTime: existing.checkInTime,
        checkOutTime: DateTime.now(),
        checkedInBy: existing.checkedInBy,
        checkedOutBy: checkedOutBy,
        pickupPerson: existing.pickupPerson,
        pickupRelation: existing.pickupRelation,
        isCheckedIn: true,
        isCheckedOut: true,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      ),
    );
  }
}