enum AttendanceStatus {
  present,
  absent,
  late,
}

class AttendanceRecord {
  final String id;
  final String studentId;
  final DateTime date;
  final AttendanceStatus status;
  final DateTime markedAt;
  final String markedBy;

  const AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.date,
    required this.status,
    required this.markedAt,
    required this.markedBy,
  });

  AttendanceRecord copyWith({
    String? id,
    String? studentId,
    DateTime? date,
    AttendanceStatus? status,
    DateTime? markedAt,
    String? markedBy,
  }) {
    return AttendanceRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      date: date ?? this.date,
      status: status ?? this.status,
      markedAt: markedAt ?? this.markedAt,
      markedBy: markedBy ?? this.markedBy,
    );
  }
}