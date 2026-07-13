import '../models/daycare_session.dart';
import '../models/monthly_daycare_ledger.dart';

class MonthlyDaycareLedgerRepository {
  MonthlyDaycareLedgerRepository._();

  static final MonthlyDaycareLedgerRepository instance =
  MonthlyDaycareLedgerRepository._();

  final List<MonthlyDaycareLedger> _ledgers = [];

  List<MonthlyDaycareLedger> get ledgers =>
      List.unmodifiable(_ledgers);

  void addSession(DaycareSession session) {
    final month = session.checkInTime.month;
    final year = session.checkInTime.year;

    final index = _ledgers.indexWhere(
          (ledger) =>
      ledger.childId == session.childId &&
          ledger.month == month &&
          ledger.year == year,
    );

    if (index == -1) {
      _ledgers.add(
        MonthlyDaycareLedger(
          childId: session.childId,
          childName: session.childName,
          month: month,
          year: year,
          sessions: [session],
        ),
      );
      return;
    }

    final ledger = _ledgers[index];

    final updatedSessions = List<DaycareSession>.from(ledger.sessions)
      ..add(session);

    _ledgers[index] = ledger.copyWith(
      sessions: updatedSessions,
    );
  }

  MonthlyDaycareLedger? getLedger({
    required String childId,
    required int month,
    required int year,
  }) {
    try {
      return _ledgers.firstWhere(
            (ledger) =>
        ledger.childId == childId &&
            ledger.month == month &&
            ledger.year == year,
      );
    } catch (_) {
      return null;
    }
  }

  void markAsPaid({
    required String childId,
    required int month,
    required int year,
  }) {
    final index = _ledgers.indexWhere(
          (ledger) =>
      ledger.childId == childId &&
          ledger.month == month &&
          ledger.year == year,
    );

    if (index == -1) return;

    _ledgers[index] = _ledgers[index].copyWith(
      isPaid: true,
    );
  }

  void clear() {
    _ledgers.clear();
  }
}