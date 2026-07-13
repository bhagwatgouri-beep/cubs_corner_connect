import 'daycare_session.dart';

class MonthlyDaycareLedger {
  final String childId;
  final String childName;
  final int month;
  final int year;
  final List<DaycareSession> sessions;
  final bool isPaid;

  const MonthlyDaycareLedger({
    required this.childId,
    required this.childName,
    required this.month,
    required this.year,
    required this.sessions,
    this.isPaid = false,
  });

  int get totalMinutes =>
      sessions.fold(0, (sum, session) => sum + session.totalMinutes);

  double get totalHours => totalMinutes / 60.0;

  int get totalVisits => sessions.length;

  MonthlyDaycareLedger copyWith({
    List<DaycareSession>? sessions,
    bool? isPaid,
  }) {
    return MonthlyDaycareLedger(
      childId: childId,
      childName: childName,
      month: month,
      year: year,
      sessions: sessions ?? this.sessions,
      isPaid: isPaid ?? this.isPaid,
    );
  }
}