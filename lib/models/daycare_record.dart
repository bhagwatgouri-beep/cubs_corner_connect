class DaycareRecord {
  final String id;
  final String studentId;

  final DateTime date;

  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  final String checkedInBy;
  final String checkedOutBy;

  final String pickupPerson;
  final String pickupRelation;

  final bool isCheckedIn;
  final bool isCheckedOut;

  final DateTime createdAt;
  final DateTime updatedAt;

  const DaycareRecord({
    required this.id,
    required this.studentId,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    this.checkedInBy = '',
    this.checkedOutBy = '',
    this.pickupPerson = '',
    this.pickupRelation = '',
    this.isCheckedIn = false,
    this.isCheckedOut = false,
    required this.createdAt,
    required this.updatedAt,
  });

  DaycareRecord copyWith({
    String? id,
    String? studentId,
    DateTime? date,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    String? checkedInBy,
    String? checkedOutBy,
    String? pickupPerson,
    String? pickupRelation,
    bool? isCheckedIn,
    bool? isCheckedOut,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DaycareRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      date: date ?? this.date,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      checkedInBy: checkedInBy ?? this.checkedInBy,
      checkedOutBy: checkedOutBy ?? this.checkedOutBy,
      pickupPerson: pickupPerson ?? this.pickupPerson,
      pickupRelation: pickupRelation ?? this.pickupRelation,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      isCheckedOut: isCheckedOut ?? this.isCheckedOut,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory DaycareRecord.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return DaycareRecord(
      id: id,
      studentId: map['studentId'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      checkInTime: map['checkInTime'] == null
          ? null
          : DateTime.tryParse(map['checkInTime']),
      checkOutTime: map['checkOutTime'] == null
          ? null
          : DateTime.tryParse(map['checkOutTime']),
      checkedInBy: map['checkedInBy'] ?? '',
      checkedOutBy: map['checkedOutBy'] ?? '',
      pickupPerson: map['pickupPerson'] ?? '',
      pickupRelation: map['pickupRelation'] ?? '',
      isCheckedIn: map['isCheckedIn'] ?? false,
      isCheckedOut: map['isCheckedOut'] ?? false,
      createdAt:
      DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt:
      DateTime.tryParse(map['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'date': date.toIso8601String(),
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'checkedInBy': checkedInBy,
      'checkedOutBy': checkedOutBy,
      'pickupPerson': pickupPerson,
      'pickupRelation': pickupRelation,
      'isCheckedIn': isCheckedIn,
      'isCheckedOut': isCheckedOut,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DaycareRecord && other.id == id;

  @override
  int get hashCode => id.hashCode;
}