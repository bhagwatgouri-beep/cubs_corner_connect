class HealthRecord {
  final String id;
  final String studentId;

  final String bloodGroup;
  final List<String> allergies;
  final List<String> medicalConditions;
  final List<String> medications;

  final double heightCm;
  final double weightKg;

  final String emergencyNotes;

  final DateTime createdAt;
  final DateTime updatedAt;

  const HealthRecord({
    required this.id,
    required this.studentId,
    this.bloodGroup = '',
    this.allergies = const [],
    this.medicalConditions = const [],
    this.medications = const [],
    this.heightCm = 0,
    this.weightKg = 0,
    this.emergencyNotes = '',
    required this.createdAt,
    required this.updatedAt,
  });

  double get bmi {
    if (heightCm <= 0 || weightKg <= 0) return 0;
    final h = heightCm / 100;
    return weightKg / (h * h);
  }

  HealthRecord copyWith({
    String? id,
    String? studentId,
    String? bloodGroup,
    List<String>? allergies,
    List<String>? medicalConditions,
    List<String>? medications,
    double? heightCm,
    double? weightKg,
    String? emergencyNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HealthRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      medicalConditions:
      medicalConditions ?? this.medicalConditions,
      medications: medications ?? this.medications,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      emergencyNotes:
      emergencyNotes ?? this.emergencyNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory HealthRecord.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return HealthRecord(
      id: id,
      studentId: map['studentId'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      allergies:
      List<String>.from(map['allergies'] ?? const []),
      medicalConditions: List<String>.from(
        map['medicalConditions'] ?? const [],
      ),
      medications:
      List<String>.from(map['medications'] ?? const []),
      heightCm: (map['heightCm'] ?? 0).toDouble(),
      weightKg: (map['weightKg'] ?? 0).toDouble(),
      emergencyNotes: map['emergencyNotes'] ?? '',
      createdAt:
      DateTime.tryParse(map['createdAt'] ?? '') ??
          DateTime.now(),
      updatedAt:
      DateTime.tryParse(map['updatedAt'] ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'medicalConditions': medicalConditions,
      'medications': medications,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'emergencyNotes': emergencyNotes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HealthRecord && other.id == id;

  @override
  int get hashCode => id.hashCode;
}