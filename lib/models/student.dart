class Student {
  final String id;
  final String admissionNumber;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String classroomId;
  final String centreId;
  final List<String> parentIds;
  final String profileImageUrl;
  final bool isActive;
  final bool isDaycareEnrolled;
  final bool usesTransport;
  final List<String> pickupPersons;
  final String medicalNotes;
  final String allergies;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Student({
    required this.id,
    required this.admissionNumber,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.classroomId,
    required this.centreId,
    required this.parentIds,
    required this.profileImageUrl,
    required this.isActive,
    required this.isDaycareEnrolled,
    required this.usesTransport,
    required this.pickupPersons,
    required this.medicalNotes,
    required this.allergies,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  Student copyWith({
    String? id,
    String? admissionNumber,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? classroomId,
    String? centreId,
    List<String>? parentIds,
    String? profileImageUrl,
    bool? isActive,
    bool? isDaycareEnrolled,
    bool? usesTransport,
    List<String>? pickupPersons,
    String? medicalNotes,
    String? allergies,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      admissionNumber: admissionNumber ?? this.admissionNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      classroomId: classroomId ?? this.classroomId,
      centreId: centreId ?? this.centreId,
      parentIds: parentIds ?? this.parentIds,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isActive: isActive ?? this.isActive,
      isDaycareEnrolled:
      isDaycareEnrolled ?? this.isDaycareEnrolled,
      usesTransport: usesTransport ?? this.usesTransport,
      pickupPersons: pickupPersons ?? this.pickupPersons,
      medicalNotes: medicalNotes ?? this.medicalNotes,
      allergies: allergies ?? this.allergies,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Student.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return Student(
      id: id,
      admissionNumber: map['admissionNumber'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      dateOfBirth: DateTime.tryParse(
        map['dateOfBirth'] ?? '',
      ) ??
          DateTime.now(),
      gender: map['gender'] ?? '',
      classroomId: map['classroomId'] ?? '',
      centreId: map['centreId'] ?? '',
      parentIds: List<String>.from(
        map['parentIds'] ?? [],
      ),
      profileImageUrl: map['profileImageUrl'] ?? '',
      isActive: map['isActive'] ?? true,
      isDaycareEnrolled:
      map['isDaycareEnrolled'] ?? false,
      usesTransport: map['usesTransport'] ?? false,
      pickupPersons: List<String>.from(
        map['pickupPersons'] ?? [],
      ),
      medicalNotes: map['medicalNotes'] ?? '',
      allergies: map['allergies'] ?? '',
      createdAt: DateTime.tryParse(
        map['createdAt'] ?? '',
      ) ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
        map['updatedAt'] ?? '',
      ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'admissionNumber': admissionNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'classroomId': classroomId,
      'centreId': centreId,
      'parentIds': parentIds,
      'profileImageUrl': profileImageUrl,
      'isActive': isActive,
      'isDaycareEnrolled': isDaycareEnrolled,
      'usesTransport': usesTransport,
      'pickupPersons': pickupPersons,
      'medicalNotes': medicalNotes,
      'allergies': allergies,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() => 'Student($id, $fullName)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Student && other.id == id;

  @override
  int get hashCode => id.hashCode;
}