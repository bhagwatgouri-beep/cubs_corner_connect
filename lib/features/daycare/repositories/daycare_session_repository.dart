import '../models/daycare_session.dart';

class DaycareSessionRepository {
  DaycareSessionRepository._();

  static final DaycareSessionRepository instance =
  DaycareSessionRepository._();

  final List<DaycareSession> _sessions = [];

  List<DaycareSession> get allSessions =>
      List.unmodifiable(_sessions);

  List<DaycareSession> get activeSessions =>
      _sessions.where((s) => !s.isCheckedOut).toList();

  List<DaycareSession> get completedSessions =>
      _sessions.where((s) => s.isCheckedOut).toList();

  void checkIn({
    required String childId,
    required String childName,
  }) {
    _sessions.insert(
      0,
      DaycareSession(
        childId: childId,
        childName: childName,
        checkInTime: DateTime.now(),
      ),
    );
  }

  bool checkOut(String childId) {
    final index = _sessions.indexWhere(
          (s) => s.childId == childId && !s.isCheckedOut,
    );

    if (index == -1) {
      return false;
    }

    final session = _sessions[index];

    _sessions[index] = session.copyWith(
      checkOutTime: DateTime.now(),
    );

    return true;
  }

  DaycareSession? getActiveSession(String childId) {
    try {
      return _sessions.firstWhere(
            (s) => s.childId == childId && !s.isCheckedOut,
      );
    } catch (_) {
      return null;
    }
  }

  void clear() {
    _sessions.clear();
  }

  int get activeCount => activeSessions.length;

  int get completedCount => completedSessions.length;
}