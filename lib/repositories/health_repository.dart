import '../models/health_record.dart';

class HealthRepository {
  HealthRepository._();

  static final HealthRepository instance =
  HealthRepository._();

  final List<HealthRecord> _records = [];

  List<HealthRecord> get records =>
      List.unmodifiable(_records);

  void saveRecord(HealthRecord record) {
    _records.removeWhere((r) => r.id == record.id);
    _records.add(record);
  }

  void saveRecords(List<HealthRecord> records) {
    for (final record in records) {
      saveRecord(record);
    }
  }

  HealthRecord? getRecord(String studentId) {
    try {
      return _records.firstWhere(
            (record) => record.studentId == studentId,
      );
    } catch (_) {
      return null;
    }
  }

  bool hasRecord(String studentId) {
    return _records.any(
          (record) => record.studentId == studentId,
    );
  }

  void deleteRecord(String studentId) {
    _records.removeWhere(
          (record) => record.studentId == studentId,
    );
  }

  void clear() {
    _records.clear();
  }
}