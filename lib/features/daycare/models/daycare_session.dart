class DaycareSession {
  final String childId;
  final String childName;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final bool breakfastTaken;
  final bool lunchTaken;
  final bool snackTaken;

  const DaycareSession({
    required this.childId,
    required this.childName,
    required this.checkInTime,
    this.checkOutTime,
    this.breakfastTaken = false,
    this.lunchTaken = false,
    this.snackTaken = false,
  });

  bool get isCheckedOut => checkOutTime != null;

  int get totalMinutes {
    final end = checkOutTime ?? DateTime.now();
    return end.difference(checkInTime).inMinutes;
  }

  double get totalHours => totalMinutes / 60.0;

  DaycareSession copyWith({
    String? childId,
    String? childName,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    bool? breakfastTaken,
    bool? lunchTaken,
    bool? snackTaken,
  }) {
    return DaycareSession(
      childId: childId ?? this.childId,
      childName: childName ?? this.childName,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      breakfastTaken: breakfastTaken ?? this.breakfastTaken,
      lunchTaken: lunchTaken ?? this.lunchTaken,
      snackTaken: snackTaken ?? this.snackTaken,
    );
  }
}